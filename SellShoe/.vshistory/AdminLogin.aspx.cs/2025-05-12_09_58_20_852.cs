using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if(txtUsername.Text != "" && txtPassword.Text != "")
            {
                var data = from q in db.tb_AccountAdmins
                           where q.Username == "Username" && q.Password == txtUsername.Text
                           select q;
                if(data!=null && data.Count() > 0)
                {
                    Session["Admin"] = data.FirstOrDefault();
                    Response.Redirect("~/Admin/Dash.aspx");
                }
                else
                {
                    lblMessage.Text = "Invalid username or password.";
                }
            }

            string username = txtUsername.Text;
            string password = txtPassword.Text;
            // Check if the username and password are correct
            if (username == "admin" && password == "password")
            {
                // Redirect to the admin dashboard
                Response.Redirect("~/Admin/Dash.aspx");
            }
            else
            {
                lblMessage.Text = "Invalid username or password.";
            }
        }
    }
}