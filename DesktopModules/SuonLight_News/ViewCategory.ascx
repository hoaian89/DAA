<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewCategory.ascx.cs" Inherits="SuonLight.Modules.News.ViewCategory" %>
<asp:DataList ID="dlCategories" runat="server" DataKeyField="CatID">
<ItemTemplate>
    <asp:HyperLink ID="hplCategory" runat="server" Text='<%# Eval("Category") %>'></asp:HyperLink>
</ItemTemplate>
</asp:DataList>
