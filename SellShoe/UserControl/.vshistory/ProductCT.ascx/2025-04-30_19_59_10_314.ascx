<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductCT.ascx.cs" Inherits="SellShoe.UserControl.ProductCT" %>
<section id="page-header" class="shop-header" style="background-image: url(../img/banner/b1.png);">

    <h2>#bestchoice</h2>

    <p>Chúng tôi mang đến sự lựa chọn tốt nhất</p>

</section>
<!-- Hàng mới -->
<section id="product" class="section-p1 product-section">

    <div class="pro-container">

        <% for (int i = 0; i < listSP.Count; i++)
            { %>

        <div class="pro" data-category="<%= GetCategoryAlias(listSP[i].ProductCategoryId)%>">
            <a href="sproduct.aspx?id=<%= listSP[i].id %>">

                <img src='<%=listSP[i].Image %>' alt="">
                <div class="des">
                    <h5><%= listSP[i].Title %></h5>
                    <span class="price-sale"><%= ((int)listSP[i].Price) %></span>
                    <h4 class="price"><%= ((int)listSP[i].PriceSale) %></h4>
                    <%
                        double avgRating = RatingCacheManager.GetRatingByProductId(listSP[i].id);
                        int fullStars = (int)avgRating;
                        bool hasHalfStar = (avgRating - fullStars) >= 0.5;
                        int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
                    %>
                    <div class="star">
                        <% for (int s = 0; s < fullStars; s++)
                            { %>
                        <i class="fas fa-star"></i>
                        <% } %>
                        <% if (hasHalfStar)
                            { %>
                        <i class="fas fa-star-half-alt"></i>
                        <% } %>
                        <% for (int s = 0; s < emptyStars; s++)
                            { %>
                        <i class="far fa-star"></i>
                        <% } %>
                    </div>

                </div>
                <a href="#"><i class="fal fa-cart-plus cart"></i></a>
        </div>

        <% } %>
    </div>

    <!--<div class="pro-container">
        <% for (int i = 0; i < listProductWithRating.Count; i++)
        {
            var avgRating = listProductWithRating[i].AverageRating ?? 0; // Nếu null thì gán 0
            int fullStars = (int)avgRating;
            bool hasHalfStar = (avgRating - fullStars) >= 0.5;
            int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
        %>

        <div class="pro">
            <a href="sproduct.aspx?id=<%= listProductWithRating[i].Product.id %>">
                <img src="<%= listProductWithRating[i].Product.Image %>" alt="">
                <div class="des">
                    <h5><%= listProductWithRating[i].Product.Title %></h5>
                    <span class="price-sale"><%= ((int)listProductWithRating[i].Product.Price) %></span>
                    <h4 class="price"><%= ((int)listProductWithRating[i].Product.PriceSale) %></h4>

                    <div class="star">
                        <% 
        for (int star = 0; star < fullStars; star++)
        { %>
                        <i class="fas fa-star"></i>
                        <% }
        if (hasHalfStar)
        { %>
                        <i class="fas fa-star-half-alt"></i>
                        <% }
        for (int star = 0; star < emptyStars; star++)
        { %>
                        <i class="far fa-star"></i>
                        <% } %>
                    </div>

                </div>
                <a href="#"><i class="fal fa-cart-plus cart"></i></a>
            </a>
        </div>

        <% } %>
    </div>-->

</section>

<section id="pagination" class="section-p1">
    <a href="">1</a>
    <a href="">2</a>
    <a href=""><i class="fal fa-long-arrow-right"></i></a>
</section>

<script src="../js/script.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Rút gọn tên sản phẩm
        document.querySelectorAll(".pro .des h5").forEach(el => {
            const maxLength = 27;
            const text = el.innerText.trim();
            if (text.length > maxLength) {
                el.innerText = text.slice(0, maxLength - 3) + "...";
                el.setAttribute("title", text);
            }
        });

        // Format giá tiền
        document.querySelectorAll('.price, .price-sale').forEach(el => {
            let number = parseInt(el.innerText.replace(/\D/g, ''), 10);
            el.innerText = number.toLocaleString('vi-VN');
        });

    });
</script>
