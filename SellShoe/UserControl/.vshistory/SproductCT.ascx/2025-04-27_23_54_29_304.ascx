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
            <a href="home.aspx"><span>Trang chủ</span></a>
            <i class="fad fa-chevron-right"></i>
            <span><%= danhMuc != null ? danhMuc.Title : "" %></span>
            <i class="fad fa-chevron-right"></i>
            <span class="current"><%= sanPham != null ? sanPham.Title : "" %></span>
        </div>

        <h2><%= sanPham != null ? sanPham.Title : "" %></h2>
        <div class="price-box">
            <span class="old-price"><%= sanPham != null ? ((int)sanPham.PriceSale).ToString("N0") + "" : ""%></span>
            <span class="new-price"><%= sanPham != null ? ((int)sanPham.PriceSale).ToString("N0") + "" : ""%></span>
        </div>

        <div class="stars">
            <i class="fa fa-star" aria-hidden="true"></i>
            <i class="fa fa-star" aria-hidden="true"></i>
            <i class="fa fa-star" aria-hidden="true"></i>
            <i class="fa fa-star" aria-hidden="true"></i>
            <i class="fa fa-star" aria-hidden="true"></i>
        </div>

        <!-- Chọn size -->
        <div class="size-group">
            <span class="size-option active">36</span>
            <span class="size-option">37</span>
            <span class="size-option">38</span>
            <span class="size-option">39</span>
            <span class="size-option">40</span>
        </div>

        <!-- Chọn số lượng + nút giỏ -->
        <div class="quantity">
            <!-- <span>Số lượng:</span> -->
            <div class="quantity_selector">
                <span class="minus"><i class="fa fa-minus" aria-hidden="true"></i></span>
                <span id="quantity_value">1</span>
                <span class="plus"><i class="fa fa-plus" aria-hidden="true"></i></span>
            </div>
            <div class="red_button add_to_cart_button"><a href="#">Thêm vào giỏ hàng</a></div>
        </div>


        <h4>Mô tả sản phẩm</h4>
        <% if (sanPham != null && !String.IsNullOrEmpty(sanPham.Description))
            { %>
        <p><%= sanPham.Description %></p>
        <% }
            else
            { %>
        <p>Đang cập nhật mô tả sản phẩm...</p>
        <% } %>
    </div>
</section>

<!-- Product Information Tabs -->
<section class="product-tabs section-p1">
    <div class="tabs-header">
        <button class="tab-btn active" data-tab="products-details">Thông tin sản phẩm</button>
        <button class="tab-btn" data-tab="customer-photos">Hình ảnh</button>
        <button class="tab-btn" data-tab="customer-reviews">Đánh giá</button>
    </div>
    <div class="tab-content">
        <div class="tab-pane" id="products-details">
            <p>Thông tin</p>

            <h3>Size & Fit</h3>
            <p>Nhiều lựa chọn size</p>

            <h3>Material & Care</h3>
            <p>Material: Cotton</p>
            <p>Machine-wash</p>
        </div>


        <div class="tab-pane" id="customer-photos">
            <p>Photo here</p>
        </div>

        <div class="tab-pane active" id="customer-reviews">

            <section class="review-section">
                <div class="review-container">
                    <!-- Cột trái: Danh sách review -->
                    <div class="review-list">
                        <% for (int i = 0; i < listRV.Count; i++)
                            { %>
                        <div class="review-item">
                            <div class="review-avatar"></div>
                            <div class="review-content">
                                <p class="review-date">
                                    <%= listRV[i].CreatedDate.HasValue ? listRV[i].CreatedDate.Value.ToString("dd/MM/yyyy") : "" %>
                                </p>
                                <p class="review-name">
                                    <%= listRV[i].ReviewerName %>
                                </p>
                                <div class="review-stars">
                                    <% 
                                        int rating = listRV[i].Rating ?? 0;
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
                                        }
                                    %>
                                </div>
                                <p class="review-text">
                                    <%= listRV[i].Content %>
                                </p>
                            </div>
                        </div>
                        <% } %>
                    </div>


                    <!-- Cột phải: Form đánh giá -->
                    <div class="review-form">
                        <h3>Thêm đánh giá sản phẩm</h3>
                        <input type="text" id="reviewerName" placeholder="Tên của bạn" />
                        <input type="email" id="reviewerEmail" placeholder="Email" />
                        <div class="rating-label">
                            <label>Đánh giá:</label>
                            <div class="star-rating" id="starRating">
                                <i class="far fa-star" data-value="1"></i>
                                <i class="far fa-star" data-value="2"></i>
                                <i class="far fa-star" data-value="3"></i>
                                <i class="far fa-star" data-value="4"></i>
                                <i class="far fa-star" data-value="5"></i>
                            </div>
                        </div>
                        <textarea id="reviewText" placeholder="Đánh giá của bạn" rows="2" cols="2"></textarea>
                        <button id="submitReviewBtn" class="submit-btn">Thêm đánh giá</button>
                    </div>

                </div>
            </section>

        </div>
    </div>
</section>

<section id="product-best-seller" class="section-p1 product-section">
    <div class="section_title">
        <h2>BEST SELLER</h2>
    </div>
    <div class="pro-container">

        <% for (int i = 0; i < listSP.Count; i++)
            {
                if (listSP[i].IsHot)
                { %>

        <div class="pro">
            <a href="sproduct.aspx?id=<%= listSP[i].id %>">
                <img src='<%=listSP[i].Image %>' alt="">

                <div class="des">
                    <h5 title="<%=listSP[i].Title %>"><%=listSP[i].Title %></h5>
                    <span class="price-sale"><%=((int)listSP[i].Price) %></span>
                    <h4 class="price"><%=((int)listSP[i].PriceSale) %></h4>
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

        <%  } // end if
            }     // end for %>
    </div>
</section>

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

    // Xử lý thêm vào giỏ hàng
    const addToCartBtn = document.querySelector('.add_to_cart_button a');

    addToCartBtn.addEventListener('click', (e) => {
        e.preventDefault(); // Ngăn điều hướng link
        alert(`Đã thêm vào giỏ hàng\nSize: ${selectedSize}\nSố lượng: ${quantity}`);
    });

    //Xử lý click các tab
    document.addEventListener('DOMContentLoaded', function () {
        // Tab functionality
        const tabBtns = document.querySelectorAll('.tab-btn');
        const tabPanes = document.querySelectorAll('.tab-pane');

        tabBtns.forEach(btn => {
            btn.addEventListener('click', function () {
                // Remove active class from all buttons and panes
                tabBtns.forEach(btn => btn.classList.remove('active'));
                tabPanes.forEach(pane => pane.classList.remove('active'));

                // Add active class to clicked button
                this.classList.add('active');

                // Show corresponding tab pane
                const tabId = this.getAttribute('data-tab');
                document.getElementById(tabId).classList.add('active');
            });
        });
    });

    document.addEventListener('DOMContentLoaded', function () {
        var stars = document.querySelectorAll('#starRating i');
        var selectedRating = 0;

        stars.forEach(function (star) {
            star.addEventListener('click', function () {
                selectedRating = this.getAttribute('data-value');
                updateStarDisplay(selectedRating);
            });
        });

        function updateStarDisplay(rating) {
            stars.forEach(function (star) {
                if (star.getAttribute('data-value') <= rating) {
                    star.classList.remove('far');
                    star.classList.add('fas');
                } else {
                    star.classList.remove('fas');
                    star.classList.add('far');
                }
            });
        }

        document.getElementById('submitReviewBtn').addEventListener('click', function () {
            var reviewerName = document.getElementById('reviewerName').value.trim();
            var reviewerEmail = document.getElementById('reviewerEmail').value.trim();
            var reviewText = document.getElementById('reviewText').value.trim();

            if (reviewerName === '' || selectedRating == 0 || reviewText === '') {
                alert('Vui lòng nhập đầy đủ thông tin và chọn số sao!');
                return;
            }

            var productId = CURRENT_PRODUCT_ID; // <-- cần gán id sản phẩm đúng nhé!

            fetch('/SubmitReview.aspx', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    ProductId: productId,
                    ReviewerName: reviewerName,
                    ReviewerEmail: reviewerEmail,
                    Rating: selectedRating,
                    ReviewText: reviewText
                })
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('Cảm ơn bạn đã gửi đánh giá!');
                        window.location.reload();
                    } else {
                        alert('Có lỗi xảy ra, vui lòng thử lại.');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Không thể kết nối server!');
                });
        });
    });



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
