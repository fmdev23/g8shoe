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
                listSP = data.ToList();
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
            // Check nếu đang thêm mới
            if (string.IsNullOrEmpty(hdProductId.Value))
            {
                var sp = new tb_Product();
                sp.Title = txtTitle.Text.Trim();
                sp.ProductCode = txtProductCode.Text.Trim();
                sp.Description = txtDescription.Text.Trim();
                sp.Detail = txtDetail.Text.Trim();
                sp.Image = txtImage.Text.Trim();
                sp.Price = decimal.Parse(txtPrice.Text);
                sp.PriceSale = decimal.Parse(txtPriceSale.Text);
                sp.Quantity = int.Parse(txtQuantity.Text);
                sp.ProductCategoryId = int.Parse(ddlCategory.SelectedValue);
                sp.IsHot = chkIsHot.Checked;
                sp.IsHome = chkIsHome.Checked;
                sp.IsActive = chkIsActive.Checked;
                sp.CreatedDate = DateTime.Now;

                db.tb_Products.InsertOnSubmit(sp);
                db.SubmitChanges();
            }
            // Có thể thêm phần cập nhật ở đây nếu muốn chỉnh sửa

            Response.Redirect("~Admin/Product.aspx");
        }


        void ClearForm()
        {
            txtTitle.Text = "";
            txtProductCode.Text = "";
            txtDescription.Text = "";
            txtDetail.Text = "";
            txtPrice.Text = "";
            txtPriceSale.Text = "";
            txtQuantity.Text = "";
            txtImage.Text = "";
            ddlCategory.SelectedIndex = 0;
        }
    }

}