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

            LoadSanPham();
            LoadBestSeller();
            loadRV();

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

            var data = db.tb_Reviews.Where(r => r.ProductId == productId)
                        .OrderByDescending(r => r.CreatedAt);

            if (data != null && data.Any())
            {
                listRV = data.ToList();
            }
        }

        protected void btnSubmitReview_Click(object sender, EventArgs e)
        {
            int productId = 0;
            if (Request.QueryString["id"] != null)
            {
                int.TryParse(Request.QueryString["id"], out productId);
            }

            if (productId > 0)
            {
                int rating = 0;
                int.TryParse(hfRating.Value, out rating);

                if (!string.IsNullOrEmpty(txtReviewerName.Text) && rating > 0)
                {
                    var newReview = new tb_Review
                    {
                        ProductId = productId,
                        ReviewerName = txtReviewerName.Text.Trim(),
                        ReviewerEmail = string.IsNullOrEmpty(txtReviewerEmail.Text) ? null : txtReviewerEmail.Text.Trim(),
                        Rating = rating,
                        ReviewText = string.IsNullOrEmpty(txtReviewText.Text) ? null : txtReviewText.Text.Trim(),
                        CreatedAt = DateTime.Now
                    };

                    db.tb_Reviews.InsertOnSubmit(newReview);
                    db.SubmitChanges();

                    // Sau khi Insert -> Load lại Review để hiện ra liền
                    LoadSanPham();
                    loadRV();

                    // Gửi một Script về client để bật popup
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess", "showSuccessToast();", true);

                    // Xóa form
                    txtReviewerName.Text = "";
                    txtReviewerEmail.Text = "";
                    hfRating.Value = "0";
                    txtReviewText.Text = "";

                    // Có thể bổ sung thông báo thành công nếu muốn
                    // ví dụ dùng ScriptManager để hiển thị alert
                }
            }
        }


    }
}