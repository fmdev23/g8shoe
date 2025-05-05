<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ProductCategory.aspx.cs" Inherits="SellShoe.Admin.ProductCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Content Card -->
    <div class="content-card">
        <div class="card-header">
            <h2>QUẢN LÝ DANH MỤC SẢN PHẨM</h2>
            <div class="header-actions">
                <div class="search-container">
                    <i class="fal fa-search"></i>
                    <input type="text" placeholder="Search products">
                </div>
                <button class="add-product-btn" id="addProductBtn">Thêm danh mục</button>
            </div>
        </div>

        <div class="table-container">
            <asp:Repeater ID="rptCategory" runat="server">
                <HeaderTemplate>
                    <table class="products-table">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Tên danh mục</th>
                                <th>Mô tả</th>
                                <th>Alias</th>
                                <th>Tùy chọn</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("id") %></td>
                        <td><%# Eval("Title") %></td>
                        <td><%# Eval("Description") %></td>
                        <td><%# Eval("Alias") %></td>
                        <td class="action-cell">
                            <div class="action-menu" data-id='<%# Eval("id") %>'>
                                <button class="action-btn">
                                    <i class="fad fa-edit"></i>
                                </button>
                                <button class="action-btn">
                                    <i class="fal fa-trash"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody>
        </table>
                </FooterTemplate>
            </asp:Repeater>

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

        <!-- Add/Edit Product Modal -->
        <div class="modal" id="categoryModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 id="modalTitle">Thêm danh mục sản phẩm</h3>
                    <button class="close-modal" id="closeModal">
                        <i class="fad fa-times"></i>
                    </button>
                </div>
                <div class="modal-body">

                    <form id="productForm">
                        <input type="hidden" id="categoryId" />

                        <div class="form-group">
                            <label>Tên danh mục</label>
                            <input type="text" id="txtTitle" />
                        </div>
                        <div class="form-group">
                            <label>Mô tả</label>
                            <input type="text" id="txtDescription" />
                        </div>
                        <div class="form-group">
                            <label>Alias</label>
                            <input type="text" id="txtAlias" />
                        </div>

                        <div class="form-actions">
                            <button type="button" class="cancel-btn" id="cancelBtn">Thoát</button>
                            <button type="button" class="save-btn" id="saveProductBtn">Lưu</button>
                            <button type="button" class="delete-btn" id="deleteProductBtn">Xóa</button>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>


    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const modal = document.getElementById("categoryModal");

            document.getElementById("addProductBtn").addEventListener("click", function () {
                resetForm();
                document.getElementById("modalTitle").innerText = "Thêm danh mục sản phẩm";
                modal.style.display = "flex";  // Đảm bảo modal hiển thị
            });

            document.querySelectorAll(".action-menu .fa-edit").forEach(function (btn) {
                btn.addEventListener("click", function () {
                    const id = this.closest(".action-menu").getAttribute("data-id");
                    const row = this.closest("tr");

                    document.getElementById("categoryId").value = id;
                    document.getElementById("txtTitle").value = row.cells[1].innerText;
                    document.getElementById("txtDescription").value = row.cells[2].innerText;
                    document.getElementById("txtAlias").value = row.cells[3].innerText;

                    document.getElementById("modalTitle").innerText = "Sửa danh mục sản phẩm";
                    modal.style.display = "flex";  // Hiển thị modal
                });
            });

            document.getElementById("closeModal").addEventListener("click", function () {
                modal.style.display = "none";
            });

            document.getElementById("cancelBtn").addEventListener("click", function () {
                modal.style.display = "none";
            });

            function resetForm() {
                document.getElementById("categoryId").value = "";
                document.getElementById("txtTitle").value = "";
                document.getElementById("txtDescription").value = "";
                document.getElementById("txtAlias").value = "";
            }
        });

    </script>



</asp:Content>
