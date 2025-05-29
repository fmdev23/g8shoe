using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.Admin
{
    public partial class QLTeam : System.Web.UI.Page
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public static List<tb_ContactPeople> listTeam = new List<tb_ContactPeople>();

        protected void Page_Load(object sender, EventArgs e)
        {
            CheckDangNhap();
            if (!IsPostBack)
            {
                LoadMembers();
            }
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Xoá session
            Session.Clear();
            Session.Abandon();

            Response.Redirect("~/adminlogin.aspx");
        }

        void CheckDangNhap()
        {
            if (Session["Admin"] != null && Session["Password"] != null)
            {
                var data = from q in db.tb_AccountAdmins
                           where q.TenBien == "Admin"
                           && q.GiaTri == Session["Admin"].ToString()
                           select q;
                var dataPass = from q in db.tb_AccountAdmins
                               where q.TenBien == "Password"
                               && q.GiaTri == Session["Password"].ToString()
                               select q;
                if (data != null && data.Count() > 0)
                {
                    
                }
                else
                {
                    Response.Redirect("../AdminLogin.aspx");
                }
            }
            else
            {
                Response.Redirect("../AdminLogin.aspx");
            }
        }

        private void LoadMembers()
        {
            dgMembers.DataSource = db.tb_ContactPeoples.ToList(); // Lấy danh sách thành viên từ CSDL
            dgMembers.DataBind(); // Ràng buộc dữ liệu vào DataGrid
        }

        protected void dgMembers_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
        {
            dgMembers.CurrentPageIndex = e.NewPageIndex; // Cập nhật chỉ mục trang hiện tại
            LoadMembers(); // Tải lại danh sách thành viên
        }

        protected void dgMembers_EditCommand(object source, DataGridCommandEventArgs e)
        {
            dgMembers.EditItemIndex = e.Item.ItemIndex; // Đặt chỉ mục của mục đang chỉnh sửa
            LoadMembers();  // Tải lại danh sách thành viên để hiển thị chế độ chỉnh sửa
        }

        protected void dgMembers_CancelCommand(object source, DataGridCommandEventArgs e)
        {
            dgMembers.EditItemIndex = -1; // Hủy chế độ chỉnh sửa
            LoadMembers(); // Tải lại danh sách thành viên
        }

        protected void dgMembers_UpdateCommand(object source, DataGridCommandEventArgs e)
        {
            int id = (int)dgMembers.DataKeys[e.Item.ItemIndex]; // Lấy ID của thành viên từ DataKeys

            var member = db.tb_ContactPeoples.FirstOrDefault(m => m.Id == id); // Tìm thành viên theo ID
            if (member != null) // Nếu tìm thấy thành viên
            {
                member.FullName = ((TextBox)e.Item.FindControl("txtFullName")).Text.Trim(); // Lấy giá trị từ TextBox
                member.Position = ((TextBox)e.Item.FindControl("txtPosition")).Text.Trim(); // Cập nhật vị trí
                member.Phone = ((TextBox)e.Item.FindControl("txtPhone")).Text.Trim(); // Cập nhật số điện thoại
                member.Email = ((TextBox)e.Item.FindControl("txtEmail")).Text.Trim(); // Cập nhật email

                db.SubmitChanges();
            }

            dgMembers.EditItemIndex = -1;
            LoadMembers();
        }

        protected void dgMembers_DeleteCommand(object source, DataGridCommandEventArgs e)
        {
            int id = (int)dgMembers.DataKeys[e.Item.ItemIndex]; // Lấy ID của thành viên từ DataKeys
            var member = db.tb_ContactPeoples.FirstOrDefault(m => m.Id == id); // Tìm thành viên theo ID
            if (member != null)
            {
                db.tb_ContactPeoples.DeleteOnSubmit(member);
                db.SubmitChanges();
            }

            LoadMembers();
        }

        protected void btnSaveMember_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return; // Kiểm tra tính hợp lệ của trang

            try
            {
                string imagePath = ""; // Biến để lưu đường dẫn ảnh

                if (fuImage.HasFile)
                {
                    string fileName = Path.GetFileName(fuImage.FileName); // Lấy tên file từ FileUpload control
                    string peopleFolder = "/img/people/"; // Thư mục lưu ảnh thành viên
                    string serverFolder = Server.MapPath(peopleFolder);

                    // Tạo tên file duy nhất để tránh trùng
                    string uniqueFileName = DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + fileName;
                    string filePath = peopleFolder + uniqueFileName;

                    // Lưu file ảnh lên server
                    fuImage.SaveAs(Server.MapPath(filePath));

                    // Lưu đường dẫn vào CSDL
                    imagePath = filePath;
                }

                int memberId = 0;
                int.TryParse(hfMemberId.Value, out memberId);

                if (memberId == 0)
                {
                    // Thêm mới thành viên
                    var member = new tb_ContactPeople
                    {
                        FullName = txtMemberFullName.Text.Trim(),
                        Position = txtMemberPosition.Text.Trim(),
                        Phone = txtMemberPhone.Text.Trim(),
                        Email = txtMemberEmail.Text.Trim(),
                        Avatar = imagePath
                    };

                    db.tb_ContactPeoples.InsertOnSubmit(member);
                }
                else
                {
                    // Cập nhật thành viên
                    var member = db.tb_ContactPeoples.FirstOrDefault(m => m.Id == memberId);
                    if (member != null)
                    {
                        member.FullName = txtMemberFullName.Text.Trim();
                        member.Position = txtMemberPosition.Text.Trim();
                        member.Phone = txtMemberPhone.Text.Trim();
                        member.Email = txtMemberEmail.Text.Trim();
                        if (!string.IsNullOrEmpty(imagePath))
                            member.Avatar = imagePath;
                    }
                }

                db.SubmitChanges();

                // Làm mới lại giao diện
                txtMemberFullName.Text = "";
                txtMemberPosition.Text = "";
                txtMemberPhone.Text = "";
                txtMemberEmail.Text = "";
                hfMemberId.Value = "0";

                LoadMembers();
                upMembers.Update();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "closeModal", "closeModal();", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "alert('Lỗi khi lưu thành viên: " + ex.Message.Replace("'", "\\'") + "');", true);
            }
        }





    }
}