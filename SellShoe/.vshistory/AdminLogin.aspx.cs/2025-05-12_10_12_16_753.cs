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
                           where q.Username == "Username" && q.Username == txtUsername.Text
                           select q;
                if (data != null && data.Count() > 0)
                {
                    var dataPass = from q in db.tb_AccountAdmins
                                   where q.Username == "Password" && q.Password == txtPassword.Text
                                   select q;
                    if (dataPass != null && dataPass.Count() > 0)
                    {
                        Session["Admin"] = txtUsername.Text;
                        Session["Password"] = txtPassword.Text;
                        Response.Redirect("~/Admin/Dash.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Invalid password.";
                    }
                } 
                else
                {
                    lblMessage.Text = "Invalid username.";
                }
            } 
            else
            {
                lblMessage.Text = "Please enter username and password.";
            }
        }
    }
}