<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HomeCT.ascx.cs" Inherits="SellShoe.UserControl.Home" %>

<section id="hero" style="background-image: url(../img/banner1.png)">
    <h4>New Collection</h4>
    <h2>Supper value deals</h2>
    <h1>On all product</h1>
    <a href="sproduct.aspx?id=91" style="background-image: url('../img/button1.png');">XEM NGAY</a>
</section>

<section id="feature" class="section-p1">

    <% foreach (var item in listFT)
        { %>
    <div class="fe-box">
        <img src="<%= item.ImgFeature %>" alt="">
        <h6><%= item.NameFeature %></h6>
    </div>
    <% } %>
</section>

<section id="product-best-seller" class="section-p1 product-section">
    <div class="section_title">
        <h2>BEST SELLER</h2>
    </div>
    <div class="pro-container">

        <% for (int i = 0; i < listSP.Count; i++)
            { %>

        <div class="pro">
            <a href="sproduct.aspx?id=<%= listSP[i].id %>">

                <img src='<%=listSP[i].Image %>' alt="">
                <div class="des">
                    <h5 title="<%=listSP[i].Title %>"><%=listSP[i].Title %></h5>
                    <span class="price-sale"><%= string.Format("{0:N0}", ((int)listSP[i].Price)).Replace(",", ".") %></span>
                    <h4 class="price"><%= string.Format("{0:N0}", ((int)listSP[i].PriceSale)).Replace(",", ".") %></h4>
                    <!-- Xử lý số sao trung bình -->
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
                <a href="sproduct.aspx?id=<%= listSP[i].id %>"><i class="fad fa-wallet cart"></i></a>
        </div>

        <%  }     // end for %>
    </div>
</section>


<!-- Hàng mới -->
<section id="product-new" class="section-p1 product-section">
    <div class="section_title">
        <h2>SẢN PHẨM MỚI</h2>
    </div>

    <!-- Filter Tabs -->
    <div class="filter-tabs">
        <button class="filter-tab active" data-category="all">Tất Cả</button>
        <% foreach (var cat in listCategory)
            { %>
        <button class="filter-tab" data-category="<%= cat.Alias %>"><%= cat.Title %></button>
        <% } %>
    </div>

    <div class="pro-container">

        <% for (int i = 0; i < listNewProducts.Count; i++) {
                if (listNewProducts[i].IsHome) { %>

                    <div class="pro" data-category="<%= GetCategoryAlias(listNewProducts[i].ProductCategoryId)%>">
                        <a href="sproduct.aspx?id=<%= listNewProducts[i].id %>">

                            <img src='<%=listNewProducts[i].Image %>' alt="">
                            <div class="des">
                                <h5><%= listNewProducts[i].Title %></h5>
                                <span class="price-sale"><%= string.Format("{0:N0}", ((int)listNewProducts[i].Price)).Replace(",", ".") %></span>
                                <h4 class="price"><%= string.Format("{0:N0}", ((int)listNewProducts[i].PriceSale)).Replace(",", ".") %></h4>
                                <%
                                    double avgRating = RatingCacheManager.GetRatingByProductId(listNewProducts[i].id);
                                    int fullStars = (int)avgRating;
                                    bool hasHalfStar = (avgRating - fullStars) >= 0.5;
                                    int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
                                %>
                                <div class="star">
                                    <% for (int s = 0; s < fullStars; s++) { %>
                                        <i class="fas fa-star"></i>
                                    <% } %>
                                    <% if (hasHalfStar) { %>
                                        <i class="fas fa-star-half-alt"></i>
                                    <% } %>
                                    <% for (int s = 0; s < emptyStars; s++) { %>
                                        <i class="far fa-star"></i>
                                    <% } %>
                                </div>

                            </div>
                            <a href="sproduct.aspx?id=<%= listNewProducts[i].id %>"><i class="fad fa-wallet cart"></i></a>
                    </div>
             <% } %>
        <% } %>
    </div>
    <!-- Nút Xem Thêm -->
    <div class="show-more-wrapper">
        <a href="Product.aspx" class="show_more">Xem thêm</a>
    </div>
</section>

<!-- xử lý lọc sản phẩm -->
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
    });
</script>




