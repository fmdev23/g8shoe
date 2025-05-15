<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Team.aspx.cs" Inherits="SellShoe.Admin.Team" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <!-- Content Card -->
    <div class="content-card">
        <div class="card-header">
            <h2>QUẢN LÝ THÀNH VIÊN ĐỘI NGŨ</h2>
            <div class="header-actions">
                <asp:Button ID="btnShowModal" runat="server" CssClass="add-product-btn" Text="Thêm thành viên" UseSubmitBehavior="false" OnClientClick="showModal(); return false;" />
            </div>
        </div>

            <asp:UpdatePanel ID="upMembers" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
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
                    </ContentTemplate>
                </asp:UpdatePanel>
        </div>


        <!-- Modal thêm thành viên -->
        <asp:Panel ID="pnlMemberModal" runat="server" CssClass="modal" Style="display: none;">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 id="modalTitle">Thêm thành viên</h3>
                    <asp:LinkButton ID="btnCloseModal" runat="server" CssClass="close-modal" OnClientClick="closeModal(); return false;">
                <i class="fad fa-times"></i>
                    </asp:LinkButton>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hfMemberId" runat="server" />

                    <div class="form-group">
                        <label>Họ và tên</label>
                        <asp:TextBox ID="txtMemberFullName" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group">
                        <label>Chức vụ</label>
                        <asp:TextBox ID="txtMemberPosition" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group">
                        <label>Điện thoại</label>
                        <asp:TextBox ID="txtMemberPhone" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group">
                        <label>Email</label>
                        <asp:TextBox ID="txtMemberEmail" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group">
                        <label>Ảnh đại diện (URL)</label>
                        <asp:TextBox ID="txtMemberAvatar" runat="server" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtMemberAvatar_TextChanged" />
                        <div style="margin-top: 10px;">
                            <asp:Image ID="imgMemberAvatar" runat="server" Width="100" Height="100" />
                        </div>
                    </div>

                    <div class="form-actions">
                        <asp:Button ID="btnCancelMember" runat="server" Text="Thoát" CssClass="cancel-btn" OnClientClick="closeModal(); return false;" />
                        <asp:Button ID="btnSaveMember" runat="server" Text="Lưu" CssClass="save-btn" OnClick="btnSaveMember_Click" UseSubmitBehavior="true"/>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>

    <script>
        function showModal() {
            document.getElementById('<%= pnlMemberModal.ClientID %>').style.display = 'flex';
    }

    function closeModal() {
        document.getElementById('<%= pnlMemberModal.ClientID %>').style.display = 'none';
        }
    </script>




</asp:Content>
