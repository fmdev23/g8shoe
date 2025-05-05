<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CartCT.ascx.cs" Inherits="SellShoe.UserControl.CartCT" %>
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
        <tbody id="cartItems" runat="server">
            <tr>
                <td><a href=""><i class="fad fa-trash-alt" style="color: red;"></i></a></td>
                <td>
                    <img src="img/products/p1.png" alt=""></td>
                <td>Air Jordan 1 Low Premium</td>
                <td>4.635.000</td>
                <td>
                    <input type="number" value="1" min="1"></td>
                <td>4.635.000</td>
            </tr>
        </tbody>
    </table>

    <div class="checkout-btn-wrapper">
        <a href="checkout.aspx" class="checkout-btn" target="_blank">
            <i class="fas fa-credit-card"></i>Thanh toán
        </a>
    </div>
</section>

