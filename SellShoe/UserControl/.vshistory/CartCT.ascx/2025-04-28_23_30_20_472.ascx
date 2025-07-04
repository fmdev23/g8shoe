﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CartCT.ascx.cs" Inherits="SellShoe.UserControl.CartCT" %>
<section id="page-header" class="cart-header" style="background-image: url(../img/banner/1.png);">

    <h2>#cart</h2>

    <p>Chúng tôi giữ bảo mật tất cả thông tin của khách hàng</p>

</section>

<section id="cart" class="section-p1">
    <table width="100%">
    <thead>
        <tr>
            <td>Xóa</td>
            <td>Hình ảnh</td>
            <td>Tên sản phẩm</td>
            <td>Giá tiền</td>
            <td>Số lượng</td>
            <td>Tổng tiền</td>
        </tr>
    </thead>
    <tbody id="cartItems">
        <!-- Các sản phẩm trong giỏ hàng sẽ được thêm vào đây -->
    </tbody>
</table>

    <div class="checkout-btn-wrapper">
        <a href="checkout.aspx" class="checkout-btn" target="_blank">
            <i class="fas fa-credit-card"></i>Thanh toán
        </a>
    </div>
</section>
