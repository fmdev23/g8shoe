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
        public List<ProductViewModel> listSP = new List<ProductViewModel>();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                loadData(); // Chỉ load lần đầu
            }
        }

        void loadData()
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

                        // Sau khi thêm, reload lại trang
                        Response.Redirect("~/Admin/Product.aspx");
                    }
                    catch (Exception ex)
                    {
                        Response.Write("<script>alert('Lỗi: " + ex.Message + "');</script>");
                    }
                }
            }
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
            public string CategoryName { get; set; } // Tên danh mục
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