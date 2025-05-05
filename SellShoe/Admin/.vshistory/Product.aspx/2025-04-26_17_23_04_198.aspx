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
                        <th>Danh mục</th>
                        <th>Tùy chọn</th>
                    </tr>
                </thead>
                <tbody>

                    <%for (int i = 0; i < listSP.Count; i++)
                        {  %>
                    <tr>
                        <th><%=listSP[i].id %></th>
                        <th><%= listSP[i].Image %></th>
                        <th><%=listSP[i].Title %></th>
                        <th><%=listSP[i].ProductCode %></th>
                        <th><%=((int)listSP[i].PriceSale) %></th>
                        <th><%=listSP[i].Quantity %></th>
                        <th><%= listSP[i].IsHot %></th>
                        <th><%=listSP[i].IsHome %></th>
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
    </div>

    <script>
    document.addEventListener("DOMContentLoaded", function () {
        // Format giá tiền
        document.querySelectorAll('.price, .price-sale').forEach(el => {
            let number = parseInt(el.innerText.replace(/\D/g, ''), 10);
            el.innerText = number.toLocaleString('vi-VN');
        });

    });
    </script>

</asp:Content>
