using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.Admin
{
    public partial class ProductCategory : System.Web.UI.Page
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public List<tb_ProductCategory> listCategory = new List<tb_ProductCategory>();
        protected void Page_Load(object sender, EventArgs e)
        {
            var master = this.Master as Admin;
            LoadCategories();
        }

        // Load danh mục sản phẩm
        void LoadCategories()
        {
            var listCategory = db.tb_ProductCategories.ToList();
            rptCategory.DataSource = listCategory;
            rptCategory.DataBind();
        }
    }
}