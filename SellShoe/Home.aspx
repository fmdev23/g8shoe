<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="SellShoe.Home1" %>
<%@ Register TagPrefix="uc" TagName="HomeCT" Src="~/UserControl/HomeCT.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc:HomeCT ID="HomeCT1" runat="server" />
</asp:Content>
