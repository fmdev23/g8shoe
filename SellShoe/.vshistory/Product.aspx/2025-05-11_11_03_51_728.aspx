<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="SellShoe.Product" %>

<%@ Register Src="~/UserControl/ProductCT.ascx" TagName="ProductCT" TagPrefix="uc" %>
<asp:Content ID="ContentHead" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc:ProductCT ID="ProductCT1" runat="server" />
</asp:Content>
