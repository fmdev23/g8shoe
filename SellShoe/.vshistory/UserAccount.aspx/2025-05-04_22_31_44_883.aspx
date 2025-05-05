<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserAccount.aspx.cs" Inherits="SellShoe.Account" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login & Registration</title>
    <link rel="stylesheet" href="../css/log.css">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" />
</head>
<body>
    <div class="container">
        <div class="left-panel">
            <div class="bg-image"></div>
            <div class="overlay">
                <div class="welcome-text">
                    <h2>Chào mừng bạn đến với Shoe World @g8shoe</h2>
                    <p>Đăng nhập để khám phá</p>
                    <div class="dots">
                        <span class="dot active"></span>
                        <span class="dot"></span>
                        <span class="dot"></span>
                        <span class="dot"></span>
                        <span class="dot"></span>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="right-panel">
            <div class="form-container login-form active">
                <h1>Đăng nhập tài khoản của bạn!</h1>
                
                <div class="tabs">
                    <div class="tab active" data-tab="email">E-mail</div>
                </div>
                <div class="tab-indicator"></div>
                
                <form id="login-form">
                    <div class="input-group">
                        <i class="fal fa-envelope"></i>
                        <input type="email" id="email" placeholder="Email" required>
                    </div>
                    <div class="input-group">
                        <i class="fal fa-eye-slash"></i>
                        <input type="password" id="password" placeholder="Mật khẩu" required>
                    </div>
                    <div class="forgot-password">
                        <a href="#">Quên mật khẩu?</a>
                    </div>
                    <button type="submit" class="btn-continue">Đăng nhập</button>
                </form>
                
                <div class="social-login">
                    <p>Đăng nhập với</p>
                    <div class="social-icons">
                        <a href="#" class="social-icon facebook">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="social-icon google">
                            <i class="fab fa-google"></i>
                        </a>
                        <a href="#" class="social-icon apple">
                            <i class="fab fa-apple"></i>
                        </a>
                    </div>
                </div>
                
                <div class="switch-form">
                    <p>Bạn chưa có tài khoản? <a href="#" id="show-signup">Đăng ký</a></p>
                </div>
            </div>
            
            <div class="form-container signup-form">
                <h1>Tạo tài khoản của bạn!</h1>
                
                <form id="signup-form">
                    <div class="input-group">
                        <i class="fal fa-user-alt"></i>
                        <input type="text" id="fullname" placeholder="Họ tên" required>
                    </div>
                    <div class="input-group">
                        <i class="fal fa-envelope"></i>
                        <input type="email" id="signup-email" placeholder="Email" required>
                    </div>
                    <div class="input-group">
                        <i class="fal fa-eye-slash"></i>
                        <input type="password" id="signup-password" placeholder="Mật khẩu" required>
                    </div>
                    <div class="input-group">
                        <i class="fal fa-eye-slash"></i>
                        <input type="password" id="confirm-password" placeholder="Xác nhận mật khẩu" required>
                    </div>
                    <button type="submit" class="btn-continue">Đăng ký</button>
                </form>
                
                <div class="social-login">
                    <p>Hoặc đăng nhập với</p>
                    <div class="social-icons">
                        <a href="#" class="social-icon facebook">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="#" class="social-icon google">
                            <i class="fab fa-google"></i>
                        </a>
                        <a href="#" class="social-icon apple">
                            <i class="fab fa-apple"></i>
                        </a>
                    </div>
                </div>
                
                <div class="switch-form">
                    <p>Bạn đã có tài khoản? <a href="#" id="show-login">Đăng nhập</a></p>
                </div>
            </div>
        </div>
    </div>
    <script src="../js/log.js"></script>
</body>
</html>
