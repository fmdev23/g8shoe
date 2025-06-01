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
            var topProducts = from q in db.tb_OrderDetails
                              where q.tb_Order.Status == 1
                              join p in db.tb_Products on q.ProductId equals p.id
                              group q by new { q.ProductId, p } into g
                              orderby g.Sum(x => x.Quantity) descending
                              select g.Key.p

        }

        // Load danh sách sản phẩm mới
        void loadNewProducts()
        {
            // Lấy các sản phẩm đang hoạt động và hiển thị trang chủ (IsHome),
            // sắp xếp theo ngày tạo mới nhất
            var newProducts = (from q in db.tb_Products
                               where q.IsActive == true && q.IsHome == true
                               orderby q.CreatedDate descending // Sắp xếp theo ngày tạo mới nhất
                               select q).Take(10).ToList();

            listNewProducts = newProducts; // Lưu danh sách sản phẩm mới vào biến toàn cục
        }

        // Load danh mục sản phẩm
        void LoadCategories()
        {
            listCategory = db.tb_ProductCategories.ToList();
        }

        // Hàm lấy alias danh mục từ CategoryId
        public string GetCategoryAlias(int? categoryId)
        {
            var cat = listCategory.FirstOrDefault(c => c.id == categoryId); // Tìm danh mục theo ID
            return cat != null ? cat.Alias : ""; // Trả về alias nếu tìm thấy, nếu không thì trả về chuỗi rỗng
        }

    }
}