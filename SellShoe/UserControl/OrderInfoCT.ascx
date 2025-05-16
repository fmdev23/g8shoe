<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OrderInfoCT.ascx.cs" Inherits="SellShoe.UserControl.OrderInfoCT" %>

<div class="container1">
    <!-- Panel hiển thị khi không có đơn hàng -->
    <asp:Panel ID="pnlNoOrder" runat="server" Visible="false" CssClass="no-order-panel">
        <p>
            Hiện tại bạn chưa có đơn hàng nào, 
           <a href="Product.aspx" class="shop-now-link">mua sắm ngay nhé!</a>
        </p>
    </asp:Panel>

    <!-- Panel hiển thị thông tin đơn hàng -->
    <asp:Panel ID="pnlOrderInfo" runat="server">
        <div class="header-border"></div>
        <div class="delivery-info">
            <div class="recipient-info">
                <h2 class="recipient-title">Thông tin nhận hàng</h2>
                <asp:Label ID="lblRecipientName" runat="server" CssClass="recipient-name" /><br />
                SDT:
                <asp:Label ID="lblPhone" runat="server" CssClass="recipient-phone" /><br />
                Địa chỉ:
                <asp:Label ID="lblAddress" runat="server" CssClass="recipient-address" />
                <div class="recipient-detail">
                    <asp:Image ID="imgProduct" runat="server" Width="130px" Height="130px" />
                </div>

                Tên sản phẩm:
                <asp:Label ID="lblProductTitle" runat="server" /><br />

                Số lượng:
                <asp:Label ID="lblQuantity" runat="server" /><br />

                Size:
                <asp:Label ID="lblSize" runat="server" /><br />
                <asp:Label ID="lblPayment" runat="server" /><br />
            </div>

            <div class="tracking-info">
                <div class="tracking-number">Mã đơn hàng</div>
                <asp:Label ID="lblOrderCode" runat="server" CssClass="express-label" />

                <div class="tracking-timeline">
                    <asp:Repeater ID="rptTimeline" runat="server">
                        <ItemTemplate>
                            <div class='timeline-item <%# !(bool)Eval("IsActive") ? "normal" : "" %>'>
                                <div class='timeline-dot <%# (bool)Eval("IsActive") ? "active" : "" %>'></div>
                                <div class="timeline-line"></div>
                                <div class="timeline-content">
                                    <div class="timeline-time"><%# Eval("CreatedAt", "{0:HH:mm dd-MM-yyyy}") %></div>
                                    <div class='timeline-status <%# !(bool)Eval("IsActive") ? "normal" : "" %>'><%# Eval("StatusTitle") %></div>
                                    <div class='timeline-status <%# !(bool)Eval("IsActive") ? "normal" : "" %>'><%# Eval("StatusDetail") %></div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
            <div class="del-order">
                <asp:LinkButton
                    ID="btnCancelOrder"
                    runat="server"
                    CssClass="delete-order-btn"
                    OnClick="btnCancelOrder_Click"
                    OnClientClick="return false;">
                    <i class="fad fa-trash"></i>
                </asp:LinkButton>

            </div>
        </div>
    </asp:Panel>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const btn = document.getElementById("<%= btnCancelOrder.ClientID %>");
        if (btn) {
            btn.addEventListener("click", function (e) {
                e.preventDefault(); // chặn postback gốc

                Swal.fire({
                    title: "Bạn chắc chắn?",
                    text: "Hủy đơn rồi là không khôi phục được đâu nha!",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#ed7d8c",
                    cancelButtonColor: "#004aad",
                    confirmButtonText: "Hủy luôn!",
                    cancelButtonText: "Không"
                }).then((result) => {
                    if (result.isConfirmed) {
                        __doPostBack('<%= btnCancelOrder.UniqueID %>', '');
                    }
                });
            });
        }
    });
    </script>



</div>

