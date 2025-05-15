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
            }
            loadData();
        }

        void loadData()
        {
            var data = from p in db.tb_Products
                       join c in db.tb_ProductCategories on p.ProductCategoryId equals c.id
                       orderby p.CreatedDate descending
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

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]

        public static object SaveProduct(ProductData product)
        {
            try
            {
                var db = new QuanLyBanGiayDataContext();

                if (product.id == 0) // Thêm mới
                {
                    var sp = new tb_Product
                    {
                        Title = product.Title,
                        ProductCode = product.ProductCode,
                        Description = product.Description,
                        Detail = product.Detail,
                        Image = product.Image,
                        Price = product.Price ?? 0,
                        PriceSale = product.PriceSale ?? 0,
                        Quantity = product.Quantity ?? 0,
                        ProductCategoryId = product.ProductCategoryId,
                        IsHot = product.IsHot,
                        IsHome = product.IsHome,
                        IsActive = product.IsActive,
                        CreatedDate = DateTime.Now,
                        ModifiedDate = DateTime.Now
                    };
                    db.tb_Products.InsertOnSubmit(sp);
                }
                else // Cập nhật
                {
                    var sp = db.tb_Products.FirstOrDefault(x => x.id == product.id);
                    if (sp == null) return new { success = false, message = "Không tìm thấy sản phẩm." };

                    sp.Title = product.Title;
                    sp.ProductCode = product.ProductCode;
                    sp.Description = product.Description;
                    sp.Detail = product.Detail;
                    sp.Image = product.Image;
                    sp.Price = product.Price ?? 0;
                    sp.PriceSale = product.PriceSale ?? 0;
                    sp.Quantity = product.Quantity ?? 0;
                    sp.ProductCategoryId = product.ProductCategoryId;
                    sp.IsHot = product.IsHot;
                    sp.IsHome = product.IsHome;
                    sp.IsActive = product.IsActive;
                    sp.ModifiedDate = DateTime.Now;
                }

                db.SubmitChanges();
                return new { success = true };
            }
            catch (Exception ex)
            {
                return new { success = false, message = ex.Message };
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static object DeleteProduct(int id)
        {
            try
            {
                var db = new QuanLyBanGiayDataContext();
                var sp = db.tb_Products.FirstOrDefault(x => x.id == id);
                if (sp != null)
                {
                    db.tb_Products.DeleteOnSubmit(sp);
                    db.SubmitChanges();
                    return new { success = true };
                }
                return new { success = false, message = "Không tìm thấy sản phẩm." };
            }
            catch (Exception ex)
            {
                return new { success = false, message = ex.Message };
            }
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

    }

}