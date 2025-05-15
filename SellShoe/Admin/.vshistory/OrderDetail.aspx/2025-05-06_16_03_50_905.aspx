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
                        <th><%=listOD[i].TotalAmount %></th>
                        <th><%=listOD[i].CreatedDate.ToString("dd/MM/yy") %></th>
                        <td>
                            <span class='status-badge <%= (listOD[i].Status == 0) ? "processing" : "completed" %>'
                                onclick='toggleStatus(<%= listOD[i].id %>, this)'>
                                <%= (listOD[i].Status == 0) ? "Đang xử lý" : "Hoàn thành" %>
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
        function toggleStatus(orderId, element) {
            fetch('OrderDetail.aspx/ToggleOrderStatus', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ id: orderId })
            })
                .then(response => response.json())
                .then(data => {
                    if (data.d === true) {
                        // Cập nhật giao diện
                        if (element.classList.contains('processing')) {
                            element.classList.remove('processing');
                            element.classList.add('completed');
                            element.innerText = 'Hoàn thành';
                        } else {
                            element.classList.remove('completed');
                            element.classList.add('processing');
                            element.innerText = 'Đang xử lý';
                        }
                    } else {
                        alert('Cập nhật trạng thái thất bại');
                    }
                })
                .catch(error => {
                    console.error(error);
                    alert('Có lỗi xảy ra');
                });
        }
    </script>




</asp:Content>
