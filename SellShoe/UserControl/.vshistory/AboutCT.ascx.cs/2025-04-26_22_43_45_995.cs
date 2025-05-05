using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.UserControl
{
    public partial class AboutCT : System.Web.UI.UserControl
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public static List<tb_ContactPeople> listTV = new List<tb_ContactPeople>();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        void loadTV() { 
            var data = from q in db.tb_ContactPeoples

        }
    }
}