<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SproductCT.ascx.cs" Inherits="SellShoe.UserControl.SproductCT" %>
<section id="prodetails" class="section-p1">
    <!-- Hình ảnh sản phẩm -->
    <div class="single-pro-image">
        <img src="<%= sanPham != null ? sanPham.Image : "" %>" width="100%" id="MainImg" alt="">
        <div class="small-img-group">
            <div class="small-img-col">
                <img src="<%= sanPham != null ? sanPham.Image : "" %>" width="100%" class="small-img" alt="">
            </div>
            <div class="small-img-col">
                <img src="<%= sanPham != null ? sanPham.Image : "" %>" width="100%" class="small-img" alt="">
            </div>
            <div class="small-img-col">
                <img src="<%= sanPham != null ? sanPham.Image : "" %>" width="100%" class="small-img" alt="">
            </div>
        </div>
    </div>

    <!-- Thông tin sản phẩm -->
    <div class="single-pro-details">
        <div class="breadcrumbs">
            <a href="home.aspx"><span>Trang Chủ</span></a>
            <i class="fad fa-chevron-right"></i>
            <span><%= danhMuc != null ? danhMuc.Title : "" %></span>
            <i class="fad fa-chevron-right"></i>
            <span class="current"><%= sanPham != null ? sanPham.Title : "" %></span>
        </div>

        <h2><%= sanPham != null ? sanPham.Title : "" %></h2>
        <input type="hidden" id="productId" value='<%= sanPham != null ? sanPham.id.ToString() : "" %>' />
        <div class="price-box">
            <span class="old-price"><%= sanPham != null ? ((int)sanPham.Price).ToString("N0") + "" : ""%></span>
            <span class="new-price"><%= sanPham != null ? ((int)sanPham.PriceSale).ToString("N0") + "" : ""%></span>
        </div>

        <%
            double avgRating = RatingCacheManager.GetRatingByProductId(sanPham.id);
            int fullStars = (int)avgRating;
            bool hasHalfStar = (avgRating - fullStars) >= 0.5;
            int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
        %>
        <div class="stars">
            <% for (int star = 0; star < fullStars; star++)
                { %>
            <i class="fas fa-star"></i>
            <% } %>
            <% if (hasHalfStar)
                { %>
            <i class="fas fa-star-half-alt"></i>
            <% } %>
            <% for (int star = 0; star < emptyStars; star++)
                { %>
            <i class="far fa-star"></i>
            <% } %>
        </div>


        <!-- HiddenField ASP.NET để lưu productId -->
        <asp:HiddenField ID="hfProductId" runat="server" />

        <!-- Chọn size -->
        <div class="size-group">
            <span class="size-option active">36</span>
            <span class="size-option">37</span>
            <span class="size-option">38</span>
            <span class="size-option">39</span>
            <span class="size-option">40</span>
            <span class="size-option">41</span>
            <span class="size-option">42</span>
        </div>

        <!-- Chọn số lượng + nút giỏ -->
        <div class="quantity">
            <div class="quantity_selector">
                <span class="minus"><i class="fa fa-minus" aria-hidden="true"></i></span>
                <span id="quantity_value">1</span>
                <span class="plus"><i class="fa fa-plus" aria-hidden="true"></i></span>
            </div>
            <div class="red_button add_to_cart_button">
                <a href="#" class="normal" id="btnOrderClient">Đặt hàng</a>
            </div>
        </div>

        <!-- Form ẩn để gửi dữ liệu qua server -->
        <form id="orderForm" method="post" action="sproductct.ascx">
            <input type="hidden" name="hfSelectedSize" id="hfSelectedSize" />
            <input type="hidden" name="hfQuantity" id="hfQuantity" />
            <asp:Button ID="btnOrderServer" runat="server" OnClick="btnOrderServer_Click" Style="display: none;" />
        </form>



        <h4>Mô tả sản phẩm</h4>
        <p><%=sanPham.Description %></p>
    </div>
</section>


<!-- Product Information Tabs -->
<section class="product-tabs section-p1">
    <div class="tabs-header">
        <button class="tab-btn active" data-tab="products-details">Thông tin sản phẩm</button>
        <button class="tab-btn " data-tab="customer-reviews">Đánh giá</button>
    </div>
    <div class="tab-content">
        <div class="tab-pane active" id="products-details">

            <h3>Size</h3>
            <p>Nhiều lựa chọn size</p>

            <h3>Mô tả sản phẩm</h3>
            <p>Mã sản phẩm (SKU): <%=sanPham.ProductCode %></p>
            <p>GIÁ GỐC: <%=((int)sanPham.Price) %></p>
            <p>SỐ LƯỢNG HÀNG CÓ SẴN: <%=sanPham.Quantity + " Đôi"%></p>
            <p><%=sanPham.Description %></p>
            <div>
                <%=sanPham.Detail %>
            </div>
        </div>

        <div class="tab-pane" id="customer-reviews">

            <section class="review-section">
                <div class="review-container">
                    <!-- Danh sách review -->
                    <div class="review-list" id="reviewList">
                        <% for (int i = 0; i < listRV.Count; i++)
                            {
                                if (listRV[i].ProductId == sanPham.id)
                                { %>
                        <div class="review-item">
                            <div class="review-avatar">
                                <img class="review-avatar" src="../img/user.jpg" />
                            </div>
                            <div class="review-content">
                                <p class="review-date">
                                    <%= listRV[i].CreatedAt.HasValue ? listRV[i].CreatedAt.Value.ToString("dd/MM/yyyy") : "" %>
                                </p>
                                <p class="review-name">
                                    <%= listRV[i].ReviewerName %>
                                </p>
                                <div class="review-stars">
                                    <% 
                                        int rating = listRV[i].Rating;
                                        for (int star = 1; star <= 5; star++)
                                        {
                                            if (star <= rating)
                                            { %>
                                    <i class="fas fa-star"></i>
                                    <% }
                                        else
                                        { %>
                                    <i class="far fa-star"></i>
                                    <% }
                                        } %>
                                </div>
                                <p class="review-text">
                                    <%= listRV[i].ReviewText %>
                                </p>
                            </div>
                        </div>
                        <% }
                            } %>
                    </div>

                    <!-- Form thêm review -->
                    <div class="review-form">
                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <h3>Thêm đánh giá sản phẩm</h3>
                        <asp:TextBox ID="txtReviewerName" runat="server" Placeholder="Tên của bạn"></asp:TextBox><br />
                        <asp:TextBox ID="txtReviewerEmail" runat="server" Placeholder="Email" TextMode="Email"></asp:TextBox><br />

                        <div class="rating-label">
                            <label>Đánh giá:</label>
                            <asp:HiddenField ID="hfRating" runat="server" />
                            <div class="star-rating" id="starRating">
                                <i class="far fa-star" data-value="1"></i>
                                <i class="far fa-star" data-value="2"></i>
                                <i class="far fa-star" data-value="3"></i>
                                <i class="far fa-star" data-value="4"></i>
                                <i class="far fa-star" data-value="5"></i>
                            </div>
                        </div>

                        <asp:TextBox ID="txtReviewText" runat="server" Placeholder="Đánh giá của bạn" TextMode="MultiLine" Rows="3"></asp:TextBox><br />

                        <asp:Button ID="btnSubmitReview" runat="server" Text="Gửi đánh giá" CssClass="submit-btn" OnClick="btnSubmitReview_Click" />
                    </div>

                </div>

            </section>

        </div>
    </div>
</section>


<section id="product-best-seller" class="section-p1 product-section">
    <div class="section_title">
        <h2>DÀNH CHO BẠN</h2>
    </div>
    <div class="pro-container">

        <% for (int i = 0; i < listSP.Count; i++)
            { %>

        <div class="pro">
            <a href="sproduct.aspx?id=<%= listSP[i].id %>">
                <img src='<%=listSP[i].Image %>' alt="">

                <div class="des">
                    <h5 title="<%=listSP[i].Title %>"><%=listSP[i].Title %></h5>
                    <span class="price-sale"><%=((int)listSP[i].Price) %></span>
                    <h4 class="price"><%=((int)listSP[i].PriceSale) %></h4>
                    <%
                        double avgRatingBS = RatingCacheManager.GetRatingByProductId(listSP[i].id);
                        int fullStarsBS = (int)avgRatingBS;
                        bool hasHalfStarBS = (avgRatingBS - fullStarsBS) >= 0.5;
                        int emptyStarsBS = 5 - fullStarsBS - (hasHalfStarBS ? 1 : 0);
                    %>
                    <div class="stars">
                        <% for (int star = 0; star < fullStarsBS; star++)
                            { %>
                        <i class="fas fa-star"></i>
                        <% } %>
                        <% if (hasHalfStarBS)
                            { %>
                        <i class="fas fa-star-half-alt"></i>
                        <% } %>
                        <% for (int star = 0; star < emptyStarsBS; star++)
                            { %>
                        <i class="far fa-star"></i>
                        <% } %>
                    </div>

                </div>
                <a href="sproduct.aspx?id=<%= listSP[i].id %>"><i class="fad fa-wallet cart"></i></a>
        </div>

        <%
            }     // end for %>
    </div>
</section>

<script type="text/javascript">
    var isLoggedIn = <%= Session["user"] != null ? "true" : "false" %>;
</script>

<script>
    var MainImg = document.getElementById("MainImg");
    var smallimg = document.getElementsByClassName("small-img");

    smallimg[0].onclick = function () {
        MainImg.src = smallimg[0].src;
    }

    smallimg[1].onclick = function () {
        MainImg.src = smallimg[1].src;
    }

    smallimg[2].onclick = function () {
        MainImg.src = smallimg[2].src;
    }

    smallimg[3].onclick = function () {
        MainImg.src = smallimg[3].src;
    }
</script>


<!-- hiện popup thông báo đã gửi đánh giá thành công -->
<script type="text/javascript">
    function showSuccessToast() {
        Swal.fire({
            icon: 'success',
            title: 'Gửi đánh giá thành công!',
            showConfirmButton: false,
            timer: 5000
        });
    }
</script>

<!-- xử lý rating -->
<script>
    const stars = document.querySelectorAll('#starRating i');
    const ratingField = document.getElementById('<%= hfRating.ClientID %>');

    stars.forEach(star => {
        star.addEventListener('click', function () {
            const rating = this.getAttribute('data-value');
            ratingField.value = rating;

            // Đổi màu sao
            stars.forEach(s => {
                if (parseInt(s.getAttribute('data-value')) <= rating) {
                    s.classList.remove('far');
                    s.classList.add('fas');
                } else {
                    s.classList.remove('fas');
                    s.classList.add('far');
                }
            });
        });
    });
</script>

<script>
    // Xử lý chọn size
    const sizeOptions = document.querySelectorAll('.size-option');
    let selectedSize = document.querySelector('.size-option.active')?.textContent;

    sizeOptions.forEach(option => {
        option.addEventListener('click', () => {
            sizeOptions.forEach(o => o.classList.remove('active'));
            option.classList.add('active');
            selectedSize = option.textContent;
        });
    });

    // Xử lý tăng/giảm số lượng
    const minusBtn = document.querySelector('.minus');
    const plusBtn = document.querySelector('.plus');
    const quantityValue = document.getElementById('quantity_value');

    let quantity = parseInt(quantityValue.textContent);

    minusBtn.addEventListener('click', () => {
        if (quantity > 1) {
            quantity--;
            quantityValue.textContent = quantity;
        }
    });

    plusBtn.addEventListener('click', () => {
        quantity++;
        quantityValue.textContent = quantity;
    });

    // Xử lý click Đặt hàng
    const btnOrderClient = document.getElementById('btnOrderClient');
    btnOrderClient.addEventListener('click', (e) => {
        e.preventDefault();

        if (!isLoggedIn) {
            Swal.fire({
                icon: 'warning',
                title: 'Bạn cần đăng nhập để đặt hàng!',
                showConfirmButton: true,
                confirmButtonText: 'Đăng nhập ngay'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = 'useraccount.aspx';
                }
            });
            return;
        }

        // Gán giá trị vào input hidden
        document.getElementById('hfSelectedSize').value = selectedSize;
        document.getElementById('hfQuantity').value = quantity;

        // Submit form để xử lý ở server (btnOrderServer_Click)
        document.getElementById('<%= btnOrderServer.ClientID %>').click();
    });


    //Xử lý click các tab
    document.addEventListener("DOMContentLoaded", function () {
        const tabButtons = document.querySelectorAll(".tab-btn");
        const tabPanes = document.querySelectorAll(".tab-pane");

        tabButtons.forEach(button => {
            button.addEventListener("click", function (e) {
                e.preventDefault(); // CHẶN reload trang !!!

                // Remove active ở tất cả button
                tabButtons.forEach(btn => btn.classList.remove("active"));

                // Remove active ở tất cả content
                tabPanes.forEach(pane => pane.classList.remove("active"));

                // Add active cho button được click
                this.classList.add("active");

                // Lấy id tab cần mở
                const tabId = this.getAttribute("data-tab");

                // Thêm active cho tab-pane tương ứng
                document.getElementById(tabId).classList.add("active");
            });
        });
    });

    //rút gọn tên sản phẩm và format giá tiền
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
        document.querySelectorAll('.price, .price-sale, .old-price, .new-price').forEach(el => {
            let number = parseInt(el.innerText.replace(/\D/g, ''), 10);
            el.innerText = number.toLocaleString('vi-VN');
        });

    });
</script>
