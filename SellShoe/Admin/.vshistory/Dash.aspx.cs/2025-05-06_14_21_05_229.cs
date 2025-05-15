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
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public List<tb_OrderDetail> listOD = new List<tb_OrderDetail>();
        protected void Page_Load(object sender, EventArgs e)
        {
            loadOD();
        }

        void loadOD()
        {
            listOD = db.tb_OrderDetails.ToList();
        }
    }
}