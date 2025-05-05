using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe
{
    public partial class Account : System.Web.UI.Page
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public tb_User user;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            if (password != confirmPassword)
            {
                // Gợi ý: nên dùng Label để hiển thị lỗi thay vì alert nếu bạn muốn UX tốt
                Response.Write("<script>alert('Mật khẩu xác nhận không khớp.');</script>");
                return;
            }

            try
            {
                using (var db = new QuanLyBanGiayDataContext()) // Tên context bạn đã import
                {
                    // Kiểm tra email đã tồn tại chưa
                    var existingUser = db.tb_Users.FirstOrDefault(u => u.Email == email);
                    if (existingUser != null)
                    {
                        Response.Write("<script>alert('Email đã được sử dụng.');</script>");
                        return;
                    }

                    var newUser = new tb_User
                    {
                        FullName = fullName,
                        Email = email,
                        Password = password, // Có thể băm sau nếu cần
                        CreatedAt = DateTime.Now
                    };

                    db.tb_Users.InsertOnSubmit(newUser);
                    db.SubmitChanges();

                    Response.Write("<script>alert('Đăng ký thành công!'); window.location.href='UserAccount.aspx';</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Lỗi khi đăng ký: " + ex.Message + "');</script>");
            }
        }

    }
}