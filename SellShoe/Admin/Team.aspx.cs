using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SellShoe.Admin
{
    public partial class Team : System.Web.UI.Page
    {
        public static QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public static List<tb_ContactPeople> listTeam = new List<tb_ContactPeople>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadTeam();
            }
        }

        void loadTeam()
        {
            try
            {
                var data = db.tb_ContactPeoples.ToList();
                if (data != null && data.Count > 0)
                {
                    listTeam = data;
                }
            }
            catch (Exception ex)
            {
                // Ghi log nếu cần
                listTeam = new List<tb_ContactPeople>();
            }
        }

        [WebMethod]
        public static string SaveMember(int id, string fullName, string position, string phone, string email, string avatar)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(fullName) || string.IsNullOrWhiteSpace(position))
                {
                    return "Vui lòng nhập đầy đủ họ tên và chức vụ.";
                }

                if (id == 0)
                {
                    // Thêm mới
                    var newMember = new tb_ContactPeople
                    {
                        FullName = fullName.Trim(),
                        Position = position.Trim(),
                        Phone = phone?.Trim(),
                        Email = email?.Trim(),
                        Avatar = avatar?.Trim()
                    };
                    db.tb_ContactPeoples.InsertOnSubmit(newMember);
                }
                else
                {
                    // Cập nhật
                    var member = db.tb_ContactPeoples.FirstOrDefault(x => x.Id == id);
                    if (member == null)
                        return "Không tìm thấy thành viên cần sửa.";

                    member.FullName = fullName.Trim();
                    member.Position = position.Trim();
                    member.Phone = phone?.Trim();
                    member.Email = email?.Trim();
                    member.Avatar = avatar?.Trim();
                }

                db.SubmitChanges();
                return "success";
            }
            catch (Exception ex)
            {
                // Ghi log ex.Message nếu cần
                return "error";
            }
        }

        [WebMethod]
        public static string DeleteMember(int id)
        {
            try
            {
                var member = db.tb_ContactPeoples.FirstOrDefault(x => x.Id == id);
                if (member == null)
                    return "Không tìm thấy thành viên cần xóa.";

                db.tb_ContactPeoples.DeleteOnSubmit(member);
                db.SubmitChanges();
                return "success";
            }
            catch (Exception ex)
            {
                // Ghi log ex.Message nếu cần
                return "error";
            }
        }
    }
}
