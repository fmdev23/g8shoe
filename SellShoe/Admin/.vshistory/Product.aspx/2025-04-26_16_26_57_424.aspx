<%@ Page Title="Quản lý sản phẩm" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="SellShoe.Admin.Product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="content-card">
        <div class="card-header">
            <h2>QUẢN LÝ SẢN PHẨM</h2>
            <div class="header-actions">
                <div class="search-container">
                    <i class="fal fa-search"></i>
                    <input type="text" id="txtSearch" placeholder="Tìm kiếm sản phẩm..." />
                </div>
                <button type="button" id="btnAddProduct" class="add-product-btn">Thêm sản phẩm</button>
            </div>
        </div>

        <div class="table-container">
            <asp:Repeater ID="rptProduct" runat="server">
                <HeaderTemplate>
                    <table class="products-table">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Hình ảnh</th>
                                <th>Tên sản phẩm</th>
                                <th>Mã SP</th>
                                <th>Giá</th>
                                <th>Giá KM</th>
                                <th>Số lượng</th>
                                <th>Danh mục</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("Id") %></td>
                        <td>
                            <img src='<%# Eval("Image") %>' style="width: 60px;" /></td>
                        <td><%# Eval("Title") %></td>
                        <td><%# Eval("ProductCode") %></td>
                        <td><%# String.Format("{0:N0}", Eval("Price")) %></td>
                        <td><%# String.Format("{0:N0}", Eval("PriceSale")) %></td>
                        <td><%# Eval("Quantity") %></td>
                        <td><%# Eval("CategoryName") %></td>
                        <td>
                            <button type="button" class="action-btn edit-btn" data-id='<%# Eval("Id") %>'>
                                <i class="fad fa-edit"></i>
                            </button>
                            <button type="button" class="action-btn delete-btn" data-id='<%# Eval("Id") %>'>
                                <i class="fal fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>

        <!-- Modal Thêm / Sửa Sản Phẩm -->
        <div class="modal" id="productModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 id="modalTitle">Thêm sản phẩm</h3>
                    <button type="button" class="close-modal" id="btnCloseModal">
                        <i class="fad fa-times"></i>
                    </button>
                </div>

                <div class="modal-body">
                    <form id="productForm" runat="server">
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
                            <label>Ảnh sản phẩm</label>
                            <input type="text" id="txtImage" />
                        </div>

                        <div class="form-group">
                            <label>Danh mục sản phẩm</label>
                            <select id="ddlCategory"></select>
                        </div>

                        <div class="form-group">
                            <label>Trạng thái</label><br />
                            <input type="checkbox" id="chkIsHome" />
                            Trang chủ
                            <input type="checkbox" id="chkIsSale" />
                            Khuyến mãi
                            <input type="checkbox" id="chkIsFeature" />
                            Nổi bật
                            <input type="checkbox" id="chkIsHot" />
                            Best Seller
                        </div>

                        <div class="form-group">
                            <label>Alias</label>
                            <input type="text" id="txtAlias" />
                        </div>

                        <div class="form-group">
                            <label>Mô tả ngắn</label>
                            <textarea id="txtDescription"></textarea>
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
                            <button type="button" class="cancel-btn" id="btnCancel">Hủy</button>
                            <button type="button" class="save-btn" id="btnSaveProduct">Lưu</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {

            // Mở Modal thêm sản phẩm
            document.getElementById("btnAddProduct").addEventListener("click", function () {
                clearForm();
                document.getElementById("modalTitle").innerText = "Thêm sản phẩm";
                openModal();
            });

            // Đóng Modal
            document.getElementById("btnCloseModal").addEventListener("click", closeModal);
            document.getElementById("btnCancel").addEventListener("click", closeModal);

            // Lưu sản phẩm
            document.getElementById("btnSaveProduct").addEventListener("click", saveProduct);

            // Bắt sự kiện Edit
            document.querySelectorAll(".edit-btn").forEach(function (btn) {
                btn.addEventListener("click", function () {
                    const id = this.getAttribute("data-id");
                    loadProduct(id);
                });
            });

            // Bắt sự kiện Delete
            document.querySelectorAll(".delete-btn").forEach(function (btn) {
                btn.addEventListener("click", function () {
                    const id = this.getAttribute("data-id");
                    deleteProduct(id);
                });
            });

        });

        function openModal() {
            document.getElementById("productModal").style.display = "block";
        }

        function closeModal() {
            document.getElementById("productModal").style.display = "none";
        }

        function clearForm() {
            document.getElementById("productForm").reset();
            document.getElementById("productId").value = "";
        }

        function saveProduct() {
            const product = {
                Id: parseInt(document.getElementById("productId").value) || 0,
                Title: document.getElementById("txtTitle").value,
                ProductCode: document.getElementById("txtProductCode").value,
                Price: parseFloat(document.getElementById("txtPrice").value) || 0,
                PriceSale: parseFloat(document.getElementById("txtPriceSale").value) || 0,
                Quantity: parseInt(document.getElementById("txtQuantity").value) || 0,
                Image: document.getElementById("txtImage").value,
                ProductCategoryId: parseInt(document.getElementById("ddlCategory").value) || 0,
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

            fetch("Product.aspx/SaveProduct", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({ product: product })
            })
                .then(response => response.json())
                .then(result => {
                    if (result.d === "success") {
                        alert("Lưu sản phẩm thành công!");
                        location.reload();
                    } else {
                        alert("Lỗi: " + result.d);
                    }
                })
                .catch(error => {
                    console.error("Lỗi:", error);
                    alert("Đã xảy ra lỗi trong quá trình lưu sản phẩm.");
                });
        }

        function loadProduct(id) {
            fetch("Product.aspx/GetProductById", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({ id: id })
            })
                .then(response => response.json())
                .then(result => {
                    const product = result.d;
                    if (product) {
                        document.getElementById("modalTitle").innerText = "Cập nhật sản phẩm";
                        document.getElementById("productId").value = product.Id;
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
                        openModal();
                    }
                })
                .catch(error => {
                    console.error("Lỗi:", error);
                });
        }

        function deleteProduct(id) {
            if (!confirm("Bạn có chắc chắn muốn xóa sản phẩm này?")) return;

            fetch("Product.aspx/DeleteProduct", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({ id: id })
            })
                .then(response => response.json())
                .then(result => {
                    if (result.d === "success") {
                        alert("Đã xóa sản phẩm thành công!");
                        location.reload();
                    } else {
                        alert("Lỗi: " + result.d);
                    }
                })
                .catch(error => {
                    console.error("Lỗi:", error);
                });
        }

    </script>

</asp:Content>
