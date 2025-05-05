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

        // WebMethod để thêm/sửa sản phẩm
        [WebMethod]
        public static string SaveProduct(ProductModel product)
        {
            try
            {
                using (var db = new QuanLyBanGiayDataContext())
                {
                    if (product.Id == 0)
                    {
                        // Thêm mới sản phẩm
                        var newProduct = new tb_Product
                        {
                            Title = product.Title,
                            ProductCode = product.ProductCode,
                            Description = product.Description ?? "",
                            Detail = product.Detail ?? "",
                            Image = product.Image ?? "",
                            Price = product.Price,
                            PriceSale = product.PriceSale,
                            Quantity = product.Quantity,
                            IsHome = product.IsHome,
                            IsSale = product.IsSale,
                            IsFeature = product.IsFeature,
                            IsHot = product.IsHot,
                            ProductCategoryId = product.ProductCategoryId,
                            SeoTitle = product.SeoTitle ?? "",
                            SeoDescription = product.SeoDescription ?? "",
                            SeoKeywords = product.SeoKeywords ?? "",
                            Alias = product.Alias ?? "",
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
                        // Cập nhật sản phẩm
                        var existingProduct = db.tb_Products.SingleOrDefault(p => p.id == product.Id);
                        if (existingProduct != null)
                        {
                            existingProduct.Title = product.Title;
                            existingProduct.ProductCode = product.ProductCode;
                            existingProduct.Description = product.Description ?? "";
                            existingProduct.Detail = product.Detail ?? "";
                            existingProduct.Image = product.Image ?? "";
                            existingProduct.Price = product.Price;
                            existingProduct.PriceSale = product.PriceSale;
                            existingProduct.Quantity = product.Quantity;
                            existingProduct.IsHome = product.IsHome;
                            existingProduct.IsSale = product.IsSale;
                            existingProduct.IsFeature = product.IsFeature;
                            existingProduct.IsHot = product.IsHot;
                            existingProduct.ProductCategoryId = product.ProductCategoryId;
                            existingProduct.SeoTitle = product.SeoTitle ?? "";
                            existingProduct.SeoDescription = product.SeoDescription ?? "";
                            existingProduct.SeoKeywords = product.SeoKeywords ?? "";
                            existingProduct.Alias = product.Alias ?? "";
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
                return "error: " + ex.Message;
            }
        }

        // WebMethod để xóa sản phẩm
        [WebMethod]
        public static string DeleteProduct(int id)
        {
            try
            {
                using (var db = new QuanLyBanGiayDataContext())
                {
                    var product = db.tb_Products.SingleOrDefault(p => p.id == id);
                    if (product != null)
                    {
                        db.tb_Products.DeleteOnSubmit(product);
                        db.SubmitChanges();
                        return "success";
                    }
                    return "not found";
                }
            }
            catch (Exception ex)
            {
                return "error: " + ex.Message;
            }
        }

        public class ProductModel
        {
            public int Id { get; set; }
            public string Title { get; set; }
            public string ProductCode { get; set; }
            public string Description { get; set; }
            public string Detail { get; set; }
            public string Image { get; set; }
            public decimal Price { get; set; }
            public decimal PriceSale { get; set; }
            public int Quantity { get; set; }
            public bool IsHome { get; set; }
            public bool IsSale { get; set; }
            public bool IsFeature { get; set; }
            public bool IsHot { get; set; }
            public int ProductCategoryId { get; set; }
            public string SeoTitle { get; set; }
            public string SeoDescription { get; set; }
            public string SeoKeywords { get; set; }
            public string Alias { get; set; }
        }


    }




}
