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
    .style4
    {
        width: 100%;
        border-bottom-color:Navy;
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
    .style7
    {
        text-align: center;
        font-weight: bold;
        color: #FFFFFF;
        height: 25px;
    }
    .style9
    {
        width: 134px;
    }
</style>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
<strong><span class="style1"><span class="style3">Cập nhật thời khóa biểu&nbsp;</span> <hr />
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
            <strong>
            <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/add.gif" 
                onclick="ImageButton2_Click" />
</strong> 
        </td>
    </tr>
</table>
</strong> 
<table class="style4" border="1px" align="center" id="AddClass">
    <tr>
        <td class="style7" bgcolor="#669999">
            &nbsp;Mã lớp&nbsp;</td>
        <td class="style7" bgcolor="#669999">
            Mã môn</td>
        <td class="style7" bgcolor="#669999">
            Giảng viên</td>
        <td class="style7" bgcolor="#669999">
            Buổi</td>
        <td class="style7" bgcolor="#669999">
            Thứ</td>
        <td class="style7" bgcolor="#669999">
            Phòng</td>
        <td class="style7" bgcolor="#669999">
            Số tối đa</td>
    </tr>
    <tr>
        <td>
            <asp:TextBox ID="ClassID" runat="server" Width="96px"></asp:TextBox>
        </td>
        <td class="style9" align="center">
            <asp:TextBox ID="SubID" runat="server" Width="79px"></asp:TextBox>
        </td>
        <td align="center">
            <asp:TextBox ID="LecNm" runat="server" Width="169px"></asp:TextBox>
        </td>
        <td>
            <asp:TextBox ID="Period" runat="server" Width="91px"></asp:TextBox>
        </td>
        <td>
            <asp:TextBox ID="Day" runat="server" Width="85px"></asp:TextBox>
        </td>
        <td>
            <asp:TextBox ID="Room" runat="server" Width="99px"></asp:TextBox>
        </td>
        <td>
            <asp:TextBox ID="StuMx" runat="server" Width="86px"></asp:TextBox>
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
    onrowdeleting="GridView1_RowDeleting" Width="100%">
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
            SortExpression="StuMx" />
        <asp:BoundField DataField="CurNm" HeaderText="Đã đk" 
            SortExpression="CurNm" />
        <asp:CommandField ShowEditButton="True" ButtonType="Image" 
            EditImageUrl="~/images/edit.gif" 
            HeaderText="Điều chỉnh" 
            CancelImageUrl="~/images/action_import.gif" 
            UpdateImageUrl="~/images/save.gif">
        <ItemStyle Width="30px" HorizontalAlign="Center" />
        </asp:CommandField>
        <asp:CommandField ButtonType="Image" 
            DeleteImageUrl="~/images/delete.gif"
            HeaderText="Xóa" ShowDeleteButton="True">
        <ItemStyle Width="30px" HorizontalAlign="Center" />
        </asp:CommandField>
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
</asp:UpdatePanel>