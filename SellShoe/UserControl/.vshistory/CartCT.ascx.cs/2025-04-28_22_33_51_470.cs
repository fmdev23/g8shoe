using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.UserControl
{
    public partial class CartCT : System.Web.UI.UserControl
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();

        public tb_Product product = new tb_Product();
        protected void Page_Load(object sender, EventArgs e)
        {
            loadProduct();
        }

        void loadProduct()
        {
            // Load sản phẩm từ database
            int productId = Convert.ToInt32(Request.QueryString["id"]);
            product = db.tb_Products.SingleOrDefault(p => p.id == productId);
        }
    }
}