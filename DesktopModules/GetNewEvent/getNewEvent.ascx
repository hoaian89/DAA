<%@ Control Language="C#" AutoEventWireup="true" CodeFile="getNewEvent.ascx.cs" Inherits="DesktopModules_getNewEvent" %>
<style type="text/css">
    .style1
    {
        width: 100%;
        color:Navy;
    }
</style>
<p>
    <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1" 
        DataKeyField="ItemID" >
        <ItemTemplate>
            <table class="style1">
                <tr>
                    <td class="style1">    
                        <a href='<%=RequestPage %><%#Eval("ItemID")%>'><%#Server.HtmlDecode(Eval("Title").ToString()) %></a>
                        <%#getIconNew(Eval("PublishDate").ToString())%>
                    </td>
                </tr>
                <tr>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
    <br />
</p>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
    SelectCommand="SELECT Top 6 [ItemID], [Title], [PublishDate] FROM [Announcements] WHERE (Datediff(day,[PublishDate],getdate()) >= 0 ) AND([ModuleID] = 572) AND (Datediff(day,getdate(),[ExpireDate]) > 0 or [ExpireDate] Is Null) ORDER BY [PublishDate] DESC">
</asp:SqlDataSource>
<p style="text-align: left;"><a href="http://daa.uit.edu.vn/Danhsáchtinmới.aspx">Các tin khác<br />
</a></p>
