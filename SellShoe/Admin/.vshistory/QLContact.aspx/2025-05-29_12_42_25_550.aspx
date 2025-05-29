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
                            <a href="QLDashboard.aspx" class="nav-item">
                                <i class="fad fa-th-large"></i>
                                <span>Dữ liệu</span>
                            </a>
                        </li>
                        <li>
                            <a href="QLProductCate.aspx" class="nav-item">
                                <i class="fad fa-list-ul"></i>
                                <span>Danh mục</span>
                            </a>
                        </li>
                        <li>
                            <a href="QLProduct.aspx" class="nav-item">
                                <i class="fad fa-shopping-bag"></i>
                                <span>Sản phẩm</span>
                            </a>
                        </li>
                        <li>
                            <a href="QLOrder.aspx" class="nav-item">
                                <i class="fad fa-shopping-cart"></i>
                                <span>Đơn hàng</span>
                            </a>
                        </li>
                        <li>
                            <a href="QLContact.aspx" class="nav-item">
                                <i class="fad fa-star-half-alt"></i>
                                <span>Phản hồi</span>
                            </a>
                        </li>
                        <li>
                            <a href="QLTeam.aspx" class="nav-item">
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
                                        <asp:LinkButton ID="btnDelete" runat="server"
                                            CommandName="Delete"
                                            CommandArgument='<%# Eval("Id") %>'
                                            CssClass="cancel-btn delete-feedback"
                                            ClientIDMode="Static">
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

        <script type="text/javascript">
            document.addEventListener('DOMContentLoaded', function () {
                document.querySelectorAll('.delete-feedback').forEach(function (btn) {
                    btn.addEventListener('click', function (e) {
                        e.preventDefault(); // Ngăn submit mặc định

                        const realBtn = this;

                        Swal.fire({
                            title: 'Bạn có chắc chắn muốn xóa phản hồi này?',
                            text: 'Hành động này không thể hoàn tác!',
                            icon: 'warning',
                            showCancelButton: true,
                            confirmButtonColor: '#3085d6',
                            cancelButtonColor: '#d33',
                            confirmButtonText: 'Xóa',
                            cancelButtonText: 'Hủy'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                __doPostBack(realBtn.name, '');
                            }
                        });
                    });
                });
            });
        </script>





    </form>
</body>
</html>
