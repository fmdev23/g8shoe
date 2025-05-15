<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OrderInfoCT.ascx.cs" Inherits="SellShoe.UserControl.OrderInfoCT" %>

<div class="header-border"></div>
<div class="container">
    <div class="delivery-info">
        <div class="recipient-info">
            <h2 class="recipient-title">Thông tin nhận hàng</h2>
            <asp:Label ID="lblRecipientName" runat="server" CssClass="recipient-name" /><br />
            <asp:Label ID="lblPhone" runat="server" CssClass="recipient-phone" /><br />
            <asp:Label ID="lblAddress" runat="server" CssClass="recipient-address" />
            <div class="recipient-detail">
                <asp:Image ID="imgProduct" runat="server" Width="130px" Height="130px" />
            </div>
            <asp:Label ID="lblProductTitle" runat="server" /><br />
            <asp:Label ID="lblQuantity" runat="server" /><br />
            <asp:Label ID="lblSize" runat="server" /><br />
            <asp:Label ID="lblPayment" runat="server" /><br />
        </div>

        <div class="tracking-info">
            <div class="tracking-number">Mã đơn hàng</div>
            <asp:Label ID="lblOrderCode" runat="server" CssClass="express-label" />

            <div class="tracking-timeline">
                <asp:Repeater ID="rptTimeline" runat="server">
                    <ItemTemplate>
                        <div class="timeline-item">
                            <div class='<%# (bool)Eval("IsActive") ? "timeline-dot active" : "timeline-dot" %>'></div>
                            <%-- timeline-line nếu là item đầu tiên --%>
                            <div class="timeline-line"></div>
                            <div class="timeline-content">
                                <div class="timeline-time"><%# Eval("CreatedAt", "{0:HH:mm dd-MM-yyyy}") %></div>
                                <div class="timeline-status"><%# Eval("StatusTitle") %></div>
                                <div class="timeline-status"><%# Eval("StatusDetail") %></div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</div>

