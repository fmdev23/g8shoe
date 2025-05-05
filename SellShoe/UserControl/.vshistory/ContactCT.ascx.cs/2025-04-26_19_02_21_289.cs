using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.UserControl
{
    public partial class ContactCT : System.Web.UI.UserControl
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public static List<tb_ContactInfo> listInfo = new List<tb_ContactInfo>();
        public static List<tb_ContactPeople> listTV = new List<tb_ContactPeople>();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                // Tạo mới một feedback object
                var feedback = new tb_ContactFeedback
                {
                    FullName = txtName.Text.Trim(),
                    Email = txtEmail.Text.Trim(),
                    Subject = txtSubject.Text.Trim(),
                    Content = txtContent.Text.Trim(),
                    CreatedAt = DateTime.Now
                };

                // Thêm vào database
                db.tb_ContactFeedbacks.InsertOnSubmit(feedback);
                db.SubmitChanges();

                // Sau khi lưu xong, có thể reset form hoặc báo thành công
                ClearForm();
                lblMessage.Text = "Gửi thành công! Chúng tôi đã ghi nhận ý kiến của bạn.";
                lblMessage.ForeColor = System.Drawing.Color.Green;
            }
            catch (Exception ex)
            {
                // Nếu có lỗi thì hiện thông báo lỗi
                lblMessage.Text = "Có lỗi xảy ra, vui lòng thử lại sau.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                // Log lỗi nếu cần thiết
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }

        private void ClearForm()
        {
            txtName.Text = "";
            txtEmail.Text = "";
            txtSubject.Text = "";
            txtContent.Text = "";
        }
    }
}