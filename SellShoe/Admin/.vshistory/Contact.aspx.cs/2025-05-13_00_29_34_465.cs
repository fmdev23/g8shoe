using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.Admin
{
    public partial class Contact : System.Web.UI.Page
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFeedback();
                HandleDeleteRequest();
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
    }


}