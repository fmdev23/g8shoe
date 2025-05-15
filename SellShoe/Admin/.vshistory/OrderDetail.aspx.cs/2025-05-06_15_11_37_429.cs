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
            var data = from q in db.tb_Orders
                       select q;
            if (data != null && data.Count() > 0)
            {
                listOD = data.ToList();
            }
        }
    }
}