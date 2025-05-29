using System;
using System.Collections.Generic;
using System.Linq;
using SellShoe;

public static class RatingCacheManager
{
    private static List<ProductWithRating> ratingList = new List<ProductWithRating>();

    public static void LoadRatings() // Load all product ratings into the cache
    {
        using (var db = new QuanLyBanGiayDataContext())
        {
            ratingList = (from p in db.tb_Products
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

    public static double GetRatingByProductId(int productId)
    {
        if (ratingList == null || ratingList.Count == 0)
        {
            LoadRatings();
        }

        var product = ratingList.FirstOrDefault(x => x.Product.id == productId);
        return product?.AverageRating ?? 0;
    }

    public class ProductWithRating
    {
        public tb_Product Product { get; set; }
        public double? AverageRating { get; set; }
    }
}
