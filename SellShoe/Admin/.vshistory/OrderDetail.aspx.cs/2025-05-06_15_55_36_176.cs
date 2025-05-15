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
        void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadOrder(); // luôn gọi load sau khi xử lý toggle
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
    }
}