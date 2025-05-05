using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;
using Helpers; // nếu bạn để StarHelper.cs trong thư mục Helpers


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
            if (!IsPostBack)
            {
                loadFuture();
                loadData();
                LoadCategories();
            }
        }

        // Load danh sách tính năng
        void loadFuture()
        {
            listFT = db.tb_Features.ToList();
        }

        // Load danh sách sản phẩm
        void loadData()
        {
            var data = from q in db.tb_Products
                       where q.IsHot == true || q.IsHome == true
                       select q;
            if (data != null && data.Count() > 0)
            {
                listSP = data.ToList();
            }
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