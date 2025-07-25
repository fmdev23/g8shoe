﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Configuration;
using Newtonsoft.Json;
using System.Data.SqlClient;


namespace SellShoe.Admin
{
    public partial class ProductCategory : System.Web.UI.Page
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public List<tb_ProductCategory> listCategory = new List<tb_ProductCategory>();
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadCategories();
        }

        // Load danh mục sản phẩm
        void LoadCategories()
        {
            var list = db.tb_Categories.OrderBy(c => c.id).ToList();
            gvCategory.DataSource = list;
            gvCategory.DataBind();
        }

        protected void gvCategory_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCategory.EditIndex = e.NewEditIndex;
            LoadCategories();
        }

        protected void gvCategory_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCategory.EditIndex = -1;
            LoadCategories();
        }

        protected void gvCategory_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = (int)gvCategory.DataKeys[e.RowIndex].Value;
            GridViewRow row = gvCategory.Rows[e.RowIndex];

            TextBox txtTitle = (TextBox)row.FindControl("txtTitle");
            TextBox txtDescription = (TextBox)row.FindControl("txtDescription");
            TextBox txtAlias = (TextBox)row.FindControl("txtAlias");

            var cate = db.tb_Categories.SingleOrDefault(c => c.id == id);
            if (cate != null)
            {
                cate.Title = txtTitle.Text.Trim();
                cate.Description = txtDescription.Text.Trim();
                cate.Alias = txtAlias.Text.Trim();

                db.SubmitChanges();
            }

            gvCategory.EditIndex = -1;
            LoadCategories();
        }

        protected void gvCategory_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = (int)gvCategory.DataKeys[e.RowIndex].Value;
            var cate = db.tb_Categories.SingleOrDefault(c => c.id == id);
            if (cate != null)
            {
                db.tb_Categories.DeleteOnSubmit(cate);
                db.SubmitChanges();
            }

            LoadCategories();
        }

        // WebMethod để thêm/sửa danh mục sản phẩm
        [WebMethod]
        public static string SaveCategory(CategoryModel category)
        {
            try
            {
                using (var db = new QuanLyBanGiayDataContext())
                {
                    if (category.id == 0)
                    {
                        // THÊM MỚI
                        var newCategory = new tb_ProductCategory
                        {
                            Title = category.title,
                            Description = category.description ?? "",
                            Alias = category.alias,
                            CreatedDate = DateTime.Now,
                            ModifiedDate = DateTime.Now,   // << BẮT BUỘC CÓ
                            CreatedBy = "admin",
                            ModifierBy = "admin",
                            Icon = "",
                            SeoTitle = category.title, // Hoặc để ""
                            SeoDescription = category.description ?? "",
                            SeoKeywords = ""
                        };
                        db.tb_ProductCategories.InsertOnSubmit(newCategory);
                    }
                    else
                    {
                        // CHỈNH SỬA
                        var existingCategory = db.tb_ProductCategories.SingleOrDefault(c => c.id == category.id);
                        if (existingCategory != null)
                        {
                            existingCategory.Title = category.title;
                            existingCategory.Description = category.description ?? "";
                            existingCategory.Alias = category.alias;
                            existingCategory.ModifiedDate = DateTime.Now;
                            existingCategory.ModifierBy = "admin";
                            existingCategory.SeoTitle = category.title;
                            existingCategory.SeoDescription = category.description ?? "";
                            existingCategory.SeoKeywords = "";
                        }
                        else
                        {
                            return "not found";
                        }
                    }

                    db.SubmitChanges();
                    return "success";
                }
            }
            catch (Exception ex)
            {
                return "error: " + ex.ToString(); // để debug lỗi kỹ hơn
            }
        }

        // WebMethod để xóa danh mục sản phẩm
        [WebMethod]
        public static string DeleteCategory(int id)
        {
            using (var db = new QuanLyBanGiayDataContext())
            {
                var category = db.tb_ProductCategories.SingleOrDefault(c => c.id == id);
                if (category != null)
                {
                    db.tb_ProductCategories.DeleteOnSubmit(category);
                    db.SubmitChanges();
                    return "success";
                }
                return "not found";
            }
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