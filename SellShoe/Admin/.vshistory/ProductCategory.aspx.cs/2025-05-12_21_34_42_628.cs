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
        public static List<tb_ProductCategory> listCategory = new List<tb_ProductCategory>();
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadCategories();
        }

        // Load danh mục sản phẩm
        void LoadCategories()
        {
            var list = db.tb_ProductCategories.OrderBy(c => c.id).ToList();
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

        public class CategoryModel
        {
            public int id { get; set; }
            public string title { get; set; }
            public string description { get; set; }
            public string alias { get; set; }
        }


    }
}