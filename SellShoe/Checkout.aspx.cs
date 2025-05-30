using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe
{
    public partial class Checkout : Page
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["OrderProduct"] != null)
                {
                    LoadOrderInfo();
                }
                else
                {
                    Response.Redirect("home.aspx");
                }
            }
        }

        private void LoadOrderInfo()
        {
            if (Session["OrderProduct"] != null)
            {
                dynamic orderProduct = Session["OrderProduct"];

                // Hiển thị thông tin sản phẩm
                lblOrderTitle.Text = orderProduct.Title;
                lblOrderTitle2.Text = orderProduct.Title;
                lblOrderSize.Text = orderProduct.Size;
                lblOrderQuantity.Text = orderProduct.Quantity.ToString();

                // Set hình ảnh
                imgOrderProduct.ImageUrl = orderProduct.Image;

                // Tính toán giá
                decimal priceSale = (decimal)orderProduct.PriceSale;
                int quantity = (int)orderProduct.Quantity;
                decimal totalAmount = priceSale * quantity;

                // Format giá tiền VND
                lblOrderPrice.Text = priceSale.ToString("N0") + " VND";
                lblOrderTotal.Text = totalAmount.ToString("N0") + " VND";
            }
        }

        protected void btnPay_Click(object sender, EventArgs e)
        {
            try
            {
                string name = txtFullName.Text.Trim();
                string phone = txtPhone.Text.Trim();
                string email = txtEmail.Text.Trim();
                string address = txtAddress.Text.Trim();

                if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(phone) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(address))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage",
                        "Swal.fire({ icon: 'warning', title: 'Thông báo', text: 'Vui lòng điền đầy đủ thông tin.' });", true);
                    return;
                }

                if (Session["OrderProduct"] == null)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "AlertMessage",
                        "Swal.fire({ icon: 'error', title: 'Lỗi', text: 'Phiên thanh toán đã hết hạn. Vui lòng chọn lại sản phẩm.' }).then(() => { window.location.href = 'product.aspx'; });", true);
                    return;
                }

                dynamic orderProduct = Session["OrderProduct"];
                int productId = (int)orderProduct.ID;
                int quantity = (int)orderProduct.Quantity;
                decimal priceSale = (decimal)orderProduct.PriceSale;
                string size = orderProduct.Size.ToString();
                string productTitle = orderProduct.Title.ToString();

                // Tạo đơn hàng
                tb_Order order = new tb_Order
                {
                    Code = "DH" + DateTime.Now.ToString("ddMMyyHHmmssff"),
                    CustomerName = name,
                    Phone = phone,
                    Address = address,
                    Email = email,
                    Quantity = quantity,
                    TotalAmount = priceSale * quantity,
                    CreatedDate = DateTime.Now,
                    ModifiedDate = DateTime.Now,
                    TypePayment = 1,
                    Status = 0
                };

                db.tb_Orders.InsertOnSubmit(order);
                db.SubmitChanges();

                // Lưu ID đơn hàng vào Session
                Session["lastOrderId"] = order.id;

                // Tạo trạng thái đơn hàng
                db.tb_OrderStatus.InsertOnSubmit(new tb_OrderStatus
                {
                    OrderID = order.id,
                    StatusTitle = "Đang chờ",
                    StatusDetail = "Đơn hàng đang chờ xác nhận.",
                    CreatedAt = DateTime.Now,
                    IsActive = true
                });
                db.SubmitChanges();

                // Tạo chi tiết đơn hàng
                db.tb_OrderDetails.InsertOnSubmit(new tb_OrderDetail
                {
                    OrderId = order.id,
                    ProductId = productId,
                    Price = priceSale,
                    Quantity = quantity,
                    Size = size
                });
                db.SubmitChanges();

                // Xóa Session sau khi đặt hàng thành công
                Session.Remove("OrderProduct");
                Session.Remove("OrderProductId");
                Session.Remove("OrderSize");
                Session.Remove("OrderQuantity");

                // Hiển thị thông báo thành công
                ScriptManager.RegisterStartupScript(this, GetType(), "SuccessMessage", @"
Swal.fire({
    icon: 'success',
    title: 'Đặt hàng thành công!',
    text: 'Chúng tôi đã nhận được đơn hàng của bạn. Mã đơn hàng: " + order.Code + @"',
    confirmButtonColor: '#004aad',
    confirmButtonText: 'Xem đơn hàng'
}).then((result) => {
    if (result.isConfirmed) {
        window.location.href = 'orderinfo.aspx';
    } else {
        window.location.href = 'home.aspx';
    }
});
", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ErrorMessage",
                    "Swal.fire({ icon: 'error', title: 'Lỗi', text: 'Đã xảy ra lỗi: " + ex.Message + "' });", true);
            }
        }
    }
}