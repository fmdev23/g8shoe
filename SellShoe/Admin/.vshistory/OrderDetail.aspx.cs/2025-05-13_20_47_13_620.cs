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

            var query = from o in db.tb_Orders
                        join od in db.tb_OrderDetails on o.id equals od.OrderId into odGroup
                        from od in odGroup.DefaultIfEmpty()
                        join p in db.tb_Products on od.ProductId equals p.id into pGroup
                        from p in pGroup.DefaultIfEmpty()
                        orderby o.CreatedDate descending
                        select new OrderDisplayInfo
                        {
                            Order = o,
                            ProductImage = p != null ? p.Image : ""
                        };

            listDisplay = query.ToList();

            rptOrders.DataSource = listDisplay;
            rptOrders.DataBind();
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

        protected void rptOrders_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteOrder")
            {
                int orderId = int.Parse(e.CommandArgument.ToString());

                var order = db.tb_Orders.FirstOrDefault(o => o.id == orderId);
                if (order != null)
                {
                    // Xóa các chi tiết đơn hàng trước (nếu có)
                    var details = db.tb_OrderDetails.Where(d => d.OrderId == orderId).ToList();
                    db.tb_OrderDetails.DeleteAllOnSubmit(details);

                    // Xóa log trạng thái đơn hàng
                    var statuses = db.tb_OrderStatus.Where(s => s.OrderID == orderId).ToList();
                    db.tb_OrderStatus.DeleteAllOnSubmit(statuses);

                    // Xóa đơn hàng chính
                    db.tb_Orders.DeleteOnSubmit(order);
                    db.SubmitChanges();
                }

                loadOrder(); // Reload danh sách
            }
        }

        public class OrderDisplayInfo
        {
            public tb_Order Order { get; set; }
            public string ProductImage { get; set; }
        }

    }
}