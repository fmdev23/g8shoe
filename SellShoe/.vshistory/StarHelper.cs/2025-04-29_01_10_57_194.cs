using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SellShoe
{
    public class StarHelper
    {
        static QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();

        public static string RenderStars(double rating)
        {
            int fullStars = (int)Math.Floor(rating);
            bool halfStar = (rating - fullStars) >= 0.5;
            int emptyStars = 5 - fullStars - (halfStar ? 1 : 0);

            string starsHtml = "";

            for (int i = 0; i < fullStars; i++)
            {
                starsHtml += "<i class='fas fa-star'></i>";
            }

            if (halfStar)
            {
                starsHtml += "<i class='fas fa-star-half-alt'></i>";
            }

            for (int i = 0; i < emptyStars; i++)
            {
                starsHtml += "<i class='far fa-star'></i>";
            }

            return starsHtml;
        }

        public static double GetAverageRating(int productId)
        {
            var reviews = db.tb_Review.Where(r => r.ProductId == productId);
            if (reviews.Any())
            {
                return Math.Round(reviews.Average(r => r.Rating ?? 0), 1);
            }
            return 0;
        }
    }
}