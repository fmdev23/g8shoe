using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.Admin
{
    public partial class Product : System.Web.UI.Page
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public List<tb_ProductCategory> listCategory = new List<tb_ProductCategory>();
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadCategories();
        }

        // Load danh mục sản phẩm
        void LoadCategories()
        {
            var listCategory = db.tb_ProductCategories.ToList();
            rptCategory.DataSource = listCategory;
            rptCategory.DataBind();
        }

        // WebMethod để thêm/sửa danh mục sản phẩm
        [WebMethod]
        public static string SaveCategory(CategoryModel category)
        {
            try
            {
                using (var db = new QuanLyBanGiayDataContext())
                {
                    if (category.id == 0)
                    {
                        // THÊM MỚI
                        var newCategory = new tb_ProductCategory
                        {
                            Title = category.title,
                            Description = category.description ?? "",
                            Alias = category.alias,
                            CreatedDate = DateTime.Now,
                            ModifiedDate = DateTime.Now,   // << BẮT BUỘC CÓ
                            CreatedBy = "admin",
                            ModifierBy = "admin",
                            Icon = "",
                            SeoTitle = category.title, // Hoặc để ""
                            SeoDescription = category.description ?? "",
                            SeoKeywords = ""
                        };
                        db.tb_ProductCategories.InsertOnSubmit(newCategory);
                    }
                    else
                    {
                        // CHỈNH SỬA
                        var existingCategory = db.tb_ProductCategories.SingleOrDefault(c => c.id == category.id);
                        if (existingCategory != null)
                        {
                            existingCategory.Title = category.title;
                            existingCategory.Description = category.description ?? "";
                            existingCategory.Alias = category.alias;
                            existingCategory.ModifiedDate = DateTime.Now;
                            existingCategory.ModifierBy = "admin";
                            existingCategory.SeoTitle = category.title;
                            existingCategory.SeoDescription = category.description ?? "";
                            existingCategory.SeoKeywords = "";
                        }
                        else
                        {
                            return "not found";
                        }
                    }

                    db.SubmitChanges();
                    return "success";
                }
            }
            catch (Exception ex)
            {
                return "error: " + ex.ToString(); // để debug lỗi kỹ hơn
            }
        }

        // WebMethod để xóa danh mục sản phẩm
        [WebMethod]
        public static string DeleteCategory(int id)
        {
            using (var db = new QuanLyBanGiayDataContext())
            {
                var category = db.tb_ProductCategories.SingleOrDefault(c => c.id == id);
                if (category != null)
                {
                    db.tb_ProductCategories.DeleteOnSubmit(category);
                    db.SubmitChanges();
                    return "success";
                }
                return "not found";
            }
        }

        public class CategoryModel
        {
            public int id { get; set; }
            public string title { get; set; }
            public string description { get; set; }
            public string alias { get; set; }
        }


    }
}