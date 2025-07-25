﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.Admin
{
    public partial class QLContact : System.Web.UI.Page
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            CheckDangNhap();
            
            if (!IsPostBack)
            {
                HandleDeleteRequest();
                LoadFeedback();
            }
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Xoá session
            Session.Clear(); // Xoá tất cả các biến trong session
            Session.Abandon(); // Hủy session hiện tại

            Response.Redirect("~/adminlogin.aspx");
        }

        void CheckDangNhap()
        {
            if (Session["Admin"] != null && Session["Password"] != null)
            {
                var data = from q in db.tb_AccountAdmins
                           where q.TenBien == "Admin"
                           && q.GiaTri == Session["Admin"].ToString()
                           select q;
                var dataPass = from q in db.tb_AccountAdmins
                               where q.TenBien == "Password"
                               && q.GiaTri == Session["Password"].ToString()
                               select q;
                if (data != null && data.Count() > 0)
                {

                }
                else
                {
                    Response.Redirect("../AdminLogin.aspx"); // Không hợp lệ → ép đăng nhập lại
                }
            }
            else
            {
                Response.Redirect("../AdminLogin.aspx"); // Nếu chưa có session → ép đăng nhập
            }
        }

        void LoadFeedback()
        {
            var feedbacks = db.tb_ContactFeedbacks.ToList(); // Lấy tất cả phản hồi từ cơ sở dữ liệu
            rptFeedback.DataSource = feedbacks; // Gán dữ liệu cho Repeater
            rptFeedback.DataBind(); // Hiển thị ra UI
        }
        void HandleDeleteRequest() // Xử lý yêu cầu xóa phản hồi từ URL
        {
            string deleteId = Request.QueryString["deleteId"]; // Lấy ID phản hồi cần xóa từ query string
            if (!string.IsNullOrEmpty(deleteId)) // Kiểm tra xem có ID xóa không
            {
                int id = Convert.ToInt32(deleteId); // Chuyển đổi ID từ chuỗi sang số nguyên
                var feedback = db.tb_ContactFeedbacks.SingleOrDefault(fb => fb.Id == id); // Tìm phản hồi theo ID
                if (feedback != null) // Nếu tìm thấy phản hồi
                {
                    db.tb_ContactFeedbacks.DeleteOnSubmit(feedback);
                    db.SubmitChanges();
                    LoadFeedback(); // Refresh lại UI
                }
            }
        }
    }
}