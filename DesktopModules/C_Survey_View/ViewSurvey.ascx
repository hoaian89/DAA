<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ViewSurvey.ascx.cs" Inherits="DesktopModules_C_Survey_ViewSurvey_" %>
<div style="width:100%;">
    <asp:SqlDataSource ID="SqlDataSourceClass" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SiteSQLServer %>" 
        SelectCommand="SELECT * FROM [C_Class] ORDER BY [ClassName]"></asp:SqlDataSource>
<asp:Panel ID="pnlSurvey" runat="server">
<div>
    Chọn lớp: <asp:DropDownList runat="server" ID="ddlClasses" 
        DataSourceID="SqlDataSourceClass" DataTextField="ClassName" 
        DataValueField="ClassID"></asp:DropDownList>
</div>
    <asp:DataList ID="lstSurvey" runat="server" DataKeyField="SurveyID" 
        DataSourceID="SqlDataSourceSurvey" 
        onitemdatabound="lstSurvey_ItemDataBound">
        <HeaderTemplate><table></HeaderTemplate>
        <ItemTemplate>
                <tr><td><b><%# Container.ItemIndex + 1 %>: <asp:Label runat="server" ID="lblQuestion" Text='<%# Eval("Question") %>' /></b></td></tr>
                <tr><td>
                    <asp:RadioButtonList ID="radOptions" runat="server" DataTextField="OptionName" 
                    DataValueField="SurveyOptionID">
                    </asp:RadioButtonList>
                    </td>
                </tr>
                <tr><td><br /></td></tr>
        </ItemTemplate>
        <FooterTemplate></table></FooterTemplate>
    </asp:DataList>
    <asp:SqlDataSource ID="SqlDataSourceSurvey" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SiteSQLServer %>" 
        SelectCommand="SELECT * FROM [C_Survey]"></asp:SqlDataSource>
        <div style="color:Red; text-align:center;">
        <asp:Label ID="lblInfo" runat="server"></asp:Label>
        </div>
        <br />
        <div style="text-align:center">
        <asp:Button ID="btnVote" runat="server" Text="Đánh giá xong" 
                onclick="btnVote_Click" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnViewResult" runat="server" Text="Xem kết quả" 
                onclick="btnViewResult_Click" />
        </div>
</asp:Panel>
<asp:Panel ID="pnlResult" runat="server">
<div>
Chọn lớp: 
    <asp:DropDownList ID="lstClasses" runat="server" 
        DataSourceID="SqlDataSourceClass" DataTextField="ClassName" 
        DataValueField="ClassID" AutoPostBack="True"></asp:DropDownList>
</div>
    <asp:DataList ID="lstResult" runat="server" DataKeyField="SurveyID" 
        DataSourceID="SqlDataSourceResult" 
        onitemdatabound="lstResult_ItemDataBound">
        <ItemTemplate>
        <table>
            <tr><td colspan="3"><b><%# Container.ItemIndex + 1 %>: <asp:Label runat="server" ID="lblQuestion" Text='<%# Eval("Question") %>' />
            </b>
            </td></tr>
                <asp:Repeater runat="server" ID="repOptions">
                    <ItemTemplate>
                    <tr >
                        <td style="padding-left: 20px; width: 200px"><%# DataBinder.Eval(Container.DataItem, "OptionName") %></td>
                        <td width="200px"><asp:Label Text='<%# Eval("Percent").ToString() + "%" %>' ForeColor="Black" Width='<%# Convert.ToDouble(Eval("Percent")) * 2 %>' 
                        runat="server" ID="lblGraph" BackColor="Aqua" Font-Size="Small"/></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "OptionVotes") %></td>
                    </tr>
                    </ItemTemplate>
                </asp:Repeater>
        </table>
        <br />
        </ItemTemplate>
    </asp:DataList>
    <asp:SqlDataSource ID="SqlDataSourceResult" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SiteSQLServer %>" SelectCommand="Select s.SurveyID, s.Question,
'Votes' = (select count(*) from C_SurveyResult where SurveyID = s.SurveyID AND ClassID = @ClassID)
from C_Survey s">
        <SelectParameters>
            <asp:ControlParameter ControlID="lstClasses" DefaultValue="-1" Name="ClassID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceOptionResult" runat="server">
    </asp:SqlDataSource>
    <div style="text-align:center">
    <asp:Button ID="btnViewSurvey" runat="server" Visible="false" 
        Text="Xem bảng đánh giá" onclick="btnViewSurvey_Click"/>
    </div>
    
    &nbsp;</asp:Panel>
    
</div>
