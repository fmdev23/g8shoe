using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.UserControl
{
    public partial class OrderToastNotify : System.Web.UI.UserControl
    {
        QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int userId = 0;

                // TODO: Cập nhật theo hệ thống auth của bạn
                if (Session["UserID"] != null)
                {
                    userId = Convert.ToInt32(Session["UserID"]);
                }

                var order = db.tb_Orders
                              .Where(o => o.UserID == userId && o.Status == 1)
                              .OrderByDescending(o => o.ModifiedDate)
                              .FirstOrDefault();

                if (order != null)
                {
                    var status = db.tb_OrderStatus
                                   .FirstOrDefault(s => s.OrderID == order.id && s.IsActive && s.StatusTitle == "Đã xác nhận");

                    if (status != null)
                    {
                        string message = status.StatusDetail;

                        // Chèn script SweetAlert2
                        litToastScript.Text = $@"
                        <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
                        <script>
                            window.onload = function () {{
                                Swal.fire({{
                                    toast: true,
                                    position: 'top-end',
                                    icon: 'success',
                                    title: '{message}',
                                    showConfirmButton: false,
                                    timer: 3000,
                                    timerProgressBar: true
                                }});
                            }};
                        </script>";
                    }
                }
            }
        }
    }

}