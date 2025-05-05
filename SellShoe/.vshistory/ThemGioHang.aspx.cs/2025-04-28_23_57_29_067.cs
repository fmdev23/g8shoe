using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe
{
    public partial class ThemGioHang : System.Web.UI.Page
    {
        QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            int id = 0;
            int quantity = 1;
            int size = 0;

            if (Request.QueryString["id"] != null)
            {
                int.TryParse(Request.QueryString["id"], out id);
            }
            if (Request.QueryString["quantity"] != null)
            {
                int.TryParse(Request.QueryString["quantity"], out quantity);
            }
            if (Request.QueryString["size"] != null)
            {
                int.TryParse(Request.QueryString["size"], out size);
            }
        }
    }
}