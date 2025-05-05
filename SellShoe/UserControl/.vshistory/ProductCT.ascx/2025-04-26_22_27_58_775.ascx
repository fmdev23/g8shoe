<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductCT.ascx.cs" Inherits="SellShoe.UserControl.ProductCT" %>
<section id="page-header" class="shop-header" style="background-image: url(../img/banner/b1.png);">

    <h2>#bestchoice</h2>

    <p>Chúng tôi mang đến sự lựa chọn tốt nhất</p>

</section>
<!-- Hàng mới -->
<section id="product1" class="section-p1">
    <div class="pro-container">

        <div class="pro-container">
            <% for (int i = 0; i < ProductCT.listSP.Count; i++)
                { %>
            <div class="pro">
                <img src="<%= ProductCT.listSP[i].Image %>" alt="">
                <div class="des">
                    <h5><%= ProductCT.listSP[i].ProductName %></h5>
                    <span><%= string.Format("{0:N0}", ProductCT.listSP[i].Price) %> đ</span>
                    <div class="star">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                    </div>
                </div>
                <a href="#"><i class="fal fa-cart-plus cart"></i></a>
            </div>
            <% } %>
        </div>



    </div>
</section>

<section id="pagination" class="section-p1">
    <a href="">1</a>
    <a href="">2</a>
    <a href=""><i class="fal fa-long-arrow-right"></i></a>
</section>
