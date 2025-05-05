<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="SellShoe.Admin.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Content Card -->
    <div class="content-card">
        <div class="card-header">
            <h2>PHẢN HỒI / GÓP Ý / ĐÁNH GIÁ</h2>
            <div class="header-actions">
            </div>
        </div>

        <div class="table-container">

            <table class="products-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Tên khách hàng</th>
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
</asp:Content>
