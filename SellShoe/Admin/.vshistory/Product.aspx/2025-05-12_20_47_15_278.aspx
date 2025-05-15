<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="SellShoe.Admin.Product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div class="content-card">
        <div class="card-header">
            <h2>QUẢN LÝ SẢN PHẨM</h2>
            <div class="header-actions">
                <div class="search-container">
                    <i class="fal fa-search"></i>
                    <input type="text" placeholder="Tìm sản phẩm">
                </div>
                <asp:Button ID="btnAddProduct" runat="server" CssClass="add-product-btn" Text="Thêm sản phẩm"
                    OnClientClick="showAddModal(); return false;" UseSubmitBehavior="false" />
            </div>
        </div>

        <div class="table-container">
            <asp:DataGrid ID="dgProducts" runat="server"
                AutoGenerateColumns="False"
                AllowPaging="True"
                PageSize="10"
                nableViewState="true"
                OnPageIndexChanged="dgProducts_PageIndexChanged"
                PagerStyle-Mode="NumericPages"
                CssClass="products-table">
                <Columns>
                    <asp:TemplateColumn HeaderText="Ảnh SP">
                        <ItemTemplate>
                            <%# !string.IsNullOrEmpty(Eval("Image").ToString()) ? $"<img src='{Eval("Image")}' style='width:60px; height:60px; border-radius:50%;' />" : "" %>
                        </ItemTemplate>
                    </asp:TemplateColumn>

                    <asp:BoundColumn DataField="Title" HeaderText="Tên SP" />
                    <asp:BoundColumn DataField="ProductCode" HeaderText="Mã SP" />
                    <asp:TemplateColumn HeaderText="Giá hiển thị">
                        <ItemTemplate>
                            <%# string.Format("{0:N0}", Convert.ToInt32(Eval("PriceSale"))).Replace(",", ".") %>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:BoundColumn DataField="Quantity" HeaderText="Số lượng" />
                    <asp:BoundColumn DataField="IsHot" HeaderText="Best Seller" />
                    <asp:BoundColumn DataField="IsHome" HeaderText="SP Mới" />
                    <asp:BoundColumn DataField="IsActive" HeaderText="Hiển thị" />
                    <asp:BoundColumn DataField="CategoryName" HeaderText="Danh mục" />

                    <asp:TemplateColumn HeaderText="Tùy chọn">
                        <ItemTemplate>
                            <div class="action-menu">
                                <button type="button" class="action-btn">
                                    <i class="fad fa-edit"></i>
                                </button>
                                <button type="button" class="action-btn">
                                    <i class="fal fa-trash"></i>
                                </button>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
            </asp:DataGrid>
        </div>


        <!-- Modal -->
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
                            <label>Giá hiển thị</label>
                            <asp:TextBox ID="txtPriceSale" runat="server" CssClass="form-control" TextMode="Number" />
                        </div>
                        <div class="form-group">
                            <label>Số lượng</label>
                            <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" TextMode="Number" />
                        </div>
                        <div class="form-group">
                            <label>Danh mục</label>
                            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" />
                        </div>
                        <div class="form-group checkbox-group">
                            <label>
                                <asp:CheckBox ID="chkIsHot" runat="server" />
                                Best Seller</label>
                            <label>
                                <asp:CheckBox ID="chkIsHome" runat="server" />
                                SP Mới</label>
                            <label>
                                <asp:CheckBox ID="chkIsActive" runat="server" />
                                Hiển thị</label>
                        </div>
                        <div class="form-actions">
                            <asp:Button ID="btnCancel" runat="server" Text="Thoát" CssClass="cancel-btn" CausesValidation="false" OnClientClick="hideAddModal(); return false;" />
                            <asp:Button ID="btnSaveProduct" runat="server" Text="Lưu" CssClass="save-btn" OnClick="btnSaveProduct_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
    <script type="text/javascript">
        function showAddModal() {
            document.getElementById('productModal').classList.add('active');
        }

        function hideAddModal() {
            document.getElementById('productModal').classList.remove('active');
        }

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

