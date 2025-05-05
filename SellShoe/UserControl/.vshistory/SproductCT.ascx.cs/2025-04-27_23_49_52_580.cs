using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.UserControl
{
    public partial class SproductCT : System.Web.UI.UserControl
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public tb_Product sanPham; // Sản phẩm chi tiết
        public tb_ProductCategory danhMuc;
        public static List<tb_Product> listSP = new List<tb_Product>(); // Best seller (IsHot)
        public static List<ProductReview> listRV = new List<ProductReview>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSanPham();
                LoadBestSeller();
            }
        }

        void LoadSanPham()
        {
            int id = 0;
            if (Request.QueryString["id"] != null)
            {
                int.TryParse(Request.QueryString["id"], out id);
            }

            if (id > 0)
            {
                sanPham = db.tb_Products.FirstOrDefault(p => p.id == id && p.IsActive == true);
                if (sanPham != null && sanPham.ProductCategoryId != null)
                {
                    danhMuc = db.tb_ProductCategories.FirstOrDefault(c => c.id == sanPham.ProductCategoryId);
                }
            }
        }

        void LoadBestSeller()
        {
            listSP = db.tb_Products
                       .Where(p => p.IsActive == true && p.IsHot == true)
                       .Take(5) // chỉ lấy tối đa 5 sản phẩm hot
                       .ToList();
        }

        void loadRV()
        {
            var data = from q in db.ProductReviews
                       select q;
            if(data!=null && data.Count() > 0)
            {
                loadRV = review.ToString();
            }
        }
    }
}