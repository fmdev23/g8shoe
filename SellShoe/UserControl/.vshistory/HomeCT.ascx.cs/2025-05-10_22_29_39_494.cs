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
        public static List<tb_Feature> listFT = new List<tb_Feature>(); //tính năng
        public static List<tb_ProductCategory> listCategory = new List<tb_ProductCategory>(); //danh mục sản phẩm


        protected void Page_Load(object sender, EventArgs e)
        {

            loadFuture();
            loadData();
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
                               group od by new { od.ProductId, p } into g 
                               orderby g.Sum(x => x.Quantity) descending // Sắp xếp theo tổng số lượng đã bán
                               select g.Key.p) // Lấy sản phẩm từ nhóm
                              .Take(5)
                              .ToList();

            listSP = topProducts;
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