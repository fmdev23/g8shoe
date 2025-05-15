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
                if (Request.QueryString["toggle"] == "1" && Request.QueryString["id"] != null)
                {
                    int orderId = int.Parse(Request.QueryString["id"]);
                    ToggleOrderStatus(orderId);
                }

                loadOrder(); // luôn gọi load sau khi xử lý toggle
            }
        }

        void ToggleOrderStatus(int id)
        {
            var order = db.tb_Orders.FirstOrDefault(o => o.id == id);
            if (order != null)
            {
                // Toggle status: nếu 0 thì chuyển thành 1, ngược lại chuyển về 0
                order.Status = (order.Status == 0) ? 1 : 0;
                order.ModifiedDate = DateTime.Now;
                db.SubmitChanges();
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