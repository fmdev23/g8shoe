<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HomeCT.ascx.cs" Inherits="SellShoe.UserControl.Home" %>


<section id="product1" class="section-p1">
    <div class="section_title">
        <h2>BEST SELLER</h2>
    </div>
    <div class="pro-container">

        <% for (int i = 0; i < listSP.Count; i++)
            { %>

        <div class="pro">
            <img src='<%="../img/products/" + listSP[i].Image %>'  alt="">
            <div class="des">
                <h5><%=listSP[i].Title %></h5>
                <span><%=listSP[i].PriceSale %></span>
                <h4><%=listSP[i].Price %></h4>
                <div class="star">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                </div>
            </div>
            <a href=""><i class="fal fa-cart-plus cart"></i></a>
        </div>

        <% } %>
    </div>
</section>


<!-- Hàng mới -->
<section id="product1" class="section-p1">
    <div class="section_title">
        <h2>SẢN PHẨM MỚI</h2>
    </div>

    <div class="pro-container">
        <div class="pro">
            <img src="../img/products/p1.png" alt="">
            <div class="des">
                <h5>Air Jordan 1 Low Premium</h5>
                <span>5.670.000</span>
                <h4>4.635.000</h4>
                <div class="star">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                </div>
            </div>
            <a href=""><i class="fal fa-cart-plus cart"></i></a>
        </div>

        <div class="pro">
            <img src="../img/products/p1.png" alt="">
            <div class="des">
                <h5>Air Jordan 1 Low Premium</h5>
                <span>5.670.000</span>
                <h4>4.635.000</h4>
                <div class="star">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                </div>
            </div>
            <a href=""><i class="fal fa-cart-plus cart"></i></a>
        </div>

        <div class="pro">
            <img src="../img/products/p1.png" alt="">
            <div class="des">
                <h5>Air Jordan 1 Low Premium</h5>
                <span>5.670.000</span>
                <h4>4.635.000</h4>
                <div class="star">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                </div>
            </div>
            <a href=""><i class="fal fa-cart-plus cart"></i></a>
        </div>

        <div class="pro">
            <img src="../img/products/p2.png" alt="">
            <div class="des">
                <h5>Air Jordan 1 Low Premium</h5>
                <span>5.670.000</span>
                <h4>4.635.000</h4>
                <div class="star">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                </div>
            </div>
            <a href=""><i class="fal fa-cart-plus cart"></i></a>
        </div>

        <div class="pro">
            <img src="../img/products/p3.png" alt="">
            <div class="des">
                <h5>Air Jordan 1 Low Premium</h5>
                <span>5.670.000</span>
                <h4>4.635.000</h4>
                <div class="star">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                </div>
            </div>
            <a href=""><i class="fal fa-cart-plus cart"></i></a>
        </div>

        <div class="pro">
            <img src="../img/products/p4.png" alt="">
            <div class="des">
                <h5>Air Jordan 1 Low Premium</h5>
                <span>5.670.000</span>
                <h4>4.635.000</h4>
                <div class="star">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                </div>
            </div>
            <a href=""><i class="fal fa-cart-plus cart"></i></a>
        </div>

        <div class="pro">
            <img src="../img/products/p5.png" alt="">
            <div class="des">
                <h5>Air Jordan 1 Low Premium</h5>
                <span>5.670.000</span>
                <h4>4.635.000</h4>
                <div class="star">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                </div>
            </div>
            <a href=""><i class="fal fa-cart-plus cart"></i></a>
        </div>

        <div class="pro">
            <img src="../img/products/p6.png" alt="">
            <div class="des">
                <h5>Air Jordan 1 Low Premium</h5>
                <span>5.670.000</span>
                <h4>4.635.000</h4>
                <div class="star">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                </div>
            </div>
            <a href=""><i class="fal fa-cart-plus cart"></i></a>
        </div>

        <div class="pro">
            <img src="../img/products/p7.png" alt="">
            <div class="des">
                <h5>Air Jordan 1 Low Premium</h5>
                <span>5.670.000</span>
                <h4>4.635.000</h4>
                <div class="star">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                </div>
            </div>
            <a href=""><i class="fal fa-cart-plus cart"></i></a>
        </div>

        <div class="pro">
            <img src="../img/products/p8.png" alt="">
            <div class="des">
                <h5>Air Jordan 1 Low Premium</h5>
                <span>5.670.000</span>
                <h4>4.635.000</h4>
                <div class="star">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                </div>
            </div>
            <a href=""><i class="fal fa-cart-plus cart"></i></a>
        </div>
        <a href="shop.html" class="show_more">Xem thêm</a>
    </div>
</section>
