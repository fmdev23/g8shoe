<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QLTeam.aspx.cs" Inherits="SellShoe.Admin.QLTeam" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ADMIN</title>
    <link rel="stylesheet" href="~/Admin/admin.css" />
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" />

    <!-- SweetAlert2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet" />

    <!-- SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />

        <div class="app-container">
            <!-- Sidebar -->
            <aside class="sidebar">
                <div class="logo-container">
                    <i class="fad fa-layer-group"></i>
                    <h1>G8Shoe | ADMIN</h1>
                </div>

                <nav class="sidebar-nav">
                    <ul>
                        <li>
                            <a href="QLDashboard.aspx" class="nav-item">
                                <i class="fad fa-th-large"></i>
                                <span>Dữ liệu</span>
                            </a>
                        </li>
                        <li>
                            <a href="ProductCategory.aspx" class="nav-item">
                                <i class="fad fa-list-ul"></i>
                                <span>Danh mục</span>
                            </a>
                        </li>
                        <li>
                            <a href="Product.aspx" class="nav-item">
                                <i class="fad fa-shopping-bag"></i>
                                <span>Sản phẩm</span>
                            </a>
                        </li>
                        <li>
                            <a href="OrderDetail.aspx" class="nav-item">
                                <i class="fad fa-shopping-cart"></i>
                                <span>Đơn hàng</span>
                            </a>
                        </li>
                        <li>
                            <a href="Contact.aspx" class="nav-item">
                                <i class="fad fa-star-half-alt"></i>
                                <span>Phản hồi</span>
                            </a>
                        </li>
                        <li>
                            <a href="Team.aspx" class="nav-item">
                                <i class="fad fa-users"></i>
                                <span>Thành viên</span>
                            </a>
                        </li>
                    </ul>
                    <div class="sidebar-divider"></div>
                    <ul>
                        <li>
                            <asp:LinkButton ID="btnLogout" runat="server" OnClick="btnLogout_Click" CssClass="nav-item">
<i class="fad fa-sign-out"></i>
<span>Đăng xuất</span>
                            </asp:LinkButton>

                        </li>
                    </ul>
                </nav>
            </aside>

            <!-- Main Content -->
            <main class="main-content">
                <!-- Breadcrumb -->
                <div class="breadcrumb">
                    <a href="dash.aspx">Admin</a>
                    <i class="fad fa-chevron-right"></i>
                    <span id="breadcrumbTitle">Đang tải...</span>
                </div>
                <!-- Content Card -->
                <div class="content-card">
                    <div class="card-header">
                        <h2>QUẢN LÝ THÀNH VIÊN ĐỘI NGŨ</h2>
                        <div class="header-actions">
                            <asp:Button ID="btnShowModal" runat="server" CssClass="add-product-btn" Text="Thêm thành viên" UseSubmitBehavior="false" OnClientClick="showModal(); return false;" />
                        </div>
                    </div>

                    <div class="table-container">
                        <asp:UpdatePanel ID="upMembers" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:DataGrid ID="dgMembers" runat="server"
                                    AllowPaging="true" PageSize="10"
                                    AutoGenerateColumns="False"
                                    PagerStyle-Mode="NumericPages"
                                    DataKeyField="Id"
                                    OnPageIndexChanged="dgMembers_PageIndexChanged"
                                    OnEditCommand="dgMembers_EditCommand"
                                    OnCancelCommand="dgMembers_CancelCommand"
                                    OnUpdateCommand="dgMembers_UpdateCommand"
                                    OnDeleteCommand="dgMembers_DeleteCommand"
                                    CssClass="products-table"
                                    BorderWidth="0px"
                                    GridLines="None"
                                    CellPadding="0"
                                    CellSpacing="0"
                                    BorderStyle="None">

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
                    Text='<i class="fad fa-trash"></i>' CssClass="cancel-btn"
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
                                    <PagerStyle CssClass="pager-style" HorizontalAlign="Center" />
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
                                    <label>Chọn ảnh sản phẩm</label>
                                    <asp:FileUpload ID="fuImage" runat="server" CssClass="form-control" />
                                    <div style="margin-top: 10px;">
                                        <asp:Image ID="imgMemberAvatar" runat="server" Width="100" Height="100" />
                                    </div>
                                </div>

                                <div class="form-actions">
                                    <asp:Button ID="btnCancelMember" runat="server" Text="Thoát" CssClass="cancel-btn" OnClientClick="closeModal(); return false;" />
                                    <asp:Button ID="btnSaveMember" runat="server" Text="Lưu" CssClass="save-btn" OnClick="btnSaveMember_Click" UseSubmitBehavior="true" />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                </div>

            </main>
        </div>

        <script>
            function showModal() {
                document.getElementById('<%= pnlMemberModal.ClientID %>').style.display = 'flex';
            }

            function closeModal() {
                document.getElementById('<%= pnlMemberModal.ClientID %>').style.display = 'none';
            }
        </script>

        <script>
            // Lấy file hiện tại
            const currentPage = window.location.pathname.split("/").pop().toLowerCase();

            document.querySelectorAll('.sidebar .nav-item').forEach(link => {
                const hrefPage = link.getAttribute('href');
                if (hrefPage && hrefPage.toLowerCase() === currentPage) {
                    link.classList.add('active');
                }
            });

            // Tạo map ánh xạ từ file -> tiêu đề breadcrumb
            const breadcrumbMap = {
                'qlproductcate.aspx': 'Quản lý danh mục sản phẩm',
                'qldashboard.aspx': 'Dữ liệu',
                'qlproduct.aspx': 'Quản lý sản phẩm',
                'qlorder.aspx': 'Thông tin đơn hàng',
                'qlcontact.aspx': 'Phản hồi từ khách hàng',
                'qlteam.aspx': 'Quản lý thành viên',
                // Thêm các trang khác nếu cần
            };

            // Hiển thị tiêu đề tương ứng hoặc fallback mặc định
            const breadcrumbTitle = breadcrumbMap[currentPage] || 'Trang không xác định';
            document.getElementById('breadcrumbTitle').textContent = breadcrumbTitle;
        </script>

    </form>
</body>
</html>
