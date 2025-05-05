using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.IO; // nhớ using cái này

namespace SellShoe.Admin
{
    public partial class Team : System.Web.UI.Page
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public static List<tb_ContactPeople> listTeam = new List<tb_ContactPeople>();
        protected void Page_Load(object sender, EventArgs e)
        {
            loadTeam();
        }

        void loadTeam()
        {
            var data = from q in db.tb_ContactPeoples
                       select q;
            if (data != null && data.Count() > 0)
            {
                listTeam = data.ToList();
            }
        }

        [WebMethod]
        public static string UploadAvatar()
        {
            try
            {
                HttpPostedFile file = HttpContext.Current.Request.Files["file"];
                if (file != null && file.ContentLength > 0)
                {
                    string folderPath = HttpContext.Current.Server.MapPath("~/Uploads/Avatars/");
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }
                    string fileName = Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
                    string filePath = folderPath + fileName;
                    file.SaveAs(filePath);
                    string relativePath = "/Uploads/Avatars/" + fileName;
                    return relativePath;
                }
                return "";
            }
            catch
            {
                return "";
            }
        }
    }
}
