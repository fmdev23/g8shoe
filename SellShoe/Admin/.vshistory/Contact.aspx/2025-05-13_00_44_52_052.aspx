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
                        <td><%# ((DateTime)Eval("CreatedAt")).ToString("dd/MM/yyyy - HH:mm") %></td>
                        <td>
                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="cancel-btn"
                                CommandArgument='<%# Eval("Id") %>'
                                OnClientClick="return deleteFeedback('<%# Eval("id") %>');">
                    <i class="fal fa-trash"></i>
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

            <!-- SweetAlert2 JS -->
            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

            <script type="text/javascript">
                function deleteFeedback(id) {
                    Swal.fire({
                        title: 'Bạn có chắc chắn muốn xóa phản hồi này?',
                        text: 'Hành động này không thể hoàn tác! Hãy chắc chắn bạn đã đọc kỹ trước khi xóa.',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Xóa',
                        cancelButtonText: 'Hủy'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            // Chuyển hướng đến server để xóa phản hồi
                            window.location.href = 'Contact.aspx?deleteId=' + id;
                        }
                    });
                    return false; // Ngừng hành động mặc định của LinkButton
                }
            </script>

        
</asp:Content>
