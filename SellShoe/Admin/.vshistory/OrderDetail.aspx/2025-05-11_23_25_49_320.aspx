<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="OrderDetail.aspx.cs" Inherits="SellShoe.Admin.OrderDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />

    <!-- Content Card -->
    <div class="content-card">
        <div class="card-header">
            <h2>QUẢN LÝ ĐƠN HÀNG</h2>
            <div class="header-actions">
                <div class="search-container">
                    <i class="fal fa-search"></i>
                    <input type="text" id="searchOrderInput" placeholder="Tìm đơn hàng">
                </div>
            </div>
        </div>

        <div class="table-container">
            <table class="products-table" id="ordersTable">
                <thead>
                    <tr>
                        <th>H.Ảnh</th>
                        <th>Mã đơn</th>
                        <th>Tên KH</th>
                        <th>SDT</th>
                        <th>Email</th>
                        <th>Đ.Chỉ</th>
                        <th>S.Lượng</th>
                        <th>Tổng</th>
                        <th>T.Gian</th>
                        <th>Tr.Thái</th>
                        <!--<th>Tùy chọn</th>-->

                    </tr>
                </thead>
                <tbody>

                    <%for (int i = 0; i < listDisplay.Count; i++)
                        {  %>
                    <tr>
                        <th>
                            <img src="<%= listDisplay[i].ProductImage %>" style="width: 60px; height: 60px; object-fit: cover;" />
                        </th>
                        <th><%= listDisplay[i].Order.Code %></th>
                        <th><%= listDisplay[i].Order.CustomerName %></th>
                        <th><%= listDisplay[i].Order.Phone %></th>
                        <th><%= listDisplay[i].Order.Email %></th>
                        <th><%= listDisplay[i].Order.Address %></th>
                        <th><%= listDisplay[i].Order.Quantity %></th>
                        <th><%= string.Format("{0:N0}", listDisplay[i].Order.TotalAmount).Replace(",", ".") %></th>
                        <th><%= listDisplay[i].Order.CreatedDate.ToString("dd/MM/yy") %></th>
                        <td>
                            <span class='status-badge <%= (listDisplay[i].Order.Status == 0) ? "processing" : "completed" %>'
                                onclick='toggleStatus(<%= listDisplay[i].Order.id %>, this)' style="cursor: pointer">
                                <%= (listDisplay[i].Order.Status == 0) ? "Đang chờ" : "Đã xác nhận" %>
                            </span>
                        </td>
                        <!--<td class="action-cell">
            <div class="action-menu">
                <button type="button" class="action-btn">
                    <i class="fad fa-edit"></i>
                </button>
                <button type="button" class="action-btn">
                    <i class="fal fa-trash"></i>
                </button>
            </div>
        </td>-->
                    </tr>

                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function toggleStatus(orderId, span) {
            PageMethods.ToggleOrderStatus(orderId, function (result) {
                if (result) {
                    if (span.classList.contains("processing")) {
                        span.classList.remove("processing");
                        span.classList.add("completed");
                        span.innerText = "Đã xác nhận";
                    } else {
                        span.classList.remove("completed");
                        span.classList.add("processing");
                        span.innerText = "Đang chờ";
                    }
                } else {
                    alert("Không thể cập nhật trạng thái.");
                }
            });
        }
    </script>

    <!-- xử lý tìm kiếm đơn hàng theo mã, tên, SDT, Email, Đ.Chỉ, S.Lượng, Tổng, T.Gian -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const searchInput = document.getElementById("searchOrderInput");
            const table = document.getElementById("ordersTable");
            const rows = table.getElementsByTagName("tbody")[0].getElementsByTagName("tr");

            searchInput.addEventListener("input", function () {
                const keyword = this.value.toLowerCase();

                for (let row of rows) {
                    const cells = row.getElementsByTagName("th");
                    let match = false;

                    for (let cell of cells) {
                        if (cell.textContent.toLowerCase().includes(keyword)) {
                            match = true;
                            break;
                        }
                    }

                    row.style.display = match ? "" : "none";
                }
            });
        });
    </script>






</asp:Content>
