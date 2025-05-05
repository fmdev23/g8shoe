using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Configuration;
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

        [System.Web.Services.WebMethod]
        public static bool UpdateCategory(dynamic category)
        {
            try
            {
                int id = Convert.ToInt32(category.id);
                string title = category.title;
                string description = category.description;
                string alias = category.alias;

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["YourConnection"].ConnectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("UPDATE tb_ProductCategory SET Title=@Title, Description=@Description, Alias=@Alias WHERE Id=@Id", conn);
                    cmd.Parameters.AddWithValue("@Id", id);
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Description", description);
                    cmd.Parameters.AddWithValue("@Alias", alias);
                    return cmd.ExecuteNonQuery() > 0;
                }
            }
            catch { return false; }
        }

        [System.Web.Services.WebMethod]
        public static bool DeleteCategory(int id)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["YourConnection"].ConnectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("DELETE FROM tb_ProductCategory WHERE Id=@Id", conn);
                    cmd.Parameters.AddWithValue("@Id", id);
                    return cmd.ExecuteNonQuery() > 0;
                }
            }
            catch { return false; }
        }


    }


}