using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services; // nhớ using cái này

namespace SellShoe.Admin
{
    public partial class Team : System.Web.UI.Page
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public static List<tb_ContactPeople> listTeam = new List<tb_ContactPeople>();
        protected void Page_Load(object sender, EventArgs e)
        {
            loadTeam();
        }

        void loadTeam()
        {
            var data = from q in db.tb_ContactPeoples
                       select q;
            if (data != null && data.Count() > 0)
            {
                listTeam = data.ToList();
            }
        }

        // Hàm lưu (thêm/sửa) thành viên
        [WebMethod]
        public static string SaveContact(tb_ContactPeople contact)
        {
            try
            {
                using (QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext())
                {
                    if (contact.Id > 0)
                    {
                        // Sửa
                        var existing = db.tb_ContactPeoples.FirstOrDefault(x => x.Id == contact.Id);
                        if (existing != null)
                        {
                            existing.FullName = contact.FullName;
                            existing.Position = contact.Position;
                            existing.Phone = contact.Phone;
                            existing.Email = contact.Email;
                            // Avatar nếu bạn muốn thêm upload ảnh riêng
                        }
                    }
                    else
                    {
                        // Thêm mới
                        db.tb_ContactPeoples.InsertOnSubmit(contact);
                    }

                    db.SubmitChanges();
                    return "success";
                }
            }
            catch (Exception ex)
            {
                return "error";
            }
        }

        // Hàm xóa thành viên
        [WebMethod]
        public static string DeleteContact(int id)
        {
            try
            {
                using (QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext())
                {
                    var contact = db.tb_ContactPeoples.FirstOrDefault(x => x.Id == id);
                    if (contact != null)
                    {
                        db.tb_ContactPeoples.DeleteOnSubmit(contact);
                        db.SubmitChanges();
                        return "success";
                    }
                    return "notfound";
                }
            }
            catch (Exception ex)
            {
                return "error";
            }
        }
    }
}