using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using FredCK.FCKeditorV2;
using static System.Runtime.CompilerServices.RuntimeHelpers;

namespace SellShoe.Admin
{
    public partial class Product : System.Web.UI.Page
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
            var categories = db.tb_ProductCategories.ToList();
            ddlCategory.DataSource = categories;
            ddlCategory.DataTextField = "Title";
            ddlCategory.DataValueField = "id";
            ddlCategory.DataBind();
            ddlCategory.Items.Insert(0, new ListItem("-- Chọn danh mục --", "0"));
        }

        void LoadData(string searchKeyword = "")
        {
            var data = from p in db.tb_Products
                       join c in db.tb_ProductCategories on p.ProductCategoryId equals c.id
                       orderby p.CreatedDate descending
                       where p.IsActive == true
                       select new ProductViewModel
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

            if (!string.IsNullOrEmpty(searchKeyword))
            {
                searchKeyword = searchKeyword.ToLower();
                data = data.Where(p => p.Title.ToLower().Contains(searchKeyword)
                                    || p.ProductCode.ToLower().Contains(searchKeyword)
                                    || p.CategoryName.ToLower().Contains(searchKeyword));
            }

            listSP = data.ToList();
            BindDataGrid();
        }

        void BindDataGrid()
        {
            dgProducts.DataSource = listSP;
            dgProducts.DataBind();
        }

        protected void dgProducts_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
        {
            dgProducts.CurrentPageIndex = e.NewPageIndex;
            LoadData(SearchKeyword);
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            SearchKeyword = txtSearch.Text.Trim();
            dgProducts.CurrentPageIndex = 0;
            LoadData(SearchKeyword);
        }

        protected void dgProducts_DeleteCommand(object source, DataGridCommandEventArgs e)
        {
            int id = Convert.ToInt32(dgProducts.DataKeys[e.Item.ItemIndex]);

            var product = db.tb_Products.FirstOrDefault(p => p.id == id);
            if (product != null)
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
                int productId = Convert.ToInt32(e.CommandArgument);
                var product = db.tb_Products.FirstOrDefault(p => p.id == productId);
                if (product != null)
                {
                    hdProductId.Value = product.id.ToString();
                    txtTitle.Text = product.Title;
                    txtProductCode.Text = product.ProductCode;
                    txtDescription.Text = product.Description;
                    fckDetail.Value = product.Detail;
                    txtPrice.Text = product.Price.ToString();
                    txtPriceSale.Text = product.PriceSale.ToString();
                    txtQuantity.Text = product.Quantity.ToString();
                    ddlCategory.SelectedValue = product.ProductCategoryId.ToString();
                    chkIsHot.Checked = product.IsHot;
                    chkIsHome.Checked = product.IsHome;
                    chkIsActive.Checked = product.IsActive;

                    // Mở modal thông qua JS
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showEditModal", "showAddModal();", true);
                }
            }
        }


        protected void btnSaveProduct_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            try
            {
                string imagePath = "";

                if (fuImage.HasFile)
                {
                    string fileName = Path.GetFileName(fuImage.FileName);
                    string productFolder = "/img/products/";
                    string serverFolder = Server.MapPath(productFolder);

                    if (!Directory.Exists(serverFolder))
                        Directory.CreateDirectory(serverFolder);

                    string filePath = productFolder + DateTime.Now.Ticks + "_" + fileName;
                    fuImage.SaveAs(Server.MapPath(filePath));
                    imagePath = filePath;
                }

                int productId = 0;
                int.TryParse(hdProductId.Value, out productId);

                if (productId == 0)
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
                    var product = db.tb_Products.FirstOrDefault(p => p.id == productId);
                    if (product != null)
                    {
                        product.Title = txtTitle.Text.Trim();
                        product.ProductCode = txtProductCode.Text.Trim();
                        product.Description = txtDescription.Text.Trim();
                        product.Detail = fckDetail.Value;
                        if (!string.IsNullOrEmpty(imagePath))
                            product.Image = imagePath;

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
            get { return ViewState["SearchKeyword"] as string ?? ""; }
            set { ViewState["SearchKeyword"] = value; }
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