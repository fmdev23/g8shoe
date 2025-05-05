<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductdetailsCT.ascx.cs" Inherits="SellShoe.UserControl.ProductdetailsCT" %>
<section id="prodetails" class="section-p1">
    <% 
        int productId = 0;
        if (!string.IsNullOrEmpty(Request.QueryString["id"]))
        {
            productId = Convert.ToInt32(Request.QueryString["id"]);
        }

        var product = listSP.FirstOrDefault(p => p.id == productId);
        var productCategory = listDMSP.FirstOrDefault(c => c.id == product.ProductCategoryId);

        if (product != null)
        {
    %>
    <!-- Hình ảnh sản phẩm -->
    <div class="single-pro-image">
        <img src='<%= product.Image %>' width="100%" id="MainImg" alt="">
        <div class="small-img-group">
            <div class="small-img-col">
                <img src='<%= product.Image %>' width="100%" class="small-img" alt="">
            </div>
            <div class="small-img-col">
                <img src='<%= product.Image %>' width="100%" class="small-img" alt="">
            </div>
            <div class="small-img-col">
                <img src='<%= product.Image %>' width="100%" class="small-img" alt="">
            </div>
        </div>
    </div>

    <!-- Thông tin sản phẩm -->
    <div class="single-pro-details">
        <div class="breadcrumbs">
            <span>Trang chủ</span> &gt;
        <span><%= productCategory != null ? productCategory.Title : "" %></span> &gt;
        <span class="current"><%= product.Title %></span>
        </div>

        <h2><%= product.Title %></h2>

        <div class="price-box">
            <% if (product.PriceSale.HasValue && product.PriceSale.Value > 0)
                { %>
            <span class="old-price"><%= string.Format("{0:N0}đ", product.Price) %></span>
            <span class="new-price"><%= string.Format("{0:N0}đ", product.PriceSale.Value) %></span>
            <% }
            else
            { %>
            <span class="new-price"><%= string.Format("{0:N0}đ", product.Price) %></span>
            <% } %>
        </div>

        <p><%= product.Description %></p>
    </div>

    <% } %>

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

                        <div class="review-item">
                            <div class="review-avatar"></div>
                            <div class="review-content">
                                <p class="review-date">19/05/2025</p>
                                <p class="review-name">Nguyễn Cảnh Bằng</p>
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
