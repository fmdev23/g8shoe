<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Sproduct.aspx.cs" Inherits="SellShoe.Sproduct" %>

<%@ Register TagPrefix="uc" TagName="SproductCT" Src="~/UserControl/SproductCT.ascx" %>
<asp:Content ID="ContentHead" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc:SproductCT ID="SproductCT1" runat="server" />
</asp:Content>
