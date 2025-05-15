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
                <asp:Button ID="btnAddProduct" runat="server" CssClass="add-product-btn" Text="Thêm sản phẩm" UseSubmitBehavior="false" OnClientClick="showAddModal(); return false;" />

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

        <!-- Add/Edit Product Modal -->
        <div class="modal" id="productModal" runat="server" clientidmode="Static">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 id="modalTitle">Thêm sản phẩm</h3>
                    <button class="close-modal" id="closeModal">
                        <i class="fad fa-times"></i>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="productForm">
                        <asp:HiddenField ID="hdProductId" runat="server" />

                        <div class="form-group">
                            <label>Tên sản phẩm</label>
                            <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" />
                        </div>

                        <div class="form-group">
                            <label>Mã sản phẩm</label>
                            <asp:TextBox ID="txtProductCode" runat="server" CssClass="form-control" />
                        </div>

                        <div class="form-group">
                            <label>Mô tả</label>
                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" />
                        </div>

                        <div class="form-group">
                            <label>Chi tiết</label>
                            <asp:TextBox ID="txtDetail" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" />
                        </div>

                        <div class="form-group">
                            <label>Đường dẫn ảnh</label>
                            <asp:TextBox ID="txtImage" runat="server" CssClass="form-control" />
                        </div>

                        <div class="form-group">
                            <label>Giá gốc</label>
                            <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" TextMode="Number" />
                        </div>

                        <div class="form-group">
                            <label>Giá khuyến mãi</label>
                            <asp:TextBox ID="txtPriceSale" runat="server" CssClass="form-control" TextMode="Number" />
                        </div>

                        <div class="form-group">
                            <label>Số lượng</label>
                            <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" TextMode="Number" />
                        </div>

                        <div class="form-group">
                            <label>Danh mục sản phẩm</label>
                            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" />
                        </div>

                        <div class="form-group checkbox-group">
                            <label>
                                <asp:CheckBox ID="chkIsHot" runat="server" />
                                Hot
                            </label>
                            <label>
                                <asp:CheckBox ID="chkIsHome" runat="server" />
                                Trang chủ
                            </label>
                            <label>
                                <asp:CheckBox ID="chkIsActive" runat="server" />
                                Kích hoạt
                            </label>
                        </div>

                        <div class="form-actions">
                            <asp:Button ID="btnCancel" runat="server" Text="Thoát" CssClass="cancel-btn" CausesValidation="false" />
                            <asp:Button ID="btnSaveProduct" runat="server" Text="Lưu" CssClass="save-btn" OnClick="btnSaveProduct_Click" />
                        </div>
                    </div>
                </div>

            </div>
        </div>

    </div>

    <script type="text/javascript">
        function showAddModal() {
            document.getElementById('productModal').classList.add('active');
        }

        function hideAddModal() {
            document.getElementById('productModal').classList.remove('active');
        }

        // Đóng modal khi click nút X
        document.addEventListener('DOMContentLoaded', function () {
            var closeBtn = document.getElementById('closeModal');
            if (closeBtn) {
                closeBtn.addEventListener('click', function () {
                    hideAddModal();
                });
            }
        });
    </script>

</asp:Content>
