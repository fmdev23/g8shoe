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
        private QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Không cần xử lý gì trong Load nếu chỉ đăng ký
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            if (password != confirmPassword)
            {
                ShowMessage("Mật khẩu xác nhận không khớp.");
                return;
            }

            try
            {
                // Kiểm tra xem email đã tồn tại chưa
                var existingUser = db.tb_Users.FirstOrDefault(u => u.Email == email);
                if (existingUser != null)
                {
                    ShowMessage("Email đã được sử dụng.");
                    return;
                }

                // Tạo user mới
                var newUser = new tb_User
                {
                    FullName = fullName,
                    Email = email,
                    Password = password, // Có thể băm sau nếu cần thiết
                    CreatedAt = DateTime.Now
                };

                db.tb_Users.InsertOnSubmit(newUser);
                db.SubmitChanges();

                // Sau khi đăng ký thành công, điều hướng về trang đăng nhập
                ShowMessage("Đăng ký thành công!", true);
            }
            catch (Exception ex)
            {
                ShowMessage("Đã xảy ra lỗi: " + Server.HtmlEncode(ex.Message));
            }
        }

        // Hàm hỗ trợ hiển thị thông báo dạng JS alert (có thể dùng Label nếu thích)
        private void ShowMessage(string message, bool redirect = false)
        {
            string script = $"alert('{message}');";
            if (redirect)
            {
                script += "document.querySelector('.signup-form').classList.remove('active');";
                script += "document.querySelector('.login-form').classList.add('active');";
            }
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtLoginEmail.Text.Trim();
            string password = txtLoginPassword.Text.Trim();

            // Kiểm tra dữ liệu đầu vào
            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Vui lòng nhập đầy đủ thông tin!');", true);
                return;
            }

            // Khởi tạo context LINQ
            QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();

            // Kiểm tra tài khoản có tồn tại không
            var user = db.tb_Users.SingleOrDefault(u => u.Email == email && u.Password == password);

            if (user != null)
            {
                // Đăng nhập thành công
                Session["user"] = user.FullName; // hoặc user.ID
                Response.Redirect("Home.aspx");
            }
            else
            {
                // Đăng nhập thất bại
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Email hoặc mật khẩu không đúng!');", true);
            }
        }


    }

}