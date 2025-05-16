<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="SellShoe.Contact" %>

<%@ Register Src="~/UserControl/ContactCT.ascx" TagName="ContactCT" TagPrefix="uc" %>
<%@ Register Src="~/UserControl/OrderToastNotify.ascx" TagPrefix="uc" TagName="ToastNotify" %>
<uc:ToastNotify runat="server" ID="toastNotify" />

<asp:Content ID="ContentHead" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <uc:ContactCT ID="ContactCT1" runat="server" />

</asp:Content>

