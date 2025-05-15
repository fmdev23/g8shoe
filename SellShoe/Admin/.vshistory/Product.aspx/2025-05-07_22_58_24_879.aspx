<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="SellShoe.Admin.Product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Content Card -->
    <div class="content-card">
        <div class="card-header">
            <h2>QUẢN LÝ SẢN PHẨM</h2>
            <div class="header-actions">
                <div class="search-container">
                    <i class="fal fa-search"></i>
                    <input type="text" placeholder="Tìm sản phẩm">
                </div>
                <button class="add-product-btn" id="addProductBtn">Thêm sản phẩm</button>
            </div>
        </div>

        <div class="table-container">
            <table class="products-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Ảnh SP</th>
                        <th>Tên SP</th>
                        <th>Mã SP</th>
                        <th>Giá hiển thị</th>
                        <th>Số lượng</th>
                        <th>Best Seller</th>
                        <th>New Arrival</th>
                        <th>Hiển thị</th>
                        <th>Danh mục</th>
                        <th>Tùy chọn</th>
                    </tr>
                </thead>
                <tbody>

                    <%for (int i = 0; i < listSP.Count; i++)
                        {  %>
                    <tr>
                        <th><%=listSP[i].id %></th>
                        <th>
                            <% if (!string.IsNullOrEmpty(listSP[i].Image))
                                { %>
                            <img src="<%= listSP[i].Image %>" style="width: 60px; height: 60px; border-radius: 50%;" />
                            <% } %>
                        </th>
                        <th><%=listSP[i].Title %></th>
                        <th><%=listSP[i].ProductCode %></th>
                        <th><%= string.Format("{0:N0}", ((int)listSP[i].PriceSale)).Replace(",", ".") %></th>
                        <th><%=listSP[i].Quantity %></th>
                        <th><%= listSP[i].IsHot %></th>
                        <th><%=listSP[i].IsHome %></th>
                        <th><%=listSP[i].IsActive %></th>
                        <th><%=listSP[i].ProductCategoryId %></th>
                        <td class="action-cell">
                            <div class="action-menu">
                                <button type="button" class="action-btn">
                                    <i class="fad fa-edit"></i>
                                </button>
                                <button type="button" class="action-btn">
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
        <div class="modal" id="productModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 id="modalTitle">Thêm sản phẩm</h3>
                    <button class="close-modal" id="closeModal">
                        <i class="fad fa-times"></i>
                    </button>
                </div>
                <div class="modal-body">

                    <div id="productForm">
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
                            <label>Đường dẫn ảnh</label>
                            <input type="text" id="txtImage" />
                        </div>

                        <div class="form-group">
                            <label>Giá gốc</label>
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
                            <label>Danh mục sản phẩm</label>
                            <select id="ddlCategory">
                                <!-- Populate bằng JS từ ASP.NET hoặc ajax -->
                            </select>
                        </div>

                        <div class="form-group checkbox-group">
                            <label>
                                <input type="checkbox" id="chkIsHot" />
                                Hot</label>
                            <label>
                                <input type="checkbox" id="chkIsHome" />
                                Trang chủ</label>
                            <label>
                                <input type="checkbox" id="chkIsActive" />
                                Kích hoạt</label>
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


</asp:Content>
