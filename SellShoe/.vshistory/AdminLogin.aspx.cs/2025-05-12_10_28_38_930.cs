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
                           where q.TenBien == "Admin"
                           && q.GiaTri == txtUsername.Text
                           select q;
                if (data != null && data.Count() > 0) {
                    var dataPass = from q in db.tb_AccountAdmins
                                   where q.TenBien == "Password"
                                   && q.GiaTri == txtPassword.Text
                                   select q;
                    if (dataPass != null && dataPass.Count() > 0) { 
                        Session["Admin"] = txtUsername.Text;
                        Session["Password"] = txtPassword.Text;
                        Response.Redirect("../Admin/Dash.aspx");
                    } else {
                        lblPassword.Text = "Sai mật khẩu";
                    }
                } else {
                    lblUsername.Text = "Sai tài khoản";
                }
            } else
            {
                if (txtUsername.Text == "")
                {
                    lblUsername.Text = "Vui lòng nhập tài khoản";
                }
                if (txtPassword.Text == "")
                {
                    lblPassword.Text = "Vui lòng nhập mật khẩu";
                }
            }
        }


    }
}