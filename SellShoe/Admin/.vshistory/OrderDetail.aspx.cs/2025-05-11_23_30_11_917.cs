﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.Admin
{
    public partial class OrderDetail : System.Web.UI.Page
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public static List<tb_Order> listOD = new List<tb_Order>();
        public tb_OrderStatus listStatus = new tb_OrderStatus();
        public static List<OrderDisplayInfo> listDisplay = new List<OrderDisplayInfo>();

        void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadOrder();
            }
        }

        void loadOrder()
        {
            listDisplay.Clear(); // Xóa dữ liệu cũ

            var orders = db.tb_Orders
                .OrderByDescending(o => o.CreatedDate)
                .ToList();

            foreach (var order in orders)
            {
                string image = ""; // giá trị mặc định nếu không tìm thấy

                var detail = db.tb_OrderDetails.FirstOrDefault(od => od.OrderId == order.id);
                if (detail != null)
                {
                    var product = db.tb_Products.FirstOrDefault(p => p.id == detail.ProductId);
                    if (product != null)
                    {
                        image = product.Image;
                    }
                }

                listDisplay.Add(new OrderDisplayInfo
                {
                    Order = order,
                    ProductImage = image
                });
            }
        }

        [WebMethod]
        public static bool ToggleOrderStatus(int id)
        {
            try
            {
                QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
                var order = db.tb_Orders.FirstOrDefault(o => o.id == id);
                if (order != null)
                {
                    int newStatus = (order.Status == 0) ? 1 : 0;
                    order.Status = newStatus;
                    order.ModifiedDate = DateTime.Now;

                    // THÊM VÀO BẢNG TIMELINE
                    tb_OrderStatus statusLog = new tb_OrderStatus
                    {
                        OrderID = order.id,
                        StatusTitle = (newStatus == 1) ? "Đã xác nhận" : "Đang chờ",
                        StatusDetail = (newStatus == 1) ? "Đơn hàng của bạn đã được xác nhận!." : "Đơn hàng đang chờ xác nhận.",
                        CreatedAt = DateTime.Now,
                        IsActive = true
                    };

                    // Các status cũ chuyển về Inactive (nếu cần chỉ hiển thị 1 status active)
                    var oldStatuses = db.tb_OrderStatus.Where(s => s.OrderID == order.id && s.IsActive == true);
                    foreach (var s in oldStatuses)
                    {
                        s.IsActive = false;
                    }

                    db.tb_OrderStatus.InsertOnSubmit(statusLog);
                    db.SubmitChanges();

                    return true;
                }
                return false;
            }
            catch
            {
                return false;
            }
        }

        public class OrderDisplayInfo
        {
            public tb_Order Order { get; set; }
            public string ProductImage { get; set; }
        }

    }
}