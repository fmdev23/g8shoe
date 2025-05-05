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
    <tbody id="cartItem">
        <!-- Các sản phẩm trong giỏ hàng sẽ được thêm vào đây -->
    </tbody>
</table>

    <div class="checkout-btn-wrapper">
        <a href="checkout.aspx" class="checkout-btn" target="_blank">
            <i class="fas fa-credit-card"></i>Thanh toán
        </a>
    </div>
</section>

<script>
    function updateQuantity(productId, quantity) {
        fetch('/CartCT.ascx/UpdateQuantity', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                ProductId: productId,
                Quantity: quantity
            })
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Số lượng đã được cập nhật!');
                    location.reload();  // Tải lại trang để hiển thị lại giỏ hàng với số lượng mới
                } else {
                    alert('Có lỗi xảy ra, vui lòng thử lại.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Không thể kết nối server.');
            });
    }

    function removeFromCart(productId) {
        fetch('/CartCT.ascx/RemoveFromCart', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                ProductId: productId
            })
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Sản phẩm đã được xóa khỏi giỏ hàng');
                    location.reload();  // Tải lại trang
                } else {
                    alert('Có lỗi xảy ra, vui lòng thử lại.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Không thể kết nối server.');
            });
    }


</script>
