using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.Admin
{
    public partial class Dash : System.Web.UI.Page
    {
        // ViewModel: Định nghĩa lớp trung gian để dễ bind ra view (tránh thao tác trực tiếp với entity gốc)
        public class OrderViewModel
        {
            public string Code { get; set; }              // Mã đơn hàng
            public DateTime? CreatedDate { get; set; }    // Ngày tạo đơn
            public decimal TotalAmount { get; set; }      // Tổng tiền của đơn
            public string Status { get; set; }            // Trạng thái hiển thị (chuỗi mô tả)
        }

        public List<OrderViewModel> listOD = new List<OrderViewModel>(); // Danh sách đơn hàng để hiển thị lên UI
        public decimal TotalRevenue = 0; // Tổng doanh thu (chỉ cộng đơn đã xác nhận)

        QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext(); // Khởi tạo kết nối tới database

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) // Chỉ chạy khi lần đầu load trang (tránh reload nhiều lần sau PostBack)
            {
                LoadRecentOrders(); // Gọi hàm load dữ liệu
            }
        }

        void LoadRecentOrders()
        {
            // Lấy danh sách 5 đơn mới nhất, sắp xếp theo ngày tạo (mới nhất -> cũ)
            listOD = (from o in db.tb_Orders
                      orderby o.CreatedDate descending
                      select new OrderViewModel
                      {
                          Code = o.Code,
                          CreatedDate = o.CreatedDate,
                          TotalAmount = o.TotalAmount,
                          Status = o.Status == 1 ? "Đã xác nhận" :
                                   o.Status == 0 ? "Đang chờ" :
                                   "Đã huỷ"
                      })
                     .Take(5) // Giới hạn chỉ lấy 5 đơn gần nhất
                     .ToList(); // Chuyển sang List để dễ dùng trong .aspx

            // Tính tổng doanh thu từ các đơn có Status là "Đã xác nhận"
            TotalRevenue = (from o in db.tb_Orders
                            where o.Status == 1 // Trạng thái "Đã xác nhận"
                            select o.TotalAmount)
                   .Sum();
        }
    }

}