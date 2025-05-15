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
                        <th>Mã đơn</th>
                        <th>Tên KH</th>
                        <th>SDT</th>
                        <th>Email</th>
                        <th>Đ.Chỉ</th>
                        <th>S.Lượng</th>
                        <th>Tổng</th>
                        <th>T.Gian</th>
                        <th>Tr.Thái</th>
                        <th>Tùy chọn</th>

                    </tr>
                </thead>
                <tbody>

                    <%for (int i = 0; i < listOD.Count; i++)
                        {  %>
                    <tr>
                        <th><%=listOD[i].Code %></th>
                        <th><%=listOD[i].CustomerName %></th>
                        <th><%=listOD[i].Phone %></th>
                        <th><%=listOD[i].Email %></th>
                        <th><%=listOD[i].Address %></th>
                        <th><%=listOD[i].Quantity %></th>
                        <th><%= string.Format("{0:N0}", listOD[i].TotalAmount).Replace(",", ".") %></th>

                        <th><%=listOD[i].CreatedDate.ToString("dd/MM/yy") %></th>
                        <td>
                            <span style="cursor: pointer" class='status-badge <%= (listOD[i].Status == 0) ? "processing" : "completed" %>'
                                onclick='toggleStatus(<%= listOD[i].id %>, this)'>
                                <%= (listOD[i].Status == 0) ? "Đang chờ" : "Đã xác nhận" %>
                            </span>
                        </td>


                        <td class="action-cell">
                            <div class="action-menu">
                                <button type="button" class="action-btn">
                                    <i class="fad fa-edit"></i>
                                </button>
                                <button type="button" class="action-btn">
                                    <i class="fal fa-trash"></i>
                                </button>
                            </div>
                        </td>
                    </tr>

                    <% } %>
                </tbody>
            </table>
        </div>

        <div class="pagination">
            <button class="pagination-arrow prev">
                <i class="fal fa-chevron-left"></i>
            </button>
            <div class="pagination-numbers">
                <button class="pagination-number active">1</button>
                <button class="pagination-number">2</button>
                <span class="pagination-ellipsis">...</span>
                <button class="pagination-number">23</button>
                <button class="pagination-number">24</button>
            </div>
            <button class="pagination-arrow next">
                <i class="fal fa-chevron-right"></i>
            </button>
        </div>
    </div>

    <script>
        function toggleStatus(orderId, span) {
            PageMethods.ToggleOrderStatus(orderId, function (result) {
                if (result) {
                    if (span.classList.contains("processing")) {
                        span.classList.remove("processing");
                        span.classList.add("completed");
                        span.innerText = "Đã X.Nhận";
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
