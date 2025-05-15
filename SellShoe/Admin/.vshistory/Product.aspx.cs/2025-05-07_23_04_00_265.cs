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
                loadData();
            }
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
            try
            {
                if (string.IsNullOrWhiteSpace(txtTitle.Text) ||
                    string.IsNullOrWhiteSpace(txtProductCode.Text) ||
                    string.IsNullOrWhiteSpace(txtPriceSale.Text))
                {
                    // Báo lỗi nếu thiếu thông tin bắt buộc
                    return;
                }

                var product = new tb_Product
                {
                    Title = txtTitle.Text.Trim(),
                    ProductCode = txtProductCode.Text.Trim(),
                    Description = txtDescription.Text.Trim(),
                    Detail = txtDetail.Text.Trim(),
                    Image = txtImage.Text.Trim(),
                    Price = string.IsNullOrEmpty(txtPrice.Text) ? 0 : decimal.Parse(txtPrice.Text),
                    PriceSale = decimal.Parse(txtPriceSale.Text),
                    Quantity = string.IsNullOrEmpty(txtQuantity.Text) ? 0 : int.Parse(txtQuantity.Text),
                    IsActive = true,
                    CreatedDate = DateTime.Now,
                    ProductCategoryId = int.Parse(ddlCategory.SelectedValue)
                };

                db.tb_Products.InsertOnSubmit(product);
                db.SubmitChanges();

                loadData(); // Refresh dữ liệu
                DataBind(); // Cập nhật UI

                // Reset form nếu muốn
                ClearForm();
            }
            catch (Exception ex)
            {
                // Handle lỗi
            }
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