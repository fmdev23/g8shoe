<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AboutCT.ascx.cs" Inherits="SellShoe.UserControl.AboutCT" %>
<section id="page-header" class="about-header" style="background-image: url(../img/about/banner.png);">

    <h2>#WeAre</h2>

    <p>Giới thiệu thông tin về chúng tôi</p>

</section>
<section id="about-head" class="section-p1">
    <img src="../img/about/a1.png" alt="">
    <div>
        <h2>Giới thiệu về G8Shoe</h2>
        <p>
            "G8Shoe – Where Every Step Becomes Your Signature. Lightweight Innovation, Timeless Style."<br>
            Every Step Becomes Your Signature: Nhấn mạnh cá tính và sự độc đáo, mỗi bước đi thành dấu ấn riêng.<br>
            Lightweight Innovation: Phù hợp cho cả thể thao và thời trang.<br>
            Timeless Style: Thiết kế sang trọng, vượt xu hướng, đi cùng bạn mọi nơi.<br>
        </p>
        <br>
        <br>
        <marquee bgcolor="#ccc" loop="-1" scrollamount="8" width="100%">
            
            <%for (int i = 0; i < listPeople.Count; i++)
                {  %>
            <%= listPeople[i].FullName + " " + listPeople[i].Position + ". "%>
            <% } %>
        </marquee>

    </div>

</section>

<section id="about-app" class="section-p1">
    <h1>Tải về <a href="">Ứng dụng</a> của chúng tôi</h1>
    <div class="video">
        <video autoplay muted loop src="img/about/1.mp4"></video>
    </div>
</section>
