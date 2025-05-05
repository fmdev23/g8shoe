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

        [WebMethod]
        public static string SaveCategory(tb_ProductCategory category)
        {
            using (var db = new QuanLyBanGiayDataContext())
            {
                if (category.id > 0)
                {
                    var existing = db.tb_ProductCategories.FirstOrDefault(x => x.id == category.id);
                    if (existing != null)
                    {
                        existing.Title = category.Title;
                        existing.Description = category.Description;
                        existing.Alias = category.Alias;
                        existing.ModifiedDate = DateTime.Now;
                        existing.ModifierBy = "admin"; // bạn có thể thay đổi theo session
                    }
                }
                else
                {
                    category.CreatedDate = DateTime.Now;
                    category.CreatedBy = "admin"; // bạn có thể thay đổi theo session
                    db.tb_ProductCategories.InsertOnSubmit(category);
                }

                db.SubmitChanges();
                return "success";
            }
        }

        [WebMethod]
        public static string DeleteCategory(int id)
        {
            using (var db = new QuanLyBanGiayDataContext())
            {
                var category = db.tb_ProductCategories.FirstOrDefault(x => x.id == id);
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