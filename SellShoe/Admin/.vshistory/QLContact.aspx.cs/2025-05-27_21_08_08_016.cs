using System;
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
                LoadFeedback();
                HandleDeleteRequest();
            }
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Xoá session
            Session.Clear();
            Session.Abandon();

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
                    Response.Redirect("../AdminLogin.aspx");
                }
            }
            else
            {
                Response.Redirect("../AdminLogin.aspx");
            }
        }

        void LoadFeedback()
        {
            var feedbacks = db.tb_ContactFeedbacks.ToList();
            rptFeedback.DataSource = feedbacks;
            rptFeedback.DataBind();
        }

        void HandleDeleteRequest()
        {
            // Kiểm tra nếu có yêu cầu xóa phản hồi từ query string
            string deleteId = Request.QueryString["deleteId"];
            if (!string.IsNullOrEmpty(deleteId))
            {
                int id = Convert.ToInt32(deleteId);
                var feedback = db.tb_ContactFeedbacks.SingleOrDefault(fb => fb.Id == id);
                if (feedback != null)
                {
                    db.tb_ContactFeedbacks.DeleteOnSubmit(feedback);
                    db.SubmitChanges();
                    LoadFeedback(); // Cập nhật lại danh sách sau khi xóa
                }
            }
        }

        protected void rptFeedback_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                var feedback = db.tb_ContactFeedbacks.SingleOrDefault(fb => fb.Id == id);
                if (feedback != null)
                {
                    db.tb_ContactFeedbacks.DeleteOnSubmit(feedback);
                    db.SubmitChanges();
                    LoadFeedback(); // Cập nhật lại danh sách sau khi xóa
                }
            }
        }
    }
}