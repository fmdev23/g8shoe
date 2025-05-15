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

            <asp:Repeater ID="rptFeedback" runat="server">
                <HeaderTemplate>
                    <div class="table-container">
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
                            <%# Eval("Subject").ToString().Contains("khuyến mãi") 
                    ? "<span style='color: #ffe426; font-weight: bold;'>" + Eval("Subject") + "</span>" 
                    : Eval("Subject").ToString() %>
                        </td>
                        <td><%# Eval("Content") %></td>
                        <td><%# Convert.ToDateTime(Eval("CreatedAt")).ToString("dd/MM/yyyy - HH:mm") %></td>
                        <td class="action-cell">
                            <div class="action-menu">
                                <asp:LinkButton
                                    ID="btnDelete"
                                    runat="server"
                                    CssClass="action-btn btn-delete"
                                    CommandArgument='<%# Eval("Id") %>'
                                    OnClientClick="return confirmDelete(this);"
                                    OnCommand="btnDelete_Command">
                        <i class="fal fa-trash"></i>
                                </asp:LinkButton>
                            </div>
                        </td>
                    </tr>
                </ItemTemplate>

                <FooterTemplate>
                    </tbody>
            </table>
        </div>
                </FooterTemplate>
            </asp:Repeater>


        </div>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const deleteButtons = document.querySelectorAll(".btn-delete");

                deleteButtons.forEach(function (button) {
                    button.addEventListener("click", function () {
                        const id = this.getAttribute("data-id");
                        const row = this.closest("tr");

                        Swal.fire({
                            title: 'Bạn có chắc chắn muốn xóa?',
                            text: "Hành động này không thể hoàn tác!. Phải chắc chắn bạn đã đọc hết rồi nha!",
                            icon: 'warning',
                            showCancelButton: true,
                            confirmButtonColor: '#3085d6',
                            cancelButtonColor: '#d33',
                            confirmButtonText: 'Xóa',
                            cancelButtonText: 'Hủy'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                // Gửi yêu cầu xóa
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
                                            Swal.fire(
                                                'Đã xóa!',
                                                'Phản hồi đã được xóa thành công.',
                                                'success'
                                            );
                                            if (row) {
                                                row.remove(); // Xóa dòng trên bảng
                                            }
                                        } else {
                                            Swal.fire(
                                                'Thất bại!',
                                                'Không thể xóa phản hồi. Vui lòng thử lại.',
                                                'error'
                                            );
                                        }
                                    })
                                    .catch(error => {
                                        console.error('Error:', error);
                                        Swal.fire(
                                            'Lỗi!',
                                            'Không thể kết nối server.',
                                            'error'
                                        );
                                    });
                            }
                        });
                    });
                });
            });
        </script>
</asp:Content>
