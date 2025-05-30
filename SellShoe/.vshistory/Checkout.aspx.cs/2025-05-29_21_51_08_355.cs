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
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["CurrentCheckout"] == null)
                {
                    Response.Redirect("product.aspx");
                    return;
                }

                dynamic checkout = Session["CurrentCheckout"];

                // Gán thông tin sản phẩm ra UI
                imgProduct.ImageUrl = checkout.Image;
                lblTitle.InnerText = checkout.Title;
                lblProductName.InnerText = checkout.Title;
                lblSize.InnerText = "Size: " + checkout.Size;
                lblQuantity.InnerText = "Số lượng: " + checkout.Quantity;
                lblPrice.InnerText = ((decimal)checkout.Price).ToString("N0") + " VND";
                lblTotal.InnerText = ((decimal)checkout.Price * checkout.Quantity).ToString("N0") + " VND";
            }
        }

        protected void btnPay_Click(object sender, EventArgs e)
        {
            try
            {
                // 1. Lấy dữ liệu người dùng từ form
                string name = txtFullName.Text.Trim();
                string phone = txtPhone.Text.Trim();
                string email = txtEmail.Text.Trim();
                string address = txtAddress.Text.Trim();

                if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(phone) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(address))
                {
                    Response.Write("<script>alert('Vui lòng điền đầy đủ thông tin.');</script>");
                    return;
                }

                // 2. Lấy dữ liệu sản phẩm từ Session
                if (Session["CurrentCheckout"] == null)
                {
                    Response.Write("<script>alert('Phiên thanh toán đã hết hạn. Vui lòng chọn lại sản phẩm.');</script>");
                    Response.Redirect("product.aspx");
                    return;
                }

                dynamic checkout = Session["CurrentCheckout"];
                int productId = checkout.ProductID;
                int quantity = checkout.Quantity;
                decimal price = (decimal)checkout.Price;
                string size = checkout.Size;

                // 3. Tạo đơn hàng
                tb_Order order = new tb_Order
                {
                    Code = "DH" + DateTime.Now.ToString("ddMMyyHHmmssff"),
                    CustomerName = name,
                    Phone = phone,
                    Address = address,
                    Email = email,
                    Quantity = quantity,
                    TotalAmount = price * quantity,
                    CreatedDate = DateTime.Now,
                    ModifiedDate = DateTime.Now,
                    TypePayment = 1,
                    Status = 0
                };
                db.tb_Orders.InsertOnSubmit(order);
                db.SubmitChanges();
                Session["lastOrderId"] = order.id;

                // 3.1 Trạng thái ban đầu
                db.tb_OrderStatus.InsertOnSubmit(new tb_OrderStatus
                {
                    OrderID = order.id,
                    StatusTitle = "Đang chờ",
                    StatusDetail = "Đơn hàng đang chờ xác nhận.",
                    CreatedAt = DateTime.Now,
                    IsActive = true
                });
                db.SubmitChanges();

                // 4. Tạo chi tiết đơn hàng
                db.tb_OrderDetails.InsertOnSubmit(new tb_OrderDetail
                {
                    OrderId = order.id,
                    ProductId = productId,
                    Price = price,
                    Quantity = quantity,
                    Size = size
                });
                db.SubmitChanges();

                // 5. Gửi thông báo
                ScriptManager.RegisterStartupScript(this, GetType(), "SuccessMessage", @"
Swal.fire({
    icon: 'success',
    title: 'Đặt hàng thành công!',
    text: 'Chúng tôi đã nhận được đơn hàng của bạn!',
    confirmButtonColor: '#004aad',
    confirmButtonText: 'Xem đơn hàng'
}).then((result) => {
    if (result.isConfirmed) {
        window.location.href = 'orderinfo.aspx';
    }
});
", true);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Đã xảy ra lỗi: " + ex.Message + "');</script>");
                Response.Redirect("error.aspx");
            }
        }
    }

}