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
        document.addEventListener('DOMContentLoaded', function () {
            // Gán sự kiện cho tất cả nút trong action-menu
            document.querySelectorAll('.action-menu .action-btn').forEach(function (btn) {
                btn.addEventListener('click', function (e) {
                    e.preventDefault();

                    const actionMenu = this.closest('.action-menu');
                    const categoryId = actionMenu.getAttribute('data-id');
                    const row = this.closest('tr');

                    const title = row.children[1].innerText.trim();
                    const description = row.children[2].innerText.trim();
                    const alias = row.children[3].innerText.trim();

                    // Check loại icon
                    if (this.querySelector('.fa-edit')) {
                        // Nếu click nút Edit
                        document.getElementById('modalTitle').innerText = 'Chỉnh sửa danh mục';
                        document.getElementById('categoryId').value = categoryId;
                        document.getElementById('txtTitle').value = title;
                        document.getElementById('txtDescription').value = description;
                        document.getElementById('txtAlias').value = alias;

                        // Hiện nút Save và Delete
                        document.getElementById('saveProductBtn').style.display = 'inline-block';
                        document.getElementById('deleteProductBtn').style.display = 'inline-block';

                        openModal();
                    } else if (this.querySelector('.fa-trash')) {
                        // Nếu click nút Delete
                        if (confirm('Bạn có chắc chắn muốn xóa danh mục này không?')) {
                            // Gọi hàm xóa ở đây, ví dụ:
                            deleteCategory(categoryId);
                        }
                    }
                });
            });

            // Mở modal
            function openModal() {
                document.getElementById('categoryModal').style.display = 'flex';
            }

            // Đóng modal
            document.getElementById('closeModal').addEventListener('click', function () {
                document.getElementById('categoryModal').style.display = 'none';
            });
            document.getElementById('cancelBtn').addEventListener('click', function () {
                document.getElementById('categoryModal').style.display = 'none';
            });

            // Hàm giả lập xóa danh mục
            function deleteCategory(id) {
                console.log('Xóa danh mục ID:', id);
                // TODO: Gọi Ajax hoặc Submit form để xóa
            }

            // Gán sự kiện cho nút thêm mới
            document.getElementById('addProductBtn').addEventListener('click', function () {
                document.getElementById('modalTitle').innerText = 'Thêm danh mục sản phẩm';
                document.getElementById('categoryId').value = '';
                document.getElementById('txtTitle').value = '';
                document.getElementById('txtDescription').value = '';
                document.getElementById('txtAlias').value = '';

                // Ẩn nút Delete khi thêm mới
                document.getElementById('deleteProductBtn').style.display = 'none';
                document.getElementById('saveProductBtn').style.display = 'inline-block';

                openModal();
            });
        });
    </script>





</asp:Content>
