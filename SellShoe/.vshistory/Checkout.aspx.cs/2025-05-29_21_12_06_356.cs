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
                // Kiểm tra nếu không có thông tin sản phẩm trong Session thì chuyển hướng
                if (Session["checkoutProduct"] == null)
                {
                    Response.Redirect("default.aspx");
                    return;
                }

                // Lấy sản phẩm từ session và hiển thị lên form
                var product = (ProductCheckoutSession)Session["checkoutProduct"];
                lblProductName.Text = product.Name;
                lblPrice.Text = product.Price.ToString("N0") + " đ";
                lblQuantity.Text = product.Quantity.ToString();
                lblSize.Text = product.Size;
                lblTotal.Text = (product.Price * product.Quantity).ToString("N0") + " đ";
            }
        }

        protected void btnPay_Click(object sender, EventArgs e)
        {
            try
            {
                // 1. Lấy thông tin người mua từ form
                string name = txtFullName.Text.Trim();
                string phone = txtPhone.Text.Trim();
                string email = txtEmail.Text.Trim();
                string address = txtAddress.Text.Trim();

                if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(phone) ||
                    string.IsNullOrEmpty(email) || string.IsNullOrEmpty(address))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "missingInfo",
                        "Swal.fire('Thiếu thông tin', 'Vui lòng điền đầy đủ thông tin giao hàng.', 'warning');", true);
                    return;
                }

                // 2. Lấy thông tin sản phẩm từ Session
                var product = (ProductCheckoutSession)Session["checkoutProduct"];
                if (product == null)
                {
                    Response.Redirect("default.aspx");
                    return;
                }

                // 3. Tạo đơn hàng (tb_Order)
                tb_Order order = new tb_Order
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
                    TypePayment = 1, // COD
                    Status = 0       // Chưa xử lý
                };

                db.tb_Orders.InsertOnSubmit(order);
                db.SubmitChanges();
                Session["lastOrderId"] = order.id;

                // 3.1 Trạng thái đơn hàng: Đang chờ
                tb_OrderStatus status = new tb_OrderStatus
                {
                    OrderID = order.id,
                    StatusTitle = "Đang chờ",
                    StatusDetail = "Đơn hàng đang chờ xác nhận.",
                    CreatedAt = DateTime.Now,
                    IsActive = true
                };

                db.tb_OrderStatus.InsertOnSubmit(status);
                db.SubmitChanges();

                // 4. Chi tiết đơn hàng
                tb_OrderDetail detail = new tb_OrderDetail
                {
                    OrderId = order.id,
                    ProductId = product.ProductId,
                    Price = product.Price,
                    Quantity = product.Quantity,
                    Size = product.Size
                };

                db.tb_OrderDetails.InsertOnSubmit(detail);
                db.SubmitChanges();

                // 5. Hiển thị thông báo thành công
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
                // Ghi log hoặc chuyển hướng lỗi
                Response.Redirect("error.aspx?msg=" + HttpUtility.UrlEncode(ex.Message));
            }
        }

        // Định nghĩa lớp trung gian để truyền dữ liệu sản phẩm qua Session
        [Serializable]
        public class ProductCheckoutSession
        {
            public int ProductId { get; set; }
            public string Name { get; set; }
            public decimal Price { get; set; }
            public int Quantity { get; set; }
            public string Size { get; set; }
        }
    }

}