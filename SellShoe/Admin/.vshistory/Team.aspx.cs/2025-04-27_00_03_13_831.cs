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

        // WebMethod: Lưu (Thêm/Sửa) thành viên
        [WebMethod]
        public static string SaveContact(tb_ContactPeople contact)
        {
            try
            {
                using (var db = new QuanLyBanGiayDataContext())
                {
                    if (contact == null)
                    {
                        return "invalid";
                    }

                    if (contact.Id > 0)
                    {
                        // Sửa thành viên
                        var existing = db.tb_ContactPeoples.FirstOrDefault(x => x.Id == contact.Id);
                        if (existing != null)
                        {
                            existing.FullName = contact.FullName?.Trim();
                            existing.Position = contact.Position?.Trim();
                            existing.Phone = contact.Phone?.Trim();
                            existing.Email = contact.Email?.Trim();
                            // Nếu có xử lý Avatar thì thêm vào đây
                        }
                        else
                        {
                            return "notfound";
                        }
                    }
                    else
                    {
                        // Thêm mới thành viên
                        var newContact = new tb_ContactPeople
                        {
                            FullName = contact.FullName?.Trim(),
                            Position = contact.Position?.Trim(),
                            Phone = contact.Phone?.Trim(),
                            Email = contact.Email?.Trim(),
                            Avatar = contact.Avatar // Nếu có thêm upload Avatar
                        };

                        db.tb_ContactPeoples.InsertOnSubmit(newContact);
                    }

                    db.SubmitChanges();
                    return "success";
                }
            }
            catch (Exception ex)
            {
                // Ghi log lỗi nếu cần
                return "error";
            }
        }

        // WebMethod: Xóa thành viên
        [WebMethod]
        public static string DeleteContact(int id)
        {
            try
            {
                using (var db = new QuanLyBanGiayDataContext())
                {
                    var contact = db.tb_ContactPeoples.FirstOrDefault(x => x.Id == id);
                    if (contact != null)
                    {
                        db.tb_ContactPeoples.DeleteOnSubmit(contact);
                        db.SubmitChanges();
                        return "success";
                    }
                    else
                    {
                        return "notfound";
                    }
                }
            }
            catch (Exception ex)
            {
                // Ghi log lỗi nếu cần
                return "error";
            }
        }
    }
}
