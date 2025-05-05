using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace SellShoe.UserControl
{
    public partial class ContactCT : System.Web.UI.UserControl
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public static List<tb_ContactInfo> listInfo = new List<tb_ContactInfo>();
        public static List<tb_ContactPeople> listTV = new List<tb_ContactPeople>();

        protected void Page_Load(object sender, EventArgs e)
        {

            LoadContactInfo();
            LoadContactPeople();

        }

        void LoadContactInfo()
        {
            // Load dữ liệu Contact Info từ database
            listInfo = db.tb_ContactInfos.ToList();
        }

        void LoadContactPeople()
        {
            // Load dữ liệu Contact People từ database
            listTV = db.tb_ContactPeoples.ToList();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string name = txtContactName.Text.Trim();
            string email = txtContactEmail.Text.Trim();
            string subject = txtContactSubject.Text.Trim();
            string content = txtContactContent.Text.Trim();

            try
            {
                // Khởi tạo object feedback mới
                tb_ContactFeedback feedback = new tb_ContactFeedback()
                {
                    FullName = name,
                    Email = email,
                    Subject = subject,
                    Content = content,
                    CreatedAt = DateTime.Now
                };

                // Thêm vào context và submit
                db.tb_ContactFeedbacks.InsertOnSubmit(feedback);
                db.SubmitChanges();

                // Reset form
                txtContactName.Text = "";
                txtContactEmail.Text = "";
                txtContactSubject.Text = "";
                txtContactContent.Text = "";

                // Hiển thị SweetAlert2
                ScriptManager.RegisterStartupScript(this, GetType(), "SuccessMessage", @"
            Swal.fire({
                icon: 'success',
                title: 'Gửi thành công!',
                text: 'Cảm ơn bạn đã liên hệ với chúng tôi.',
                confirmButtonText: 'Tiếp tục'
            });
        ", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ErrorMessage", $@"
            Swal.fire({{
                icon: 'error',
                title: 'Lỗi hệ thống',
                text: '{ex.Message}',
                confirmButtonText: 'Đóng'
            }});
        ", true);
            }
        }


    }

}