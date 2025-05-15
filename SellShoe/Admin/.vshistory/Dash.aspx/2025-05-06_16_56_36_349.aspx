<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Dash.aspx.cs" Inherits="SellShoe.Admin.Dash" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
    <link rel="stylesheet" href="../Admin/dash.css" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Dashboard Page -->
    <div id="dashboard-page" class="page active">
        <div class="dashboard-grid">
            <!-- Total Sales Card -->
            <div class="dashboard-card">
                <div class="card-header">
                    <div>
                        <h3>Tổng doanh thu</h3>
                        <p class="subtitle">trong tháng</p>
                    </div>
                    <div class="card-value">
                        <%= string.Format("{0:N0}", TotalRevenue).Replace(",", ".") %> VNĐ
                    </div>

                </div>
                <div class="chart-container">
                    <canvas id="salesChart"></canvas>
                </div>
            </div>

            <!-- Customers Card -->
            <div class="dashboard-card">
                <div class="card-header">
                    <div>
                        <h3>Khách hàng</h3>
                        <p class="subtitle">trong tháng</p>
                    </div>
                    <div class="card-value"><%= CustomersThisMonth %> KH</div>


                </div>
                <div class="chart-container">
                    <canvas id="customersChart"></canvas>
                </div>
            </div>

            <!-- Orders Card -->
            <div class="dashboard-card">
                <div class="card-header">
                    <div>
                        <h3>Đơn hàng</h3>
                        <p class="subtitle">trong tháng</p>
                    </div>
                    <div class="card-value">
                        <%= TotalOrder %>
                    </div>
                </div>
                <div class="progress-container">
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: 73.4%;"></div>
                    </div>
                </div>
            </div>

            <!-- Best Selling Card -->
            <div class="dashboard-card">
                <div class="card-header">
                    <div>
                        <h3>BEST SELLER</h3>
                        <p class="subtitle">trong tháng</p>
                    </div>
                </div>
                <div class="best-selling-content">
                    <div class="best-selling-header">
                        <div class="best-selling-total">456.867.595</div>
                        <div class="best-selling-label">— Tổng doanh số</div>
                    </div>
                    <div class="best-selling-items">
                        <div class="best-selling-item">
                            <div class="item-name">Air Jordan 1 Low Premium —</div>
                            <div class="item-sales">940 Lượt bán</div>
                        </div>
                        <div class="best-selling-item">
                            <div class="item-name">Monochromatic Wardrobe —</div>
                            <div class="item-sales">790 Lượt bán</div>
                        </div>
                        <div class="best-selling-item">
                            <div class="item-name">Essential Neutrals —</div>
                            <div class="item-sales">740 Lượt bán</div>
                        </div>
                    </div>
                    <div class="chart-container donut-chart-container">
                        <canvas id="bestSellingChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Recent Orders Card -->
            <div class="dashboard-card recent-orders-card">
                <div class="card-header">
                    <div>
                        <h3>Đơn hàng mới nhất</h3>
                    </div>
                    <button class="view-all-btn">View All</button>
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

</asp:Content>
