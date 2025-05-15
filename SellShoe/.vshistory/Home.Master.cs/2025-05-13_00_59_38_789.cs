using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe
{
    public partial class Home : System.Web.UI.MasterPage
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public static List<tb_Category> listDM = new List<tb_Category>();
        protected void Page_Load(object sender, EventArgs e)
        {
            loadData(); // Load danh mục sản phẩm
            if (!IsPostBack)
            {
                if (Session["user"] != null)
                {
                    lblUserName.Text = Session["user"].ToString();
                    phLogout.Visible = true; // Hiện nút "Đăng xuất"
                }
                else
                {
                    lblUserName.Text = "Tài khoản";
                    phLogout.Visible = false; // Ẩn nút "Đăng xuất"
                }
            }

            // Nếu người dùng click logout bằng JS
            if (Request.QueryString["logout"] == "true")
            {
                Session["user"] = null;
                Response.Redirect("Home.aspx"); // Quay lại trang chủ sau khi đăng xuất
            }
        }

        void loadData()
        {
            var data = from q in db.tb_Categories
                       where q.IsActive == true
                       orderby q.Position ascending
                       select q;
            try
            {
                if (data != null && data.Count() > 0)
                {
                    listDM = data.ToList();
                }
            }
            catch (System.ComponentModel.Win32Exception ex)
            {
                // Log lỗi chi tiết để kiểm tra nguyên nhân
                // Ví dụ: Log ex.Message hoặc ex.StackTrace
                Console.WriteLine(ex.Message);
            }

        }

        protected void Newsletter_Submit_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();

            if (!string.IsNullOrEmpty(email))
            {
                try
                {
                    tb_ContactFeedback contact = new tb_ContactFeedback
                    {
                        FullName = "Khách hàng", // Không nhập tên
                        Email = email,
                        Subject = "Nhận khuyến mãi",
                        Content = "Đăng ký nhận thông tin khuyến mãi",
                        CreatedAt = DateTime.Now
                    };

                    db.tb_ContactFeedbacks.InsertOnSubmit(contact);
                    db.SubmitChanges();

                    // Hiển thị alert thành công
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "Swal.fire('Thành Công!', 'Đăng ký nhận khuyến mãi thành công.', 'success');", true);
                }
                catch (Exception ex)
                {
                    // Hiển thị alert lỗi
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "Swal.fire('Lỗi!', 'Có lỗi xảy ra, vui lòng thử lại.', 'error');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "Swal.fire('Chú Ý!', 'Vui lòng nhập Email hợp lệ.', 'warning');", true);
            }
        }

    }
}