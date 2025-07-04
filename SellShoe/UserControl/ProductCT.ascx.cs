﻿using System;
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

        public static List<ProductWithRating> listProductWithRating = new List<ProductWithRating>(); // danh sách sản phẩm với rating


        protected void Page_Load(object sender, EventArgs e)
        {
            loadProduct();
        }

        void loadProduct() // Hàm này sẽ load tất cả sản phẩm từ database
        {
            var data = from q in db.tb_Products // Lấy tất cả sản phẩm từ bảng tb_Products
                       where q.IsActive == true
                       select q;
            if (data != null && data.Count() > 0)
            {
                listSP = data.ToList(); // Chuyển đổi kết quả truy vấn thành danh sách sản phẩm

                // Tính Rating trung bình
                listProductWithRating = (from p in db.tb_Products
                                         where p.IsActive == true
                                         select new ProductWithRating // Tạo một đối tượng ProductWithRating cho mỗi sản phẩm
                                         {
                                             Product = p, // Lưu sản phẩm
                                             AverageRating = (from rv in db.tb_Reviews
                                                              where rv.ProductId == p.id
                                                              select rv.Rating).Average() // Tính trung bình đánh giá
                                         }).ToList();
            }
        }

        public class ProductWithRating // Lớp để lưu trữ sản phẩm và xếp hạng trung bình của nó
        {
            public tb_Product Product { get; set; } 
            public double? AverageRating { get; set; } // Dùng double? (nullable)
        }

    }


}