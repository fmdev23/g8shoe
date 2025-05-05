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
            int quantity = 1;
            int size = 0;

            if (Request.QueryString["id"] != null)
            {
                int.TryParse(Request.QueryString["id"], out id);
            }
            if (Request.QueryString["quantity"] != null)
            {
                int.TryParse(Request.QueryString["quantity"], out quantity);
            }
            if (Request.QueryString["size"] != null)
            {
                int.TryParse(Request.QueryString["size"], out size);
            }

            if (id > 0)
            {
                tb_Product sp = db.tb_Products.FirstOrDefault(p => p.id == id && p.IsActive == true);
                if (sp != null)
                {
                    List<CartItem> cart = new List<CartItem>();
                    if (Session["cart"] != null)
                    {
                        cart = (List<CartItem>)Session["cart"];
                    }

                    // Kiểm tra nếu sản phẩm + size đã có thì chỉ cộng thêm số lượng
                    CartItem item = cart.Find(x => x.ProductId == id && x.Size == size);
                    if (item != null)
                    {
                        item.Quantity += quantity;
                        item.TotalPrice = item.Quantity * item.Price;
                    }
                    else
                    {
                        CartItem newItem = new CartItem()
                        {
                            ProductId = sp.id,
                            ProductName = sp.Title,
                            Image = sp.Image,
                            Price = sp.PriceSale ?? sp.Price,
                            Quantity = quantity,
                            Size = size,
                            TotalPrice = quantity * (sp.PriceSale ?? sp.Price)
                        };
                        cart.Add(newItem);
                    }

                    Session["cart"] = cart;
                }
            }

            Response.Redirect("Cart.aspx");
        }
    
    }
}