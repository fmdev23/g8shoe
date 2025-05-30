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
        public static List<tb_Product> listSP = new List<tb_Product>(); // load sản phẩm gợi ý
        public List<tb_Review> listRV = new List<tb_Review>();

        protected void Page_Load(object sender, EventArgs e)
        {
            LoadSanPham();
            LoadBestSeller(); //load sản phẩm gợi ý
            loadRV();
            RatingCacheManager.LoadRatings(); // Load ratings vào cache
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
                if (sanPham != null)
                {
                    danhMuc = db.tb_ProductCategories.FirstOrDefault(c => c.id == sanPham.ProductCategoryId);

                    // Set giá trị cho HiddenField
                    hfProductId.Value = sanPham.id.ToString();

                    // Lưu vào Session để dùng sau khi postback (nút Đặt hàng)
                    Session["ProductDetail"] = new
                    {
                        ID = sanPham.id,
                        Name = sanPham.Title,
                        Price = sanPham.Price,
                        PriceSale = sanPham.PriceSale,
                        Image = sanPham.Image
                    };
                }
            }
        }

        void LoadBestSeller() //load 5 sản phẩm cùng danh mục với sản phẩm hiện tại
        {
            if (sanPham != null) // Kiểm tra xem sản phẩm hiện tại có tồn tại không
            {
                int currentProductId = sanPham.id; // Lấy id của sản phẩm hiện tại
                int currentCategoryId = sanPham.ProductCategoryId; // Lấy id của danh mục sản phẩm hiện tại

                // Lấy 5 sản phẩm cùng danh mục, khác sản phẩm hiện tại
                listSP = db.tb_Products // Lấy tất cả sản phẩm
                           .Where(p => p.IsActive == true
                                   && p.ProductCategoryId == currentCategoryId // Chỉ lấy sản phẩm cùng danh mục
                                   && p.id != currentProductId) // Loại trừ sản phẩm hiện tại
                           .Take(5)
                           .ToList();
            }
            else
            {
                listSP = new List<tb_Product>(); // Không có sản phẩm để gợi ý
            }
        }

        void loadRV()
        {
            int productId = 0; // Biến để lưu id của sản phẩm
            if (Request.QueryString["id"] != null) // Kiểm tra xem có tham số "id" trong chuỗi truy vấn không
            {
                int.TryParse(Request.QueryString["id"], out productId); // Chuyển đổi giá trị "id" từ chuỗi sang số nguyên. Nếu sai định dạng thì productId vẫn là 0.
            }

            var data = db.tb_Reviews.Where(r => r.ProductId == productId) // Lấy tất cả đánh giá của sản phẩm theo id
                        .OrderByDescending(r => r.CreatedAt); // Sắp xếp theo ngày tạo giảm dần

            if (data != null && data.Any()) // Kiểm tra xem có đánh giá nào không
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

                    // Reload
                    LoadSanPham();
                    loadRV();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess", "showSuccessToast();", true);

                    // Clear form
                    txtReviewerName.Text = "";
                    txtReviewerEmail.Text = "";
                    hfRating.Value = "0";
                    txtReviewText.Text = "";
                }
            }
        }

        protected void btnSubmitReview_Click(object sender, EventArgs e)
        {
            // Check if user is logged in
            if (Session["user"] == null)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertLoginError",
                    "Swal.fire({ icon: 'warning', title: 'Bạn cần đăng nhập!', text: 'Vui lòng đăng nhập để gửi đánh giá.', confirmButtonText: 'Đăng nhập ngay' }).then((result) => { if (result.isConfirmed) { window.location.href = 'useraccount.aspx'; } });", true);
                return;
            }

            int productId = 0;
            if (Request.QueryString["id"] != null)
            {
                int.TryParse(Request.QueryString["id"], out productId);
            }

            if (productId > 0)
            {
                int rating = 0;
                int.TryParse(hfRating.Value, out rating);

                // Validate required fields
                if (string.IsNullOrEmpty(txtReviewerName.Text))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertError",
                        "Swal.fire({ icon: 'error', title: 'Lỗi!', text: 'Vui lòng nhập tên của bạn.' });", true);
                    return;
                }

                if (rating == 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertError",
                        "Swal.fire({ icon: 'error', title: 'Lỗi!', text: 'Vui lòng chọn số sao đánh giá.' });", true);
                    return;
                }

                try
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

                    // Reload data
                    LoadSanPham();
                    loadRV();

                    // Show success message
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess", "showSuccessToast();", true);

                    // Clear form
                    txtReviewerName.Text = "";
                    txtReviewerEmail.Text = "";
                    hfRating.Value = "0";
                    txtReviewText.Text = "";

                    // Reset star rating display
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "resetStars",
                        "resetStarRating();", true);
                }
                catch (Exception ex)
                {
                    // Log the error if needed
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertError",
                        "Swal.fire({ icon: 'error', title: 'Lỗi!', text: 'Có lỗi xảy ra, vui lòng thử lại sau.' });", true);
                }
            }
        }
    }
}