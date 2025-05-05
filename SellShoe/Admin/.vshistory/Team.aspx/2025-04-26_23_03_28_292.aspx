<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Team.aspx.cs" Inherits="SellShoe.Admin.Team" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
            <tr>
                <th>1</th>
                <th>Giày Nam</th>
                <th>Danh mục giày nam</th>
                <th>giay-nam</th>
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
</asp:Content>
