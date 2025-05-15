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
                AllowPaging="true" PageSize="7"
                AutoGenerateColumns="False"
                PagerStyle-Mode="NumericPages"
                DataKeyField="id"
                OnPageIndexChanged="dgProducts_PageIndexChanged"
                OnEditCommand="dgProducts_EditCommand"
                OnCancelCommand="dgProducts_CancelCommand"
                OnUpdateCommand="dgProducts_UpdateCommand"
                OnDeleteCommand="dgProducts_DeleteCommand"
                CssClass="products-table table-container">

                <Columns>
                    <%-- Ảnh không cho sửa --%>
                    <asp:TemplateColumn HeaderText="Ảnh SP">
                        <ItemTemplate>
                            <asp:Image ID="imgProduct" runat="server" Width="60" Height="60" Style="border-radius: 50%;"
                                ImageUrl='<%# Eval("Image") %>' />
                        </ItemTemplate>
                    </asp:TemplateColumn>

                    <%-- Tên SP --%>
                    <asp:TemplateColumn HeaderText="Tên SP">
                        <ItemTemplate>
                            <%# Eval("Title") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtTitle" runat="server" Text='<%# Bind("Title") %>' />
                        </EditItemTemplate>
                    </asp:TemplateColumn>

                    <%-- SKU --%>
                    <asp:TemplateColumn HeaderText="Mã SP">
                        <ItemTemplate><%# Eval("ProductCode") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCode" runat="server" Text='<%# Bind("ProductCode") %>' />
                        </EditItemTemplate>
                    </asp:TemplateColumn>

                    <%-- Giá --%>
                    <asp:TemplateColumn HeaderText="Giá hiển thị">
                        <ItemTemplate>
                            <%# string.Format("{0:N0}", Eval("PriceSale")).Replace(",", ".") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPriceSale" runat="server" Text='<%# Bind("PriceSale") %>' />
                        </EditItemTemplate>
                    </asp:TemplateColumn>

                    <%-- Số lượng --%>
                    <asp:TemplateColumn HeaderText="Số lượng">
                        <ItemTemplate><%# Eval("Quantity") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Bind("Quantity") %>' />
                        </EditItemTemplate>
                    </asp:TemplateColumn>

                    <%-- Các cột boolean --%>

                    <asp:TemplateColumn HeaderText="Hiển thị">
                        <ItemTemplate><%# Eval("IsActive") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:CheckBox ID="chkIsActive" runat="server" Checked='<%# Bind("IsActive") %>' />
                        </EditItemTemplate>

                        <ItemTemplate><%# Eval("IsHome") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:CheckBox ID="chkIsHome" runat="server" Checked='<%# Bind("IsHome") %>' />
                        </EditItemTemplate>
                    </asp:TemplateColumn>

                    <asp:TemplateColumn HeaderText="Danh mục">
                        <ItemTemplate><%# Eval("CategoryName") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCategoryName" runat="server" Text='<%# Bind("CategoryName") %>' />
                        </EditItemTemplate>
                    </asp:TemplateColumn>


                    <%-- tùy chọn --%>
                    <asp:TemplateColumn HeaderText="Tùy chọn">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" CommandName="Edit" ToolTip="Sửa"
                                Text='<i class="fad fa-edit"></i>' CssClass="btn-icon" />
                            &nbsp;
        <asp:LinkButton runat="server" CommandName="Delete" ToolTip="Xóa"
            Text='<i class="fad fa-trash"></i>' CssClass="btn-icon"
            OnClientClick="return confirm('Xóa sản phẩm này?');" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:LinkButton runat="server" CommandName="Update" ToolTip="Cập nhật"
                                Text='<i class="fad fa-check"></i>' CssClass="btn-icon" />
                            &nbsp;
        <asp:LinkButton runat="server" CommandName="Cancel" ToolTip="Hủy"
            Text='<i class="fad fa-outdent"></i>' CssClass="btn-icon" />
                        </EditItemTemplate>
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

