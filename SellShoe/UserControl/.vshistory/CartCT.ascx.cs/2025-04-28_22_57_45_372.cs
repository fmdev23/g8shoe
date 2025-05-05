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
            LoadCart();

            if (Request.QueryString["remove"] != null)
            {
                RemoveCartItem();
            }
        }

        private void LoadCart()
        {
            if (Session["Cart"] != null)
            {
                cartItems = Session["Cart"] as List<CartItem>;
            }
        }

        private void RemoveCartItem()
        {
            int productId = 0;
            string size = "";

            if (Request.QueryString["remove"] != null)
            {
                int.TryParse(Request.QueryString["remove"], out productId);
            }

            if (Request.QueryString["size"] != null)
            {
                size = Request.QueryString["size"];
            }

            List<CartItem> cart = Session["Cart"] as List<CartItem>;
            if (cart != null)
            {
                var itemToRemove = cart.FirstOrDefault(x => x.ProductId == productId && x.Size == size);
                if (itemToRemove != null)
                {
                    cart.Remove(itemToRemove);
                    Session["Cart"] = cart;
                }
            }

            Response.Redirect("~/Cart.aspx");
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