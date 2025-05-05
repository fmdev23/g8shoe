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
                                <th>Hình ảnh</th>
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
                        <td><img src='<%# Eval("Image") %>' style="width: 60px;" /></td>
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
                            <asp:FileUpload ID="fuImage" runat="server" />
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
                            <input type="checkbox" id="chkIsHot" /> Best Seller
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




</asp:Content>
