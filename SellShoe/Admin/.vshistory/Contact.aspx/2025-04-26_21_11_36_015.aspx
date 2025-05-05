<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="SellShoe.Admin.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Content Card -->
    <div class="content-card">
        <div class="card-header">
            <h2>QUẢN LÝ DANH MỤC SẢN PHẨM</h2>
            <div class="header-actions">
                <button type="button" class="add-product-btn" id="addProductBtn">Thêm danh mục</button>
            </div>
        </div>

        <div class="table-container">
            <asp:Repeater ID="rptCategory" runat="server">
                <HeaderTemplate>
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
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("id") %></td>
                        <td><%# Eval("Title") %></td>
                        <td><%# Eval("Description") %></td>
                        <td><%# Eval("Alias") %></td>
                        <td class="action-cell">
                            <div class="action-menu" data-id='<%# Eval("id") %>'>
                                <button type="button" class="action-btn">
                                    <i class="fad fa-edit"></i>
                                </button>
                                <button type="button" class="action-btn">
                                    <i class="fal fa-trash"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody>
    </table>
                </FooterTemplate>
            </asp:Repeater>

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
</asp:Content>
