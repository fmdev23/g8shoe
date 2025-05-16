using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.Admin
{
    public partial class Product : System.Web.UI.Page
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public static List<ProductViewModel> listSP = new List<ProductViewModel>(); // Dùng static để giữ qua nhiều PostBack

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                LoadData();
            }
        }

        void LoadData()
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

            listSP = data.ToList();
            BindDataGrid();
        }

        void BindDataGrid()
        {
            dgProducts.DataSource = listSP;
            dgProducts.DataBind();
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

        protected void dgProducts_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
        {
            dgProducts.CurrentPageIndex = e.NewPageIndex;
            BindDataGrid();
        }

        protected void dgProducts_EditCommand(object source, DataGridCommandEventArgs e)
        {
            dgProducts.EditItemIndex = e.Item.ItemIndex;
            BindDataGrid();
        }

        protected void dgProducts_CancelCommand(object source, DataGridCommandEventArgs e)
        {
            dgProducts.EditItemIndex = -1;
            BindDataGrid();
        }

        protected void dgProducts_UpdateCommand(object source, DataGridCommandEventArgs e)
        {
            int id = Convert.ToInt32(dgProducts.DataKeys[e.Item.ItemIndex]);

            // Lấy textbox
            string title = ((TextBox)e.Item.FindControl("txtTitle")).Text;
            string code = ((TextBox)e.Item.FindControl("txtCode")).Text;
            decimal priceSale = decimal.Parse(((TextBox)e.Item.FindControl("txtPriceSale")).Text);
            int quantity = int.Parse(((TextBox)e.Item.FindControl("txtQuantity")).Text);
            bool isActive = ((CheckBox)e.Item.FindControl("chkIsActive")).Checked;
            bool isHome = ((CheckBox)e.Item.FindControl("chkIsHome")).Checked;
            string categoryName = ((TextBox)e.Item.FindControl("txtCategoryName")).Text;

            var product = db.tb_Products.FirstOrDefault(p => p.id == id);
            if (product != null)
            {
                product.Title = title;
                product.ProductCode = code;
                product.PriceSale = priceSale;
                product.Quantity = quantity;
                product.IsHome = isHome;
                product.IsActive = isActive;
                product.ProductCategoryId = db.tb_ProductCategories.FirstOrDefault(c => c.Title == categoryName)?.id ?? 0;
                product.ModifiedDate = DateTime.Now;

                db.SubmitChanges();
            }

            dgProducts.EditItemIndex = -1;
            LoadData(); // Load lại dữ liệu mới
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

            LoadData(); // Load lại dữ liệu sau khi xóa
        }

        protected void btnSaveProduct_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if (string.IsNullOrEmpty(hdProductId.Value)) // Thêm mới
                {
                    try
                    {
                        var sp = new tb_Product
                        {
                            Title = txtTitle.Text.Trim(),
                            ProductCode = txtProductCode.Text.Trim(),
                            Description = txtDescription.Text.Trim(),
                            Detail = txtDetail.Text.Trim(),
                            Image = txtImage.Text.Trim(),
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
                        db.SubmitChanges();

                        Response.Redirect("~/Admin/Product.aspx");
                    }
                    catch (Exception ex)
                    {
                        Response.Write("<script>alert('Lỗi: " + ex.Message + "');</script>");
                    }
                }
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