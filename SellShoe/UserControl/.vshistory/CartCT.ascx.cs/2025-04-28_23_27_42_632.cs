using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using static SellShoe.UserControl.CartCT;

namespace SellShoe.UserControl
{
    public partial class CartCT : System.Web.UI.UserControl
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            // Load giỏ hàng từ session khi trang được tải
            if (Session["Cart"] == null)
            {
                Session["Cart"] = new List<CartItem>();
            }
        }

        // Lấy giỏ hàng từ session và hiển thị lên frontend
        void LoadCart()
        {
            // Lấy giỏ hàng từ session
            List<CartItem> cart = Session["Cart"] as List<CartItem>;
            if (cart != null && cart.Count > 0)
            {
                // Duyệt qua từng sản phẩm trong giỏ hàng để hiển thị
                StringBuilder html = new StringBuilder();

                foreach (var item in cart)
                {
                    decimal totalPrice = item.Price * item.Quantity;
                    html.Append("<tr>");
                    html.Append("<td><a href='#' onclick='removeFromCart(" + item.ProductId + ")'><i class='fad fa-trash-alt' style='color: red;'></i></a></td>");
                    html.Append("<td><img src='" + item.Image + "' alt='" + item.Title + "' /></td>");
                    html.Append("<td>" + item.Title + "</td>");
                    html.Append("<td>" + item.Price.ToString("C") + "</td>");
                    html.Append("<td><input type='number' value='" + item.Quantity + "' min='1' onchange='updateQuantity(" + item.ProductId + ", this.value)' /></td>");
                    html.Append("<td>" + totalPrice.ToString("C") + "</td>");
                    html.Append("</tr>");
                }

                // Đưa html vào bảng giỏ hàng
                cartItems.InnerHtml = html.ToString(); // cartItems là ID của tbody trong bảng giỏ hàng
            }
            else
            {
                cartItems.InnerHtml = "<tr><td colspan='6'>Giỏ hàng của bạn trống.</td></tr>";
            }
        }

        [WebMethod]
        public static void HandleAddToCart(int ProductId, int Quantity, string Size)
        {
            // Lấy thông tin sản phẩm từ DB
            using (var db = new QuanLyBanGiayDataContext())
            {
                var product = db.tb_Products.SingleOrDefault(p => p.id == ProductId);
                if (product != null)
                {
                    // Tạo đối tượng giỏ hàng
                    var cartItem = new CartItem
                    {
                        ProductId = product.id,
                        Title = product.Title,
                        Image = product.Image,
                        Price = product.PriceSale, // Nếu có giảm giá dùng PriceSale
                        Quantity = Quantity,
                        Size = Size
                    };

                    // Lấy giỏ hàng từ session
                    List<CartItem> cart = HttpContext.Current.Session["Cart"] as List<CartItem>;

                    // Thêm sản phẩm vào giỏ hàng (kiểm tra nếu sản phẩm đã có trong giỏ)
                    var existingItem = cart.FirstOrDefault(c => c.ProductId == ProductId && c.Size == Size);
                    if (existingItem != null)
                    {
                        existingItem.Quantity += Quantity; // Tăng số lượng nếu sản phẩm đã có
                    }
                    else
                    {
                        cart.Add(cartItem); // Thêm mới nếu sản phẩm chưa có
                    }

                    // Lưu lại giỏ hàng vào session
                    HttpContext.Current.Session["Cart"] = cart;
                }
            }
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