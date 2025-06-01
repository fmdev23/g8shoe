<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QLDashboard.aspx.cs" Inherits="SellShoe.Admin.QLDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ADMIN</title>
    <link rel="stylesheet" href="~/Admin/dash.css" />
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" />

    <!-- SweetAlert2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet" />

    <!-- SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    <form id="form1" runat="server">

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


                <!-- Dashboard Page -->
                <div id="dashboard-page" class="page active">
                    <div class="dashboard-grid">
                        <!-- Total Sales Card -->
                        <div class="dashboard-card">
                            <div class="card-header">
                                <div>
                                    <h3>Doanh Thu</h3>
                                    <p class="subtitle">tổng số</p>
                                </div>
                                <div class="card-value">
                                    <%= string.Format("{0:N0}", TotalRevenue).Replace(",", ".") %> VNĐ
                                </div>
                            </div>
                        </div>

                        <!-- Customers Card -->
                        <div class="dashboard-card">
                            <div class="card-header">
                                <div>
                                    <h3>Khách hàng</h3>
                                    <p class="subtitle">tổng số</p>
                                </div>
                                <div class="card-value"><%= CustomersThisMonth %> KH</div>
                            </div>
                        </div>

                        <!-- Orders Card -->
                        <div class="dashboard-card">
                            <div class="card-header">
                                <div>
                                    <h3>Đơn hàng</h3>
                                    <p class="subtitle">tổng số</p>
                                </div>
                                <div class="card-value">
                                    <%= TotalOrder %>
                                </div>
                            </div>
                            <div class="progress-container">
                            </div>
                        </div>

                        <!-- Best Selling Card -->
                        <div class="dashboard-card">
                            <div class="card-header">
                                <div>
                                    <h3>BEST SELLER</h3>
                                    <p class="subtitle">doanh số TOP 5 BEST SELLER</p>
                                </div>
                            </div>
                            <div class="best-selling-content">
                                <div class="best-selling-header">
                                    <div class="best-selling-total"><%= string.Format("{0:N0}", Top5Revenue).Replace(",", ".") %> VNĐ</div>
                                    <div class="best-selling-label">— Tổng doanh số</div>
                                </div>
                                <% foreach (var item in TopSellingProducts)
                                    { %>
                                <div class="best-selling-item">
                                    <div class="item-name"><%= item.ProductName %> —</div>
                                    <div class="item-sales"><%= item.TotalSold %> Lượt bán</div>
                                </div>
                                <% } %>
                            </div>
                        </div>

                        <!-- Recent Orders Card -->
                        <div class="dashboard-card recent-orders-card">
                            <div class="card-header">
                                <div>
                                    <h3>Đơn hàng mới nhất</h3>
                                </div>
                                <a href="QLOrder.aspx" class="view-all-btn">Xem tất cả</a>
                            </div>
                            <div class="recent-orders-table-container">
                                <table class="recent-orders-table">
                                    <thead>
                                        <tr>
                                            <th>Mã đơn</th>
                                            <th>Thời gian</th>
                                            <th>Giá tiền</th>
                                            <th>Trạng thái</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% foreach (var order in listOD)
                                            { %>
                                        <tr>
                                            <td><%= order.Code %></td>
                                            <td><%= order.CreatedDate?.ToString("HH:mm:ss") %></td>
                                            <td><%= string.Format("{0:N0}", order.TotalAmount).Replace(",", ".") %></td>

                                            <td>
                                                <% if (order.Status == "Đã xác nhận")
                                                    { %>
                                                <span class="status-badge completed">Đã xác nhận</span>
                                                <% }
                                                    else if (order.Status == "Đang chờ")
                                                    { %>
                                                <span class="status-badge processing">Đang chờ</span>
                                                <% }
                                                    else
                                                    { %>
                                                <span class="status-badge cancelled"><%= order.Status %></span>
                                                <% } %>
                                            </td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>


                        </div>
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

    </form>
</body>
</html>
