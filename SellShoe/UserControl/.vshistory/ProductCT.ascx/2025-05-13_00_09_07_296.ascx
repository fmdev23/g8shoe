<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductCT.ascx.cs" Inherits="SellShoe.UserControl.ProductCT" %>
<section id="page-header" class="shop-header" style="background-image: url(../img/banner/b1.png);">

    <h2>#bestchoice</h2>

    <p>Chúng tôi mang đến sự lựa chọn tốt nhất</p>

</section>
<!-- Toàn bộ sản phẩm -->
<section id="product" class="section-p1 product-section">

    <div class="pro-container" id="product-list">
        <% for (int i = 0; i < listProductWithRating.Count; i++)
            {
                var avgRating = listProductWithRating[i].AverageRating ?? 0; // Nếu null thì gán 0
                int fullStars = (int)avgRating;
                bool hasHalfStar = (avgRating - fullStars) >= 0.5;
                int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
        %>

        <div class="pro" data-product> 
            <a href="sproduct.aspx?id=<%= listProductWithRating[i].Product.id %>">
                <img src="<%= listProductWithRating[i].Product.Image %>" alt=""> 
                <div class="des">
                    <h5><%= listProductWithRating[i].Product.Title %></h5>
                    <span class="price-sale"><%= string.Format("{0:N0}", ((int)listProductWithRating[i].Product.Price)).Replace(",", ".") %></span>
                    
                    <h4 class="price"><%= string.Format("{0:N0}", ((int)listProductWithRating[i].Product.PriceSale)).Replace(",", ".") %></h4> 

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
                <a href="sproduct.aspx?id=<%= listProductWithRating[i].Product.id %>"><i class="fad fa-wallet cart"></i></a>
            </a>
        </div>

        <% } %>
    </div>

</section>

<section id="pagination" class="section-p1">
    <div id="pagination-buttons"></div>
</section>


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

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const pageSize = 15;
        const products = document.querySelectorAll('[data-product]');
        const totalProducts = products.length;
        const totalPages = Math.ceil(totalProducts / pageSize);
        const paginationDiv = document.getElementById("pagination-buttons");

        function showPage(page) {
            for (let i = 0; i < totalProducts; i++) {
                products[i].style.display = (i >= (page - 1) * pageSize && i < page * pageSize) ? 'block' : 'none';
            }

            // Update active button
            const buttons = paginationDiv.querySelectorAll('a');
            buttons.forEach(btn => btn.classList.remove('active'));
            if (buttons[page - 1]) buttons[page - 1].classList.add('active');
        }

        function createPagination() {
            for (let i = 1; i <= totalPages; i++) {
                const a = document.createElement("a");
                a.href = "#";
                a.textContent = i;
                a.addEventListener("click", function (e) {
                    e.preventDefault();
                    showPage(i);
                });
                paginationDiv.appendChild(a);
            }
        }

        createPagination();
        showPage(1); // Show first page on load
    });
</script>

