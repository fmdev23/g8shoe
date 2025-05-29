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
            if (Request.QueryString["logout"] == "true") // Kiểm tra xem có yêu cầu đăng xuất không
            {
                Session["user"] = null; // Xóa session người dùng
                Response.Redirect("UserAccount.aspx"); // Quay lại trang đăng nhập
            }
        }

        /// Xử lý đăng ký tài khoản
        protected void btnRegister_Click(object sender, EventArgs e) // Xử lý sự kiện khi người dùng nhấn nút đăng ký
        {
            string fullName = txtFullName.Text.Trim(); // Lấy tên đầy đủ từ TextBox
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            // Kiểm tra dữ liệu không được để trống
            if (string.IsNullOrEmpty(fullName) ||
                string.IsNullOrEmpty(email) ||
                string.IsNullOrEmpty(password) ||
                string.IsNullOrEmpty(confirmPassword))
            {
                Response.Write("<script>alert('Vui lòng điền đầy đủ thông tin trước khi đăng ký.');</script>");
                return;
            }

            // Kiểm tra xác nhận mật khẩu
            if (password != confirmPassword)
            {
                ShowMessage("Mật khẩu xác nhận không khớp.");
                return;
            }

            try
            {
                // Kiểm tra xem email đã tồn tại chưa
                var existingUser = db.tb_Users.FirstOrDefault(u => u.Email == email); // Tìm user theo email
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
                    Password = password,
                    CreatedAt = DateTime.Now
                };

                db.tb_Users.InsertOnSubmit(newUser);
                db.SubmitChanges();

                // Hiển thị thông báo thành công & chuyển form về đăng nhập
                ShowMessage("Đăng ký thành công!", redirect: true);
            }
            catch (Exception ex)
            {
                ShowMessage("Đã xảy ra lỗi: " + Server.HtmlEncode(ex.Message));
            }
        }

        /// Xử lý đăng nhập
        protected void btnLogin_Click(object sender, EventArgs e) // Xử lý sự kiện khi người dùng nhấn nút đăng nhập
        {
            string email = txtLoginEmail.Text.Trim();
            string password = txtLoginPassword.Text.Trim();

            // Kiểm tra dữ liệu đầu vào
            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password)) 
            {
                ShowMessage("Vui lòng nhập đầy đủ thông tin!");
                return;
            }

            // Kiểm tra tài khoản có tồn tại không
            var user = db.tb_Users.SingleOrDefault(u => u.Email == email && u.Password == password); // Tìm user theo email và mật khẩu

            if (user != null)
            {
                // Đăng nhập thành công
                Session["user"] = user.FullName;
                Response.Redirect("Home.aspx");
            }
            else
            {
                ShowMessage("Email hoặc mật khẩu không đúng!");
            }
        }

        /// Hiển thị thông báo dạng alert + xử lý chuyển form nếu cần
        private void ShowMessage(string message, bool redirect = false) 
        {
            string script = $"alert('{message}');"; // Tạo script alert với thông điệp

            // Nếu chuyển từ đăng ký -> đăng nhập
            if (redirect)
            {
                script += @"
                document.addEventListener('DOMContentLoaded', function() {
                    document.querySelector('.signup-form').classList.remove('active');
                    document.querySelector('.login-form').classList.add('active');
                });";
            }

            ClientScript.RegisterStartupScript(this.GetType(), "msg", script, true);
        }
    }


}