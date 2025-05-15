<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="OrderInfo.aspx.cs" Inherits="SellShoe.OrderInfo" %>
<%@ Register TagPrefix="uc" TagName="OrderInfoCT" Src="~/UserControl/OrderInfoCT.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc:OrderInfoCT ID="OrderInfo1" runat="server" />
</asp:Content>
