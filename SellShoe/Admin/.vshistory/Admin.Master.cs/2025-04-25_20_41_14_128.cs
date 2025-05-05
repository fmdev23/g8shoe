using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.Admin
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        void HighlightCurrentPage()
        {
            string currentPage = Path.GetFileName(Request.Url.AbsolutePath).ToLower();

            if (currentPage == "ad_dash.aspx")
                lnkDashboard.Attributes["class"] += " active";
            else if (currentPage == "ad_category.aspx")
                lnkCategory.Attributes["class"] += " active";
            else if (currentPage == "ad_product.aspx")
                lnkProduct.Attributes["class"] += " active";
            else if (currentPage == "ad_prodetail.aspx")
                lnkProDetail.Attributes["class"] += " active";
            // Add more if needed
        }
    }
}