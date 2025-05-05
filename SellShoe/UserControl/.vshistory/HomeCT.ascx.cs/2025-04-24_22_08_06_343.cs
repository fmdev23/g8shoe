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
        
        // Danh mục[ID, (Title, Alias)]
        public static List<tb_ProductCategory> listCategory = new List<tb_ProductCategory>();
        
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

        // Load danh mục sản phẩm từ bảng tb_ProductCategory
        void LoadCategories()
        {
            var categories = db.tb_ProductCategories.ToList();
            categoryMap.Clear();

            foreach (var cat in categories)
            {
                string slug = Slugify(cat.Title);
                categoryMap[cat.id] = slug;
            }
        }

        // Hàm chuyển tên danh mục thành slug (giống data-category)
        string Slugify(string phrase)
        {
            string str = phrase.ToLowerInvariant();

            // Replace Vietnamese accents
            str = RemoveDiacritics(str);

            // Replace spaces and special chars
            str = Regex.Replace(str, @"[^a-z0-9\s-]", "");
            str = Regex.Replace(str, @"\s+", "-").Trim('-');

            return str;
        }

        // Xóa dấu tiếng Việt
        string RemoveDiacritics(string text)
        {
            string formD = text.Normalize(System.Text.NormalizationForm.FormD);
            char[] chars = formD.Where(c => System.Globalization.CharUnicodeInfo.GetUnicodeCategory(c) != System.Globalization.UnicodeCategory.NonSpacingMark).ToArray();
            return new string(chars).Normalize(System.Text.NormalizationForm.FormC);
        }

    }
}