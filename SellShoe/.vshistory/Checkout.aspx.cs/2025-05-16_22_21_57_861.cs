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

                // Kiểm tra dữ liệu đầu vào từ người dùng
                if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(phone) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(address))
                {
                    Response.Write("<script>alert('Vui lòng điền đầy đủ thông tin.');</script>");
                    return;
                }

                // 2. Lấy dữ liệu sản phẩm từ QueryString
                int productId; // ID sản phẩm
                int quantity; // Số lượng sản phẩm
                decimal price; // Giá sản phẩm

                if (!int.TryParse(Request.QueryString["productId"], out productId) || // Lấy productId từ QueryString
                    !int.TryParse(Request.QueryString["quantity"], out quantity) || // Lấy quantity từ QueryString
                    !decimal.TryParse(Request.QueryString["price"].Replace(".", ""), out price)) // xử lý số có dấu chấm
                {
                    Response.Write("<script>alert('Dữ liệu sản phẩm không hợp lệ.');</script>"); // Kiểm tra dữ liệu sản phẩm
                    return;
                }

                string size = Request.QueryString["size"]; // Lấy size từ QueryString


                // 3. Tạo đơn hàng (tb_Order)
                tb_Order order = new tb_Order
                {
                    Code = "DH" + DateTime.Now.ToString("ddMMyyyyHHmm"),  // Mã đơn hàng
                    CustomerName = name,
                    Phone = phone,
                    Address = address,
                    Email = email,
                    Quantity = quantity,
                    TotalAmount = price * quantity,  // Tính tổng giá trị đơn hàng
                    CreatedDate = DateTime.Now,
                    ModifiedDate = DateTime.Now,
                    TypePayment = 1,  // 1 = Thanh toán khi nhận hàng
                    Status = 0  // 0 = Chưa xử lý
                };

                // Insert đơn hàng vào bảng tb_Order
                db.tb_Orders.InsertOnSubmit(order);
                db.SubmitChanges();
                Session["lastOrderId"] = order.id;

                // 3.1 Insert trạng thái mặc định "Đang chờ"
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

                // 4. Tạo chi tiết đơn hàng (tb_OrderDetail)
                tb_OrderDetail detail = new tb_OrderDetail
                {
                    OrderId = order.id,  // ID của đơn hàng vừa tạo
                    ProductId = productId,
                    Price = price,
                    Quantity = quantity,
                    Size = size  // Lưu size sản phẩm vào tb_OrderDetail
                };

                // Insert chi tiết đơn hàng vào bảng tb_OrderDetail
                db.tb_OrderDetails.InsertOnSubmit(detail);
                db.SubmitChanges();

                // 5. Hiển thị thông báo thành công hoặc chuyển hướng
                ScriptManager.RegisterStartupScript(this, GetType(), "SuccessMessage", @"
    Swal.fire({
        icon: 'success',
        title: 'Đặt hàng thành công!',
        text: 'Chúng tôi đã nhận được đơn hàng của bạn!',
        confirmButtonColor: ""#004aad"",
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
                // Xử lý lỗi, có thể ghi log hoặc hiển thị thông báo
                Response.Write("<script>alert('Đã xảy ra lỗi khi xử lý đơn hàng: " + ex.Message + "');</script>");
                Response.Redirect("error.aspx"); // Chuyển hướng về trang sản phẩm
            }
        }
    }

}