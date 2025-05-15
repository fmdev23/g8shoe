using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;


namespace SellShoe.UserControl
{
    public partial class Home : System.Web.UI.UserControl
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();

        public static List<tb_Product> listSP = new List<tb_Product>(); //sản phẩm
        public static List<tb_Product> listNewProducts = new List<tb_Product>(); // Sản phẩm mới
        public static List<tb_Feature> listFT = new List<tb_Feature>(); //tính năng
        public static List<tb_ProductCategory> listCategory = new List<tb_ProductCategory>(); //danh mục sản phẩm


        protected void Page_Load(object sender, EventArgs e)
        {

            loadFuture();
            loadData();
            loadNewProducts();
            LoadCategories();
            RatingCacheManager.LoadRatings(); // Load ratings vào cache

        }

        // Load danh sách tính năng
        void loadFuture()
        {
            listFT = db.tb_Features.ToList();
        }

        // Load danh sách sản phẩm
        void loadData()
        {
            // Lấy top 5 sản phẩm bán chạy nhất dựa trên số lượng đã bán
            var topProducts = (from od in db.tb_OrderDetails
                               where od.tb_Order.Status == 1 // Chỉ lấy đơn hàng đã xác nhận
                               join p in db.tb_Products on od.ProductId equals p.id // Kết nối (join) với bảng sản phẩm theo ID
                               group od by new { od.ProductId, p } into g // Nhóm theo ProductId và sản phẩm để tính tổng số lượng bán của từng sản phẩm
                               orderby g.Sum(x => x.Quantity) descending // Sắp xếp theo tổng số lượng đã bán
                               select g.Key.p) // Sau khi sắp xếp, chọn lại đối tượng sản phẩm (g.Key.p) từ nhóm
                              .Take(5)
                              .ToList();

            listSP = topProducts; // Lưu danh sách sản phẩm vào biến toàn cục
        }

        // Load danh sách sản phẩm mới
        void loadNewProducts()
        {
            // Lấy các sản phẩm đang hoạt động và hiển thị trang chủ (IsHome),
            // sắp xếp theo ngày tạo mới nhất
            var newProducts = db.tb_Products
                                .Where(p => p.IsActive == true)
                                .OrderByDescending(p => p.CreatedDate) // Sắp xếp theo ngày tạo mới nhất
                                .Take(10) // Lấy 10 sản phẩm mới nhất
                                .ToList();

            listNewProducts = newProducts; // Cập nhật danh sách sản phẩm mới
        }

        // Load danh mục sản phẩm
        void LoadCategories()
        {
            listCategory = db.tb_ProductCategories.ToList();
        }

        // Hàm lấy alias danh mục từ CategoryId
        public string GetCategoryAlias(int? categoryId)
        {
            var cat = listCategory.FirstOrDefault(c => c.id == categoryId);
            return cat != null ? cat.Alias : "";
        }

    }
}