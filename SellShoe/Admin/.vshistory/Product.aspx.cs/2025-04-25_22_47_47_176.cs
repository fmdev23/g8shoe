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

        // WebMethod để thêm/sửa sản phẩm
        [WebMethod]
        public static string SaveProduct(ProductModel product)
        {
            try
            {
                using (var db = new QuanLyBanGiayDataContext())
                {
                    if (product.id == 0)
                    {
                        // THÊM MỚI
                        var newProduct = new tb_Product
                        {
                            Title = product.title,
                            ProductCode = product.productCode,
                            Description = product.description ?? "",
                            Detail = product.detail ?? "",
                            Image = product.image ?? "",
                            Price = product.price,
                            PriceSale = product.priceSale,
                            Quantity = product.quantity,
                            IsHome = product.isHome,
                            IsSale = product.isSale,
                            IsFeature = product.isFeature,
                            IsHot = product.isHot,
                            ProductCategoryId = product.productCategoryId,
                            SeoTitle = product.seoTitle ?? "",
                            SeoDescription = product.seoDescription ?? "",
                            SeoKeywords = product.seoKeywords ?? "",
                            Alias = product.alias ?? "",
                            CreatedDate = DateTime.Now,
                            ModifiedDate = DateTime.Now,
                            CreatedBy = "admin",
                            ModifierBy = "admin",
                            IsActive = true,
                            ViewCount = 0
                        };
                        db.tb_Products.InsertOnSubmit(newProduct);
                    }
                    else
                    {
                        // CHỈNH SỬA
                        var existingProduct = db.tb_Products.SingleOrDefault(p => p.id == product.id);
                        if (existingProduct != null)
                        {
                            existingProduct.Title = product.title;
                            existingProduct.ProductCode = product.productCode;
                            existingProduct.Description = product.description ?? "";
                            existingProduct.Detail = product.detail ?? "";
                            existingProduct.Image = product.image ?? "";
                            existingProduct.Price = product.price;
                            existingProduct.PriceSale = product.priceSale;
                            existingProduct.Quantity = product.quantity;
                            existingProduct.IsHome = product.isHome;
                            existingProduct.IsSale = product.isSale;
                            existingProduct.IsFeature = product.isFeature;
                            existingProduct.IsHot = product.isHot;
                            existingProduct.ProductCategoryId = product.productCategoryId;
                            existingProduct.SeoTitle = product.seoTitle ?? "";
                            existingProduct.SeoDescription = product.seoDescription ?? "";
                            existingProduct.SeoKeywords = product.seoKeywords ?? "";
                            existingProduct.Alias = product.alias ?? "";
                            existingProduct.ModifiedDate = DateTime.Now;
                            existingProduct.ModifierBy = "admin";
                            // Giữ nguyên CreatedDate, CreatedBy, ViewCount, IsActive
                        }
                        else
                        {
                            return "not found";
                        }
                    }

                    db.SubmitChanges();
                    return "success";
                }
            }
            catch (Exception ex)
            {
                return "error: " + ex.ToString();
            }
        }

    }
}