<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewListNews.ascx.cs" Inherits="SuonLight.Modules.News.ViewListNews" %>
<%@ Register Assembly="SuonLight.UI.WebControls" Namespace="SuonLight.UI.WebControls"
    TagPrefix="cc2" %>
<%@ Register Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" TagPrefix="cc1" %>

<style type="text/css">
    .style1
    {
        width: 100%;
    }
    .style2
    {
        height: 35px;
    }
    .style3
    {
        height: 35px;
        width: 25px;
    }
</style>

<asp:DataList ID="dlNews" runat="server" DataKeyField="ID"  
    onitemdatabound="dlNews_ItemDataBound" RepeatLayout="Table" 
    RepeatDirection="Horizontal" onitemcreated="dlNews_ItemCreated">
<ItemTemplate>    
    <div class="news_item">        
        <div>
            &nbsp;&nbsp;<table class="style1">
                <tr>
                    <td class="style3" valign="middle">
                        <asp:Image ID="Image2" runat="server" 
                            ImageUrl="http://daa.uit.edu.vn/Images/index_event.jpg" Width="25px" />
                    </td>
                    <td align="left" class="style2" valign="middle">
                        <asp:HyperLink ID="hplTitle" runat="server" CssClass="title" 
                            style="font-family: Tahoma; color: #336699; font-weight: 700; font-size: 11pt;"></asp:HyperLink>
                        <asp:Image ID="iIconNew" runat="server" Width="16px" Visible="false"/>
                    </td>
                </tr>
            </table>
        </div>
        <div class="news_item_c1">        
            <asp:HyperLink ID="iImage" runat="server" Width="105px" Height="105px" 
                CssClass="lnkimg">[iImage]</asp:HyperLink>
        </div>
        <div class="news_item_c2">
            <asp:Label ID="lblCreatedDate" runat="server" ForeColor="#C77676" ></asp:Label>  
            <br />
            <asp:Label ID="lblDescription" runat="server" style="font-size: 11pt" ></asp:Label>    
        </div>        
    </div>
</ItemTemplate>
</asp:DataList>

<asp:Image ID="Image1" runat="server" />

<cc2:PagingControl ID="PagingControl" runat="server"  EnableViewState="true"/>
<br/> <br/>
<asp:DataList ID="dlOrtherNews" runat="server" DataKeyField="ID" 
    onitemdatabound="dlOrtherNews_ItemDataBound">
<HeaderTemplate>
&nbsp;&nbsp;Các tin khác
</HeaderTemplate>
<ItemTemplate>
    &nbsp;
    <asp:Image ID="Image2" runat="server" 
                            ImageUrl="http://daa.uit.edu.vn/images/Index.jpg" Width="10px" />
    <asp:HyperLink ID="hplTitle" runat="server" Text='<%# Eval("Title") %>' 
        style="font-family: Tahoma; font-size: small; color: #999966; font-style: italic"></asp:HyperLink>
</ItemTemplate>
</asp:DataList>



