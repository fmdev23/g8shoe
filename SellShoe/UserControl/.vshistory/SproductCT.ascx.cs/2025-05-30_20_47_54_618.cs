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

        protected void btnSubmitReview_Click(object sender, EventArgs e) // Xử lý sự kiện khi người dùng gửi đánh giá sản phẩm
        {
            // Kiểm tra xem người dùng đã đăng nhập hay chưa
            if (Session["User"] == null) // Nếu chưa đăng nhập
            {
                // Hiển thị thông báo yêu cầu đăng nhập
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertLogin", "showLoginRequiredToast();", true);
                return; // Dừng xử lý nếu chưa đăng nhập
            }

            int productId = 0; // Biến để lưu id của sản phẩm
            if (Request.QueryString["id"] != null)
            {
                int.TryParse(Request.QueryString["id"], out productId);
            }

            if (productId > 0)
            {
                int rating = 0; // Biến để lưu đánh giá (rating) của người dùng
                int.TryParse(hfRating.Value, out rating); // Chuyển đổi giá trị đánh giá từ HiddenField sang số nguyên. Nếu sai định dạng thì rating vẫn là 0.

                if (!string.IsNullOrEmpty(txtReviewerName.Text) && rating > 0) // Kiểm tra xem tên người đánh giá có được nhập và rating có lớn hơn 0 không
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

                    try
                    {
                        db.tb_Reviews.InsertOnSubmit(newReview);
                        db.SubmitChanges();

                        // Cập nhật lại cache rating
                        RatingCacheManager.LoadRatings();

                        // Sau khi Insert -> Load lại Review để hiện ra liền
                        LoadSanPham();
                        loadRV();

                        // Gửi một Script về client để bật popup
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess", "showSuccessToast();", true);

                        // Xóa form (chỉ xóa review text và rating, giữ lại tên và email)
                        hfRating.Value = "0";
                        txtReviewText.Text = "";

                        // Reset rating stars về trạng thái chưa chọn
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "resetStars", "resetRatingStars();", true);
                    }
                    catch (Exception ex)
                    {
                        // Log error và hiển thị thông báo lỗi
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertError",
                            "Swal.fire({ icon: 'error', title: 'Lỗi!', text: 'Có lỗi xảy ra khi gửi đánh giá, vui lòng thử lại.' });", true);
                    }
                }
                else
                {
                    // Thông báo thiếu thông tin
                    string message = "";
                    if (string.IsNullOrEmpty(txtReviewerName.Text))
                        message = "Vui lòng nhập tên của bạn.";
                    else if (rating == 0)
                        message = "Vui lòng chọn số sao đánh giá.";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertValidation",
                        $"Swal.fire({{ icon: 'warning', title: 'Thông tin không đầy đủ!', text: '{message}' }});", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertError",
                    "Swal.fire({ icon: 'error', title: 'Lỗi!', text: 'Không tìm thấy thông tin sản phẩm.' });", true);
            }
        }

        protected void btnOrderServer_Click(object sender, EventArgs e)
        {
            string selectedSize = Request.Form["hfSelectedSize"];
            string quantityStr = Request.Form["hfQuantity"];
            int productId;

            if (int.TryParse(hfProductId.Value, out productId) && !string.IsNullOrEmpty(selectedSize) && !string.IsNullOrEmpty(quantityStr))
            {
                int quantity = int.Parse(quantityStr);

                // Lấy thông tin sản phẩm từ database
                var product = db.tb_Products.FirstOrDefault(p => p.id == productId);
                if (product != null)
                {
                    // Lưu thông tin đầy đủ vào Session
                    Session["OrderProductId"] = productId;
                    Session["OrderSize"] = selectedSize;
                    Session["OrderQuantity"] = quantity;
                    Session["OrderProduct"] = new
                    {
                        ID = product.id,
                        Title = product.Title,
                        Price = product.Price,
                        PriceSale = product.PriceSale,
                        Image = product.Image,
                        Size = selectedSize,
                        Quantity = quantity
                    };

                    // Chuyển sang trang checkout
                    Response.Redirect("checkout.aspx");
                }
            }
            else
            {
                // Trường hợp lỗi – bạn có thể log hoặc hiện thông báo
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertError",
                    "Swal.fire({ icon: 'error', title: 'Lỗi!', text: 'Có lỗi xảy ra, vui lòng thử lại.' });", true);
            }
        }
    }
}