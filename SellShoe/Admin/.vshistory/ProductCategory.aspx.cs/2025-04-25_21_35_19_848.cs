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

        [System.Web.Services.WebMethod]
        public static bool UpdateCategory(string categoryJson)
        {
            try
            {
                // Parse dữ liệu JSON thành đối tượng Category
                var category = JsonConvert.DeserializeObject<Category>(categoryJson);

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["YourConnection"].ConnectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("UPDATE tb_ProductCategory SET Title=@Title, Description=@Description, Alias=@Alias, SeoTitle=@SeoTitle, SeoDescription=@SeoDescription, SeoKeywords=@SeoKeywords, ModifiedDate=@ModifiedDate, ModifierBy=@ModifierBy WHERE id=@Id", conn);
                    cmd.Parameters.AddWithValue("@Id", category.Id);
                    cmd.Parameters.AddWithValue("@Title", category.Title);
                    cmd.Parameters.AddWithValue("@Description", category.Description);
                    cmd.Parameters.AddWithValue("@Alias", category.Alias);
                    cmd.Parameters.AddWithValue("@SeoTitle", category.SeoTitle);
                    cmd.Parameters.AddWithValue("@SeoDescription", category.SeoDescription);
                    cmd.Parameters.AddWithValue("@SeoKeywords", category.SeoKeywords);
                    cmd.Parameters.AddWithValue("@ModifiedDate", DateTime.Now); // Cập nhật thời gian sửa đổi
                    cmd.Parameters.AddWithValue("@ModifierBy", "Admin"); // Cập nhật tên người chỉnh sửa (có thể lấy từ session hoặc hệ thống)

                    return cmd.ExecuteNonQuery() > 0;
                }
            }
            catch (Exception ex)
            {
                // Log lỗi nếu có
                return false;
            }
        }

        [System.Web.Services.WebMethod]
        public static bool DeleteCategory(int id)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["YourConnection"].ConnectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("DELETE FROM tb_ProductCategory WHERE id=@Id", conn);
                    cmd.Parameters.AddWithValue("@Id", id);
                    return cmd.ExecuteNonQuery() > 0;
                }
            }
            catch (Exception ex)
            {
                // Log lỗi nếu có
                return false;
            }
        }
    }

    // Lớp Category để giữ dữ liệu
    public class Category
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Alias { get; set; }
        public string SeoTitle { get; set; }
        public string SeoDescription { get; set; }
        public string SeoKeywords { get; set; }
    }


}