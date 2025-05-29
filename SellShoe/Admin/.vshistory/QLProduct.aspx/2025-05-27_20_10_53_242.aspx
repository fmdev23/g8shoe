<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QLProduct.aspx.cs" Inherits="SellShoe.Admin.QL_Product" %>

<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ADMIN</title>
    <link rel="stylesheet" href="~/Admin/admin.css" />
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" />

    <!-- SweetAlert2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" rel="stylesheet" />

    <!-- SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <div class="app-container">
            <!-- Sidebar -->
            <aside class="sidebar">
                <div class="logo-container">
                    <i class="fad fa-layer-group"></i>
                    <h1>G8Shoe | ADMIN</h1>
                </div>

                <nav class="sidebar-nav">
                    <ul>
                        <li>
                            <a href="Dash.aspx" class="nav-item">
                                <i class="fad fa-th-large"></i>
                                <span>Dữ liệu</span>
                            </a>
                        </li>
                        <li>
                            <a href="ProductCategory.aspx" class="nav-item">
                                <i class="fad fa-list-ul"></i>
                                <span>Danh mục</span>
                            </a>
                        </li>
                        <li>
                            <a href="Product.aspx" class="nav-item">
                                <i class="fad fa-shopping-bag"></i>
                                <span>Sản phẩm</span>
                            </a>
                        </li>
                        <li>
                            <a href="OrderDetail.aspx" class="nav-item">
                                <i class="fad fa-shopping-cart"></i>
                                <span>Đơn hàng</span>
                            </a>
                        </li>
                        <li>
                            <a href="Contact.aspx" class="nav-item">
                                <i class="fad fa-star-half-alt"></i>
                                <span>Phản hồi</span>
                            </a>
                        </li>
                        <li>
                            <a href="Team.aspx" class="nav-item">
                                <i class="fad fa-users"></i>
                                <span>Thành viên</span>
                            </a>
                        </li>
                    </ul>
                    <div class="sidebar-divider"></div>
                    <ul>
                        <li>
                            <asp:LinkButton ID="btnLogout" runat="server" OnClick="btnLogout_Click" CssClass="nav-item">
<i class="fad fa-sign-out"></i>
<span>Đăng xuất</span>
                            </asp:LinkButton>

                        </li>
                    </ul>
                </nav>
            </aside>

            <!-- Main Content -->
            <main class="main-content">
                <!-- Breadcrumb -->
                <div class="breadcrumb">
                    <a href="dash.aspx">Admin</a>
                    <i class="fad fa-chevron-right"></i>
                    <span id="breadcrumbTitle">Đang tải...</span>
                </div>


                <div class="content-card">
                    <div class="card-header">
                        <h2>QUẢN LÝ SẢN PHẨM</h2>
                        <div class="header-actions">
                            <div class="search-container">
                                <i class="fal fa-search"></i>
                                <asp:TextBox ID="txtSearch" runat="server"
                                    placeholder="Tìm sản phẩm"
                                    AutoPostBack="false"
                                    OnTextChanged="txtSearch_TextChanged" />

                            </div>
                            <asp:Button ID="btnAddProduct" runat="server" CssClass="add-product-btn" Text="Thêm sản phẩm"
                                OnClientClick="showAddModal(); return false;" UseSubmitBehavior="false" />
                        </div>
                    </div>


                    <div class="table-container">
                        <asp:DataGrid ID="dgProducts" runat="server"
                            AllowPaging="true" PageSize="10"
                            AutoGenerateColumns="False"
                            PagerStyle-Mode="NumericPages"
                            DataKeyField="id"
                            ClientIDMode="Static"
                            OnPageIndexChanged="dgProducts_PageIndexChanged"
                            OnItemCommand="dgProducts_ItemCommand"
                            OnDeleteCommand="dgProducts_DeleteCommand"
                            CssClass="products-table"
                            BorderWidth="0px"
                            GridLines="None"
                            CellPadding="0"
                            CellSpacing="0"
                            BorderStyle="None">

                            <Columns>
                                <asp:TemplateColumn HeaderText="Ảnh SP">
                                    <ItemTemplate>
                                        <asp:Image ID="imgProduct" runat="server" Width="60" Height="60" Style="border-radius: 50%;" ImageUrl='<%# Eval("Image") %>' />
                                    </ItemTemplate>
                                </asp:TemplateColumn>

                                <asp:TemplateColumn HeaderText="Tên SP">
                                    <ItemTemplate><%# Eval("Title") %></ItemTemplate>
                                </asp:TemplateColumn>

                                <asp:TemplateColumn HeaderText="Mã SP">
                                    <ItemTemplate><%# Eval("ProductCode") %></ItemTemplate>
                                </asp:TemplateColumn>

                                <asp:TemplateColumn HeaderText="Giá hiển thị">
                                    <ItemTemplate><%# string.Format("{0:N0}", Eval("PriceSale")).Replace(",", ".") %></ItemTemplate>
                                </asp:TemplateColumn>

                                <asp:TemplateColumn HeaderText="Số lượng">
                                    <ItemTemplate><%# Eval("Quantity") %></ItemTemplate>
                                </asp:TemplateColumn>

                                <asp:TemplateColumn HeaderText="Hiển thị">
                                    <ItemTemplate><%# Eval("IsActive") %></ItemTemplate>
                                </asp:TemplateColumn>

                                <asp:TemplateColumn HeaderText="New">
                                    <ItemTemplate><%# Eval("IsHome") %></ItemTemplate>
                                </asp:TemplateColumn>

                                <asp:TemplateColumn HeaderText="Danh mục">
                                    <ItemTemplate><%# Eval("CategoryName") %></ItemTemplate>
                                </asp:TemplateColumn>

                                <asp:TemplateColumn HeaderText="Tùy chọn">
                                    <ItemTemplate>
                                        <asp:LinkButton runat="server" CommandName="EditProduct" CommandArgument='<%# Eval("id") %>'
                                            ToolTip="Sửa" Text='<i class="fad fa-edit"></i>' CssClass="btn-icon" />
                                        &nbsp;
                                <asp:LinkButton runat="server" CommandName="Delete" CommandArgument='<%# Eval("id") %>' ToolTip="Xóa"
                                    Text='<i class="fad fa-trash"></i>' CssClass="cancel-btn"
                                    OnClientClick="return confirm('Xóa sản phẩm này?');" />

                                    </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns>

                            <PagerStyle CssClass="pager-style" HorizontalAlign="Center" />
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
                                        <FCKeditorV2:FCKeditor ID="fckDetail" runat="server" Width="100%" Height="300px" BasePath="~/FCKeditor/" ToolbarSet="Basic" />
                                        <!--<asp:TextBox ID="txtDetail" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" />-->
                                    </div>
                                    <div class="form-group">
                                        <label>Chọn ảnh sản phẩm</label>
                                        <asp:FileUpload ID="fuImage" runat="server" CssClass="form-control" />
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

            </main>
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

        <script>
            // Lấy file hiện tại
            const currentPage = window.location.pathname.split("/").pop().toLowerCase();

            document.querySelectorAll('.sidebar .nav-item').forEach(link => {
                const hrefPage = link.getAttribute('href');
                if (hrefPage && hrefPage.toLowerCase() === currentPage) {
                    link.classList.add('active');
                }
            });

            // Tạo map ánh xạ từ file -> tiêu đề breadcrumb
            const breadcrumbMap = {
                'productcategory.aspx': 'Quản lý danh mục sản phẩm',
                'dash.aspx': 'Dữ liệu',
                'product.aspx': 'Quản lý sản phẩm',
                'orderdetail.aspx': 'Thông tin đơn hàng',
                'contact.aspx': 'Phản hồi từ khách hàng',
                'team.aspx': 'Quản lý thành viên',
                'ql_product.aspx': 'Quản lý sản phẩm',
                // Thêm các trang khác nếu cần
            };

            // Hiển thị tiêu đề tương ứng hoặc fallback mặc định
            const breadcrumbTitle = breadcrumbMap[currentPage] || 'Trang không xác định';
            document.getElementById('breadcrumbTitle').textContent = breadcrumbTitle;
        </script>


    </form>


</body>
</html>
