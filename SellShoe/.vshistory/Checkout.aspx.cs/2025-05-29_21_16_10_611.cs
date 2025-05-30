using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe
{
    public partial class Checkout : System.Web.UI.Page
    {
        QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["checkoutProduct"] is not ProductCheckoutSession product)
                {
                    Response.Redirect("default.aspx");
                    return;
                }

                // Bind dữ liệu ra giao diện
                litProductTitle.Text = product.Name;
                litTitle.Text = product.Name;
                litPrice.Text = product.Price.ToString("N0") + " đ";
                litQuantity.Text = product.Quantity.ToString();
                litSize.Text = product.Size;
                litTotal.Text = (product.Price * product.Quantity).ToString("N0") + " đ";
                imgProduct.ImageUrl = product.ImageUrl;
            }
        }

        protected void btnPay_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["checkoutProduct"] is not ProductCheckoutSession product)
                {
                    Response.Redirect("default.aspx");
                    return;
                }

                string name = txtFullName.Text.Trim();
                string phone = txtPhone.Text.Trim();
                string email = txtEmail.Text.Trim();
                string address = txtAddress.Text.Trim();

                if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(phone) ||
                    string.IsNullOrEmpty(email) || string.IsNullOrEmpty(address))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "missing",
                        "Swal.fire('Thiếu thông tin', 'Vui lòng nhập đủ thông tin giao hàng!', 'warning');", true);
                    return;
                }

                // Tạo đơn hàng
                var order = new tb_Order
                {
                    Code = "DH" + DateTime.Now.ToString("ddMMyyHHmmssff"),
                    CustomerName = name,
                    Phone = phone,
                    Email = email,
                    Address = address,
                    Quantity = product.Quantity,
                    TotalAmount = product.Price * product.Quantity,
                    CreatedDate = DateTime.Now,
                    ModifiedDate = DateTime.Now,
                    TypePayment = 1,
                    Status = 0
                };

                db.tb_Orders.InsertOnSubmit(order);
                db.SubmitChanges();

                // Trạng thái: Đang chờ
                db.tb_OrderStatus.InsertOnSubmit(new tb_OrderStatus
                {
                    OrderID = order.id,
                    StatusTitle = "Đang chờ",
                    StatusDetail = "Đơn hàng đang chờ xác nhận.",
                    CreatedAt = DateTime.Now,
                    IsActive = true
                });
                db.SubmitChanges();

                // Chi tiết đơn hàng
                db.tb_OrderDetails.InsertOnSubmit(new tb_OrderDetail
                {
                    OrderId = order.id,
                    ProductId = product.ProductId,
                    Price = product.Price,
                    Quantity = product.Quantity,
                    Size = product.Size
                });
                db.SubmitChanges();

                Session["lastOrderId"] = order.id;
                Session.Remove("checkoutProduct");

                ScriptManager.RegisterStartupScript(this, GetType(), "success", @"
Swal.fire({
    icon: 'success',
    title: 'Đặt hàng thành công!',
    text: 'Chúng tôi đã nhận được đơn hàng của bạn!',
    confirmButtonText: 'Xem đơn hàng',
    confirmButtonColor: '#004aad'
}).then((result) => {
    if (result.isConfirmed) {
        window.location.href = 'orderinfo.aspx';
    }
});", true);
            }
            catch (Exception ex)
            {
                Response.Redirect("error.aspx?msg=" + HttpUtility.UrlEncode(ex.Message));
            }
        }

        [Serializable]
        public class ProductCheckoutSession
        {
            public int ProductId { get; set; }
            public string Name { get; set; }
            public decimal Price { get; set; }
            public int Quantity { get; set; }
            public string Size { get; set; }
            public string ImageUrl { get; set; }
        }
    }

}