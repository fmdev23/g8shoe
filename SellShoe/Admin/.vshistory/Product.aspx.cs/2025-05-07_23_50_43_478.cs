using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.Admin
{
    public partial class Product : System.Web.UI.Page
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public List<tb_Product> listSP = new List<tb_Product>();

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
            var data = from q in db.tb_Products
                       where q.IsActive == true
                       select q;
            if (data != null && data.Count() > 0)
            {
                listSP = db.tb_Products.OrderByDescending(x => x.id).ToList();

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
                        // TODO: ghi log nếu cần
                        Response.Write("<script>alert('Lỗi: " + ex.Message + "');</script>");
                    }
                }
            }
        }
    }

}