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
            loadCart();
        }

        void loadCart()
        {
            if (Session["cart"] != null)
            {
                List<CartItem> cart = (List<CartItem>)Session["cart"];
                if (cart.Count > 0)
                {
                    foreach (var item in cart)
                    {
                        cartItems.InnerHtml += $@"
                <tr>
                    <td><a href='XoaGioHang.aspx?id={item.ProductId}'><i class='fad fa-trash-alt' style='color: red;'></i></a></td>
                    <td><img src='{item.Image}' alt='' style='width: 80px;'></td>
                    <td>{item.ProductName}</td>
                    <td>{item.Price:N0} đ</td>
                    <td><input type='number' value='{item.Quantity}' min='1' readonly></td>
                    <td>{item.TotalPrice:N0} đ</td>
                </tr>
            ";
                    }
                }
                else
                {
                    cartItems.InnerHtml = "<tr><td colspan='6'>Giỏ hàng của bạn đang trống.</td></tr>";
                }
            }
            else
            {
                cartItems.InnerHtml = "<tr><td colspan='6'>Giỏ hàng của bạn đang trống.</td></tr>";
            }
        }

    }
}