<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SproductCT.ascx.cs" Inherits="SellShoe.UserControl.SproductCT" %>
<section id="prodetails" class="section-p1 section-m1">
    <!-- Hình ảnh sản phẩm -->
    <div class="single-pro-image">
        <img src="img/products/p1.png" width="100%" id="MainImg" alt="">
        <div class="small-img-group">
            <div class="small-img-col">
                <img src="img/products/p2.png" width="100%" class="small-img" alt="">
            </div>
            <div class="small-img-col">
                <img src="img/products/p3.png" width="100%" class="small-img" alt="">
            </div>
            <div class="small-img-col">
                <img src="img/products/p4.png" width="100%" class="small-img" alt="">
            </div>
        </div>
    </div>

    <!-- Thông tin sản phẩm -->
    <div class="single-pro-details">
        <div class="breadcrumbs">
            <span>Trang chủ</span> &gt;
        <span>Nam</span> &gt;
        <span class="current">Air Jordan 1 Low Premium</span>
        </div>

        <h2>Air Jordan 1 Low Premium</h2>
        <div class="price-box">
            <span class="old-price">5.670.000đ</span>
            <span class="new-price">4.635.000đ</span>
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
        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Fugiat ex adipisci ipsum atque neque minus praesentium excepturi dolorem harum veritatis!</p>
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
        <div class="tab-pane active" id="products-details">
            <p>Thông tin</p>

            <h3>Size & Fit</h3>
            <p>Nhiều lựa chọn size</p>

            <h3>Material & Care</h3>
            <p>Material: Cotton</p>
            <p>Machine-wash</p>
        </div>

        <div class="tab-pane" id="specifications">
            <h3>Size & Fit</h3>
            <p>The model (height 5'8") is wearing a size S</p>
        </div>

        <div class="tab-pane" id="customer-photos">
            <p>Photo here</p>
        </div>

        <div class="tab-pane" id="customer-reviews">

            <section class="review-section">
                <div class="review-container">
                    <!-- Cột trái: Danh sách review -->
                    <div class="review-list">

                        <div class="review-item">
                            <div class="review-avatar"></div>
                            <div class="review-content">
                                <p class="review-date">19/05/2025 </p>
                                <p class="review-name">Trần Ngọc Nhung</p>
                                <div class="review-stars">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="far fa-star"></i>
                                </div>
                                <p class="review-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>

                            </div>
                        </div>

                    </div>

                    <!-- Cột phải: Form đánh giá -->
                    <div class="review-form">
                        <h3>Thêm đánh giá sản phẩm</h3>
                        <input type="text" placeholder="Tên của bạn" />
                        <input type="email" placeholder="Email" />
                        <div class="rating-label">
                            <label>Đánh giá:</label>
                            <div class="star-rating">
                                <i class="far fa-star" data-value="1"></i>
                                <i class="far fa-star" data-value="2"></i>
                                <i class="far fa-star" data-value="3"></i>
                                <i class="far fa-star" data-value="4"></i>
                                <i class="far fa-star" data-value="5"></i>
                            </div>
                        </div>
                        <textarea placeholder="Đánh giá của bạn" rows="2" cols="2"></textarea>
                        <button class="submit-btn">Thêm đánh giá</button>
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

    //Xử lý rating
    document.addEventListener('DOMContentLoaded', function () {
        const stars = document.querySelectorAll('.star-rating i');

        stars.forEach(star => {
            star.addEventListener('click', () => {
                const rating = parseInt(star.getAttribute('data-value'));

                stars.forEach((s, index) => {
                    if (index < rating) {
                        s.classList.remove('far');
                        s.classList.add('fas', 'active');
                    } else {
                        s.classList.remove('fas', 'active');
                        s.classList.add('far');
                    }
                });
            });
        });
    });
</script>
