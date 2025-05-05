<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="SellShoe.Cart" %>

<%@ Register Src="~/UserControl/CartCT.ascx" TagName="CartCT" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc:CartCT ID="AboutCT1" runat="server" />

</asp:Content>
