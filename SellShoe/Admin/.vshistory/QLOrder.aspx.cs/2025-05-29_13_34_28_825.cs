using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.Admin
{
    public partial class QLOrder : System.Web.UI.Page
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public static List<tb_Order> listOD = new List<tb_Order>();
        public tb_OrderStatus listStatus = new tb_OrderStatus();
        public static List<OrderDisplayInfo> listDisplay = new List<OrderDisplayInfo>();

        void Page_Load(object sender, EventArgs e)
        {
            CheckDangNhap();
            if (!IsPostBack)
            {
                loadOrder();
                HandleDeleteOrder();
            }
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Xoá session
            Session.Clear();
            Session.Abandon();

            Response.Redirect("~/adminlogin.aspx");
        }

        void CheckDangNhap()
        {
            if (Session["Admin"] != null && Session["Password"] != null)
            {
                var data = from q in db.tb_AccountAdmins
                           where q.TenBien == "Admin"
                           && q.GiaTri == Session["Admin"].ToString()
                           select q;
                var dataPass = from q in db.tb_AccountAdmins
                               where q.TenBien == "Password"
                               && q.GiaTri == Session["Password"].ToString()
                               select q;
                if (data != null && data.Count() > 0)
                {

                }
                else
                {
                    Response.Redirect("../AdminLogin.aspx");
                }
            }
            else
            {
                Response.Redirect("../AdminLogin.aspx");
            }
        }

        void loadOrder()
        {
            listDisplay.Clear(); // Xóa dữ liệu cũ

            var query = from o in db.tb_Orders // Lấy tất cả đơn hàng
                        join od in db.tb_OrderDetails on o.id equals od.OrderId into odGroup // Kết nối với bảng OrderDetails
                        from od in odGroup.DefaultIfEmpty() // Sử dụng DefaultIfEmpty để lấy tất cả đơn hàng kể cả không có chi tiết
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

                    var oldStatuses = db.tb_OrderStatus.Where(s => s.OrderID == order.id && s.IsActive == true);
                    foreach (var s in oldStatuses)
                        s.IsActive = false;

                    tb_OrderStatus statusLog = new tb_OrderStatus
                    {
                        OrderID = order.id,
                        StatusTitle = (newStatus == 1) ? "Đã xác nhận" : "Đang chờ",
                        StatusDetail = (newStatus == 1) ? "Đơn hàng của bạn đã được xác nhận!." : "Đơn hàng đang chờ xác nhận.",
                        CreatedAt = DateTime.Now,
                        IsActive = true
                    };
                    db.tb_OrderStatus.InsertOnSubmit(statusLog);
                    db.SubmitChanges();

                    // Gọi Task thêm "Đang vận chuyển" sau 10 giây
                    if (newStatus == 1)
                    {
                        System.Threading.ThreadPool.QueueUserWorkItem(_ =>
                        {
                            System.Threading.Thread.Sleep(5000); // Delay 5 giây

                            try
                            {
                                QuanLyBanGiayDataContext dbDelay = new QuanLyBanGiayDataContext();

                                // Chuyển tất cả các trạng thái về Inactive
                                var old = dbDelay.tb_OrderStatus.Where(s => s.OrderID == order.id && s.IsActive == true);
                                foreach (var s in old)
                                    s.IsActive = false;

                                tb_OrderStatus newStatusEntry = new tb_OrderStatus
                                {
                                    OrderID = order.id,
                                    StatusTitle = "Đang vận chuyển",
                                    StatusDetail = "Đơn hàng đang được giao đến bạn.",
                                    CreatedAt = DateTime.Now,
                                    IsActive = true
                                };

                                dbDelay.tb_OrderStatus.InsertOnSubmit(newStatusEntry);
                                dbDelay.SubmitChanges();
                            }
                            catch
                            {

                            }
                        });
                    }

                    return true;
                }
                return false;
            }
            catch
            {
                return false;
            }
        }

        void HandleDeleteOrder()
        {
            string idStr = Request.QueryString["deleteId"];
            if (!string.IsNullOrEmpty(idStr))
            {
                int orderId = int.Parse(idStr);

                var order = db.tb_Orders.FirstOrDefault(o => o.id == orderId);
                if (order != null)
                {
                    var details = db.tb_OrderDetails.Where(d => d.OrderId == orderId).ToList();
                    db.tb_OrderDetails.DeleteAllOnSubmit(details);

                    var statuses = db.tb_OrderStatus.Where(s => s.OrderID == orderId).ToList();
                    db.tb_OrderStatus.DeleteAllOnSubmit(statuses);

                    db.tb_Orders.DeleteOnSubmit(order);
                    db.SubmitChanges();
                    loadOrder(); // Reload danh sách
                }
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