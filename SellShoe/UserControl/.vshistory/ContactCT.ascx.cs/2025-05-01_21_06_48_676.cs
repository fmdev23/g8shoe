﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
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
                string connectionString = ConfigurationManager.ConnectionStrings["WebBanGiayConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string sql = "INSERT INTO tb_ContactFeedback (FullName, Email, Subject, Content) VALUES (@FullName, @Email, @Subject, @Content)";

                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@FullName", name);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Subject", subject);
                        cmd.Parameters.AddWithValue("@Content", content);

                        cmd.ExecuteNonQuery();
                    }
                }

                // Clear form sau khi gửi thành công
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
            catch (Exception)
            {
                // Nếu cần xử lý lỗi, có thể log hoặc hiển thị thông báo ở đây
            }
        }
    }

}