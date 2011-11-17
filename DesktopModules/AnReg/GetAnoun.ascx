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
<asp:GridView ID="GridView1" runat="server" AllowPaging = "True" 
        DataSourceID="SqlDataSource1" DataKeyField="ItemID" 
        BorderWidth="0px" AutoGenerateColumns="false" GridLines="None" 
        PageSize="15"  Width="100%">
    <Columns>
        <asp:TemplateField>
            <ItemTemplate>
                 <table width="100%">
                    <tr>
                        <td>
                            <asp:Image ID="Image1" runat="server" ImageUrl="~\images\Index.jpg"/>
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
        </asp:TemplateField>
    </Columns>
    <PagerSettings Mode="NumericFirstLast" />
    <PagerStyle HorizontalAlign="Left" Width="10%" />
</asp:GridView>
</p>

<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
    SelectCommand="SELECT [ItemID], [Title], [PublishDate], [Description] FROM [Announcements] WHERE (Datediff(day,[PublishDate],getdate())>= 0 ) AND ([ModuleID] = 404)  ORDER BY [PublishDate] DESC">
</asp:SqlDataSource>
