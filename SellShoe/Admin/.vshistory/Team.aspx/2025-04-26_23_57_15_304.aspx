<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Team.aspx.cs" Inherits="SellShoe.Admin.Team" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Content Card -->
    <div class="content-card">
        <div class="card-header">
            <h2>QUẢN LÝ THÀNH VIÊN</h2>
            <div class="header-actions">
                <div class="search-container">
                    <i class="fal fa-search"></i>
                    <input type="text" placeholder="Search products">
                </div>
                <button class="add-product-btn" id="addProductBtn">Thêm thành viên</button>
            </div>
        </div>

        <div class="table-container">
            <table class="products-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Tên thành viên</th>
                        <th>Vị trí</th>
                        <th>Số điện thoại</th>
                        <th>Email</th>
                        <th>Ảnh</th>
                        <th>Tùy chọn</th>
                    </tr>
                </thead>
                <tbody id="productsTableBody">

                    <%for (int i = 0; i < listTeam.Count; i++)
                        {  %>
                    <tr>
                        <th><%=listTeam[i].Id %></th>
                        <th><%=listTeam[i].FullName %></th>
                        <th><%=listTeam[i].Position %></th>
                        <th><%=listTeam[i].Phone %></th>
                        <th><%=listTeam[i].Email %></th>
                        <th><%=listTeam[i].Avatar %></th>
                        <th class="action-cell">
                            <div class="action-menu" data-id="<%=listTeam[i].Id %>">
                                <button class="action-btn" type="button">
                                    <i class="fad fa-edit"></i>
                                </button>
                                <button class="action-btn" type="button" data-id="<%=listTeam[i].Id %>">
                                    <i class="fal fa-trash"></i>
                                </button>
                            </div>
                        </th>
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

    <!-- Add/Edit Product Modal -->
    <div class="modal" id="teamModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="modalTitle">Thêm thành viên</h3>
                <button class="close-modal" id="closeModal">
                    <i class="fad fa-times"></i>
                </button>
            </div>
            <div class="modal-body">

                <form id="teamForm">
                    <input type="hidden" id="teamId" />

                    <div class="form-group">
                        <label>Tên thành viên</label>
                        <input type="text" id="txtFullName" />
                    </div>
                    <div class="form-group">
                        <label>Vị trí</label>
                        <input type="text" id="txtPosition" />
                    </div>
                    <div class="form-group">
                        <label>Số điện thoại</label>
                        <input type="text" id="txtPhone" />
                    </div>

                    <div class="form-group">
                        <label>Email</label>
                        <input type="text" id="txtEmail" />
                    </div>

                    <div class="form-actions">
                        <button type="button" class="cancel-btn" id="cancelBtn">Thoát</button>
                        <button type="button" class="save-btn" id="saveProductBtn">Lưu</button>
                    </div>
                </form>

            </div>
        </div>
    </div>





</asp:Content>
