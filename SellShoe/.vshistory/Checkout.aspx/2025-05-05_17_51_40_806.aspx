<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="SellShoe.Checkout" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>G8Shoe | Thanh toán</title>
    <link rel="stylesheet" href="../css/checkout.css">
</head>
<body>
    <form id="form1" runat="server">
        <div class="checkout-container">
        <div class="payment-form-container">
            <h1>Bước cuối cùng, hoàn thành thanh toán của bạn</h1>
            <p class="subtitle">
                Để bắt đầu thanh toán của bạn, nhập chi tiết thông tin thanh toán. Bạn sẽ được chuyển hướng đến trang ủy quyền ngân hàng của bạn.
            </p>

            <form id="payment-form">
                <div class="form-group">
                    <input type="text" id="fullname" placeholder="Tên của bạn" value="" required>
                </div>
               
                <div class="form-row">
                    <div class="form-group half">
                        <input type="text" id="phone" placeholder="Số điện thoại" value="" required>
                    </div>
                    <div class="form-group half">
                        <input type="text" id="email" placeholder="Email" value="" maxlength="100" required>
                    </div>
                </div>

                <div class="form-group">
                    <input type="text" id="address" placeholder="Địa chỉ" value="" required>
                </div>
                
                <div class="form-group promo-group">
                    <input type="text" id="promo-code" placeholder="Mã giảm giá" value="">
                    <button type="button" id="apply-promo" class="apply-button">Áp dụng</button>
                </div>

                <div class="button_sub">
                    <a href="cart.html">Hủy</a>
                    <button type="submit" id="pay-button" class="pay-button">Thanh toán</button>
                </div>
            </form>
        </div>

        <div class="order-summary-container">
            <div class="order-summary">
                <div class="summary-header">
                    <p>Tổng đơn hàng,</p>
                    <h2>4.550.000 VND</h2>
                </div>

                <div class="summary-items">
                    <div class="summary-item">
                    <img src="../img/products/1.png" style="width: 30px; height: 30px; justify-content: center" />
                        <div class="item-details">
                            <h3>Custom Prada Shoes</h3>
                            <p class="item-meta">Size: 40  Màu: Red</p>
                        </div>
                        <p class="item-price">4.000.000 VND</p>
                    </div>

                    <div class="summary-item">
                        <div class="item-details">
                            <h3>St. Ives Cream 400ml</h3>
                            <p class="item-meta">Size: 30  Màu: Blue</p>
                        </div>
                        <p class="item-price">550.000 VND</p>
                    </div>
                </div>

                <div class="summary-discounts">
                    <div class="discount-row">
                        <p>Vận chuyển</p>
                        <p class="discount-amount">0 VND</p>
                    </div>
                </div>

                <div class="summary-divider"></div>

                <div class="summary-tax">
                    <p>Mã giảm giá</p>
                    <p class="tax-amount">0</p>
                </div>

                <div class="summary-total">
                    <p>Tổng cộng</p>
                    <p class="total-amount">4.550.000 VND</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Payment Success Modal -->
    <div id="success-modal" class="modal">
        <div class="modal-content">
            <div class="success-icon">✓</div>
            <h2>Thanh toán thành công!</h2>
            <p>Đơn hàng của bạn đã được xử lý thành công.</p>
            <button id="close-modal" class="modal-button">Tiếp tục mua sắm</button>
        </div>
    </div>
    
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const form = document.getElementById("payment-form");
            const modal = document.getElementById("success-modal");
            const closeModal = document.getElementById("close-modal");
            const payButton = document.getElementById("pay-button");
        
            form.addEventListener("submit", function (e) {
                e.preventDefault();
        
                // Lấy dữ liệu
                const name = document.getElementById("fullname").value.trim();
                const phone = document.getElementById("phone").value.trim();
                const email = document.getElementById("email").value.trim();
                const address = document.getElementById("address").value.trim();
        
                // Kiểm tra
                if (!name || !phone || !email || !address) {
                    alert("Vui lòng điền đầy đủ thông tin trước khi thanh toán.");
                    return;
                }
        
                // Bắt đầu xử lý
                payButton.textContent = "Đang xử lý...";
                payButton.disabled = true;
        
                // Giả lập thời gian xử lý (ví dụ: 2 giây)
                setTimeout(() => {
                    payButton.textContent = "Thanh toán";
                    payButton.disabled = false;
        
                    // Hiện modal thành công
                    modal.style.display = "flex";
                }, 1500); // 1,5s
            });
        
            closeModal.addEventListener("click", function () {
                window.location.href = "shop.html";
            });
        });
    </script>
    </form>
</body>
</html>
