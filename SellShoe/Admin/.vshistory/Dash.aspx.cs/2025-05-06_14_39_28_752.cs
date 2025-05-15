using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.Admin
{
    public partial class Dash : System.Web.UI.Page
    {
        public class OrderSummary
        {
            public string Code { get; set; }
            public DateTime CreatedDate { get; set; }
            public decimal TotalAmount { get; set; }
            public string Status { get; set; }
        }

        public List<OrderSummary> listOD = new List<OrderSummary>();

        QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadRecentOrders();
            }
        }

        void loadRecentOrders()
        {
            listOD = (from o in db.tb_Orders
                      orderby o.CreatedDate descending
                      select new OrderSummary
                      {
                          Code = o.Code,
                          CreatedDate = o.CreatedDate ?? DateTime.MinValue,
                          TotalAmount = db.tb_OrderDetails
                                         .Where(od => od.OrderId == o.Id)
                                         .Sum(od => (decimal?)od.Quantity * od.Price) ?? 0,
                          Status = o.Status // assuming o.Status is a string or enum
                      })
                     .Take(5)
                     .ToList();
        }
    }

}