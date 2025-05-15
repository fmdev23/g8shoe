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
            <asp:UpdatePanel ID="updProducts" runat="server">
                <ContentTemplate>
                    <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
                        <HeaderTemplate>
                            <table class="products-table">
                                <thead>
                                    <tr>
                                        <th>Ảnh SP</th>
                                        <th>Tên SP</th>
                                        <th>Mã SP</th>
                                        <th>Giá hiển thị</th>
                                        <th>Số lượng</th>
                                        <th>Best Seller</th>
                                        <th>SP Mới</th>
                                        <th>Hiển thị</th>
                                        <th>Danh mục</th>
                                        <th>Tùy chọn</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <img src='<%# Eval("Image") %>' style="width: 60px; height: 60px; border-radius: 50%;" />
                                </td>
                                <td><%# Eval("Title") %></td>
                                <td><%# Eval("ProductCode") %></td>
                                <td><%# String.Format("{0:N0}", Eval("PriceSale")).Replace(",", ".") %></td>
                                <td><%# Eval("Quantity") %></td>
                                <td><%# Eval("IsHot") %></td>
                                <td><%# Eval("IsHome") %></td>
                                <td><%# Eval("IsActive") %></td>
                                <td><%# Eval("CategoryName") %></td>
                                <td>
                                    <div class="action-menu">
                                        <asp:LinkButton ID="lnkEdit" runat="server" CssClass="action-btn" CommandName="Edit" CommandArgument='<%# Eval("id") %>'>
                                            <i class="fad fa-edit"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="lnkDelete" runat="server" CssClass="action-btn" CommandName="Delete" CommandArgument='<%# Eval("id") %>' OnClientClick="return confirm('Bạn có chắc muốn xóa?');">
                                            <i class="fal fa-trash"></i>
                                        </asp:LinkButton>
                                    </div>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </ContentTemplate>
            </asp:UpdatePanel>
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

