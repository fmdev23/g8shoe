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
            <asp:Repeater ID="rptOrders" runat="server" OnItemCommand="rptOrders_ItemCommand">
                <HeaderTemplate>
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
                                <th>Xoá</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>

                <ItemTemplate>
                    <tr>
                        <th>
                            <img src='<%# Eval("ProductImage") %>' style="width: 60px; height: 60px; object-fit: cover;" />
                        </th>
                        <th><%# Eval("Order.Code") %></th>
                        <th><%# Eval("Order.CustomerName") %></th>
                        <th><%# Eval("Order.Phone") %></th>
                        <th><%# Eval("Order.Email") %></th>
                        <th><%# Eval("Order.Address") %></th>
                        <th><%# Eval("Order.Quantity") %></th>
                        <th><%# string.Format("{0:N0}", Eval("Order.TotalAmount")).Replace(",", ".") %></th>
                        <th><%# Eval("Order.CreatedDate", "{0:dd/MM/yy}") %></th>
                        <td>
                            <span class='status-badge <%# (Convert.ToInt32(Eval("Order.Status")) == 0) ? "processing" : "completed" %>'
                                onclick='toggleStatus(<%# Eval("Order.id") %>, this)' style="cursor: pointer">
                                <%# (Convert.ToInt32(Eval("Order.Status")) == 0) ? "Đang chờ" : "Đã xác nhận" %>
                            </span>
                        </td>
                        <td>
                            <asp:LinkButton runat="server"
                                CssClass="cancel-btn"
                                CommandName="DeleteOrder"
                                CommandArgument='<%# Eval("Order.id") %>'
                                OnClientClick='<%# "return deleteOrder(" + Eval("Order.id") + ");" %>'><i class="fad fa-trash"></i>
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

    <script>
        function deleteOrder(id) {
            Swal.fire({
                title: 'Bạn có chắc chắn muốn xóa đơn hàng này?',
                text: 'Hành động này không thể hoàn tác! Hãy chắc đây là đơn lỗi! Ảnh hưởng trực tiếp đến doanh thu.',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Xóa',
                cancelButtonText: 'Hủy'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = 'OrderDetail.aspx?deleteId=' + id;
                }
            });
            return false;
        }

    </script>

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
