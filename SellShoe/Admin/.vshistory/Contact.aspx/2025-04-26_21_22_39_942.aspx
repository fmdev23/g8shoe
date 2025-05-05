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
                                <button class="action-btn">
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

        <script>
    document.addEventListener("DOMContentLoaded", function () {

        // Xóa danh mục
        document.querySelectorAll(".action-menu .fa-trash").forEach(function (btn) {
            btn.addEventListener("click", function () {
                const id = this.closest(".action-menu").getAttribute("data-id");
                if (confirm("Bạn có chắc chắn muốn xóa danh mục này không?")) {
                    fetch("ProductCategory.aspx/DeleteCategory", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json"
                        },
                        body: JSON.stringify({ id: parseInt(id) })
                    })
                        .then(res => res.json())
                        .then(data => {
                            if (data.d === "success") {
                                alert("Xóa thành công!");
                                location.reload();
                            } else {
                                alert("Không tìm thấy danh mục cần xóa!");
                            }
                        })
                        .catch(err => console.error(err));
                }
            });
        });
    });
        </script>

</asp:Content>
