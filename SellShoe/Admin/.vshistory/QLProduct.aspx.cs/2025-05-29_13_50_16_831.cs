using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.Admin
{
    public partial class QL_Product : System.Web.UI.Page
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public static List<ProductViewModel> listSP = new List<ProductViewModel>();

        protected void Page_Load(object sender, EventArgs e)
        {
            CheckDangNhap();
            if (!IsPostBack)
            {
                txtSearch.Text = "";
                SearchKeyword = "";
                LoadCategories();
                LoadData();
            }
        }

        void CheckDangNhap()
        {
            if (Session["Admin"] == null || Session["Password"] == null)
            {
                Response.Redirect("../AdminLogin.aspx");
            }

            var data = db.tb_AccountAdmins
                         .Where(q => q.TenBien == "Admin" && q.GiaTri == Session["Admin"].ToString());
            var dataPass = db.tb_AccountAdmins
                             .Where(q => q.TenBien == "Password" && q.GiaTri == Session["Password"].ToString());

            if (!data.Any() || !dataPass.Any())
            {
                Response.Redirect("../AdminLogin.aspx");
            }
        }

        void LoadCategories()
        {
            var categories = db.tb_ProductCategories.ToList(); // Lấy tất cả danh mục sản phẩm
            ddlCategory.DataSource = categories; // Gán dữ liệu cho DropDownList
            ddlCategory.DataTextField = "Title"; // Tên hiển thị trong DropDownList
            ddlCategory.DataValueField = "id"; // Giá trị của từng mục trong DropDownList
            ddlCategory.DataBind(); // Liên kết dữ liệu với DropDownList
            ddlCategory.Items.Insert(0, new ListItem("-- Chọn danh mục --", "0")); // Thêm mục chọn mặc định
        }

        void LoadData(string searchKeyword = "") // Tải dữ liệu sản phẩm với từ khóa tìm kiếm
        {
            var data = from p in db.tb_Products // Lấy tất cả sản phẩm
                       join c in db.tb_ProductCategories on p.ProductCategoryId equals c.id // Kết nối với bảng danh mục sản phẩm
                       orderby p.CreatedDate descending // Sắp xếp theo ngày tạo mới nhất
                       where p.IsActive == true // Chỉ lấy sản phẩm đang hoạt động
                       select new ProductViewModel // Tạo mô hình dữ liệu sản phẩm
                       {
                           id = p.id,
                           Title = p.Title,
                           ProductCode = p.ProductCode,
                           PriceSale = p.PriceSale,
                           Quantity = p.Quantity,
                           IsHot = p.IsHot,
                           IsHome = p.IsHome,
                           IsActive = p.IsActive,
                           Image = p.Image,
                           CategoryName = c.Title
                       };

            if (!string.IsNullOrEmpty(searchKeyword)) // Nếu có từ khóa tìm kiếm
            {
                searchKeyword = searchKeyword.ToLower(); // Chuyển đổi từ khóa về chữ thường để so sánh không phân biệt chữ hoa thường
                data = data.Where(p => p.Title.ToLower().Contains(searchKeyword) // tìm kiếm theo tiêu đề
                                    || p.ProductCode.ToLower().Contains(searchKeyword) // tìm kiếm theo mã sản phẩm
                                    || p.CategoryName.ToLower().Contains(searchKeyword)); // tìm kiếm theo tên danh mục
            }

            listSP = data.ToList(); // Chuyển đổi kết quả truy vấn thành danh sách
            BindDataGrid(); // Liên kết dữ liệu với DataGrid
        }

        void BindDataGrid()
        {
            dgProducts.DataSource = listSP; // Gán danh sách sản phẩm cho DataGrid
            dgProducts.DataBind(); // Hiển thị dữ liệu trên DataGrid
        }

        protected void dgProducts_PageIndexChanged(object source, DataGridPageChangedEventArgs e) // Xử lý sự kiện thay đổi trang của DataGrid
        {
            dgProducts.CurrentPageIndex = e.NewPageIndex; // Cập nhật chỉ mục trang hiện tại
            LoadData(SearchKeyword); // Tải lại dữ liệu với từ khóa tìm kiếm hiện tại
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e) // Xử lý sự kiện thay đổi văn bản trong ô tìm kiếm
        {
            SearchKeyword = txtSearch.Text.Trim(); // Lưu từ khóa tìm kiếm vào ViewState
            dgProducts.CurrentPageIndex = 0; // Đặt lại chỉ mục trang về 0
            LoadData(SearchKeyword); // Tải lại dữ liệu với từ khóa tìm kiếm
        }

        protected void dgProducts_DeleteCommand(object source, DataGridCommandEventArgs e) // Xử lý sự kiện xóa sản phẩm
        {
            int id = Convert.ToInt32(dgProducts.DataKeys[e.Item.ItemIndex]); // Lấy ID sản phẩm từ DataKeys

            var product = db.tb_Products.FirstOrDefault(p => p.id == id); // Tìm sản phẩm theo ID
            if (product != null) // Nếu tìm thấy sản phẩm
            {
                db.tb_Products.DeleteOnSubmit(product);
                db.SubmitChanges();
            }

            LoadData();
        }

        protected void dgProducts_ItemCommand(object source, DataGridCommandEventArgs e)
        {
            if (e.CommandName == "EditProduct")
            {
                int productId = Convert.ToInt32(e.CommandArgument); // Lấy ID sản phẩm từ CommandArgument
                var product = db.tb_Products.FirstOrDefault(p => p.id == productId); // Tìm sản phẩm theo ID
                if (product != null) // Nếu tìm thấy sản phẩm
                {
                    hdProductId.Value = product.id.ToString(); // Lưu ID sản phẩm vào HiddenField để sử dụng khi lưu
                    txtTitle.Text = product.Title; // Gán tiêu đề sản phẩm vào ô nhập liệu
                    txtProductCode.Text = product.ProductCode; // Gán mã sản phẩm vào ô nhập liệu
                    txtDescription.Text = product.Description;// Gán mô tả sản phẩm vào ô nhập liệu
                    fckDetail.Value = product.Detail;// Gán chi tiết sản phẩm vào ô nhập liệu
                    txtPrice.Text = product.Price.ToString();// Gán giá sản phẩm vào ô nhập liệu
                    txtPriceSale.Text = product.PriceSale.ToString(); // Gán giá sản phẩm vào ô nhập liệu
                    txtQuantity.Text = product.Quantity.ToString(); // Gán số lượng sản phẩm vào ô nhập liệu
                    ddlCategory.SelectedValue = product.ProductCategoryId.ToString(); // Gán danh mục sản phẩm đã chọn
                    chkIsHot.Checked = product.IsHot;// Gán trạng thái "Hot" vào checkbox
                    chkIsHome.Checked = product.IsHome;// Gán trạng thái "Home" vào checkbox
                    chkIsActive.Checked = product.IsActive;// Gán trạng thái "Active" vào checkbox

                    // Mở modal thông qua JS
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showEditModal", "showAddModal();", true);
                }
            }
        }


        protected void btnSaveProduct_Click(object sender, EventArgs e) // Xử lý sự kiện khi nhấn nút lưu sản phẩm
        {
            if (!Page.IsValid) return; // Kiểm tra tính hợp lệ của trang trước khi lưu

            try
            {
                string imagePath = ""; // Biến lưu đường dẫn hình ảnh

                if (fuImage.HasFile) // Kiểm tra xem có tệp hình ảnh được tải lên không
                {
                    string fileName = Path.GetFileName(fuImage.FileName); // Lấy tên tệp hình ảnh
                    string productFolder = "/img/products/"; // Thư mục lưu trữ hình ảnh sản phẩm
                    string serverFolder = Server.MapPath(productFolder); // Chuyển đổi đường dẫn thư mục sang đường dẫn máy chủ

                    if (!Directory.Exists(serverFolder)) // Kiểm tra xem thư mục đã tồn tại chưa
                        Directory.CreateDirectory(serverFolder); // Tạo thư mục nếu chưa tồn tại

                    string filePath = productFolder + DateTime.Now + "_" + fileName; // Tạo đường dẫn tệp với ngày giờ hiện tại để tránh trùng lặp
                    fuImage.SaveAs(Server.MapPath(filePath)); // Lưu tệp hình ảnh vào thư mục trên máy chủ
                    imagePath = filePath; // Lưu đường dẫn tệp hình ảnh vào biến
                }

                int productId = 0; // Biến lưu ID sản phẩm, mặc định là 0 (thêm mới)
                int.TryParse(hdProductId.Value, out productId); // Chuyển đổi giá trị từ HiddenField sang kiểu int

                if (productId == 0) // Nếu ID sản phẩm là 0, tức là đang thêm mới sản phẩm
                {
                    // Thêm mới
                    var sp = new tb_Product
                    {
                        Title = txtTitle.Text.Trim(),
                        ProductCode = txtProductCode.Text.Trim(),
                        Description = txtDescription.Text.Trim(),
                        Detail = fckDetail.Value,
                        Image = imagePath,
                        Price = string.IsNullOrWhiteSpace(txtPrice.Text) ? 0 : decimal.Parse(txtPrice.Text),
                        PriceSale = string.IsNullOrWhiteSpace(txtPriceSale.Text) ? 0 : decimal.Parse(txtPriceSale.Text),
                        Quantity = string.IsNullOrWhiteSpace(txtQuantity.Text) ? 0 : int.Parse(txtQuantity.Text),
                        ProductCategoryId = int.Parse(ddlCategory.SelectedValue),
                        IsHot = chkIsHot.Checked,
                        IsHome = chkIsHome.Checked,
                        IsActive = chkIsActive.Checked,
                        CreatedDate = DateTime.Now,
                        ModifiedDate = DateTime.Now
                    };

                    db.tb_Products.InsertOnSubmit(sp);
                }
                else
                {
                    // Cập nhật
                    var product = db.tb_Products.FirstOrDefault(p => p.id == productId); // Tìm sản phẩm theo ID
                    if (product != null)
                    {
                        product.Title = txtTitle.Text.Trim();
                        product.ProductCode = txtProductCode.Text.Trim();
                        product.Description = txtDescription.Text.Trim();
                        product.Detail = fckDetail.Value;
                        
                        if (!string.IsNullOrEmpty(imagePath)) // Nếu có hình ảnh mới được tải lên
                            product.Image = imagePath; // Cập nhật đường dẫn hình ảnh

                        product.Price = string.IsNullOrWhiteSpace(txtPrice.Text) ? 0 : decimal.Parse(txtPrice.Text);
                        product.PriceSale = string.IsNullOrWhiteSpace(txtPriceSale.Text) ? 0 : decimal.Parse(txtPriceSale.Text);
                        product.Quantity = string.IsNullOrWhiteSpace(txtQuantity.Text) ? 0 : int.Parse(txtQuantity.Text);
                        product.ProductCategoryId = int.Parse(ddlCategory.SelectedValue);
                        product.IsHot = chkIsHot.Checked;
                        product.IsHome = chkIsHome.Checked;
                        product.IsActive = chkIsActive.Checked;
                        product.ModifiedDate = DateTime.Now;
                    }
                }

                db.SubmitChanges();

                // Reload lại dữ liệu và đóng modal (redirect trang hiện tại để tránh postback nhiều)
                Response.Redirect(Request.RawUrl);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Lỗi: " + ex.Message.Replace("'", "\\'") + "');</script>");
            }
        }

        [WebMethod]
        public static ProductData GetProductById(int id) 
        {
            using (var db = new QuanLyBanGiayDataContext())
            {
                var product = db.tb_Products.FirstOrDefault(p => p.id == id);
                if (product == null) return null;

                return new ProductData
                {
                    id = product.id,
                    Title = product.Title,
                    ProductCode = product.ProductCode,
                    Description = product.Description,
                    Detail = product.Detail,
                    Image = product.Image,
                    Price = product.Price,
                    PriceSale = product.PriceSale,
                    Quantity = product.Quantity,
                    ProductCategoryId = product.ProductCategoryId,
                    IsHot = product.IsHot,
                    IsHome = product.IsHome,
                    IsActive = product.IsActive
                };
            }
        }

        private string SearchKeyword
        {
            get { return ViewState["SearchKeyword"] as string ?? ""; } // Lấy từ khóa tìm kiếm từ ViewState, nếu không có thì trả về chuỗi rỗng
            set { ViewState["SearchKeyword"] = value; } // Lưu từ khóa tìm kiếm vào ViewState
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Xoá session
            Session.Clear();
            Session.Abandon();

            Response.Redirect("~/adminlogin.aspx");
        }
        public class ProductViewModel
        {
            public int id { get; set; }
            public string Title { get; set; }
            public string ProductCode { get; set; }
            public decimal? PriceSale { get; set; }
            public int? Quantity { get; set; }
            public bool? IsHot { get; set; }
            public bool? IsHome { get; set; }
            public bool? IsActive { get; set; }
            public string Image { get; set; }
            public string CategoryName { get; set; }
        }

        public class ProductData
        {
            public int id { get; set; }
            public string Title { get; set; }
            public string ProductCode { get; set; }
            public string Description { get; set; }
            public string Detail { get; set; }
            public string Image { get; set; }
            public decimal? Price { get; set; }
            public decimal? PriceSale { get; set; }
            public int? Quantity { get; set; }
            public int ProductCategoryId { get; set; }
            public bool IsHot { get; set; }
            public bool IsHome { get; set; }
            public bool IsActive { get; set; }
        }
    }
}