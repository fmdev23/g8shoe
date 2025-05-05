using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.UserControl
{
    public partial class ProductCT : System.Web.UI.UserControl
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();

        public static List<tb_Product> listSP = new List<tb_Product>();

        protected void Page_Load(object sender, EventArgs e)
        {
            loadProduct();
        }

        void loadProduct()
        {
            var data = from q in db.tb_Products
                       where q.IsActive == true
                       select q;
            if(data != null && data.Count()>0)
            {
                listSP = data.ToList();
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int productId = Convert.ToInt32(btn.CommandArgument);
            int quantity = 1; // mặc định 1 nếu ở list
            string size = "39"; // bạn có thể chọn hoặc mặc định 1 size

            AddToCart(productId, quantity, size);

            Response.Redirect("~/Cart.aspx");
        }
    }


}