using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.Admin
{
    public partial class Contact : System.Web.UI.Page
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public static List<tb_ContactFeedback> listFeedback = new List<tb_ContactFeedback>();
        protected void Page_Load(object sender, EventArgs e)
        {
            loadFeedback();
        }

        void loadFeedback()
        {
            // Load dữ liệu Feedback từ database
            listFeedback = db.tb_ContactFeedbacks.ToList();
        }
    }
}