﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SellShoe.Admin
{
    public partial class Team : System.Web.UI.Page
    {
        public QuanLyBanGiayDataContext db = new QuanLyBanGiayDataContext();
        public static List<tb_ContactPeople> listTeam = new List<tb_ContactPeople>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMembers();
            }
        }

        private void LoadMembers()
        {
            dgMembers.DataSource = db.tb_ContactPeoples.ToList();
            dgMembers.DataBind();
        }

        protected void dgMembers_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
        {
            dgMembers.CurrentPageIndex = e.NewPageIndex;
            LoadMembers();
        }

        protected void dgMembers_EditCommand(object source, DataGridCommandEventArgs e)
        {
            dgMembers.EditItemIndex = e.Item.ItemIndex;
            LoadMembers();
        }

        protected void dgMembers_CancelCommand(object source, DataGridCommandEventArgs e)
        {
            dgMembers.EditItemIndex = -1;
            LoadMembers();
        }

        protected void dgMembers_UpdateCommand(object source, DataGridCommandEventArgs e)
        {
            int id = (int)dgMembers.DataKeys[e.Item.ItemIndex];

            var member = db.tb_ContactPeoples.FirstOrDefault(m => m.Id == id);
            if (member != null)
            {
                member.FullName = ((TextBox)e.Item.FindControl("txtFullName")).Text.Trim();
                member.Position = ((TextBox)e.Item.FindControl("txtPosition")).Text.Trim();
                member.Phone = ((TextBox)e.Item.FindControl("txtPhone")).Text.Trim();
                member.Email = ((TextBox)e.Item.FindControl("txtEmail")).Text.Trim();

                db.SubmitChanges();
            }

            dgMembers.EditItemIndex = -1;
            LoadMembers();
        }

        protected void dgMembers_DeleteCommand(object source, DataGridCommandEventArgs e)
        {
            int id = (int)dgMembers.DataKeys[e.Item.ItemIndex];
            var member = db.tb_ContactPeoples.FirstOrDefault(m => m.Id == id);
            if (member != null)
            {
                db.tb_ContactPeoples.DeleteOnSubmit(member);
                db.SubmitChanges();
            }

            LoadMembers();
        }

        protected void txtMemberAvatar_TextChanged(object sender, EventArgs e)
        {
            imgMemberAvatar.ImageUrl = txtMemberAvatar.Text.Trim();
        }

        protected void btnSaveMember_Click(object sender, EventArgs e)
        {
            using (var db = new QuanLyBanGiayDataContext())
            {
                try
                {
                    tb_ContactPeople member = new tb_ContactPeople
                    {
                        FullName = txtMemberFullName.Text.Trim(),
                        Position = txtMemberPosition.Text.Trim(),
                        Phone = txtMemberPhone.Text.Trim(),
                        Email = txtMemberEmail.Text.Trim(),
                        Avatar = txtMemberAvatar.Text.Trim()
                    };

                    db.tb_ContactPeoples.InsertOnSubmit(member);
                    db.SubmitChanges();

                    txtMemberFullName.Text = "";
                    txtMemberPosition.Text = "";
                    txtMemberPhone.Text = "";
                    txtMemberEmail.Text = "";
                    txtMemberAvatar.Text = "";
                    imgMemberAvatar.ImageUrl = "";

                    LoadMembers();

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "closeModal", "closeModal();", true);
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "alert('Lỗi khi thêm thành viên: " + ex.Message + "');", true);
                }
            }
        }


    }
}
