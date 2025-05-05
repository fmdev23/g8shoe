using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Configuration;
using Newtonsoft.Json;
using System.Data.SqlClient;


namespace SellShoe.Admin
{
    public partial class ProductCategory : System.Web.UI.Page
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
        public static string SaveCategory(dynamic category)
        {
            using (var db = new QuanLyBanGiayDataContext())
            {
                int id = category.id;
                string title = category.title;
                string description = category.description;
                string alias = category.alias;

                if (id != 0)
                {
                    // Thêm mới
                    var newCategory = new tb_ProductCategory
                    {
                        Title = title,
                        Description = description,
                        Alias = alias,
                        CreatedDate = DateTime.Now,
                        CreatedBy = "admin"
                    };
                    db.tb_ProductCategories.InsertOnSubmit(newCategory);
                }
                else
                {
                    // Cập nhật
                    var existingCategory = db.tb_ProductCategories.SingleOrDefault(c => c.id == id);
                    if (existingCategory != null)
                    {
                        existingCategory.Title = title;
                        existingCategory.Description = description;
                        existingCategory.Alias = alias;
                        existingCategory.ModifiedDate = DateTime.Now;
                        existingCategory.ModifierBy = "admin";
                    }
                }

                db.SubmitChanges();
                return "success";
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

    }
}