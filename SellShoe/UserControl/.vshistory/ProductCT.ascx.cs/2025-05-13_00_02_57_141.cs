using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.UserControl
{
    public partial class ProductCT : System.Web.UI.UserControl
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();

        public static List<ProductWithRating> listProductWithRating = new List<ProductWithRating>(); // toàn bộ sản phẩm
        public List<ProductWithRating> pagedProducts = new List<ProductWithRating>(); // sản phẩm phân trang

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAllProductsWithRating();
                PaginateProducts();
            }
        }

        void LoadAllProductsWithRating()
        {
            // Lấy tất cả sản phẩm kèm rating
            listProductWithRating = (from p in db.tb_Products
                                     where p.IsActive == true
                                     select new ProductWithRating
                                     {
                                         Product = p,
                                         AverageRating = (from rv in db.tb_Reviews
                                                          where rv.ProductId == p.id
                                                          select rv.Rating).Average()
                                     }).ToList();
        }

        void PaginateProducts()
        {
            int pageSize = 15;
            int currentPage = 1;

            if (!string.IsNullOrEmpty(Request.QueryString["page"]))
            {
                int.TryParse(Request.QueryString["page"], out currentPage);
                if (currentPage < 1) currentPage = 1;
            }

            int skip = (currentPage - 1) * pageSize;
            pagedProducts = listProductWithRating.Skip(skip).Take(pageSize).ToList();

            GeneratePagination(listProductWithRating.Count, pageSize, currentPage);
        }

        void GeneratePagination(int totalItems, int pageSize, int currentPage)
        {
            int totalPages = (int)Math.Ceiling((double)totalItems / pageSize);

            var paginationHtml = new System.Text.StringBuilder();

            for (int i = 1; i <= totalPages; i++)
            {
                string activeClass = i == currentPage ? "style='font-weight:bold;color:red;'" : "";
                paginationHtml.AppendFormat("<a href='product.aspx?page={0}' {1}>{0}</a>", i, activeClass);
            }

            litPagination.Text = paginationHtml.ToString();
        }

        public class ProductWithRating
        {
            public tb_Product Product { get; set; }
            public double? AverageRating { get; set; }
        }
    }



}