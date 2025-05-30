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
                if (Session["OrderProductId"] != null && Session["OrderSize"] != null && Session["OrderQuantity"] != null)
                {
                    int productId = (int)Session["OrderProductId"];
                    string size = Session["OrderSize"].ToString();
                    int quantity = (int)Session["OrderQuantity"];
                                        
                }
                else
                {
                    Response.Redirect("home.aspx");
                }
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
                    Response.Write("<script>alert('Vui lòng điền đầy đủ thông tin.');</script>");
                    return;
                }

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

                db.tb_OrderStatus.InsertOnSubmit(new tb_OrderStatus
                {
                    OrderID = order.id,
                    StatusTitle = "Đang chờ",
                    StatusDetail = "Đơn hàng đang chờ xác nhận.",
                    CreatedAt = DateTime.Now,
                    IsActive = true
                });
                db.SubmitChanges();

                db.tb_OrderDetails.InsertOnSubmit(new tb_OrderDetail
                {
                    OrderId = order.id,
                    ProductId = productId,
                    Price = price,
                    Quantity = quantity,
                    Size = size
                });
                db.SubmitChanges();

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