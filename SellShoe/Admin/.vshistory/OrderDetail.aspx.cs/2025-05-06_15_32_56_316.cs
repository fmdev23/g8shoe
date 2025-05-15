using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.Admin
{
    public partial class OrderDetail : System.Web.UI.Page
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public static List<tb_Order> listOD = new List<tb_Order>();
        protected void Page_Load(object sender, EventArgs e)
        {
            loadOrder();
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
    }
}