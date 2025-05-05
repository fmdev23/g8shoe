<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="SellShoe.Admin.Product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Content Card -->
    <div class="content-card">
        <div class="card-header">
            <h2>QUẢN LÝ SẢN PHẨM</h2>
            <div class="header-actions">
                <div class="search-container">
                    <i class="fal fa-search"></i>
                    <input type="text" placeholder="Tìm kiếm sản phẩm...">
                </div>
                <button type="button" class="add-product-btn" id="addProductBtn">Thêm sản phẩm</button>
            </div>
        </div>

        <div class="table-container">
            <asp:Repeater ID="rptCategory" runat="server">
                <HeaderTemplate>
                    <table class="products-table">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Tên sản phẩm</th>
                                <th>Mã SP</th>
                                <th>Giá</th>
                                <th>Giá KM</th>
                                <th>Số lượng</th>
                                <th>Danh mục</th>
                                <th>Tùy chọn</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("id") %></td>
                        <td><%# Eval("Title") %></td>
                        <td><%# Eval("ProductCode") %></td>
                        <td><%# String.Format("{0:N0}", Eval("Price")) %></td>
                        <td><%# String.Format("{0:N0}", Eval("PriceSale")) %></td>
                        <td><%# Eval("Quantity") %></td>
                        <td><%# Eval("ProductCategoryId") %></td>
                        <td class="action-cell">
                            <div class="action-menu" data-id='<%# Eval("id") %>'>
                                <button type="button" class="action-btn">
                                    <i class="fad fa-edit"></i>
                                </button>
                                <button type="button" class="action-btn">
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

        <!-- Modal Add/Edit Product -->
        <div class="modal" id="productModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 id="modalTitle">Thêm sản phẩm</h3>
                    <button class="close-modal" id="closeModal">
                        <i class="fad fa-times"></i>
                    </button>
                </div>
                <div class="modal-body">

                    <form id="productForm">
                        <input type="hidden" id="productId" />

                        <div class="form-group">
                            <label>Tên sản phẩm</label>
                            <input type="text" id="txtTitle" />
                        </div>

                        <div class="form-group">
                            <label>Mã sản phẩm</label>
                            <input type="text" id="txtProductCode" />
                        </div>

                        <div class="form-group">
                            <label>Giá bán</label>
                            <input type="number" id="txtPrice" />
                        </div>

                        <div class="form-group">
                            <label>Giá khuyến mãi</label>
                            <input type="number" id="txtPriceSale" />
                        </div>

                        <div class="form-group">
                            <label>Số lượng</label>
                            <input type="number" id="txtQuantity" />
                        </div>

                        <div class="form-group">
                            <label>Ảnh sản phẩm (URL)</label>
                            <input type="text" id="txtImage" />
                        </div>

                        <div class="form-group">
                            <label>Danh mục sản phẩm</label>
                            <select id="ddlCategory">
                                <option value="">-- Chọn danh mục --</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Trạng thái</label><br/>
                            <input type="checkbox" id="chkIsHome" /> Trang chủ
                            <input type="checkbox" id="chkIsSale" /> Khuyến mãi
                            <input type="checkbox" id="chkIsFeature" /> Nổi bật
                            <input type="checkbox" id="chkIsHot" /> Hot
                        </div>

                        <div class="form-group">
                            <label>Alias</label>
                            <input type="text" id="txtAlias" />
                        </div>

                        <div class="form-group">
                            <label>Mô tả ngắn</label>
                            <input type="text" id="txtDescription" />
                        </div>

                        <div class="form-group">
                            <label>Chi tiết sản phẩm</label>
                            <textarea id="txtDetail"></textarea>
                        </div>

                        <div class="form-group">
                            <label>SEO Title</label>
                            <input type="text" id="txtSeoTitle" />
                        </div>

                        <div class="form-group">
                            <label>SEO Description</label>
                            <input type="text" id="txtSeoDescription" />
                        </div>

                        <div class="form-group">
                            <label>SEO Keywords</label>
                            <input type="text" id="txtSeoKeywords" />
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
            const modal = document.getElementById("productModal");

            function resetForm() {
                document.getElementById("productId").value = "";
                document.getElementById("txtTitle").value = "";
                document.getElementById("txtProductCode").value = "";
                document.getElementById("txtPrice").value = "";
                document.getElementById("txtPriceSale").value = "";
                document.getElementById("txtQuantity").value = "";
                document.getElementById("txtImage").value = "";
                document.getElementById("ddlCategory").value = "";
                document.getElementById("chkIsHome").checked = false;
                document.getElementById("chkIsSale").checked = false;
                document.getElementById("chkIsFeature").checked = false;
                document.getElementById("chkIsHot").checked = false;
                document.getElementById("txtAlias").value = "";
                document.getElementById("txtDescription").value = "";
                document.getElementById("txtDetail").value = "";
                document.getElementById("txtSeoTitle").value = "";
                document.getElementById("txtSeoDescription").value = "";
                document.getElementById("txtSeoKeywords").value = "";
            }

            // Hiển thị modal thêm mới
            document.getElementById("addProductBtn").addEventListener("click", function () {
                resetForm();
                document.getElementById("modalTitle").innerText = "Thêm sản phẩm";
                modal.style.display = "flex";
            });

            // Đóng modal
            document.getElementById("closeModal").addEventListener("click", function () {
                modal.style.display = "none";
            });
            document.getElementById("cancelBtn").addEventListener("click", function () {
                modal.style.display = "none";
            });

            // Lưu sản phẩm
            document.getElementById("saveProductBtn").addEventListener("click", function () {
                const id = document.getElementById("productId").value;
                const product = {
                    id: id ? parseInt(id) : 0,
                    Title: document.getElementById("txtTitle").value,
                    ProductCode: document.getElementById("txtProductCode").value,
                    Price: parseFloat(document.getElementById("txtPrice").value),
                    PriceSale: parseFloat(document.getElementById("txtPriceSale").value),
                    Quantity: parseInt(document.getElementById("txtQuantity").value),
                    Image: document.getElementById("txtImage").value,
                    ProductCategoryId: parseInt(document.getElementById("ddlCategory").value),
                    IsHome: document.getElementById("chkIsHome").checked,
                    IsSale: document.getElementById("chkIsSale").checked,
                    IsFeature: document.getElementById("chkIsFeature").checked,
                    IsHot: document.getElementById("chkIsHot").checked,
                    Alias: document.getElementById("txtAlias").value,
                    Description: document.getElementById("txtDescription").value,
                    Detail: document.getElementById("txtDetail").value,
                    SeoTitle: document.getElementById("txtSeoTitle").value,
                    SeoDescription: document.getElementById("txtSeoDescription").value,
                    SeoKeywords: document.getElementById("txtSeoKeywords").value
                };

                if (!product.Title || !product.ProductCode || isNaN(product.Price) || isNaN(product.Quantity)) {
                    alert("Vui lòng nhập đầy đủ thông tin bắt buộc!");
                    return;
                }

                fetch("Product.aspx/SaveProduct", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify({ product: product })
                })
                    .then(res => res.json())
                    .then(data => {
                        if (data.d === "success") {
                            alert("Lưu sản phẩm thành công!");
                            location.reload();
                        } else {
                            alert("Có lỗi xảy ra khi lưu sản phẩm!");
                        }
                    })
                    .catch(err => console.error(err));
            });

            // Sửa sản phẩm
            document.querySelectorAll(".action-menu .fa-edit").forEach(function (btn) {
                btn.addEventListener("click", function () {
                    const id = this.closest(".action-menu").getAttribute("data-id");

                    fetch("Product.aspx/GetProductById", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json"
                        },
                        body: JSON.stringify({ id: parseInt(id) })
                    })
                        .then(res => res.json())
                        .then(data => {
                            const product = data.d;
                            if (product) {
                                document.getElementById("productId").value = product.id;
                                document.getElementById("txtTitle").value = product.Title;
                                document.getElementById("txtProductCode").value = product.ProductCode;
                                document.getElementById("txtPrice").value = product.Price;
                                document.getElementById("txtPriceSale").value = product.PriceSale;
                                document.getElementById("txtQuantity").value = product.Quantity;
                                document.getElementById("txtImage").value = product.Image;
                                document.getElementById("ddlCategory").value = product.ProductCategoryId;
                                document.getElementById("chkIsHome").checked = product.IsHome;
                                document.getElementById("chkIsSale").checked = product.IsSale;
                                document.getElementById("chkIsFeature").checked = product.IsFeature;
                                document.getElementById("chkIsHot").checked = product.IsHot;
                                document.getElementById("txtAlias").value = product.Alias;
                                document.getElementById("txtDescription").value = product.Description;
                                document.getElementById("txtDetail").value = product.Detail;
                                document.getElementById("txtSeoTitle").value = product.SeoTitle;
                                document.getElementById("txtSeoDescription").value = product.SeoDescription;
                                document.getElementById("txtSeoKeywords").value = product.SeoKeywords;

                                document.getElementById("modalTitle").innerText = "Sửa sản phẩm";
                                modal.style.display = "flex";
                            } else {
                                alert("Không tìm thấy sản phẩm.");
                            }
                        })
                        .catch(err => console.error(err));
                });
            });

            // Xóa sản phẩm
            document.querySelectorAll(".action-menu .fa-trash").forEach(function (btn) {
                btn.addEventListener("click", function () {
                    const id = this.closest(".action-menu").getAttribute("data-id");
                    if (confirm("Bạn có chắc chắn muốn xóa sản phẩm này không?")) {
                        fetch("Product.aspx/DeleteProduct", {
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
                                    alert("Không tìm thấy sản phẩm cần xóa!");
                                }
                            })
                            .catch(err => console.error(err));
                    }
                });
            });

            // Load danh sách danh mục cho dropdown
            function loadCategories() {
                fetch("Product.aspx/GetCategories", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    }
                })
                    .then(res => res.json())
                    .then(data => {
                        const categories = data.d;
                        const ddlCategory = document.getElementById("ddlCategory");
                        categories.forEach(cat => {
                            const option = document.createElement("option");
                            option.value = cat.id;
                            option.text = cat.Title;
                            ddlCategory.add(option);
                        });
                    })
                    .catch(err => console.error(err));
            }

            loadCategories();
        });
    </script>


</asp:Content>
