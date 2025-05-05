using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;


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

        [System.Web.Services.WebMethod]
        public static string UpdateCategory(int id, string title, string description, string alias)
        {
            try
            {
                QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
                var cat = db.tb_ProductCategories.FirstOrDefault(c => c.id == id);
                if (cat != null)
                {
                    cat.Title = title;
                    cat.Description = description;
                    cat.Alias = alias;
                    db.SubmitChanges();
                    return "success";
                }
                return "not_found";
            }
            catch (Exception ex)
            {
                return "error: " + ex.Message;
            }
        }

        [System.Web.Services.WebMethod]
        public static string DeleteCategory(int id)
        {
            try
            {
                QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
                var cat = db.tb_ProductCategories.FirstOrDefault(c => c.id == id);
                if (cat != null)
                {
                    db.tb_ProductCategories.DeleteOnSubmit(cat);
                    db.SubmitChanges();
                    return "deleted";
                }
                return "not_found";
            }
            catch (Exception ex)
            {
                return "error: " + ex.Message;
            }
        }

    }


}