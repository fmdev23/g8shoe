﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.UserControl
{
    public partial class ProductdetailsCT : System.Web.UI.UserControl
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();

        public tb_Product product;

        public static List<tb_ProductCategory> listDMSP = new List<tb_ProductCategory>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadProduct();
                loadDMSP();
            }
        }

        void loadProduct()
        {
            // Lấy id từ QueryString
            if (Request.QueryString["id"] != null)
            {
                int.TryParse(Request.QueryString["id"], out id);
            }

            // Nếu có id thì tìm sản phẩm
            if (id > 0)
            {
                product = db.tb_Products.FirstOrDefault(p => p.id == id && p.IsActive == true);
            }
        }

        void loadDMSP()
        {
            var data = from q in db.tb_ProductCategories
                       select q;
            if (data != null && data.Count() > 0)
            {
                listDMSP = data.ToList();
            }
        }
    }
}