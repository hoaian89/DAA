<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShowAnnounl.ascx.cs" Inherits="DesktopModules_ShowAnnoun_ShowAnnounl" %>
<style type="text/css">
    .style3
    {
        width: 100%;
    }
    .style4
    {
        text-align: center;
        color: #FF9900;
        height: 26px;
        font-size: 13pt;
        background-color: #FFFF66;
        font-family: Arial;
    }
    .style6
    {
        font-weight: bold;
        color: #FF9900;
        height: 20px;
        font-size: 12pt;
        background-color: #FFFF66;
        font-family: Arial;
    }
    .style1
    {
        font-family: Arial;
        font-size:13pt;
        text-align:center;
    }
</style>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
    <p class="style1">
    <b>* Danh sách toàn trường * </b>
    </p>
    <hr />
    <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1" 
        DataKeyField="StuID" >
        <HeaderTemplate>
          <table border="0" cellpadding="0" cellspacing="0" class="style3">
          <tr">
            <td class="style4" width="40%">
            <b style="text-align: left">Họ tên</b></td>
            <td class="style6" style="text-align: center" width="20%">
                MSSV</td>
            <td class="style6" style="text-align: center" width="20%">
                Điểm TB tích lũy</td>
            <td class="style6" style="text-align: center" width="10%">
                Thứ hạng</td>
            </tr>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td width="40%">
                   * &nbsp;&nbsp; <%#Server.HtmlDecode(Eval("StuNm").ToString())%></td>
                <td style="text-align: center" width="20%">
                    <%#Server.HtmlDecode(Eval("StuId").ToString())%></td>
                <td style="text-align: center" width="20%">
                   <%#Server.HtmlDecode(String.Format("{0:0.00}",Eval("Amark1")))%></td>
                <td style="text-align: center" width="10%">
                   <%# getOrder()%></td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
        </table>
        </FooterTemplate>
    </asp:DataList>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
        SelectCommand="SELECT Top 10 * FROM [Student] order by 	Amark1 desc">
    </asp:SqlDataSource>
    <br />
    
    <p class="style1">
    <b>* Danh sách khóa 1 *</b>
    </p>
    <hr />
    <asp:DataList ID="DataList2" runat="server" DataSourceID="SqlDataSource2" 
        DataKeyField="StuID" >
        <HeaderTemplate>
          <table border="0" cellpadding="0" cellspacing="0" class="style3">
          <tr>
        <td class="style4" width="40%">
            <b style="text-align: left">Họ tên</b></td>
        <td class="style6" style="text-align: center" width="20%">
            MSSV</td>
        <td class="style6" style="text-align: center" width="20%">
            Điểm TB tích lũy</td>
        <td class="style6" style="text-align: center" width="10%">
            Thứ hạng</td>
        </tr>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td width="40%">
                      * &nbsp;&nbsp; <%#Server.HtmlDecode(Eval("StuNm").ToString())%></td></td>
                <td style="text-align: center" width="20%">
                    <%#Server.HtmlDecode(Eval("StuId").ToString())%></td>
                <td style="text-align: center" width="20%">
                   <%#Server.HtmlDecode(String.Format("{0:0.00}",Eval("Amark1")))%></td>
                <td style="text-align: center" width="10%">
                  <%# getOrder(Eval("StuId").ToString())%></td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
        </table>
        </FooterTemplate>
    </asp:DataList>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
        SelectCommand="SELECT Top 10 * FROM [Student] where left(StuId,3) = '065' order by	Amark1 desc">
    </asp:SqlDataSource>
    <br />
    
    <p class="style1">
    <b>* Danh sách khóa 2 *</b>
    </p>
    <hr />
    <asp:DataList ID="DataList3" runat="server" DataSourceID="SqlDataSource3" 
        DataKeyField="StuID" >
        <HeaderTemplate>
          <table border="0" cellpadding="0" cellspacing="0" class="style3">
          <tr>
        <td class="style4" width="40%">
            <b style="text-align: left">Họ tên</b></td>
        <td class="style6" style="text-align: center" width="20%">
            MSSV</td>
        <td class="style6" style="text-align: center" width="20%">
            Điểm TB tích lũy</td>
        <td class="style6" style="text-align: center" width="10%">
            Thứ hạng</td>
        </tr>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td width="40%">
                      * &nbsp;&nbsp; <%#Server.HtmlDecode(Eval("StuNm").ToString())%></td></td>
                <td style="text-align: center" width="20%">
                    <%#Server.HtmlDecode(Eval("StuId").ToString())%></td>
                <td style="text-align: center" width="20%">
                   <%#Server.HtmlDecode(String.Format("{0:0.00}",Eval("Amark1")))%></td>
                <td style="text-align: center" width="10%">
                   <%# getOrder(Eval("StuId").ToString())%></td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
        </table>
        </FooterTemplate>
    </asp:DataList>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
        SelectCommand="SELECT Top 10 * FROM [Student] where left(StuId,3) = '075' order by	Amark1 desc">
    </asp:SqlDataSource>
    <br />
    
    <p class="style1">
    <b>* Danh sách khóa 3 *</b>
    </p>
    <hr />
    <asp:DataList ID="DataList4" runat="server" DataSourceID="SqlDataSource4" 
        DataKeyField="StuID" >
        <HeaderTemplate>
          <table border="0" cellpadding="0" cellspacing="0" class="style3">
          <tr>
        <td class="style4" width="40%">
            <b style="text-align: left">Họ tên</b></td>
        <td class="style6" style="text-align: center" width="20%">
            MSSV</td>
        <td class="style6" style="text-align: center" width="20%">
            Điểm TB tích lũy</td>
        <td class="style6" style="text-align: center" width="10%">
            Thứ hạng</td>
        </tr>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td width="40%">
                      * &nbsp;&nbsp; <%#Server.HtmlDecode(Eval("StuNm").ToString())%></td></td>
                <td style="text-align: center" width="20%">
                    <%#Server.HtmlDecode(Eval("StuId").ToString())%></td>
                <td style="text-align: center" width="20%">
                   <%#Server.HtmlDecode(String.Format("{0:0.00}",Eval("Amark1")))%></td>
                <td style="text-align: center" width="10%">
                   <%# getOrder(Eval("StuId").ToString())%></td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
        </table>
        </FooterTemplate>
    </asp:DataList>
    <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
        SelectCommand="SELECT Top 10 * FROM [Student] where left(StuId,3) = '085' order by	Amark1 desc">
    </asp:SqlDataSource>
    <br />
    
    <p class="style1">
    <b>* Danh sách khóa 4 *</b>
    </p>
    <hr />
    <asp:DataList ID="DataList5" runat="server" DataSourceID="SqlDataSource5" 
        DataKeyField="StuID" >
        <HeaderTemplate>
          <table border="0" cellpadding="0" cellspacing="0" class="style3">
          <tr>
        <td class="style4" width="40%">
            <b style="text-align: left">Họ tên</b></td>
        <td class="style6" style="text-align: center" width="20%">
            MSSV</td>
        <td class="style6" style="text-align: center" width="20%">
            Điểm TB tích lũy</td>
        <td class="style6" style="text-align: center" width="10%">
            Thứ hạng</td>
        </tr>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td width="40%">
                      * &nbsp;&nbsp; <%#Server.HtmlDecode(Eval("StuNm").ToString())%></td></td>
                <td style="text-align: center" width="20%">
                    <%#Server.HtmlDecode(Eval("StuId").ToString())%></td>
                <td style="text-align: center" width="20%">
                   <%#Server.HtmlDecode(String.Format("{0:0.00}",Eval("Amark1")))%></td>
                <td style="text-align: center" width="10%">
                   <%# getOrder(Eval("StuId").ToString())%></td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
        </table>
        </FooterTemplate>
    </asp:DataList>
    <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
        SelectCommand="SELECT Top 10 * FROM [Student] where left(StuId,3) = '095' order by	Amark1 desc">
    </asp:SqlDataSource>
    <br />
    
    <p class="style1">
    <b>* Danh sách khóa 5 *</b>
    <hr />
    </p>

    <asp:DataList ID="DataList6" runat="server" DataSourceID="SqlDataSource6" 
        DataKeyField="StuID" >
        <HeaderTemplate>
          <table border="0" cellpadding="0" cellspacing="0" class="style3">
          <tr>
        <td class="style4" width="40%">
            <b style="text-align: left">Họ tên</b></td>
        <td class="style6" style="text-align: center" width="20%">
            MSSV</td>
        <td class="style6" style="text-align: center" width="20%">
            Điểm TB tích lũy</td>
        <td class="style6" style="text-align: center" width="10%">
            Thứ hạng</td>
        </tr>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td width="40%">
                     *  &nbsp;&nbsp; <%#Server.HtmlDecode(Eval("StuNm").ToString())%></td></td>
                <td style="text-align: center" width="20%">
                    <%#Server.HtmlDecode(Eval("StuId").ToString())%></td>
                <td style="text-align: center" width="20%">
                   <%#Server.HtmlDecode(String.Format("{0:0.00}",Eval("Amark1")))%></td>
                <td style="text-align: center" width="10%">
                   <%# getOrder(Eval("StuId").ToString())%></td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
        </table>
        </FooterTemplate>
    </asp:DataList>
    <asp:SqlDataSource ID="SqlDataSource6" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
        SelectCommand="SELECT Top 10 * FROM [Student] where left(StuId,2) = '10' order by	Amark1 desc">
    </asp:SqlDataSource>
</ContentTemplate>
</asp:UpdatePanel>







