<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="SellShoe.About" %>

<%@ Register Src="~/UserControl/AboutCT.ascx" TagName="AboutCT" TagPrefix="uc" %>
<%@ Register Src="~/UserControl/OrderToastNotify.ascx" TagName="OrderToastNotify" TagPrefix="uc" %>


<asp:Content ID="ContentHead" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc:OrderToastNotify ID="ToastNotify" runat="server" />
    <uc:AboutCT ID="AboutCT1" runat="server" />
</asp:Content>
