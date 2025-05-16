<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="SellShoe.Home1" %>
<%@ Register TagPrefix="uc" TagName="HomeCT" Src="~/UserControl/HomeCT.ascx" %>
<%@ Register Src="~/UserControl/OrderToastNotify.ascx" TagName="OrderToastNotify" TagPrefix="uc" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc:OrderToastNotify ID="ToastNotify" runat="server" />
    <uc:HomeCT ID="HomeCT1" runat="server" />
</asp:Content>
