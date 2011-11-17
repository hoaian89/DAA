<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GetAnoun.ascx.cs" Inherits="DesktopModules_GetAnnoun_GetAnoun" %>
<style type="text/css">
    .style1
    {
        width: 100%;
        color: #0B647D;
        font-size:13px;
    }
    </style>
<p>
    <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1" 
        DataKeyField="ItemID" Width="100%" >
        <ItemTemplate>
            <table width="100%">
                <tr>
                    <td>
                        <b class="style1"><%#Server.HtmlDecode(Eval("Title").ToString()) %></b> 
                        ( <%#DateTime.Parse((Eval("PublishDate").ToString())).ToShortDateString() %> )
                        <%#getIconNew(Eval("PublishDate").ToString())%>
                    </td>
                </tr>
                <tr>
                    <td>
                        <%#getContent(Eval("Description").ToString())%> ...<a href='<%=RequestPage %><%#Eval("ItemID")%>'>chi tiết</a></td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
    <br />
</p>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
    SelectCommand="SELECT Top 10 [ItemID], [Title], [PublishDate], [Description] FROM [Announcements] WHERE (Datediff(day,[PublishDate],getdate())>=0 ) AND([ModuleID] = 404) AND (Datediff(day,getdate(),[ExpireDate]) > 0 or [ExpireDate] Is Null) ORDER BY [PublishDate] DESC">
</asp:SqlDataSource>
