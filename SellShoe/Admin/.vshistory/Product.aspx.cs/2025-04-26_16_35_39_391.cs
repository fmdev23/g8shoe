using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
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
            loadData();
        }

        // Load danh sách sản phẩm
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

        // WebMethod lấy sản phẩm theo Id
        [WebMethod]
        public static object GetProductById(int id)
        {
            using (var db = new QuanLyBanGiayDataContext())
            {
                var product = db.tb_Products.FirstOrDefault(p => p.id == id && p.IsActive == true);
                if (product != null)
                {
                    return new
                    {
                        Id = product.id,
                        Title = product.Title,
                        ProductCode = product.ProductCode,
                        Description = product.Description,
                        Detail = product.Detail,
                        Image = product.Image,
                        Price = product.Price,
                        PriceSale = product.PriceSale,
                        Quantity = product.Quantity,
                        IsHome = product.IsHome,
                        IsSale = product.IsSale,
                        IsFeature = product.IsFeature,
                        IsHot = product.IsHot,
                        ProductCategoryId = product.ProductCategoryId,
                        SeoTitle = product.SeoTitle,
                        SeoDescription = product.SeoDescription,
                        SeoKeywords = product.SeoKeywords,
                        Alias = product.Alias
                    };
                }
                return null;
            }
        }


    }

    


}
