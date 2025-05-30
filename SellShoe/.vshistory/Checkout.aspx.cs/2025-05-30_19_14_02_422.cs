using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe
{
    public partial class checkout : System.Web.UI.Page
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();

        // Properties để bind dữ liệu ra frontend
        public string ProductName { get; set; }
        public string ProductImage { get; set; }
        public string ProductSize { get; set; }
        public int ProductQuantity { get; set; }
        public decimal ProductPrice { get; set; }
        public int ProductId { get; set; }
        public decimal ShippingFee { get; set; } = 30000; // Phí ship mặc định 30k
        public decimal TotalAmount { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Kiểm tra đăng nhập
                if (Session["user"] == null)
                {
                    Response.Redirect("useraccount.aspx");
                    return;
                }

                LoadOrderInfo();
                LoadUserInfo();
            }
        }

        private void LoadOrderInfo()
        {
            try
            {
                // Lấy thông tin từ Session được set từ trang sproductct
                if (Session["OrderProductId"] != null &&
                    Session["OrderSize"] != null &&
                    Session["OrderQuantity"] != null)
                {
                    ProductId = Convert.ToInt32(Session["OrderProductId"]);
                    ProductSize = Session["OrderSize"].ToString();
                    ProductQuantity = Convert.ToInt32(Session["OrderQuantity"]);

                    // Lấy thông tin sản phẩm từ database
                    var product = db.tb_Products.FirstOrDefault(p => p.id == ProductId && p.IsActive == true);
                    if (product != null)
                    {
                        ProductName = product.Title;
                        ProductImage = product.Image;
                        ProductPrice = (decimal)product.PriceSale; // Sử dụng giá sale

                        // Tính tổng tiền
                        TotalAmount = (ProductPrice * ProductQuantity) + ShippingFee;

                        // Lưu vào hidden fields
                        hfProductId.Value = ProductId.ToString();
                        hfProductSize.Value = ProductSize;
                        hfProductQuantity.Value = ProductQuantity.ToString();
                        hfProductPrice.Value = ProductPrice.ToString();
                    }
                    else
                    {
                        // Sản phẩm không tồn tại, chuyển về trang chủ
                        Response.Redirect("home.aspx");
                    }
                }
                else
                {
                    // Không có thông tin đơn hàng, chuyển về trang chủ
                    Response.Redirect("home.aspx");
                }
            }
            catch (Exception ex)
            {
                // Log error và chuyển về trang chủ
                Response.Redirect("home.aspx");
            }
        }

        private void LoadUserInfo()
        {
            try
            {
                // Lấy thông tin user từ Session
                if (Session["user"] != null)
                {
                    var user = Session["user"]; // Tùy thuộc vào cách bạn lưu user trong session

                    // Nếu bạn lưu user dưới dạng object, có thể cast về kiểu phù hợp
                    // và fill thông tin vào các textbox

                    // Ví dụ:
                    // var currentUser = (tb_User)user;
                    // txtHoTen.Text = currentUser.FullName;
                    // txtEmail.Text = currentUser.Email;
                    // txtSoDienThoai.Text = currentUser.Phone;
                    // txtDiaChi.Text = currentUser.Address;
                }
            }
            catch (Exception ex)
            {
                // Log error nếu cần
            }
        }

        protected void btnDatHang_Click(object sender, EventArgs e)
        {
            try
            {
                // Validate thông tin bắt buộc
                if (string.IsNullOrWhiteSpace(txtHoTen.Text) ||
                    string.IsNullOrWhiteSpace(txtSoDienThoai.Text) ||
                    string.IsNullOrWhiteSpace(txtDiaChi.Text) ||
                    ddlTinhThanh.SelectedIndex == 0 ||
                    ddlQuanHuyen.SelectedIndex == 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertError",
                        "showErrorMessage('Vui lòng điền đầy đủ thông tin bắt buộc!');", true);
                    return;
                }

                // Kiểm tra số điện thoại
                if (!IsValidPhoneNumber(txtSoDienThoai.Text.Trim()))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertError",
                        "showErrorMessage('Số điện thoại không hợp lệ!');", true);
                    return;
                }

                // Lấy thông tin sản phẩm
                int productId = Convert.ToInt32(hfProductId.Value);
                var product = db.tb_Products.FirstOrDefault(p => p.id == productId);

                if (product == null)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertError",
                        "showErrorMessage('Sản phẩm không tồn tại!');", true);
                    return;
                }

                // Kiểm tra số lượng tồn kho
                int orderQuantity = Convert.ToInt32(hfProductQuantity.Value);
                if (product.Quantity < orderQuantity)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertError",
                        "showErrorMessage('Số lượng sản phẩm không đủ trong kho!');", true);
                    return;
                }

                // Tạo đơn hàng mới
                var order = new tb_Order
                {
                    // Thông tin khách hàng
                    CustomerName = txtHoTen.Text.Trim(),
                    CustomerPhone = txtSoDienThoai.Text.Trim(),
                    CustomerEmail = string.IsNullOrWhiteSpace(txtEmail.Text) ? null : txtEmail.Text.Trim(),
                    ShippingAddress = txtDiaChi.Text.Trim(),
                    Province = ddlTinhThanh.SelectedItem.Text,
                    District = ddlQuanHuyen.SelectedItem.Text,
                    Note = string.IsNullOrWhiteSpace(txtGhiChu.Text) ? null : txtGhiChu.Text.Trim(),

                    // Thông tin đơn hàng
                    ProductId = productId,
                    ProductName = product.Title,
                    ProductImage = product.Image,
                    ProductSize = hfProductSize.Value,
                    Quantity = orderQuantity,
                    UnitPrice = (decimal)product.PriceSale,
                    TotalAmount = (decimal)product.PriceSale * orderQuantity + ShippingFee,
                    ShippingFee = ShippingFee,

                    // Phương thức thanh toán
                    PaymentMethod = GetSelectedPaymentMethod(),

                    // Trạng thái và thời gian
                    OrderStatus = "Pending", // Chờ xử lý
                    OrderDate = DateTime.Now,
                    CreatedAt = DateTime.Now,
                    IsActive = true
                };

                // Nếu user đã đăng nhập, lưu UserId
                if (Session["user"] != null)
                {
                    // Tùy thuộc vào cách bạn lưu user trong session
                    // order.UserId = ((tb_User)Session["user"]).id;
                }

                // Lưu vào database
                db.tb_Orders.InsertOnSubmit(order);

                // Cập nhật số lượng tồn kho
                product.Quantity -= orderQuantity;

                // Submit changes
                db.SubmitChanges();

                // Xóa session order info
                Session.Remove("OrderProductId");
                Session.Remove("OrderSize");
                Session.Remove("OrderQuantity");

                // Hiển thị thông báo thành công
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSuccess",
                    "showSuccessMessage();", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertError",
                    $"showErrorMessage('Có lỗi xảy ra: {ex.Message}');", true);
            }
        }

        private string GetSelectedPaymentMethod()
        {
            if (rbCOD.Checked) return "COD";
            if (rbBankTransfer.Checked) return "Bank Transfer";
            if (rbMomo.Checked) return "MoMo";
            return "COD"; // Default
        }

        private bool IsValidPhoneNumber(string phone)
        {
            // Kiểm tra định dạng số điện thoại Việt Nam
            return phone.Length >= 10 && phone.Length <= 11 &&
                   phone.All(char.IsDigit) &&
                   (phone.StartsWith("0") || phone.StartsWith("84"));
        }

        // Helper method để format giá tiền
        public string FormatPrice(decimal price)
        {
            return price.ToString("N0") + " VNĐ";
        }
    }
}