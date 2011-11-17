<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewNews.ascx.cs" Inherits="SuonLight.Modules.News.ViewNews" %>
<style type="text/css">
    .style1
    {
        font-family: Arial, Helvetica, sans-serif;
        color: #336699;
        font-style: italic;
        font-size: 13pt;
    }
    .style2
    {
        font-family: "Times New Roman", Times, serif;
    }
    .style3
    {
        width: 100%;
    }
    .style4
    {
        height: 30px;
    }
</style>
<table width="100%">
    <tr>
        <td class="Normal">
            <table class="style3">
                <tr>
                    <td class="style4">
            <asp:Label ID="lblHeadline" runat="server" Font-Size="Large" 
                style="font-weight: 700; color: #336699; font-family: Tahoma"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
    </tr>    
    <tr>
        <td class="Normal" style="width:200px">
            <asp:Literal ID="lblContent" runat="server" ></asp:Literal>            
        </td>
    </tr>    
    <tr>
        <td class="Normal" style="text-align:right;" >
            <asp:Label ID="lblTotalView" Font-Bold="true"  runat="server"></asp:Label> lượt xem.
        </td>
    </tr>
</table>
<asp:DataList ID="dlOrtherNews" runat="server" DataKeyField="ID" 
    onitemdatabound="dlOrtherNews_ItemDataBound">
<HeaderTemplate>
&nbsp;<h3 class="style1">&nbsp;<span class="style2">Các tin khác</span></h3>
</HeaderTemplate>
<ItemTemplate>
    &nbsp;
    <asp:Image ID="Image2" runat="server" 
                            ImageUrl="http://daa.uit.edu.vn/images/Index.jpg" Width="10px" />
    &nbsp;
    <asp:HyperLink ID="hplTitle" runat="server" Text='<%# Eval("Title") %>' 
        style="font-family: Tahoma; font-size: small; color: #999966; font-style: italic"></asp:HyperLink>
</ItemTemplate>
</asp:DataList>