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
        // ViewModel đơn giản để bind ra view
        public class OrderViewModel
        {
            public string Code { get; set; }
            public DateTime? CreatedDate { get; set; }
            public decimal TotalAmount { get; set; }
            public string Status { get; set; }
        }

        public List<OrderViewModel> listOD = new List<OrderViewModel>();
        QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadRecentOrders();
            }
        }

        void LoadRecentOrders()
        {
            listOD = (from o in db.tb_Orders
                      orderby o.CreatedDate descending
                      select new OrderViewModel
                      {
                          Code = o.Code,
                          CreatedDate = o.CreatedDate,
                          TotalAmount = o.TotalAmount,
                          Status = o.Status == 1 ? "Đã xác nhận" :
                                   o.Status == 0 ? "Đang chờ" :
                                   "Đã huỷ"
                      })
                     .Take(5)
                     .ToList();
        }
    }


}