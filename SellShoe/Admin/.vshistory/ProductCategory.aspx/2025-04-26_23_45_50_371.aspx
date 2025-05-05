<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ProductCategory.aspx.cs" Inherits="SellShoe.Admin.ProductCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Content Card -->
    <div class="content-card">
        <div class="card-header">
            <h2>QUẢN LÝ DANH MỤC SẢN PHẨM</h2>
            <div class="header-actions">
                <button type="button" class="add-product-btn" id="addProductBtn">Thêm danh mục</button>
            </div>
        </div>

        <div class="table-container">

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
                <tbody id="productsTableBody">

                    <%for (int i = 0; i < listCategory.Count; i++)
                        {  %>
                    <tr>
                        <td><%=listCategory[i].id %></td>
                        <td><%=listCategory[i].Title %></td>
                        <td><%=listCategory[i].Description %></td>
                        <td><%=listCategory[i].Alias %></td>
                        <td class="action-cell">
                            <div class="action-menu" data-id="<%=listCategory[i].id %>">
                                <button class="action-btn">
                                    <i class="fad fa-edit"></i>
                                </button>
                                <button class="action-btn">
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
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>


    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const modal = document.getElementById("categoryModal");

            // Hiển thị modal khi nhấn nút thêm danh mục
            document.getElementById("addProductBtn").addEventListener("click", function () {
                resetForm();
                document.getElementById("modalTitle").innerText = "Thêm danh mục sản phẩm";
                modal.style.display = "flex";
            });

            // Hiển thị modal khi nhấn nút sửa danh mục
            document.querySelectorAll(".action-menu .fa-edit").forEach(function (btn) {
                btn.addEventListener("click", function (event) {
                    event.preventDefault();
                    const id = this.closest(".action-menu").getAttribute("data-id");
                    // Lấy dữ liệu từ hàng tương ứng
                    const row = this.closest("tr");
                    document.getElementById("categoryId").value = id;
                    document.getElementById("txtTitle").value = row.cells[1].innerText;
                    document.getElementById("txtDescription").value = row.cells[2].innerText;
                    document.getElementById("txtAlias").value = row.cells[3].innerText;

                    document.getElementById("modalTitle").innerText = "Sửa danh mục sản phẩm";
                    modal.style.display = "flex";
                });
            });

            // Đóng modal
            document.getElementById("closeModal").addEventListener("click", function () {
                modal.style.display = "none";
            });

            document.getElementById("cancelBtn").addEventListener("click", function () {
                modal.style.display = "none";
            });

            // Lưu danh mục
            document.getElementById("saveProductBtn").addEventListener("click", function () {
                const id = document.getElementById("categoryId").value;
                const title = document.getElementById("txtTitle").value;
                const description = document.getElementById("txtDescription").value;
                const alias = document.getElementById("txtAlias").value;

                if (!title || !alias) {
                    alert("Vui lòng nhập đầy đủ thông tin.");
                    return;
                }

                const payload = {
                    id: id ? parseInt(id) : 0,
                    title: title,
                    description: description,
                    alias: alias
                };

                fetch("ProductCategory.aspx/SaveCategory", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify({ category: payload })
                })
                    .then(res => res.json())
                    .then(data => {
                        if (data.d === "success") {
                            alert("Lưu thành công!");
                            location.reload();
                        } else {
                            alert("Có lỗi xảy ra!");
                        }
                    })
                    .catch(err => console.error(err));
            });

            // Xóa danh mục
            document.querySelectorAll(".action-menu .fa-trash").forEach(function (btn) {
                btn.addEventListener("click", function () {
                    const id = this.closest(".action-menu").getAttribute("data-id");
                    const row = this.closest("tr"); // << lấy dòng chứa nút xóa
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
                                    row.remove(); // << Xóa luôn dòng đó trên giao diện
                                } else {
                                    alert("Không tìm thấy danh mục cần xóa!");
                                }
                            })
                            .catch(err => console.error(err));
                    }
                });
            });

            // Reset form modal
            function resetForm() {
                document.getElementById("categoryId").value = "";
                document.getElementById("txtTitle").value = "";
                document.getElementById("txtDescription").value = "";
                document.getElementById("txtAlias").value = "";
            }
        });
    </script>




</asp:Content>
