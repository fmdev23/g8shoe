using System;
using System.Collections.Generic;
using System.Linq;
using SellShoe;

public static class RatingCacheManager
{
    private static List<ProductWithRating> ratingList = new List<ProductWithRating>();

    public static void LoadRatings() // Tải tất cả xếp hạng sản phẩm vào bộ nhớ đệm
    {
        using (var db = new QuanLyBanGiayDataContext()) // Sử dụng using để đảm bảo giải phóng tài nguyên
        {
            ratingList = (from p in db.tb_Products // Lấy tất cả sản phẩm
                          where p.IsActive == true // Chỉ lấy sản phẩm đang hoạt động
                          select new ProductWithRating // Tạo một đối tượng ProductWithRating cho mỗi sản phẩm
                          {
                              Product = p, // Lưu sản phẩm
                              AverageRating = (from rv in db.tb_Reviews // Lấy tất cả đánh giá sản phẩm
                                               where rv.ProductId == p.id // Chỉ lấy đánh giá cho sản phẩm hiện tại
                                               select rv.Rating).Average() // Tính trung bình đánh giá
                          }).ToList();
        }
    }

    public static double GetRatingByProductId(int productId) // Lấy xếp hạng trung bình của sản phẩm theo ID
    {
        if (ratingList == null || ratingList.Count == 0) // Kiểm tra xem danh sách xếp hạng đã được tải hay chưa
        {
            LoadRatings(); // Nếu chưa, gọi phương thức LoadRatings để tải dữ liệu
        }

        var product = ratingList.FirstOrDefault(x => x.Product.id == productId); // Tìm sản phẩm trong danh sách xếp hạng theo ID
        return product?.AverageRating ?? 0; // Trả về xếp hạng trung bình, nếu không tìm thấy thì trả về 0
    }

    public class ProductWithRating // Lớp để lưu trữ sản phẩm và xếp hạng trung bình của nó
    {
        public tb_Product Product { get; set; } // Sản phẩm
        public double? AverageRating { get; set; } // Xếp hạng trung bình của sản phẩm
    }
}
