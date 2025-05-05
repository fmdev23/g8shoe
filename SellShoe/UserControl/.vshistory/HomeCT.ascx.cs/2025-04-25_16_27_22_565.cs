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
        
        public static List<tb_Product> listSP = new List<tb_Product>();
        public static List<tb_Feature> listFT = new List<tb_Feature>();

        // Danh mục[ID, (Title, Alias)]
        public static List<tb_ProductCategory> listCategory = new List<tb_ProductCategory>();

        public static tb_Banner banner
        
        protected void Page_Load(object sender, EventArgs e)
        {
            loadData();
            LoadCategories();
        }

        void loadData()
        {
            var data = from q in db.tb_Products
                       where q.IsActive == true
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