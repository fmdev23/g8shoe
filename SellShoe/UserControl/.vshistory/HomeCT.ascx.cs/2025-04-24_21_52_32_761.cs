using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.UserControl
{
    public partial class Home : System.Web.UI.UserControl
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public static List<tb_Product> listSP = new List<tb_Product>();
        public static List<tb_ProductCategory> listDM = new List<tb_ProductCategory>();
        protected void Page_Load(object sender, EventArgs e)
        {
            loadData();
            loadDM();
        }

        void loadData()
        {
            var data = from q in db.tb_Products
                       where q.IsActive == true
                       select q;
            if (data != null && data.Count() > 0)
            {
                listSP = data.ToList();
            }
        }

        void loadDM()
        {
            var data = from q in db.tb_ProductCategories
                       select q;
            if (data != null && data.Count() > 0)
            {
                listDM = data.ToList();
            }
        }

        Dictionary<int, string> categoryMap = new Dictionary<int, string> {
            {1, "men"},
            {2, "women"},
            {3, "accessories"}
        };

    }
}