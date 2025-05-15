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
            // Kiểm tra nếu có lỗi trong URL thì hiển thị thông báo (nếu cần thiết)
            if (Request.QueryString["productId"] == null || Request.QueryString["price"] == null || Request.QueryString["quantity"] == null || Request.QueryString["size"] == null)
            {
                Response.Write("<script>alert('Dữ liệu không hợp lệ!');</script>");
                return;
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

                // Kiểm tra dữ liệu đầu vào từ người dùng
                if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(phone) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(address))
                {
                    Response.Write("<script>alert('Vui lòng điền đầy đủ thông tin.');</script>");
                    return;
                }

                // 2. Lấy dữ liệu sản phẩm từ QueryString
                int productId = int.Parse(Request.QueryString["productId"]);
                decimal price = decimal.Parse(Request.QueryString["price"]);
                int quantity = int.Parse(Request.QueryString["quantity"]);
                string size = Request.QueryString["size"]; // lưu size sản phẩm từ QueryString

                // Kiểm tra thông tin sản phẩm
                if (quantity <= 0)
                {
                    Response.Write("<script>alert('Số lượng sản phẩm không hợp lệ.');</script>");
                    return;
                }

                // 3. Tạo đơn hàng (tb_Order)
                tb_Order order = new tb_Order
                {
                    Code = "DH" + DateTime.Now.Ticks,  // Mã đơn hàng tự sinh
                    CustomerName = name,
                    Phone = phone,
                    Address = address,
                    Email = email,
                    Quantity = quantity,
                    TotalAmount = price * quantity,  // Tính tổng giá trị đơn hàng
                    CreatedDate = DateTime.Now,
                    ModifiedDate = DateTime.Now,
                    TypePayment = 1,  // 1 = Thanh toán khi nhận hàng (có thể thay đổi nếu cần)
                    Status = 0  // 0 = Chưa xử lý
                };

                // Insert đơn hàng vào bảng tb_Order
                db.tb_Orders.InsertOnSubmit(order);
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
                Response.Redirect("home.aspx");  // Hoặc chuyển hướng đến trang khác (ví dụ: "home.aspx")
            }
            catch (Exception ex)
            {
                // Xử lý lỗi, có thể ghi log hoặc hiển thị thông báo
                Response.Write("<script>alert('Đã xảy ra lỗi khi xử lý đơn hàng: " + ex.Message + "');</script>");
            }
        }
    }

}