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
            <li>
                <i class="fal fa-map-marked-alt"></i>
                <p>Ninh Kiều, Cần Thơ</p>
            </li>
            <li>
                <i class="fal fa-envelope"></i>
                <p>contactg8shoe@gmail.com</p>
            </li>
            <li>
                <i class="fal fa-phone-alt"></i>
                <p>0967 394 474</p>
            </li>
            <li>
                <i class="fal fa-clock"></i>
                <p>9AM - 10PM Thứ 2 đến Thứ 7</p>
            </li>
        </div>
    </div>

    <div class="map">
        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d66380.16296303923!2d105.71628472561622!3d10.034268917924626!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a0629f6de3edb7%3A0x527f09dbfb20b659!2zQ-G6p24gVGjGoSwgTmluaCBLaeG7gXUsIEPhuqduIFRoxqEsIFZp4buHdCBOYW0!5e1!3m2!1svi!2s!4v1744644244119!5m2!1svi!2s" width="600" height="450" style="border: 0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
    </div>
</section>

<section id="form-details">
    <asp:Label ID="lblTitle" runat="server" Text="Gửi phản hồi / báo cáo / góp ý"></asp:Label>
    <h2>Chúng tôi sẽ ghi nhận</h2>

    <asp:TextBox ID="txtName" runat="server" Placeholder="Tên của bạn" CssClass="input-text" required="required"></asp:TextBox>
    <asp:TextBox ID="txtEmail" runat="server" Placeholder="Email" CssClass="input-text" required="required"></asp:TextBox>
    <asp:TextBox ID="txtSubject" runat="server" Placeholder="Chủ đề" CssClass="input-text" required="required"></asp:TextBox>
    <asp:TextBox ID="txtContent" runat="server" TextMode="MultiLine" Placeholder="Nội dung" CssClass="input-textarea" Rows="5" required="required"></asp:TextBox>

    <asp:Button ID="btnSubmit" runat="server" Text="Xác nhận gửi" CssClass="normal"/>


    <div class="people">
        <div>
            <img src="img/people/1.png" alt="">
            <p>
                <span>Trần Ngọc Nhung</span>Lead <br> 
                SDT: 0974387573 <br> Email: contact@gmail.com
            </p>
        </div>

        <div>
            <img src="img/people/1.png" alt="">
            <p>
                <span>Nguyễn Hoàng Kiệt</span>Design FrontEnd <br> 
                SDT: 0974387573 <br> Email: contact@gmail.com
            </p>
        </div>

        <div>
            <img src="img/people/2.png" alt="">
            <p>
                <span>Nguyễn Cảnh Bằng</span>Design Database <br> 
                SDT: 0974387573 <br> Email: contact@gmail.com
            </p>
        </div>

        <div>
            <img src="img/people/3.png" alt="">
            <p>
                <span>Lê Minh Phú</span>BackEnd Developer<br> 
                SDT: 0967 394 474 <br> Email: s236717@nctu.edu.vn
            </p>
        </div>
    </div>
</section>
