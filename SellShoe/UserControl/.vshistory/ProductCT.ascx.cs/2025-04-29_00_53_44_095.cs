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

        public static List<tb_Product> listSP = new List<tb_Product>();

        public static List<ProductWithRating> listProductWithRating = new List<ProductWithRating>();


        protected void Page_Load(object sender, EventArgs e)
        {
            loadProduct();
        }

        void loadProduct()
        {
            var data = from q in db.tb_Products
                       where q.IsActive == true
                       select q;
            if (data != null && data.Count() > 0)
            {
                listSP = data.ToList();

                // Tính Rating trung bình
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
        }

        public class ProductWithRating
        {
            public tb_Product Product { get; set; }
            public double? AverageRating { get; set; } // Dùng double? (nullable)
        }

        public static string RenderStars(double? averageRating)
        {
            double rating = averageRating ?? 0;
            int fullStars = (int)rating;
            bool hasHalfStar = (rating - fullStars) >= 0.5;
            int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

            System.Text.StringBuilder sb = new System.Text.StringBuilder();

            for (int i = 0; i < fullStars; i++)
                sb.Append("<i class='fas fa-star'></i>");

            if (hasHalfStar)
                sb.Append("<i class='fas fa-star-half-alt'></i>");

            for (int i = 0; i < emptyStars; i++)
                sb.Append("<i class='far fa-star'></i>");

            return sb.ToString();
        }



    }


}