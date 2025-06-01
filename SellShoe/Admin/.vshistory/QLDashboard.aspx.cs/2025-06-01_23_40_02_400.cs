using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.Admin
{
    public partial class QLDashboard : System.Web.UI.Page
    {
        QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext(); // Khởi tạo kết nối tới database

        public List<OrderViewModel> listOD = new List<OrderViewModel>(); // Danh sách đơn hàng để hiển thị lên UI
        public List<BestSellingProduct> TopSellingProducts = new List<BestSellingProduct>(); // Danh sách sản phẩm bán chạy
        public decimal TotalRevenue = 0; // Tổng doanh thu (chỉ cộng đơn đã xác nhận)
        public int CustomersThisMonth = 0; // Số lượng khách hàng mới trong tháng này
        public int TotalOrder = 0; // Tổng số đơn hàng
        public decimal Top5Revenue = 0; // Tổng doanh thu 5 sản phẩm bán chạy nhất

        protected void Page_Load(object sender, EventArgs e)
        {
            CheckDangNhap(); // Kiểm tra đăng nhập, nếu chưa đăng nhập thì chuyển về trang login
            if (!IsPostBack) // Chỉ chạy khi lần đầu load trang (tránh reload nhiều lần sau PostBack)
            {
                LoadRecentOrders(); // Gọi hàm load dữ liệu
                LoadCustomerStats(); // Gọi hàm load thống kê khách hàng
                LoadTotalOrder(); // Gọi hàm load tổng số đơn hàng
                LoadBestSellingProducts(); // Gọi hàm load sản phẩm bán chạy
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
                            select o.TotalAmount).Sum(); // Tính tổng doanh thu từ các đơn hàng đã xác nhận
        }

        void LoadCustomerStats()
        {
            var now = DateTime.Now;

            CustomersThisMonth = (from q in db.tb_Users
                                  where q.CreatedAt.Year == now.Year
                                  select q).Count(); // Đếm số lượng khách hàng mới trong tháng này

        }

        void LoadTotalOrder()
        {
            TotalOrder = db.tb_Orders.Count(); // Đếm tổng số đơn hàng trong bảng tb_Orders
        }

        void LoadBestSellingProducts()
        {
            var topProducts = (from od in db.tb_OrderDetails 
                               join p in db.tb_Products on od.ProductId equals p.id // Kết nối bảng OrderDetails với Products Điều kiện để join: od.ProductId == p.id
                               group od by new { od.ProductId, p.Title } into g // Nhóm theo ProductId và Title
                               select new 
                               {
                                   ProductName = g.Key.Title, // Tên sản phẩm
                                   TotalSold = g.Sum(x => x.Quantity), // Tổng số lượng bán ra
                                   TotalRevenue = g.Sum(x => x.Quantity * x.Price) // Tổng doanh thu từ sản phẩm này
                               })
                              .OrderByDescending(x => x.TotalSold) // Sắp xếp theo số lượng bán ra (giảm dần)
                              .Take(5)
                              .ToList();

            // Gán danh sách cho ViewModel để hiện lên giao diện tên sp với số lượt bán
            TopSellingProducts = topProducts.Select(x => new BestSellingProduct // Chuyển đổi sang ViewModel 
            {
                ProductName = x.ProductName, // Tên sản phẩm
                TotalSold = x.TotalSold // Tổng số lượng bán ra
            }).ToList();

            // Tính tổng doanh số top 5
            Top5Revenue = topProducts.Sum(x => x.TotalRevenue);
        }

        // ViewModel: Định nghĩa lớp trung gian để dễ bind ra view (tránh thao tác trực tiếp với entity gốc)
        public class OrderViewModel
        {
            public string Code { get; set; }              // Mã đơn hàng
            public DateTime? CreatedDate { get; set; }    // Ngày tạo đơn
            public decimal TotalAmount { get; set; }      // Tổng tiền của đơn
            public string Status { get; set; }            // Trạng thái hiển thị (chuỗi mô tả)
        }

        public class BestSellingProduct
        {
            public string ProductName { get; set; }
            public int TotalSold { get; set; }
        }

    }
}