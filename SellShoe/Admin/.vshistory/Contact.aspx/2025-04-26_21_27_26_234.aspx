<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="SellShoe.Admin.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Content Card -->
    <div class="content-card">
        <div class="card-header">
            <h2>PHẢN HỒI / GÓP Ý / ĐÁNH GIÁ</h2>
            <div class="header-actions">
            </div>
        </div>

        <div class="table-container">

            <table class="products-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Tên khách hàng</th>
                        <th>Email</th>
                        <th>Chủ đề</th>
                        <th>Nội dung</th>
                        <th>Thời gian</th>
                        <th>Tùy chọn</th>
                    </tr>
                </thead>
                <tbody id="productsTableBody">

                    <%for (int i = 0; i < listFeedback.Count; i++)
                        {  %>
                    <tr>
                        <th><%=listFeedback[i].Id %></th>
                        <th><%=listFeedback[i].FullName %></th>
                        <th><%=listFeedback[i].Email %></th>
                        <th><%=listFeedback[i].Subject %></th>
                        <th><%=listFeedback[i].Content %></th>
                        <th><%=listFeedback[i].CreatedAt %></th>
                        <th class="action-cell">
                            <div class="action-menu" data-id="1">
                                <button class="action-btn">
                                    <i class="fad fa-edit"></i>
                                </button>
                                <button class="action-btn btn-delete" data-id="<%=listFeedback[i].Id %>">
                                    <i class="fal fa-trash"></i>
                                </button>
                            </div>
                        </th>
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



        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const deleteButtons = document.querySelectorAll(".btn-delete");

                deleteButtons.forEach(function (button) {
                    button.addEventListener("click", function () {
                        const id = this.getAttribute("data-id");

                        Swal.fire({
                            title: 'Bạn chắc chắn muốn xóa?',
                            text: "Phản hồi sẽ bị xóa vĩnh viễn!",
                            icon: 'warning',
                            showCancelButton: true,
                            confirmButtonColor: '#d33',
                            cancelButtonColor: '#3085d6',
                            confirmButtonText: 'Xóa',
                            cancelButtonText: 'Hủy'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                fetch('Contact.aspx/DeleteFeedback', {
                                    method: 'POST',
                                    headers: {
                                        'Content-Type': 'application/json'
                                    },
                                    body: JSON.stringify({ id: parseInt(id) })
                                })
                                    .then(response => response.json())
                                    .then(data => {
                                        if (data.d === true) {
                                            Swal.fire('Đã xóa!', 'Phản hồi đã được xóa.', 'success')
                                                .then(() => {
                                                    location.reload();
                                                });
                                        } else {
                                            Swal.fire('Lỗi!', 'Không thể xóa phản hồi.', 'error');
                                        }
                                    })
                                    .catch(error => {
                                        console.error('Error:', error);
                                        Swal.fire('Lỗi!', 'Không thể kết nối server.', 'error');
                                    });
                            }
                        });
                    });
                });
            });
        </script>
</asp:Content>
