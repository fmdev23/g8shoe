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

        public List<CartItem> cartItems = new List<CartItem>();
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

        public class CartItem
        {
            public int ProductId { get; set; }
            public string Title { get; set; }
            public string Image { get; set; }
            public decimal Price { get; set; }
            public int Quantity { get; set; }
            public string Size { get; set; }
        }
    }
}