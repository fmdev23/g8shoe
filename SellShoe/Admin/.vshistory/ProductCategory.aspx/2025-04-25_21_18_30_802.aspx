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
            const modal = document.getElementById('categoryModal');
            const modalTitle = document.getElementById('modalTitle');
            const categoryIdField = document.getElementById('categoryId');
            const titleField = document.getElementById('txtTitle');
            const descriptionField = document.getElementById('txtDescription');
            const aliasField = document.getElementById('txtAlias');

            const addProductBtn = document.getElementById('addProductBtn');
            const closeModalBtn = document.getElementById('closeModal');
            const cancelBtn = document.getElementById('cancelBtn');
            const saveProductBtn = document.getElementById('saveProductBtn');
            const deleteProductBtn = document.getElementById('deleteProductBtn');

            // 👉 Hàm mở modal
            function openModal() {
                modal.style.display = 'flex';
            }

            // 👉 Hàm đóng modal
            function closeModal() {
                modal.style.display = 'none';
                clearForm();
            }

            // 👉 Hàm clear form
            function clearForm() {
                categoryIdField.value = '';
                titleField.value = '';
                descriptionField.value = '';
                aliasField.value = '';
            }

            // 👉 Bắt sự kiện click nút Thêm danh mục
            addProductBtn.addEventListener('click', function () {
                modalTitle.textContent = 'Thêm danh mục sản phẩm';
                deleteProductBtn.style.display = 'none'; // Khi thêm mới thì ẩn nút Xóa
                openModal();
            });

            // 👉 Bắt sự kiện click nút Thoát hoặc dấu X
            closeModalBtn.addEventListener('click', closeModal);
            cancelBtn.addEventListener('click', closeModal);

            // 👉 Bắt sự kiện click các nút sửa/xóa trong bảng
            document.querySelectorAll('.action-menu .action-btn').forEach(function (btn, index) {
                btn.addEventListener('click', function (e) {
                    e.preventDefault();
                    const actionMenu = btn.closest('.action-menu');
                    const id = actionMenu.getAttribute('data-id');

                    // Nếu là nút edit (icon cây viết)
                    if (btn.querySelector('i').classList.contains('fa-edit')) {
                        // ⚡ Load dữ liệu vào form
                        const row = btn.closest('tr');
                        const cells = row.querySelectorAll('td');

                        categoryIdField.value = id;
                        titleField.value = cells[1].innerText.trim();
                        descriptionField.value = cells[2].innerText.trim();
                        aliasField.value = cells[3].innerText.trim();

                        modalTitle.textContent = 'Chỉnh sửa danh mục sản phẩm';
                        deleteProductBtn.style.display = 'inline-block'; // Hiện nút Xóa
                        openModal();
                    }

                    // Nếu là nút delete (icon thùng rác)
                    if (btn.querySelector('i').classList.contains('fa-trash')) {
                        if (confirm('Bạn có chắc chắn muốn xóa danh mục này không?')) {
                            // 🚀 Gọi hàm xóa tại đây
                            deleteCategory(id);
                        }
                    }
                });
            });

            // 👉 Hàm xử lý XÓA
            function deleteCategory(id) {
                console.log('Thực hiện xóa danh mục id = ' + id);
                // TODO: Thêm Ajax hoặc WebMethod ASP.NET để xóa chính thức
                // Ví dụ: gọi WebMethod .aspx.cs hoặc Submit form
                alert('Đã gửi yêu cầu xóa id = ' + id);
            }

            // 👉 Bắt sự kiện click nút Lưu
            saveProductBtn.addEventListener('click', function () {
                const id = categoryIdField.value;
                const title = titleField.value;
                const description = descriptionField.value;
                const alias = aliasField.value;

                if (!title) {
                    alert('Vui lòng nhập tên danh mục');
                    return;
                }

                if (id) {
                    // ⚡ Cập nhật
                    console.log('Update danh mục id = ' + id);
                } else {
                    // ⚡ Thêm mới
                    console.log('Thêm mới danh mục');
                }

                // TODO: Gọi Ajax hoặc WebMethod ở đây để lưu dữ liệu thực tế vào server

                closeModal(); // Đóng modal sau khi lưu
            });

        });
    </script>




</asp:Content>
