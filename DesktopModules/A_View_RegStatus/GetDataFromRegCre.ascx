<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GetDataFromRegCre.ascx.cs" Inherits="DesktopModules_A_GetData_RegCre_GetDataFromRegCre" %>
<style type="text/css">
    .style1
    {
        color: #CC3300;
    }
    .style2
    {
        color: #000000;
    }
    .style3
    {
        font-size: large;
    }
    .style5
    {
        width: 121px;
        height: 18px;
    }
    .style6
    {
        height: 18px;
    }
    .style14
    {
        width: 51px;
    }
    .style13
    {
        width: 100%;
        border-style: solid;
        border-width: 1px;
        background-color: PaleGoldenrod;
    }
    .style15
    {
        width: 41px;
    }
    .style16
    {
        width: 63%;
    }
    .style17
    {
        width: 37px;
    }
    .style19
    {
        width: 100%;
        border-style: solid;
        border-width: 1px;
        background-color: #FFFAFA;
    }
    .style20
    {
        height: 18px;
        width: 110px;
        color: #CC3300;
    }
    .style21
    {
        height: 18px;
        width: 122px;
        color: #CC3300;
    }
</style>
<asp:Timer ID="Timer1" OnTick="Timer1_Tick" runat="server" Interval="5000">
</asp:Timer>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
<span class="style1"><span class="style3">Cập nhật thời khóa biểu&nbsp;</span> <hr />
</span>
<table width="100%">
    <tr>
        <td class="style5">
            <span class="style2">Tìm theo mã lớp :</span></td>
        <td class="style6">
            <strong>
<asp:TextBox ID="FindItem" runat="server" Width="161px"></asp:TextBox>
&nbsp;<asp:ImageButton ID="ImageButton1" runat="server" 
    ImageUrl="~/images/action_source.gif" onclick="ImageButton1_Click" />
&nbsp;<asp:Label ID="ShowInfo" runat="server" style="color: #CC3300"></asp:Label>
</strong> 
        <asp:UpdateProgress ID="UpdateProgress2" runat="server" 
            AssociatedUpdatePanelID="UpdatePanel1">
        <ProgressTemplate>
            <asp:Image ID="Image3" runat="server" ImageUrl="~/images/dnnanim.gif" />
        </ProgressTemplate>
        </asp:UpdateProgress>

        </td>
        <td align="right" class="style6">
            <table width="60px" border="1px">
                <tr>
                    <td bgcolor="PaleGoldenrod">
                        &nbsp;</td>
                </tr>
            </table>
        </td>
        <td align="left" class="style21">
        : Các lớp đề nghị</td>
    <td align="right" class="style6">
        <table class="style19" width="60px" border="1px">
            <tr>
                <td  bgcolor="Snow">
                    &nbsp;</td>
            </tr>
        </table>
    </td>
    <td align="left" class="style20">
        &nbsp;: Các lớp đầy&nbsp;</td>
    <td align="right" class="style6">
        <strong>
        <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/add.gif" 
            onclick="ImageButton2_Click" />
        </strong>
    </td>
    </tr>
</table>
<br/>
<asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
    AutoGenerateColumns="False" DataKeyNames="ClassID"
    DataSourceID="SqlDataSource1" 
    onselectedindexchanged="GridView1_SelectedIndexChanged" 
    onrowcancelingedit="GridView1_RowCancelingEdit" onload="GridView1_Load" 
    onrowupdating="GridView1_RowUpdating" onrowediting="GridView1_RowEditing" 
    onrowdeleting="GridView1_RowDeleting" Width="100%"
    OnDataBound="GridView_Bound">
    <Columns>
        <asp:BoundField DataField="ClassID" HeaderText="Mã lớp" ReadOnly="True" 
            SortExpression="ClassID" />
        <asp:BoundField DataField="SubId" HeaderText="Mã môn" SortExpression="SubId" />
        <asp:BoundField DataField="LecNm" HeaderText="Giảng viên" 
            SortExpression="LecNm" />
        <asp:BoundField DataField="Period" HeaderText="Buổi" SortExpression="Period" />
        <asp:BoundField DataField="Day" HeaderText="Thứ" SortExpression="Day" />
        <asp:BoundField DataField="Room" HeaderText="Phòng" SortExpression="Room" />
        <asp:BoundField DataField="StuMx" HeaderText="Số tối đa" 
            SortExpression="StuMx" ItemStyle-Font-Bold="true"/>
        <asp:BoundField DataField="CurNm" HeaderText="Đã đk" 
            SortExpression="CurNm" ItemStyle-Font-Bold="true"/>
        <asp:TemplateField HeaderText="Phần trăm">
            <ItemTemplate>
                <asp:Label Text="" runat="server" ID="Percen"></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
    <EditRowStyle BackColor="Yellow" />
    <SelectedRowStyle BackColor="#CCFFFF" />
</asp:GridView>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
    SelectCommand="SELECT * FROM [ScheduleM] ORDER BY ROOM, DAY,PERIOD" 
    UpdateCommand="Update ScheduleM set SubId = @SubID , LecNm = @LecNm , Period = @Period , Day = @Day,Room = @Room ,StuMx = @StuMx where ClassID = @ClassID" 
    DeleteCommand="Delete RegisterInfo where ClassID = @ClassID"
    onselecting="SqlDataSource1_Selecting" onload="SqlDataSource1_Load">
    <UpdateParameters>
        <asp:Parameter Name="ClassID" />
        <asp:Parameter Name="SubID" />
        <asp:Parameter Name="LecNm" />
        <asp:Parameter Name="Period" />
        <asp:Parameter Name="Day" />
        <asp:Parameter Name="Room" />
        <asp:Parameter Name="StuMx" />
    </UpdateParameters>
    <DeleteParameters>
        <asp:Parameter Name = "ClassID" />
    </DeleteParameters>
</asp:SqlDataSource>
<br/>
</ContentTemplate>
<Triggers>
<asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" />
</Triggers>
</asp:UpdatePanel>