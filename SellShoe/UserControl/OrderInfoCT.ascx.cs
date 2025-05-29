using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.UserControl
{
    public partial class OrderInfoCT : System.Web.UI.UserControl
    {
        QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOrder();
            }
        }

        void LoadOrder()
        {
            tb_Order order = null; // Khởi tạo biến order

            // Ưu tiên đơn mới đặt
            if (Session["lastOrderId"] != null) // Kiểm tra xem có đơn hàng mới nhất không
            {
                int orderId = (int)Session["lastOrderId"]; // Lấy ID đơn hàng từ Session
                order = db.tb_Orders.FirstOrDefault(o => o.id == orderId); // Tìm đơn hàng theo ID
            }
            else if (Session["user"] != null) // Kiểm tra xem có người dùng đăng nhập không
            {
                string user = Session["user"].ToString(); // Lấy tên người dùng từ Session
                order = db.tb_Orders // Tìm đơn hàng mới nhất của người dùng
                    .Where(o => o.CustomerName == user) // Lọc theo tên người dùng
                    .OrderByDescending(o => o.CreatedDate) // Sắp xếp theo ngày tạo giảm dần
                    .FirstOrDefault(); // Lấy đơn hàng đầu tiên (mới nhất)
            }

            if (order != null) // Nếu tìm thấy đơn hàng
            {
                pnlNoOrder.Visible = false; // Ẩn thông báo không có đơn hàng
                pnlOrderInfo.Visible = true;// Hiển thị thông tin đơn hàng

                ViewState["CurrentOrderID"] = order.id; // Lưu ID đơn hàng vào ViewState để sử dụng sau này

                // Load thông tin người nhận
                lblRecipientName.Text = order.CustomerName; 
                lblPhone.Text = order.Phone;
                lblAddress.Text = order.Address;
                lblOrderCode.Text = order.Code;

                // Load sản phẩm trong đơn hàng
                var orderDetail = db.tb_OrderDetails.FirstOrDefault(od => od.OrderId == order.id); // Lấy chi tiết đơn hàng đầu tiên (nếu có)
                if (orderDetail != null) // Nếu có chi tiết đơn hàng
                {
                    var product = db.tb_Products.FirstOrDefault(p => p.id == orderDetail.ProductId); // Tìm sản phẩm theo ID trong chi tiết đơn hàng
                    if (product != null) // Nếu tìm thấy sản phẩm
                    {
                        imgProduct.ImageUrl = product.Image; // Hiển thị ảnh sản phẩm
                        lblProductTitle.Text = product.Title;
                        lblQuantity.Text = orderDetail.Quantity.ToString();
                        lblSize.Text = orderDetail.Size;
                        lblPayment.Text = $"Thanh toán: {order.TotalAmount.ToString("N0").Replace(",", ".")} VND khi nhận hàng";
                    }
                }

                // Load timeline trạng thái đơn hàng
                var timelineData = db.tb_OrderStatus // Lấy tất cả trạng thái đơn hàng liên quan đến đơn hàng hiện tại
                    .Where(s => s.OrderID == order.id) // Lọc theo ID đơn hàng
                    .OrderByDescending(s => s.CreatedAt) // Sắp xếp theo ngày tạo giảm dần
                    .ToList();

                rptTimeline.DataSource = timelineData; // Gán dữ liệu vào Repeater
                rptTimeline.DataBind(); // Ràng buộc dữ liệu vào Repeater để hiển thị timeline trạng thái
            }
            else
            {
                // Không có đơn hàng nào
                pnlNoOrder.Visible = true;
                pnlOrderInfo.Visible = false;
            }
        }

        protected void btnCancelOrder_Click(object sender, EventArgs e) // Xử lý sự kiện khi người dùng nhấn nút huỷ đơn hàng
        {
            if (ViewState["CurrentOrderID"] != null) // Kiểm tra xem có ID đơn hàng trong ViewState không
            {
                int orderId = Convert.ToInt32(ViewState["CurrentOrderID"]); // Lấy ID đơn hàng từ ViewState

                // Xóa chi tiết đơn hàng trước (foreign key)
                var details = db.tb_OrderDetails.Where(d => d.OrderId == orderId).ToList(); // Lấy tất cả chi tiết đơn hàng liên quan đến ID đơn hàng
                db.tb_OrderDetails.DeleteAllOnSubmit(details); // Xoá tất cả chi tiết đơn hàng

                // Xóa timeline trạng thái (nếu có)
                var statuses = db.tb_OrderStatus.Where(s => s.OrderID == orderId).ToList(); // Lấy tất cả trạng thái đơn hàng liên quan đến ID đơn hàng
                db.tb_OrderStatus.DeleteAllOnSubmit(statuses); // Xoá tất cả trạng thái đơn hàng

                // Xóa đơn hàng
                var order = db.tb_Orders.FirstOrDefault(o => o.id == orderId);
                if (order != null)
                {
                    db.tb_Orders.DeleteOnSubmit(order); // Xoá đơn hàng
                    db.SubmitChanges();

                    // Hiển thị thông báo huỷ đơn hàng thành công bằng SweetAlert2
                    string sweetAlert = @" 
                <script>
                    Swal.fire({
                        icon: 'success',
                        title: 'Huỷ thành công!',
                        text: 'Đơn hàng của bạn đã được huỷ. Đặt đơn mới nha',
                        confirmButtonColor: '#004aad',
                        confirmButtonText: 'OK'
                    }).then(() => {
                        window.location.href = 'product.aspx';
                    });
                </script>";

                    ScriptManager.RegisterStartupScript(this, GetType(), "swalRedirect", sweetAlert, false);
                }

            }
        }

    }
}
