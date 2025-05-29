using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.Admin
{
    public partial class QLOrder : System.Web.UI.Page
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public static List<tb_Order> listOD = new List<tb_Order>();
        public tb_OrderStatus listStatus = new tb_OrderStatus();
        public static List<OrderDisplayInfo> listDisplay = new List<OrderDisplayInfo>();

        void Page_Load(object sender, EventArgs e)
        {
            CheckDangNhap();
            if (!IsPostBack)
            {
                loadOrder();
                HandleDeleteOrder();
            }
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Xoá session
            Session.Clear();
            Session.Abandon();

            Response.Redirect("~/adminlogin.aspx");
        }

        void CheckDangNhap()
        {
            if (Session["Admin"] != null && Session["Password"] != null)
            {
                var data = from q in db.tb_AccountAdmins
                           where q.TenBien == "Admin"
                           && q.GiaTri == Session["Admin"].ToString()
                           select q;
                var dataPass = from q in db.tb_AccountAdmins
                               where q.TenBien == "Password"
                               && q.GiaTri == Session["Password"].ToString()
                               select q;
                if (data != null && data.Count() > 0)
                {

                }
                else
                {
                    Response.Redirect("../AdminLogin.aspx");
                }
            }
            else
            {
                Response.Redirect("../AdminLogin.aspx");
            }
        }

        void loadOrder()
        {
            listDisplay.Clear(); // Xóa dữ liệu cũ

            var query = from o in db.tb_Orders // Lấy tất cả đơn hàng
                        join od in db.tb_OrderDetails on o.id equals od.OrderId into odGroup // Kết nối với bảng OrderDetails
                        from od in odGroup.DefaultIfEmpty() // Sử dụng DefaultIfEmpty để lấy tất cả đơn hàng kể cả không có chi tiết
                        join p in db.tb_Products on od.ProductId equals p.id into pGroup // Kết nối với bảng Products
                        from p in pGroup.DefaultIfEmpty() // Sử dụng DefaultIfEmpty để lấy tất cả chi tiết kể cả không có sản phẩm
                        orderby o.CreatedDate descending // Sắp xếp theo ngày tạo mới nhất
                        select new OrderDisplayInfo 
                        {
                            Order = o, // Thông tin đơn hàng
                            ProductImage = p != null ? p.Image : "" // Lấy hình ảnh sản phẩm, nếu có
                        };

            listDisplay = query.ToList(); // Chuyển đổi kết quả truy vấn thành danh sách

            rptOrders.DataSource = listDisplay; // Gán dữ liệu cho Repeater
            rptOrders.DataBind(); // Hiển thị ra UI
        }

        [WebMethod]
        public static bool ToggleOrderStatus(int id)
        {
            try
            {
                QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
                var order = db.tb_Orders.FirstOrDefault(o => o.id == id); // Lấy đơn hàng theo ID
                if (order != null)
                {
                    int newStatus = (order.Status == 0) ? 1 : 0; // Chuyển đổi trạng thái: 0 -> 1 hoặc 1 -> 0
                    order.Status = newStatus; // Cập nhật trạng thái đơn hàng
                    order.ModifiedDate = DateTime.Now; // Cập nhật ngày sửa đổi

                    var oldStatuses = db.tb_OrderStatus.Where(s => s.OrderID == order.id && s.IsActive == true); // Lấy các trạng thái cũ đang hoạt động
                    foreach (var s in oldStatuses) 
                        s.IsActive = false; // Đặt trạng thái cũ thành không hoạt động

                    tb_OrderStatus statusLog = new tb_OrderStatus // Tạo bản ghi trạng thái mới
                    {
                        OrderID = order.id, // Gán ID đơn hàng
                        StatusTitle = (newStatus == 1) ? "Đã xác nhận" : "Đang chờ", // Tiêu đề trạng thái mới
                        StatusDetail = (newStatus == 1) ? "Đơn hàng của bạn đã được xác nhận!." : "Đơn hàng đang chờ xác nhận.", // Chi tiết trạng thái mới
                        CreatedAt = DateTime.Now, // Gán thời gian tạo trạng thái mới
                        IsActive = true // Đặt trạng thái mới là hoạt động
                    };
                    db.tb_OrderStatus.InsertOnSubmit(statusLog); // Thêm bản ghi trạng thái mới vào cơ sở dữ liệu
                    db.SubmitChanges();

                    // Gọi Task thêm "Đang vận chuyển" sau 5 giây
                    if (newStatus == 1) // Nếu trạng thái mới là "Đã xác nhận"
                    {
                        System.Threading.ThreadPool.QueueUserWorkItem(_ => // Tạo một tác vụ không đồng bộ
                        {
                            System.Threading.Thread.Sleep(5000); // Delay 5 giây

                            try
                            {
                                QuanLyBanGiayDataContext dbDelay = new QuanLyBanGiayDataContext();

                                // Chuyển tất cả các trạng thái về Inactive
                                var old = dbDelay.tb_OrderStatus.Where(s => s.OrderID == order.id && s.IsActive == true); // Lấy các trạng thái cũ đang hoạt động
                                foreach (var s in old)
                                    s.IsActive = false; // Đặt trạng thái cũ thành không hoạt động

                                tb_OrderStatus newStatusEntry = new tb_OrderStatus
                                {
                                    OrderID = order.id, 
                                    StatusTitle = "Đang vận chuyển",
                                    StatusDetail = "Đơn hàng đang được giao đến bạn.",
                                    CreatedAt = DateTime.Now,
                                    IsActive = true
                                };

                                dbDelay.tb_OrderStatus.InsertOnSubmit(newStatusEntry);
                                dbDelay.SubmitChanges();
                            }
                            catch
                            {

                            }
                        });
                    }

                    return true;
                }
                return false;
            }
            catch
            {
                return false;
            }
        }

        void HandleDeleteOrder()
        {
            string idStr = Request.QueryString["deleteId"]; // Lấy ID từ query string
            if (!string.IsNullOrEmpty(idStr)) // Kiểm tra nếu ID không rỗng
            {
                int orderId = int.Parse(idStr); // Chuyển đổi ID sang kiểu int

                var order = db.tb_Orders.FirstOrDefault(o => o.id == orderId); // Lấy đơn hàng theo ID
                if (order != null) // Nếu tìm thấy đơn hàng
                {
                    var details = db.tb_OrderDetails.Where(d => d.OrderId == orderId).ToList(); // Lấy tất cả chi tiết đơn hàng theo ID
                    db.tb_OrderDetails.DeleteAllOnSubmit(details); // Xoá tất cả chi tiết đơn hàng

                    var statuses = db.tb_OrderStatus.Where(s => s.OrderID == orderId).ToList(); // Lấy tất cả trạng thái đơn hàng theo ID
                    db.tb_OrderStatus.DeleteAllOnSubmit(statuses); // Xoá tất cả trạng thái đơn hàng

                    db.tb_Orders.DeleteOnSubmit(order); // Xoá đơn hàng
                    db.SubmitChanges();
                    loadOrder(); // Reload danh sách
                }
            }
        }

        public class OrderDisplayInfo
        {
            public tb_Order Order { get; set; }
            public string ProductImage { get; set; }
        }

    }
}