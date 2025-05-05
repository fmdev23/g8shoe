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


    <script type="text/javascript">
        // Lắng nghe sự kiện khi nhấn vào nút "Chỉnh sửa"
        function editCategory(id, title, description, alias) {
            // Cập nhật thông tin vào form trong modal
            document.getElementById('categoryId').value = id;
            document.getElementById('txtTitle').value = title;
            document.getElementById('txtDescription').value = description;
            document.getElementById('txtAlias').value = alias;
            document.getElementById('modalTitle').innerText = 'Chỉnh sửa danh mục sản phẩm';

            // Hiển thị modal
            document.getElementById('categoryModal').style.display = 'block';
        }

        // Lắng nghe sự kiện khi nhấn vào nút "Xóa"
        function deleteCategory(id) {
            if (confirm('Bạn có chắc chắn muốn xóa danh mục này không?')) {
                // Gọi phương thức xóa qua WebMethod
                deleteCategoryFromServer(id);
            }
        }

        // Gửi yêu cầu xóa danh mục từ server
        function deleteCategoryFromServer(id) {
            var params = { id: id };
            // Gửi yêu cầu xóa thông qua Ajax
            $.ajax({
                type: 'POST',
                url: 'ProductCategory.aspx/DeleteCategory',
                data: JSON.stringify(params),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (response) {
                    if (response.d) {
                        alert('Danh mục đã được xóa thành công');
                        location.reload(); // Tải lại trang để cập nhật danh sách
                    } else {
                        alert('Có lỗi xảy ra khi xóa danh mục');
                    }
                },
                error: function () {
                    alert('Có lỗi xảy ra khi xóa danh mục');
                }
            });
        }

        // Lắng nghe sự kiện khi nhấn nút "Lưu"
        document.getElementById('saveProductBtn').addEventListener('click', function () {
            var categoryId = document.getElementById('categoryId').value;
            var title = document.getElementById('txtTitle').value;
            var description = document.getElementById('txtDescription').value;
            var alias = document.getElementById('txtAlias').value;

            var params = {
                id: categoryId,
                title: title,
                description: description,
                alias: alias
            };

            // Gửi yêu cầu cập nhật thông qua Ajax
            $.ajax({
                type: 'POST',
                url: 'ProductCategory.aspx/UpdateCategory',
                data: JSON.stringify(params),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (response) {
                    if (response.d) {
                        alert('Cập nhật danh mục thành công');
                        location.reload(); // Tải lại trang để cập nhật danh sách
                    } else {
                        alert('Có lỗi xảy ra khi cập nhật danh mục');
                    }
                },
                error: function () {
                    alert('Có lỗi xảy ra khi cập nhật danh mục');
                }
            });
        });

        // Lắng nghe sự kiện khi nhấn nút "Thoát" hoặc đóng modal
        document.getElementById('closeModal').addEventListener('click', function () {
            document.getElementById('categoryModal').style.display = 'none';
        });

        document.getElementById('cancelBtn').addEventListener('click', function () {
            document.getElementById('categoryModal').style.display = 'none';
        });
    </script>

</asp:Content>
