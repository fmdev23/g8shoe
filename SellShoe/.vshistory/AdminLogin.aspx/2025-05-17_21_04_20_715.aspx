<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="SellShoe.AdminLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>LOGIN</title>
</head>
<body>
    <form id="form1" runat="server">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Niconne&family=Quicksand:wght@300..700&family=Signika:wght@300..700&family=Sour+Gummy:ital,wght@0,100..900;1,100..900&family=Tilt+Neon&display=swap');

        body {
            font-family: "Signika", sans-serif;
            background: linear-gradient(to right, #4e54c800, #cfd2ff);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-box {
            background-color: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            width: 320px;
            text-align: center;
        }
        .login-box h1 {
            margin-bottom: 24px;
            font-size: 24px;
            color: #333;
        }
        .login-box label {
            display: block;
            margin-bottom: 6px;
            text-align: left;
            font-weight: 600;
            color: #555;
        }
        .login-box input[type="text"],
        .login-box input[type="password"] {
            padding: 10px;
            margin-bottom: 16px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
        }
        .login-box input[type="submit"],
        .login-box button {
            background-color: #232bca;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
        }
        .login-box input[type="submit"]:hover {
            background-color: #030fff;
        }
        .error-message {
            color: red;
            margin-bottom: 12px;
            font-size: 14px;
        }
    </style>

    <div class="login-box">
        <h1>Admin Login</h1>

        <asp:Label ID="lblMessage" runat="server" CssClass="error-message"></asp:Label>

        <asp:Label ID="lblUsername" runat="server" Text="Username:"></asp:Label>
        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" autocomplete="off"></asp:TextBox>

        <asp:Label ID="lblPassword" runat="server" Text="Password:"></asp:Label>
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" autocomplete="new-password"></asp:TextBox>

        <asp:Button ID="btnLogin" runat="server" Text="Đăng nhập" OnClick="btnLogin_Click" />
    </div>
</form>

</body>
</html>
