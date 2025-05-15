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

            <asp:GridView ID="gvCategory" runat="server" AutoGenerateColumns="False"
                CssClass="products-table" DataKeyNames="id"
                OnRowEditing="gvCategory_RowEditing"
                OnRowUpdating="gvCategory_RowUpdating"
                OnRowCancelingEdit="gvCategory_RowCancelingEdit"
                OnRowDeleting="gvCategory_RowDeleting">

                <Columns>
                    <asp:BoundField DataField="id" HeaderText="#" ReadOnly="True" />

                    <asp:TemplateField HeaderText="Tên danh mục">
                        <ItemTemplate>
                            <%# Eval("Title") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtTitle" runat="server" Text='<%# Bind("Title") %>' CssClass="form-control" />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Mô tả">
                        <ItemTemplate>
                            <%# Eval("Description") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDescription" runat="server" Text='<%# Bind("Description") %>' CssClass="form-control" />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Alias">
                        <ItemTemplate>
                            <%# Eval("Alias") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtAlias" runat="server" Text='<%# Bind("Alias") %>' CssClass="form-control" />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Tùy chọn">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" CommandName="Edit" ToolTip="Sửa"
                                Text='<i class="fad fa-edit"></i>' CssClass="btn-icon" />
                            &nbsp;
                <asp:LinkButton runat="server" CommandName="Delete" ToolTip="Xóa"
                    Text='<i class="fad fa-trash"></i>' CssClass="btn-icon"
                    OnClientClick="return confirm('Xóa danh mục này?');" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:LinkButton runat="server" CommandName="Update" ToolTip="Cập nhật"
                                Text='<i class="fad fa-check"></i>' CssClass="btn-icon" />
                            &nbsp;
                <asp:LinkButton runat="server" CommandName="Cancel" ToolTip="Hủy"
                    Text='<i class="fad fa-outdent"></i>' CssClass="btn-icon" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>


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

                    <div id="productForm">
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
                    </div>

                </div>
            </div>
        </div>
    </div>


    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const modal = document.getElementById("categoryModal");

            // Hiển thị modal thêm mới
            document.getElementById("addProductBtn")?.addEventListener("click", function () {
                resetForm();
                document.getElementById("modalTitle").innerText = "Thêm danh mục sản phẩm";
                modal.style.display = "flex";
            });

            // Dùng event delegation để gán sự kiện XÓA và SỬA
            document.getElementById("productsTableBody").addEventListener("click", function (event) {
                const target = event.target;
                const btn = target.closest("button.action-btn");
                if (!btn) return; // Không click vào nút thì thôi

                const actionMenu = btn.closest(".action-menu");
                const id = actionMenu.getAttribute("data-id");
                const row = btn.closest("tr");

                if (btn.querySelector(".fa-edit")) {
                    // Click SỬA
                    document.getElementById("categoryId").value = id;
                    document.getElementById("txtTitle").value = row.cells[1].innerText;
                    document.getElementById("txtDescription").value = row.cells[2].innerText;
                    document.getElementById("txtAlias").value = row.cells[3].innerText;

                    document.getElementById("modalTitle").innerText = "Sửa danh mục sản phẩm";
                    modal.style.display = "flex";
                }
                else if (btn.querySelector(".fa-trash")) {
                    // Click XÓA
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
                                    row.remove(); // Xóa dòng ngay lập tức
                                } else {
                                    alert("Không tìm thấy danh mục cần xóa!");
                                }
                            })
                            .catch(err => console.error(err));
                    }
                }
            });

            // Đóng modal
            document.getElementById("closeModal")?.addEventListener("click", function () {
                modal.style.display = "none";
            });
            document.getElementById("cancelBtn")?.addEventListener("click", function () {
                modal.style.display = "none";
            });

            // Lưu danh mục
            document.getElementById("saveProductBtn")?.addEventListener("click", function () {
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

            // Reset form
            function resetForm() {
                document.getElementById("categoryId").value = "";
                document.getElementById("txtTitle").value = "";
                document.getElementById("txtDescription").value = "";
                document.getElementById("txtAlias").value = "";
            }
        });
    </script>




</asp:Content>
