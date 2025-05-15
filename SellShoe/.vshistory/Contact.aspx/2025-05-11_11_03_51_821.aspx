<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="SellShoe.Contact" %>

<%@ Register Src="~/UserControl/ContactCT.ascx" TagName="ContactCT" TagPrefix="uc" %>
<asp:Content ID="ContentHead" ContentPlaceHolderID="HeadContentPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <uc:ContactCT ID="ContactCT1" runat="server" />

</asp:Content>

