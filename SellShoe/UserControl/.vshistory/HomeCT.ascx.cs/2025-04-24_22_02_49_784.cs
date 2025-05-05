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

        // Từ điển danh mục sản phẩm: [id] = slug-name
        public static Dictionary<int, string> categoryMap = new Dictionary<int, string>();
        protected void Page_Load(object sender, EventArgs e)
        {
            loadData();
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

        // Load danh mục sản phẩm từ bảng tb_ProductCategory
        void LoadCategories()
        {
            var categories = db.tb_ProductCategories.ToList();
            categoryMap.Clear();

            foreach (var cat in categories)
            {
                string slug = Slugify(cat.Name);
                categoryMap[cat.Id] = slug;
            }
        }

    }
}