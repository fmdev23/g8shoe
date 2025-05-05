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
            if (!IsPostBack)
            {
                LoadContactInfo();
                LoadContactPeople();
            }
        }

        void LoadContactInfo()
        {
            // Load dữ liệu Contact Info từ database
            listInfo = db.tb_ContactInfos.ToList();
        }

        private void LoadContactPeople()
        {
            // Load dữ liệu Contact People từ database
            listTV = db.tb_ContactPeoples.ToList();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                // Tạo mới đối tượng feedback
                tb_ContactFeedback feedback = new tb_ContactFeedback
                {
                    FullName = txtName.Text.Trim(),
                    Email = txtEmail.Text.Trim(),
                    Subject = txtSubject.Text.Trim(),
                    Content = txtContent.Text.Trim(),
                    CreatedAt = DateTime.Now
                };

                // Insert vào bảng feedback
                db.tb_ContactFeedbacks.InsertOnSubmit(feedback);
                db.SubmitChanges();

                // Sau khi gửi thành công, clear form
                ClearForm();

                // Báo thành công (bạn tự thiết kế thêm label nếu cần)
                lblMessage.Text = "Gửi phản hồi thành công. Chúng tôi sẽ liên hệ sớm!";
                lblMessage.ForeColor = System.Drawing.Color.Green;
            }
            catch (Exception ex)
            {
                // Nếu lỗi, báo thất bại
                lblMessage.Text = "Có lỗi xảy ra khi gửi phản hồi.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
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