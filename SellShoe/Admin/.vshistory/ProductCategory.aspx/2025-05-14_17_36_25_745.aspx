<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ProductCategory.aspx.cs" Inherits="SellShoe.Admin.ProductCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Content Card -->
    <div class="content-card">
        <div class="card-header">
            <h2>QUẢN LÝ DANH MỤC SẢN PHẨM</h2>
            <div class="header-actions">
                <asp:Button ID="btnShowAddCategory" runat="server"
                    Text="Thêm danh mục"
                    CssClass="add-product-btn"
                    OnClientClick="showAddModal(); return false;" />
            </div>
        </div>


        <div class="table-container">

            <asp:GridView ID="gvCategory" runat="server" AutoGenerateColumns="False"
                CssClass="products-table" DataKeyNames="id"
                OnRowEditing="gvCategory_RowEditing"
                OnRowUpdating="gvCategory_RowUpdating"
                OnRowCancelingEdit="gvCategory_RowCancelingEdit"
                OnRowDeleting="gvCategory_RowDeleting"
                BorderWidth="0px"
GridLines="None"
CellPadding="0"
CellSpacing="0"
BorderStyle="None">

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
                    Text='<i class="fad fa-trash"></i>' CssClass="cancel-btn"
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
    </div>

    <!-- Add productcategory Modal -->
    <asp:Panel ID="pnlCategoryModal" runat="server" CssClass="modal" Style="display: none;">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="modalTitle">Thêm danh mục sản phẩm</h3>
                <asp:LinkButton ID="btnCloseModal" runat="server" CssClass="close-modal" OnClientClick="closeModal(); return false;">
                <i class="fad fa-times"></i>
                </asp:LinkButton>
            </div>
            <div class="modal-body">

                <asp:HiddenField ID="hfCategoryId" runat="server" />

                <div class="form-group">
                    <label>Tên danh mục</label>
                    <asp:TextBox ID="txtModalTitle" runat="server" CssClass="form-control" />
                </div>

                <div class="form-group">
                    <label>Mô tả</label>
                    <asp:TextBox ID="txtModalDescription" runat="server" CssClass="form-control" />
                </div>

                <div class="form-group">
                    <label>Alias</label>
                    <asp:TextBox ID="txtModalAlias" runat="server" CssClass="form-control" />
                </div>

                <div class="form-actions">
                    <asp:Button ID="btnCancel" runat="server" Text="Thoát" CssClass="cancel-btn" OnClientClick="closeModal(); return false;" />
                    <asp:Button ID="btnSaveCategory" runat="server" Text="Lưu" CssClass="save-btn" OnClick="btnSaveCategory_Click" />
                </div>

            </div>
        </div>
    </asp:Panel>


    <!-- SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script type="text/javascript">
        function deleteFeedback(id) {
            Swal.fire({
                title: 'Bạn có chắc chắn muốn xóa phản hồi này?',
                text: 'Hành động này không thể hoàn tác! Hãy chắc chắn bạn đã đọc kỹ trước khi xóa.',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Xóa',
                cancelButtonText: 'Hủy'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Chuyển hướng đến server để xóa phản hồi
                    window.location.href = 'Contact.aspx?deleteId=' + id;
                }
            });
            return false; // Ngừng hành động mặc định của LinkButton
        }
    </script>

    <!-- JavaScript -->
    <script type="text/javascript">
        function showAddModal() {
            var modal = document.getElementById('<%= pnlCategoryModal.ClientID %>');
            if (modal) modal.style.display = 'flex';
        }

        function hideAddModal() {
            var modal = document.getElementById('<%= pnlCategoryModal.ClientID %>');
            if (modal) modal.style.display = 'none';
        }

        document.addEventListener('DOMContentLoaded', function () {
            var closeBtn = document.getElementById('<%= btnCloseModal.ClientID %>');
            if (closeBtn) {
                closeBtn.addEventListener('click', function () {
                    hideAddModal();
                });
            }
        });
    </script>

</asp:Content>
