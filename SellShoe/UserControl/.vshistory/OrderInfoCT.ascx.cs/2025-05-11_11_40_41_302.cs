using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.UserControl
{
    public partial class OrderInfoCT : System.Web.UI.UserControl
    {
        QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOrder();
            }
        }

        void LoadOrder()
        {
            tb_Order order = null;

            // Ưu tiên đơn mới đặt
            if (Session["lastOrderId"] != null)
            {
                int orderId = (int)Session["lastOrderId"];
                order = db.tb_Orders.FirstOrDefault(o => o.id == orderId);

                // Sau khi lấy xong thì clear session
                Session["lastOrderId"] = null;
            }
            else if (Session["user"] != null)
            {
                string user = Session["user"].ToString();
                order = db.tb_Orders
                    .Where(o => o.CustomerName == user)
                    .OrderByDescending(o => o.CreatedDate)
                    .FirstOrDefault();
            }

            if (order != null)
            {
                // Load thông tin người nhận
                lblRecipientName.Text = order.CustomerName;
                lblPhone.Text = order.Phone;
                lblAddress.Text = order.Address;
                lblOrderCode.Text = order.Code;

                // Load sản phẩm trong đơn hàng
                var orderDetail = db.tb_OrderDetails.FirstOrDefault(od => od.OrderId == order.id);
                if (orderDetail != null)
                {
                    var product = db.tb_Products.FirstOrDefault(p => p.id == orderDetail.ProductId);
                    if (product != null)
                    {
                        imgProduct.ImageUrl = product.Image;
                        lblProductTitle.Text = product.Title;
                        lblQuantity.Text = orderDetail.Quantity.ToString();
                        lblSize.Text = orderDetail.Size;
                        lblPayment.Text = $"Thanh toán: {order.TotalAmount:N0} khi nhận hàng";
                    }
                }

                // Load timeline trạng thái đơn hàng
                var timelineData = db.tb_OrderStatus
                    .Where(s => s.OrderID == order.id)
                    .OrderByDescending(s => s.CreatedAt)
                    .ToList();

                rptTimeline.DataSource = timelineData;
                rptTimeline.DataBind();
            }
        }
    }


}