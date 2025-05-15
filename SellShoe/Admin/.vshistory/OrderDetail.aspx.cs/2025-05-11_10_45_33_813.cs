using System;
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
        void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadOrder();
            }
        }

        void loadOrder()
        {
            var data = db.tb_Orders
                 .OrderByDescending(o => o.CreatedDate); // Sắp xếp mới nhất trước

            if (data != null && data.Any())
            {
                listOD = data.ToList();
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
                        StatusDetail = (newStatus == 1) ? "Admin đã xác nhận đơn hàng." : "Đơn hàng đang chờ xác nhận.",
                        CreatedAt = DateTime.Now,
                        IsActive = true
                    };

                    // Các status cũ chuyển về Inactive (nếu cần chỉ hiển thị 1 status active)
                    var oldStatuses = db.tb_OrderStatus.Where(s => s.OrderId == order.id && s.IsActive);
                    foreach (var s in oldStatuses)
                    {
                        s.IsActive = false;
                    }

                    db.tb_OrderStatuses.InsertOnSubmit(statusLog);
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
    }
}