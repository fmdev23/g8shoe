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

                // 2. Lấy dữ liệu sản phẩm từ QueryString
                int productId = int.Parse(Request.QueryString["productId"]);
                decimal price = decimal.Parse(Request.QueryString["price"]);
                int quantity = int.Parse(Request.QueryString["quantity"]);
                string size = Request.QueryString["size"]; // nếu bạn muốn lưu thêm

                // 3. Tạo đơn hàng (tb_Order)
                tb_Order order = new tb_Order
                {
                    Code = "DH" + DateTime.Now.Ticks,
                    CustomerName = name,
                    Phone = phone,
                    Address = address,
                    Email = email,
                    Quantity = quantity,
                    TotalAmount = price * quantity,
                    CreatedDate = DateTime.Now,
                    ModifiedDate = DateTime.Now,
                    TypePayment = 1, // ví dụ: 1 = Thanh toán khi nhận hàng
                    Status = 0       // ví dụ: 0 = chưa xử lý
                };

                db.tb_Orders.InsertOnSubmit(order);
                db.SubmitChanges();

                // 4. Tạo chi tiết đơn hàng (tb_OrderDetail)
                tb_OrderDetail detail = new tb_OrderDetail
                {
                    OrderId = order.id,
                    ProductId = productId,
                    Price = price,
                    Quantity = quantity
                };

                db.tb_OrderDetails.InsertOnSubmit(detail);
                db.SubmitChanges();

                // 5. Hiển thị thông báo / chuyển hướng
                Response.Redirect("success.aspx"); // hoặc hiển thị modal
            }
            catch (Exception ex)
            {
                // Xử lý lỗi, có thể ghi log hoặc hiển thị thông báo
                Response.Write("<script>alert('Đã xảy ra lỗi khi xử lý đơn hàng: " + ex.Message + "');</script>");
            }
        }

    }
}