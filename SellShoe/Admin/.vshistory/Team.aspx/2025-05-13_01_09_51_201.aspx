<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Team.aspx.cs" Inherits="SellShoe.Admin.Team" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Content Card -->
    <div class="content-card">
        <div class="card-header">
            <h2>QUẢN LÝ THÀNH VIÊN ĐỘI NGŨ</h2>
            <div class="header-actions">
                <button type="button" class="add-product-btn" id="addMemberBtn">Thêm thành viên</button>
            </div>
        </div>

        <div class="table-container">
            <asp:DataGrid ID="dgMembers" runat="server"
                AllowPaging="true" PageSize="7"
                AutoGenerateColumns="False"
                PagerStyle-Mode="NumericPages"
                DataKeyField="Id"
                OnPageIndexChanged="dgMembers_PageIndexChanged"
                OnEditCommand="dgMembers_EditCommand"
                OnCancelCommand="dgMembers_CancelCommand"
                OnUpdateCommand="dgMembers_UpdateCommand"
                OnDeleteCommand="dgMembers_DeleteCommand"
                CssClass="products-table table-container">

                <Columns>
                    <%-- Họ và tên --%>
                    <asp:TemplateColumn HeaderText="Họ và tên">
                        <ItemTemplate><%# Eval("FullName") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtFullName" runat="server" Text='<%# Bind("FullName") %>' />
                        </EditItemTemplate>
                    </asp:TemplateColumn>

                    <%-- Chức vụ --%>
                    <asp:TemplateColumn HeaderText="Chức vụ">
                        <ItemTemplate><%# Eval("Position") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPosition" runat="server" Text='<%# Bind("Position") %>' />
                        </EditItemTemplate>
                    </asp:TemplateColumn>

                    <%-- Điện thoại --%>
                    <asp:TemplateColumn HeaderText="Điện thoại">
                        <ItemTemplate><%# Eval("Phone") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPhone" runat="server" Text='<%# Bind("Phone") %>' />
                        </EditItemTemplate>
                    </asp:TemplateColumn>

                    <%-- Email --%>
                    <asp:TemplateColumn HeaderText="Email">
                        <ItemTemplate><%# Eval("Email") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>' />
                        </EditItemTemplate>
                    </asp:TemplateColumn>

                    <%-- Ảnh đại diện (chỉ hiển thị, không cho sửa) --%>
                    <asp:TemplateColumn HeaderText="Ảnh đại diện">
                        <ItemTemplate>
                            <asp:Image ID="imgAvatar" runat="server" Width="60" Height="60"
                                Style="border-radius: 50%;" ImageUrl='<%# Eval("Avatar") %>' />
                        </ItemTemplate>
                    </asp:TemplateColumn>

                    <%-- Tùy chọn --%>
                    <asp:TemplateColumn HeaderText="Tùy chọn">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" CommandName="Edit" ToolTip="Sửa"
                                Text='<i class="fad fa-edit"></i>' CssClass="btn-icon" />
                            &nbsp;
                    <asp:LinkButton runat="server" CommandName="Delete" ToolTip="Xóa"
                        Text='<i class="fad fa-trash"></i>' CssClass="btn-icon"
                        OnClientClick="return confirm('Xóa thành viên này?');" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:LinkButton runat="server" CommandName="Update" ToolTip="Cập nhật"
                                Text='<i class="fad fa-check"></i>' CssClass="btn-icon" />
                            &nbsp;
                    <asp:LinkButton runat="server" CommandName="Cancel" ToolTip="Hủy"
                        Text='<i class="fad fa-outdent"></i>' CssClass="btn-icon" />
                        </EditItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
            </asp:DataGrid>
        </div>


        <!-- Add/Edit Member Modal -->
        <div class="modal" id="memberModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 id="modalTitle">Thêm thành viên</h3>
                    <button class="close-modal" id="closeModal">
                        <i class="fad fa-times"></i>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="memberForm">
                        <input type="hidden" id="memberId" />

                        <div class="form-group">
                            <label>Họ và tên</label>
                            <input type="text" id="txtFullName" />
                        </div>
                        <div class="form-group">
                            <label>Chức vụ</label>
                            <input type="text" id="txtPosition" />
                        </div>
                        <div class="form-group">
                            <label>Điện thoại</label>
                            <input type="text" id="txtPhone" />
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" id="txtEmail" />
                        </div>
                        <div class="form-group">
                            <label>Ảnh đại diện</label>
                            <input type="text" id="txtAvatarUrl" placeholder="Đường dẫn ảnh..." />
                            <div style="margin-top: 10px;">
                                <img id="previewAvatar" src="" alt="Ảnh đại diện" style="max-width: 100px; max-height: 100px;" />
                            </div>
                        </div>



                        <div class="form-actions">
                            <button type="button" class="cancel-btn" id="cancelBtn">Thoát</button>
                            <button type="button" class="save-btn" id="saveMemberBtn">Lưu</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
