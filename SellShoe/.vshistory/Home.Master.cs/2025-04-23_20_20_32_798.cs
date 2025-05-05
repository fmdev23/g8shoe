using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe
{
    public partial class Home : System.Web.UI.MasterPage
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public static List<tb_Category> listDM = new List<tb_Category>();
        protected void Page_Load(object sender, EventArgs e)
        {
            loadData();
        }

        void loadData()
        {
            var data = from q in db.tb_Categories
                       where q.IsActive == true
                       orderby q.Position ascending
                       select q;
            if (data != null && data.Count() > 0)
            {
                listDM = data.ToList();
            }
        }
    }
}