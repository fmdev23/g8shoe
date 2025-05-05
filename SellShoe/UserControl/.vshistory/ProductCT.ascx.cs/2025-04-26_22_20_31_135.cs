using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.UserControl
{
    public partial class ProductCT : System.Web.UI.UserControl
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public static List<tb_Product> listPro = new List<tb_Product>();

        protected void Page_Load(object sender, EventArgs e)
        {
            loadProduct();
        }

        void loadProduct()
        {
            listPro = db.tb_Products.Where(p => p.IsActive == true).ToList();
        }
    }

}