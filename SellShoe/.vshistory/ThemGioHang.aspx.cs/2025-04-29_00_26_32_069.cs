using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe
{
    public partial class ThemGioHang : System.Web.UI.Page
    {
        QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            int id = 0;
            int soluong = 1;

            if (Request.QueryString["id"] != null)
            {
                int.TryParse(Request.QueryString["id"], out id);
            }
            if (Request.QueryString["soluong"] != null)
            {
                int.TryParse(Request.QueryString["soluong"], out soluong);
            }

            if (id > 0)
            {
                tb_Product sp = db.tb_Products.FirstOrDefault(x => x.id == id);

                if (sp != null)
                {
                    List<CartItem> cart = new List<CartItem>();

                    if (Session["cart"] != null)
                    {
                        cart = (List<CartItem>)Session["cart"];
                    }

                    // Kiểm tra nếu sản phẩm đã tồn tại trong giỏ => cộng số lượng
                    CartItem existingItem = cart.FirstOrDefault(x => x.ProductId == id);
                    if (existingItem != null)
                    {
                        existingItem.Quantity += soluong;
                    }
                    else
                    {
                        CartItem newItem = new CartItem()
                        {
                            ProductId = sp.id,
                            ProductName = sp.Title,
                            ProductImage = sp.Image,
                            Price = (decimal)sp.PriceSale,
                            Quantity = soluong
                        };
                        cart.Add(newItem);
                    }

                    Session["cart"] = cart;
                }
            }

            Response.Redirect("Cart.aspx");
        }
    }

    public class CartItem
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public string ProductImage { get; set; }
        public string Image { get; set; }        // link hình ảnh
        public decimal Price { get; set; }
        public int Quantity { get; set; }
    }
}