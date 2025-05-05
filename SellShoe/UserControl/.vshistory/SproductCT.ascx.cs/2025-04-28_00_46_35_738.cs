using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.UserControl
{
    public partial class SproductCT : System.Web.UI.UserControl
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public tb_Product sanPham; // Sản phẩm chi tiết
        public tb_ProductCategory danhMuc;
        public static List<tb_Product> listSP = new List<tb_Product>(); // Best seller (IsHot)
        public List<tb_Review> listRV = new List<tb_Review>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSanPham();
                LoadBestSeller();
                loadRV();
                XuLyThemDanhGia();
            }
        }

        void LoadSanPham()
        {
            int id = 0;
            if (Request.QueryString["id"] != null)
            {
                int.TryParse(Request.QueryString["id"], out id);
            }

            if (id > 0)
            {
                sanPham = db.tb_Products.FirstOrDefault(p => p.id == id && p.IsActive == true);
                if (sanPham != null && sanPham.ProductCategoryId != null)
                {
                    danhMuc = db.tb_ProductCategories.FirstOrDefault(c => c.id == sanPham.ProductCategoryId);
                }
            }
        }

        void LoadBestSeller()
        {
            listSP = db.tb_Products
                       .Where(p => p.IsActive == true && p.IsHot == true)
                       .Take(5) // chỉ lấy tối đa 5 sản phẩm hot
                       .ToList();
        }

        void loadRV()
        {
            int productId = 0;
            if (Request.QueryString["id"] != null)
            {
                int.TryParse(Request.QueryString["id"], out productId);
            }

            var data = db.ProductReviews.Where(r => r.ProductId == productId)
                        .OrderByDescending(r => r.CreatedAt);

            if (data != null && data.Any())
            {
                listRV = data.ToList();
            }
        }

        void XuLyThemDanhGia()
        {
            try
            {
                int productId = int.Parse(Request.Form["ProductId"]);
                string reviewerName = Request.Form["ReviewerName"];
                string reviewerEmail = Request.Form["ReviewerEmail"];
                int rating = int.Parse(Request.Form["Rating"]);
                string reviewText = Request.Form["ReviewText"];

                ProductReview rv = new ProductReview()
                {
                    ProductId = productId,
                    ReviewerName = reviewerName,
                    ReviewerEmail = reviewerEmail,
                    Rating = rating,
                    ReviewText = reviewText,
                    CreatedAt = DateTime.Now
                };

                db.ProductReviews.InsertOnSubmit(rv);
                db.SubmitChanges();

                // Trả kết quả JSON
                var result = new
                {
                    success = true,
                    CreatedAt = rv.CreatedAt.Value.ToString("dd/MM/yyyy")
                };

                Response.ContentType = "application/json";
                Response.Write(new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(result));
                Response.End();
            }
            catch (Exception ex)
            {
                var result = new { success = false, message = ex.Message };
                Response.ContentType = "application/json";
                Response.Write(new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(result));
                Response.End();
            }
        }

    }
}