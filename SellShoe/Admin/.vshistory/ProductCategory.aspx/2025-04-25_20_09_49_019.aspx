<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ProductCategory.aspx.cs" Inherits="SellShoe.Admin.ProductCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Content Card -->
    <div class="content-card">
        <div class="card-header">
            <h2>QUẢN LÝ DANH MỤC SẢN PHẨM</h2>
            <div class="header-actions">
                <div class="search-container">
                    <i class="fal fa-search"></i>
                    <input type="text" placeholder="Search products">
                </div>
                <button class="add-product-btn" id="addProductBtn">Thêm danh mục</button>
            </div>
        </div>

        <div class="table-container">
            <table class="products-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Tên danh mục</th>
                        <th>Mô tả</th>
                        <th>Alias</th>
                        <th>Tùy chọn</th>
                    </tr>
                </thead>
                <tbody id="productsTableBody">
                    
                    <%for (int i = 0; i < listCategory.Count; i++)
                        { %>
                    <tr>
                        <th><%=listCategory[i].id %></th>
                        <th><%= listCategory[i].Title %></th>
                        <th><%=listCategory[i].Description %></th>
                        <th><%=listCategory[i].Alias %></th>
                        <th class="action-cell">
                            <div class="action-menu" data-id="1">
                                <button class="action-btn">
                                    <i class="fad fa-edit"></i>
                                </button>
                                <button class="action-btn">
                                    <i class="fal fa-trash"></i>
                                </button>
                            </div>
                        </th>
                    </tr>
                    
                    <% } %>

                    <tr>
                        <th>2</th>
                        <th>Giày Nữ</th>
                        <th>Danh mục giày nữ</th>
                        <th>giay-nu</th>
                        <th class="action-cell">
                            <div class="action-menu" data-id="1">
                                <button class="action-btn">
                                    <i class="fad fa-edit"></i>
                                </button>
                                <button class="action-btn">
                                    <i class="fal fa-trash"></i>
                                </button>
                            </div>
                        </th>
                    </tr>
                    <tr>
                        <th>3</th>
                        <th>Phụ Kiện</th>
                        <th>Danh mục phụ kiện</th>
                        <th>phu-kien</th>
                        <th class="action-cell">
                            <div class="action-menu" data-id="1">
                                <button class="action-btn">
                                    <i class="fad fa-edit"></i>
                                </button>
                                <button class="action-btn">
                                    <i class="fal fa-trash"></i>
                                </button>
                            </div>
                        </th>
                    </tr>
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
    </div>
</asp:Content>
