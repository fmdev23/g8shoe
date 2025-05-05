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

    }
}