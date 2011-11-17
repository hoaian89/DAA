<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GetAnoun.ascx.cs" Inherits="DesktopModules_GetAnnoun_GetAnoun" %>
<style type="text/css">
    .style1
    {
        width: 100%;
        color: #0B647D;
        font-size:13px;
    }
    .style2
    {
        width: 100%;
    }
    .style3
    {
        color: #CC3300;
        font-weight: bold;
    }
    </style>
<table class="style2">
    <tr>
        <td class="style3" width="120">
            Đại học chính qui</td>
        <td>
            <hr style="margin-left: 0px" />
        </td>
    </tr>
</table>
<p>
    <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1" 
        DataKeyField="ItemID" Width="100%" >
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
                        <%#getContent(Eval("Description").ToString())%> ...<a href='<%=RequestPage %><%#Eval("ItemID")%>'>chi ti&#7871;t</a><br/></td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
</p>
<p>
    <table class="style2">
        <tr>
            <td class="style3" width="100">
                Cao học</td>
            <td>
                <hr style="margin-left: 0px" />
            </td>
        </tr>
    </table>
    </p>
<p>
    <asp:DataList ID="DataList2" runat="server" DataSourceID="SqlDataSource2" 
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
                        <%#getContent(Eval("Description").ToString())%> ...<a href='<%=RequestPage %><%#Eval("ItemID")%>'>chi ti&#7871;t</a><br/></td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
    <br />
</p>
<table class="style2">
    <tr>
        <td class="style3" width="100">
            Đào tạo từ xa</td>
        <td>
            <hr style="margin-left: 0px" />
        </td>
    </tr>
</table>
<p>
    <asp:DataList ID="DataList3" runat="server" DataSourceID="SqlDataSource3" 
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
                        <%#getContent(Eval("Description").ToString())%> ...<a href='<%=RequestPage %><%#Eval("ItemID")%>'>chi ti&#7871;t</a><br/></td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
    <br />
</p>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
    SelectCommand="SELECT Top 10 [ItemID], [Title], [PublishDate], [Description] FROM [Announcements] WHERE (Target = 0) AND (Datediff(day,[PublishDate],getdate())>=0 ) AND([ModuleID] = 404) AND (Datediff(day,getdate(),[ExpireDate]) > 0 or [ExpireDate] Is Null) ORDER BY [PublishDate] DESC">
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource2" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
    SelectCommand="SELECT Top 10 [ItemID], [Title], [PublishDate], [Description] FROM [Announcements] WHERE (Target = 1) AND (Datediff(day,[PublishDate],getdate())>=0 ) AND([ModuleID] = 404) AND (Datediff(day,getdate(),[ExpireDate]) > 0 or [ExpireDate] Is Null) ORDER BY [PublishDate] DESC">
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource3" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
    SelectCommand="SELECT Top 10 [ItemID], [Title], [PublishDate], [Description] FROM [Announcements] WHERE (Target = 2) AND (Datediff(day,[PublishDate],getdate())>=0 ) AND([ModuleID] = 404) AND (Datediff(day,getdate(),[ExpireDate]) > 0 or [ExpireDate] Is Null) ORDER BY [PublishDate] DESC">
</asp:SqlDataSource>
<p style="text-align: right;"><a href="http://daa.uit.edu.vn/Danhsáchthôngbáo.aspx">Xem tất cả >> <br />
</a></p>