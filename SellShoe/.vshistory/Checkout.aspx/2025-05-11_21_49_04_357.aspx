<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="SellShoe.Checkout" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>G8Shoe</title>
    <link rel="stylesheet" href="../css/checkout.css" />
    <link rel="icon" type="image/png" href="../img/fav.png" style="border-radius: 50%; width: 50%; height: 50%"/>
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="checkout-container">
            <div class="payment-form-container">
                <h1>Bước cuối cùng, hoàn tất đơn hàng của bạn</h1>
                <p class="subtitle">
                    Để đặt hoàn tất đơn hàng của bạn, vui lòng nhập chi tiết thông tin. Chúng tôi sẽ ghi nhận và hoàn tất đơn hàng của bạn.
                </p>

                <div id="payment-form">
                    <div class="form-group">
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Tên của bạn" />
                    </div>

                    <div class="form-row">
                        <div class="form-group half">
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Số điện thoại" />
                        </div>
                        <div class="form-group half">
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email" MaxLength="100" />
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Địa chỉ" />
                    </div>

                    <div class="button_sub">
                        <a href="product.aspx">Quay lại</a>
                        <asp:Button ID="btnPay" runat="server" Text="Đặt hàng" CssClass="pay-button" OnClick="btnPay_Click" />
                    </div>
                </div>

            </div>

            <div class="order-summary-container">
                <div class="order-summary">
                    <div class="summary-header">
                        <p>Đang thanh toán cho,</p>
                        <h2></h2>
                    </div>

                    <div class="summary-items">
                        <div class="summary-item">
                            <div class="item-details">
                                <img src="" style="width: 200px; height: 200px;" />
                                <h3>Custom Prada Shoes</h3>
                                <h4 class="item-meta"></h4>
                                <h4 class="item-quan"></h4>
                                <h4 class="item-price"></h4>
                            </div>
                        </div>
                    </div>

                    <div class="summary-discounts">
                        <div class="discount-row">
                            <p>Vận chuyển</p>
                            <p class="discount-amount">0 VND</p>
                        </div>
                    </div>

                    <div class="summary-divider"></div>

                    <div class="summary-total">
                        <p>Tổng cộng</p>
                        <p class="total-amount"></p>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Hàm lấy giá trị từ query string
                function getQueryParam(param) {
                    const urlParams = new URLSearchParams(window.location.search);
                    return urlParams.get(param);
                }

                // Lấy dữ liệu
                const img = decodeURIComponent(getQueryParam("img") || "");
                const title = decodeURIComponent(getQueryParam("title") || "");
                const size = decodeURIComponent(getQueryParam("size") || "");
                const price = decodeURIComponent(getQueryParam("price") || "").replace(/[^\d]/g, "");
                const quantity = parseInt(getQueryParam("quantity") || "1");

                const priceNumber = parseInt(price); // Chuyển đổi giá thành số nguyên
                const totalPrice = priceNumber * quantity;

                // Gán dữ liệu vào HTML
                document.querySelector(".summary-items img").src = img; // Gán ảnh
                document.querySelector(".summary-items h3").textContent = title; // Gán tiêu đề
                document.querySelector(".item-meta").textContent = "Size: " + size; // Gán size
                document.querySelector(".item-quan").textContent = "Số lượng: " + quantity; // Gán số lượng
                document.querySelector(".item-price").textContent = priceNumber.toLocaleString("vi-VN") + " VND"; // Gán giá
                document.querySelector(".summary-header h2").textContent = totalPrice.toLocaleString("vi-VN") + " VND"; // Gán tổng tiền
                document.querySelector(".summary-header h2").textContent = title; // Gán tên sp
                document.querySelector(".total-amount").textContent = totalPrice.toLocaleString("vi-VN") + " VND";

                // Nếu cần lưu vào biến global, có thể tạo ở đây
                window.orderData = {
                    img, 
                    title,
                    size,
                    price: priceNumber,
                    quantity,
                    total: totalPrice
                };
            });
        </script>

    </form>
</body>
</html>
