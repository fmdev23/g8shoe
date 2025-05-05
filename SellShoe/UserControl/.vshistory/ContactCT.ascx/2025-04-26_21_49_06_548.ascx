<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ContactCT.ascx.cs" Inherits="SellShoe.UserControl.ContactCT" %>

<section id="page-header" class="contact-header" style="background-image: url(../img/banner/2.png);">

    <h2>#contact</h2>

    <p>Gửi cho chúng tôi trải nghiệm của bạn. Chúng tôi sẽ ghi nhận</p>

</section>

<section id="contact-details" class="section-p1">
    <div class="details">
        <span>THÔNG TIN LIÊN HỆ</span>
        <h2>G8Shoe luôn sẵn sàng hỗ trợ</h2>
        <h3>Liên hệ trực tiếp hoặc online</h3>
        
        <div>
            <%for (int i = 0; i < listInfo.Count; i++)
                {  %>
            <li>
                <i class="fal fa-map-marked-alt"></i>
                <p><%=listInfo[i].Address %></p>
            </li>


            <li>
                <i class="fal fa-envelope"></i>
                <p><%= listInfo[i].Email %></p>
            </li>
            <li>
                <i class="fal fa-phone-alt"></i>
                <p><%=listInfo[i].Phone %></p>
            </li>
            <li>
                <i class="fal fa-clock"></i>
                <p><%= listInfo[i].WorkHours %></p>
            </li>
        </div>
        <% } %>
    
    
    </div>

    <div class="map">
        <% if (listInfo.Count > 0) { %>
            <iframe 
                src="<%= listInfo[0].GoogleMapUrl %>" 
                width="600" 
                height="450" 
                style="border:0;" 
                allowfullscreen="" 
                loading="lazy" 
                referrerpolicy="no-referrer-when-downgrade">
            </iframe>
        <% } %>
    </div>
</section>

<section id="form-details">
    <div class="submit_form">
        <span>Gửi phản hồi / báo cáo / góp ý</span>
        <h2>Chúng tôi luôn ghi nhận những ý kiến của khách hàng</h2>

        <asp:TextBox ID="txtName" runat="server" placeholder="Tên của bạn" CssClass="form-control" required="required"></asp:TextBox>
        <asp:TextBox ID="txtEmail" runat="server" placeholder="Email" CssClass="form-control" required="required"></asp:TextBox>
        <asp:TextBox ID="txtSubject" runat="server" placeholder="Chủ đề" CssClass="form-control" required="required"></asp:TextBox>
        <asp:TextBox ID="txtContent" runat="server" TextMode="MultiLine" placeholder="Nội dung" CssClass="form-control" Rows="5" required="required"></asp:TextBox>

        <asp:Button ID="btnSubmit" runat="server" Text="Xác nhận gửi" CssClass="normal action-btn" OnClick="btnSubmit_Click"/>

        <!-- Thêm Label báo kết quả -->
        <asp:Label ID="lblMessage" runat="server" CssClass="text-success" />
    </div>

    <div class="people">

        <%for (int i = 0; i < listTV.Count; i++)
            { %>
        <div>
            <img src='<%=listTV[i].Avatar %>' alt="">
            <p>
                <span><%=listTV[i].FullName %></span><%= listTV[i].Position %>
                <br>
                SDT: <%=listTV[i].Phone %>
                <br>
                Email: <%=listTV[i].Email  %>
            </p>
        </div>
        <% } %>
    </div>

</section>