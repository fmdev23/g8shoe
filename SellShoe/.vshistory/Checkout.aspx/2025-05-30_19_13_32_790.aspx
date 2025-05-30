<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="checkout.aspx.cs" Inherits="SellShoe.checkout" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán - SellShoe</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <style>
        .checkout-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
            display: grid;
            grid-template-columns: 1fr 400px;
            gap: 40px;
        }
        
        .checkout-form {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .order-summary {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            height: fit-content;
            position: sticky;
            top: 20px;
        }
        
        .section-title {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 25px;
            color: #333;
            border-bottom: 2px solid #088178;
            padding-bottom: 10px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #333;
        }
        
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e3e6f0;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
            outline: none;
            border-color: #088178;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        .product-item {
            display: flex;
            align-items: center;
            padding: 20px 0;
            border-bottom: 1px solid #eee;
        }
        
        .product-item:last-child {
            border-bottom: none;
        }
        
        .product-image {
            width: 80px;
            height: 80px;
            border-radius: 8px;
            object-fit: cover;
            margin-right: 15px;
        }
        
        .product-info {
            flex: 1;
        }
        
        .product-name {
            font-weight: 600;
            margin-bottom: 5px;
            color: #333;
        }
        
        .product-details {
            font-size: 14px;
            color: #666;
            margin-bottom: 5px;
        }
        
        .product-price {
            font-weight: 600;
            color: #088178;
            font-size: 16px;
        }
        
        .order-total {
            border-top: 2px solid #eee;
            padding-top: 20px;
            margin-top: 20px;
        }
        
        .total-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        
        .total-row.final {
            font-size: 18px;
            font-weight: 700;
            color: #088178;
            border-top: 1px solid #eee;
            padding-top: 15px;
            margin-top: 15px;
        }
        
        .payment-methods {
            margin: 25px 0;
        }
        
        .payment-option {
            display: flex;
            align-items: center;
            padding: 15px;
            border: 2px solid #e3e6f0;
            border-radius: 8px;
            margin-bottom: 10px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .payment-option:hover {
            border-color: #088178;
        }
        
        .payment-option.selected {
            border-color: #088178;
            background-color: #f8f9ff;
        }
        
        .payment-option input[type="radio"] {
            margin-right: 10px;
        }
        
        .btn-checkout {
            width: 100%;
            background: #088178;
            color: white;
            border: none;
            padding: 15px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .btn-checkout:hover {
            background: #066b5f;
        }
        
        .breadcrumb {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
        }
        
        .breadcrumb a {
            color: #666;
            text-decoration: none;
        }
        
        .breadcrumb a:hover {
            color: #088178;
        }
        
        .breadcrumb .current {
            color: #088178;
            font-weight: 600;
        }
        
        @media (max-width: 768px) {
            .checkout-container {
                grid-template-columns: 1fr;
                margin: 20px;
                padding: 0;
            }
            
            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        
        <!-- Breadcrumb -->
        <div class="breadcrumb">
            <a href="home.aspx">Trang Chủ</a>
            <i class="fad fa-chevron-right"></i>
            <span class="current">Thanh toán</span>
        </div>
        
        <div class="checkout-container">
            <!-- Form thông tin thanh toán -->
            <div class="checkout-form">
                <h2 class="section-title">Thông tin thanh toán</h2>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="txtHoTen">Họ và tên *</label>
                        <asp:TextBox ID="txtHoTen" runat="server" placeholder="Nhập họ và tên" Required="true"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="txtSoDienThoai">Số điện thoại *</label>
                        <asp:TextBox ID="txtSoDienThoai" runat="server" placeholder="Nhập số điện thoại" Required="true"></asp:TextBox>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="txtEmail">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="Nhập email"></asp:TextBox>
                </div>
                
                <div class="form-group">
                    <label for="txtDiaChi">Địa chỉ giao hàng *</label>
                    <asp:TextBox ID="txtDiaChi" runat="server" placeholder="Nhập địa chỉ chi tiết" Required="true"></asp:TextBox>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="ddlTinhThanh">Tỉnh/Thành phố *</label>
                        <asp:DropDownList ID="ddlTinhThanh" runat="server" Required="true">
                            <asp:ListItem Value="">-- Chọn Tỉnh/Thành phố --</asp:ListItem>
                            <asp:ListItem Value="HCM">TP. Hồ Chí Minh</asp:ListItem>
                            <asp:ListItem Value="HN">Hà Nội</asp:ListItem>
                            <asp:ListItem Value="DN">Đà Nẵng</asp:ListItem>
                            <asp:ListItem Value="CT">Cần Thơ</asp:ListItem>
                            <asp:ListItem Value="Other">Tỉnh khác</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label for="ddlQuanHuyen">Quận/Huyện *</label>
                        <asp:DropDownList ID="ddlQuanHuyen" runat="server" Required="true">
                            <asp:ListItem Value="">-- Chọn Quận/Huyện --</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="txtGhiChu">Ghi chú đơn hàng</label>
                    <asp:TextBox ID="txtGhiChu" runat="server" TextMode="MultiLine" Rows="3" 
                        placeholder="Ghi chú về đơn hàng, ví dụ: thời gian hay chỉ dẫn địa điểm giao hàng chi tiết hơn."></asp:TextBox>
                </div>
                
                <!-- Phương thức thanh toán -->
                <h3 class="section-title">Phương thức thanh toán</h3>
                <div class="payment-methods">
                    <div class="payment-option selected">
                        <asp:RadioButton ID="rbCOD" runat="server" GroupName="PaymentMethod" Checked="true" />
                        <label for="<%= rbCOD.ClientID %>">
                            <i class="fas fa-money-bill-wave"></i>
                            Thanh toán khi nhận hàng (COD)
                        </label>
                    </div>
                    <div class="payment-option">
                        <asp:RadioButton ID="rbBankTransfer" runat="server" GroupName="PaymentMethod" />
                        <label for="<%= rbBankTransfer.ClientID %>">
                            <i class="fas fa-university"></i>
                            Chuyển khoản ngân hàng
                        </label>
                    </div>
                    <div class="payment-option">
                        <asp:RadioButton ID="rbMomo" runat="server" GroupName="PaymentMethod" />
                        <label for="<%= rbMomo.ClientID %>">
                            <i class="fas fa-mobile-alt"></i>
                            Thanh toán qua MoMo
                        </label>
                    </div>
                </div>
            </div>
            
            <!-- Tóm tắt đơn hàng -->
            <div class="order-summary">
                <h3 class="section-title">Đơn hàng của bạn</h3>
                
                <div class="product-item" runat="server" id="productItem">
                    <img src="<%= ProductImage %>" alt="<%= ProductName %>" class="product-image">
                    <div class="product-info">
                        <div class="product-name"><%= ProductName %></div>
                        <div class="product-details">Size: <%= ProductSize %></div>
                        <div class="product-details">Số lượng: <%= ProductQuantity %></div>
                        <div class="product-price"><%= FormatPrice(ProductPrice * ProductQuantity) %></div>
                    </div>
                </div>
                
                <div class="order-total">
                    <div class="total-row">
                        <span>Tạm tính:</span>
                        <span><%= FormatPrice(ProductPrice * ProductQuantity) %></span>
                    </div>
                    <div class="total-row">
                        <span>Phí vận chuyển:</span>
                        <span><%= FormatPrice(ShippingFee) %></span>
                    </div>
                    <div class="total-row final">
                        <span>Tổng cộng:</span>
                        <span><%= FormatPrice(TotalAmount) %></span>
                    </div>
                </div>
                
                <asp:Button ID="btnDatHang" runat="server" Text="Đặt hàng" CssClass="btn-checkout" 
                    OnClick="btnDatHang_Click" />
            </div>
        </div>
        
        <!-- Hidden fields to store order info -->
        <asp:HiddenField ID="hfProductId" runat="server" />
        <asp:HiddenField ID="hfProductSize" runat="server" />
        <asp:HiddenField ID="hfProductQuantity" runat="server" />
        <asp:HiddenField ID="hfProductPrice" runat="server" />
        
    </form>
    
    <script>
        // Xử lý click phương thức thanh toán
        document.addEventListener('DOMContentLoaded', function() {
            const paymentOptions = document.querySelectorAll('.payment-option');
            
            paymentOptions.forEach(option => {
                option.addEventListener('click', function() {
                    // Remove selected class from all options
                    paymentOptions.forEach(opt => opt.classList.remove('selected'));
                    
                    // Add selected class to clicked option
                    this.classList.add('selected');
                    
                    // Check the radio button
                    const radio = this.querySelector('input[type="radio"]');
                    if (radio) {
                        radio.checked = true;
                    }
                });
            });
        });
        
        // Hiển thị thông báo thành công
        function showSuccessMessage() {
            Swal.fire({
                icon: 'success',
                title: 'Đặt hàng thành công!',
                text: 'Chúng tôi sẽ liên hệ với bạn trong thời gian sớm nhất.',
                showConfirmButton: true,
                confirmButtonText: 'OK'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = 'home.aspx';
                }
            });
        }
        
        // Hiển thị thông báo lỗi
        function showErrorMessage(message) {
            Swal.fire({
                icon: 'error',
                title: 'Có lỗi xảy ra!',
                text: message,
                showConfirmButton: true,
                confirmButtonText: 'OK'
            });
        }
    </script>
</body>
</html>