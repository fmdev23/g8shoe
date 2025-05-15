<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="SellShoe.About" %>

<%@ Register Src="~/UserControl/AboutCT.ascx" TagName="AboutCT" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc:AboutCT ID="AboutCT1" runat="server" />
</asp:Content>
