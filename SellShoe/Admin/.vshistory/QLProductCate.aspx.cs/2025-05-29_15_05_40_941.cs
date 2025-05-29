using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.Admin
{
    public partial class QLProductCate : System.Web.UI.Page
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public static List<tb_ProductCategory> listCategory = new List<tb_ProductCategory>();

        protected void Page_Load(object sender, EventArgs e)
        {
            CheckDangNhap();
            if (!IsPostBack)
            {
                LoadCategories();
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

        // Load danh mục sản phẩm
        void LoadCategories()
        {

            var list = db.tb_ProductCategories.OrderBy(c => c.id).ToList(); // Lấy toàn bộ danh mục sản phẩm từ CSDL, sắp xếp theo id
            gvCategory.DataSource = list; // Gán dữ liệu vào GridView để hiển thị
            gvCategory.DataBind();
        }

        // Sự kiện khi người dùng nhấn nút Sửa trên 1 dòng của GridView
        protected void gvCategory_RowEditing(object sender, GridViewEditEventArgs e)
        {
            // Đặt dòng đang sửa thành dòng được chọn
            gvCategory.EditIndex = e.NewEditIndex;

            // Tải lại danh sách để hiển thị trạng thái sửa
            LoadCategories();
        }

        // Sự kiện khi người dùng nhấn nút Hủy sửa
        protected void gvCategory_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            // Đặt chỉ số dòng sửa về -1 (tắt chế độ sửa)
            gvCategory.EditIndex = -1;

            // Tải lại danh sách để trở về trạng thái xem bình thường
            LoadCategories();
        }

        // Sự kiện khi người dùng lưu cập nhật trên 1 dòng GridView
        protected void gvCategory_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = (int)gvCategory.DataKeys[e.RowIndex].Value;
            GridViewRow row = gvCategory.Rows[e.RowIndex];

            TextBox txtTitle = (TextBox)row.FindControl("txtTitle");
            TextBox txtDescription = (TextBox)row.FindControl("txtDescription");
            TextBox txtAlias = (TextBox)row.FindControl("txtAlias");

            var cate = db.tb_ProductCategories.SingleOrDefault(c => c.id == id);
            if (cate != null)
            {
                cate.Title = txtTitle.Text.Trim();
                cate.Description = txtDescription.Text.Trim();
                cate.Alias = txtAlias.Text.Trim();
                cate.ModifiedDate = DateTime.Now;

                db.SubmitChanges();
            }

            gvCategory.EditIndex = -1;
            LoadCategories();
        }

        protected void gvCategory_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = (int)gvCategory.DataKeys[e.RowIndex].Value;
            var cate = db.tb_ProductCategories.SingleOrDefault(c => c.id == id);
            if (cate != null)
            {
                db.tb_ProductCategories.DeleteOnSubmit(cate);
                db.SubmitChanges();
            }

            LoadCategories();
        }

        protected void btnSaveCategory_Click(object sender, EventArgs e)
        {
            // Lấy dữ liệu từ control
            string title = txtModalTitle.Text.Trim();
            string description = txtModalDescription.Text.Trim();
            string alias = txtModalAlias.Text.Trim();

            if (!string.IsNullOrEmpty(title))
            {
                var newCate = new tb_ProductCategory
                {
                    Title = title,
                    Description = description,
                    Alias = alias,
                    CreatedDate = DateTime.Now,
                    ModifiedDate = DateTime.Now
                };

                db.tb_ProductCategories.InsertOnSubmit(newCate);
                db.SubmitChanges();

                LoadCategories();
            }

            // Reset form
            txtModalTitle.Text = "";
            txtModalDescription.Text = "";
            txtModalAlias.Text = "";

            // Ẩn modal
            ScriptManager.RegisterStartupScript(this, this.GetType(), "HideModal", "closeModal();", true);
        }

        public class CategoryModel
        {
            public int id { get; set; }
            public string title { get; set; }
            public string description { get; set; }
            public string alias { get; set; }
        }
    }

}