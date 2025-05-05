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
        public static List<tb_ContactPeople> listTv = new List<tb_ContactPeople>();
        protected void Page_Load(object sender, EventArgs e)
        {
            loadTV();
        }

        void loadTV() { 
            var data = from q in db.tb_ContactPeoples
                       select q;
            if (data != null && data.Count() > 0) { 
                listTv = data.ToList();
            }
        }
    }
}