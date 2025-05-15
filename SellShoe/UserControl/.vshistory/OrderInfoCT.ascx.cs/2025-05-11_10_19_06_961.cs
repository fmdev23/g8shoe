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
                if (Session["user"] != null)
                {
                    LoadOrder();
                }
            }
        }

        void LoadOrder()
        {
            string user = Session["user"].ToString();

            // Lấy đơn hàng mới nhất của người dùng
            var order = (from o in db.tb_Orders
                         where o.CustomerName == user
                         orderby o.CreatedDate descending
                         select o).FirstOrDefault();

            if (order != null)
            {
                // Load thông tin người nhận
                lblRecipientName.Text = order.CustomerName;
                lblPhone.Text = order.Phone;
                lblAddress.Text = order.Address;
                lblOrderCode.Text = order.Code;

                // Load sản phẩm trong đơn
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
                        lblPayment.Text = $"Thanh toán {order.TotalAmount:N0} đ khi nhận hàng";
                    }
                }

                // Load timeline trạng thái đơn hàng
                rptTimeline.DataSource = db.tb_OrderStatuses
                    .Where(s => s.OrderID == order.id)
                    .OrderByDescending(s => s.CreatedAt);
                rptTimeline.DataBind();
            }
        }

        public class tb_OrderStatus
        {
            public int ID { get; set; }
            public int OrderID { get; set; }
            public string StatusTitle { get; set; }
            public string StatusDetail { get; set; }
            public bool IsActive { get; set; }
            public DateTime CreatedAt { get; set; }
        }

    }
}