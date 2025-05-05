using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services; // nhớ using cái này

namespace SellShoe.Admin
{
    public partial class Team : System.Web.UI.Page
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public static List<tb_ContactPeople> listTeam = new List<tb_ContactPeople>();
        protected void Page_Load(object sender, EventArgs e)
        {
            loadTeam();
        }

        void loadTeam() { 
            var data = from q in db.tb_ContactPeoples
                       select q;
            if(data != null && data.Count()>0)
            {
                listTeam = data.ToList();
            }
        }
    }
}