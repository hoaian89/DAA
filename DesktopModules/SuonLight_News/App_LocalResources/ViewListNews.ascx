<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewListNews.ascx.cs" Inherits="SuonLight.Modules.News.ViewListNews" %>
<%@ Register Assembly="SuonLight.UI.WebControls" Namespace="SuonLight.UI.WebControls"
    TagPrefix="cc2" %>
<%@ Register Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" TagPrefix="cc1" %>

<asp:DataList ID="dlNews" runat="server" DataKeyField="ID"  
    onitemdatabound="dlNews_ItemDataBound" RepeatLayout="Table" 
    RepeatDirection="Horizontal" onitemcreated="dlNews_ItemCreated">
<ItemTemplate>
    <%--<table cellpadding="0" cellspacing="0">
        <td style="width:50px">
            <asp:Image ID="iImage" runat="server" Width="70px" Height="70px"/>    
        </td>       
        <td>      
            <asp:HyperLink ID="hplTitle" runat="server" CssClass="News_Title_2"></asp:HyperLink>      
            <br />
            <asp:Label ID="lblDescription" runat="server" ></asp:Label>    
        </td>
        </tr>
    </table>--%>
    <div class="news_item">        
        <div class="news_item_c1">
            <asp:Image ID="iImage" runat="server" Width="100px" Height="100px"/>    
        </div>
        <div class="news_item_c2">
            <asp:HyperLink ID="hplTitle" runat="server" CssClass="title"></asp:HyperLink>   
            <asp:Image ID="iIconNew" runat="server" /> 
            <br />
            <asp:Label ID="lblCreatedDate" runat="server" ForeColor="#C77676" ></asp:Label>  
            <br />
            <asp:Label ID="lblDescription" runat="server" ></asp:Label>    
        </div>        
    </div>
    <hr />
</ItemTemplate>
</asp:DataList>

<cc2:PagingControl ID="PagingControl" runat="server"  EnableViewState="true"/>
<asp:DataList ID="dlOrtherNews" runat="server" DataKeyField="ID" 
    onitemdatabound="dlOrtherNews_ItemDataBound">
<HeaderTemplate>
<h3>Các tin khác</h3>
</HeaderTemplate>
<ItemTemplate>
    <asp:HyperLink ID="hplTitle" runat="server" Text='<%# Eval("Title") %>'></asp:HyperLink>
</ItemTemplate>
</asp:DataList>



