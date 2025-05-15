<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="OrderDetail.aspx.cs" Inherits="SellShoe.Admin.OrderDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Content Card -->
    <div class="content-card">
        <div class="card-header">
            <h2>QUẢN LÝ ĐƠN HÀNG</h2>
            <div class="header-actions">
                <div class="search-container">
                    <i class="fal fa-search"></i>
                    <input type="text" placeholder="Tìm đơn hàng">
                </div>
            </div>
        </div>

        <div class="table-container">
            <table class="products-table">
                <thead>
                    <tr>
                        <th>Mã đơn</th>
                        <th>Tên KH</th>
                        <th>SDT</th>
                        <th>Email</th>
                        <th>Đ.Chỉ</th>
                        <th>S.Lượng</th>
                        <th>Giá tiền</th>
                        <th>Thời gian</th>
                        <th>Trạng thái</th>
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
                    </tr>

                    <% } %>
                </tbody>
            </table>


            <table class="products-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Số lượng</th>
                        <th>Giá tiền</th>
                        <th>Thời gian</th>
                        <th>Trạng thái</th>
                        <th>Tùy chọn</th>
                    </tr>
                </thead>
                <tbody>

                    <%for (int i = 0; i < listOD.Count; i++)
                        {  %>
                    <tr>
                        <th><%=listOD[i].id %></th>
                        <th><%=listOD[i].Quantity %></th>
                        <th><%=listOD[i].TotalAmount %></th>
                        <th><%=listOD[i].CreatedDate %></th>
                        <th><%=listOD[i].Status %></th>

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
        function formatCurrencyDot(number) {
            return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
        }

        document.addEventListener("DOMContentLoaded", function () {
            const priceCells = document.querySelectorAll("tbody tr th:nth-child(5)");

            priceCells.forEach(cell => {
                const originalText = cell.innerText.trim();
                if (!isNaN(originalText) && originalText !== "") {
                    cell.innerText = formatCurrencyDot(originalText);
                }
            });
        });
    </script>

</asp:Content>
