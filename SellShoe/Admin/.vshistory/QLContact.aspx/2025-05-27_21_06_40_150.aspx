<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QLContact.aspx.cs" Inherits="SellShoe.Admin.QLContact" %>

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
                            <a href="Dash.aspx" class="nav-item">
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
                        <h2>PHẢN HỒI / GÓP Ý / ĐÁNH GIÁ</h2>
                        <div class="header-actions">
                        </div>
                    </div>

                    <div class="table-container">

                        <asp:Repeater ID="rptFeedback" runat="server" OnItemCommand="rptFeedback_ItemCommand">
                            <HeaderTemplate>
                                <table class="products-table">
                                    <thead>
                                        <tr>
                                            <th>Tên khách hàng</th>
                                            <th>Email</th>
                                            <th>Chủ đề</th>
                                            <th>Nội dung</th>
                                            <th>Thời gian</th>
                                            <th>Tùy chọn</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("FullName") %></td>
                                    <td><%# Eval("Email") %></td>
                                    <td>
                                        <%# Eval("Subject").ToString().ToLower().Contains("khuyến mãi") 
                ? $"<span style='color: #ffe426; font-weight: bold;'>{Eval("Subject")}</span>" 
                : Eval("Subject") %>
                                    </td>
                                    <td><%# Eval("Content") %></td>
                                    <td><%# ((DateTime)Eval("CreatedAt")).ToString("dd/MM/yyyy-HH:mm") %></td>
                                    <td>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="cancel-btn"
                                            CommandArgument='<%# Eval("Id") %>'
                                            OnClientClick='<%# "return deleteFeedback(\"" + Eval("Id") + "\");" %>'>
                            <i class="fad fa-trash"></i>
                                        </asp:LinkButton>

                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
    </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </div>
                </div>

            </main>

        </div>




    </form>
</body>
</html>
