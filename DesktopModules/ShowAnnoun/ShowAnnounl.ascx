<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShowAnnounl.ascx.cs" Inherits="DesktopModules_ShowAnnoun_ShowAnnounl" %>
<style type="text/css">
    .style1
    {
        width: 100%;
        color:#003366;
    }
    .style2
    {
         font-size:13px;
        color:#006699; 
    }
</style>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
<p>
    <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1" 
        DataKeyField="ItemID" >
        <ItemTemplate>
            <table class="style1">
                <tr>
                    <td>
                        <b class="style2"><%#Server.HtmlDecode(Eval("Title").ToString()) %></b> 
                        ( <%#DateTime.Parse((Eval("PublishDate").ToString())).ToShortDateString() %> )
                        <br/>
                        <br/>
                    </td>
                </tr>
                <tr>
                    <td style="font-family: Arial, Helvetica, sans-serif">
                        <%#Server.HtmlDecode(Eval("Content").ToString())%> <br/>
                        <%=attack()%>
                        
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
    <br />
</p>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
    SelectCommand="SELECT Top 1 [ItemID],[Title], [PublishDate], [Content] FROM [Announcements] WHERE (Datediff(day,[PublishDate],getdate())>=0 ) AND ([ItemID]= @ItemID)">
    <SelectParameters>
        <asp:Parameter Name="ItemID" DefaultValue="0"/>
    </SelectParameters>
</asp:SqlDataSource>
<br/>
</ContentTemplate>
</asp:UpdatePanel>