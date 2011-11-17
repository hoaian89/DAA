<%@ Control Language="C#" AutoEventWireup="true" CodeFile="C_LichThi_QuanLy.ascx.cs" Inherits="DesktopModules_C_LichThi_QuanLy_C_LichThi_QuanLy" %>

<style type="text/css">
    .style1
    {
        text-align: right;
    }
</style>
<asp:UpdatePanel ID="UpdatePanel" runat="server">
<ContentTemplate>
<p>
    Năm học:
    <asp:TextBox ID="txtYear" runat="server" Width="124px"></asp:TextBox>
&nbsp;&nbsp;&nbsp;
    <asp:LinkButton ID="btnChangeYear" runat="server" onclick="btnChangeYear_Click">Thay đổi</asp:LinkButton>
<p>
    Học kỳ:&nbsp;
    <asp:TextBox ID="txtSemester" runat="server" Width="53px"></asp:TextBox>
&nbsp;
    <asp:LinkButton ID="btnChangeSemester" runat="server" 
        onclick="btnChangeSemester_Click">Thay đổi</asp:LinkButton>
<p>
    Thời gian cập nhật:
    <asp:Label ID="lblUpdatedTime" runat="server"></asp:Label>
<asp:SqlDataSource ID="SqlDataSourceExamInfo" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" UpdateCommand="update [ExamScheduleInfo]
set [PropertyValue] = @PropertyValue
where [PropertyName] = @PropertyName">
    <UpdateParameters>
        <asp:Parameter Name="PropertyValue" Type="String"/>
        <asp:Parameter Name="PropertyName" Type="String" />
    </UpdateParameters>
</asp:SqlDataSource>
&nbsp;
<asp:GridView ID="GridExamSchedule" runat="server" AutoGenerateColumns="False" 
    DataSourceID="SqlDataSourceExam" 
    OnRowUpdating="GridExamSchedule_RowUpdating" OnRowEditing="GridExamSchedule_RowEditing"
    OnRowDeleting="GridExamSchedule_RowDeleting"
    ShowFooter="True" AllowPaging="True" PageSize="30" 
        EnableModelValidation="True" onrowcancelingedit="GridExamSchedule_RowCancelingEdit" 
    >
    <Columns>
        <asp:TemplateField HeaderText="Mã lớp">
            <ItemTemplate>
                <asp:Label runat = "server"  ID ="lblClassID" Text='<%# Eval("ClassID") %>'/>
            </ItemTemplate>
            <ItemStyle Width="15%" HorizontalAlign="Center"/>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Ngày thi">
            <ItemTemplate>
                <%#Eval("Date") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="DateEdit" runat="server" Text ='<%#Eval("Date")%>' 
                    Width="98%"/>
            </EditItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Ca thi">
            <ItemTemplate>
                <%#Eval("Period") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="PeriodEdit" runat="server" Text ='<%#Eval("Period")%>' 
                    Width="95%"/>
            </EditItemTemplate>
            <ItemStyle Width="6%" HorizontalAlign="Center"/>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Phòng thi">
            <ItemTemplate>
                <%#Eval("Room") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="RoomEdit" runat="server" Text ='<%#Eval("Room")%>' Width="96%"/>
            </EditItemTemplate>
            <ItemStyle Width="15%"  HorizontalAlign="Center"/>
        </asp:TemplateField>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:ImageButton ID ="EditButton" CommandName="Edit" 
                    ImageUrl="~/images/edit.gif" runat="server" />
                <asp:ImageButton ID="DeleteButton" CommandName="Delete" 
                    ImageUrl="~/images/delete.gif" runat="server" 
                
                    
                    OnClientClick="javascript:return confirm('Bạn có chắc muốn xóa mục này không ?');"/>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:ImageButton ID ="Update" CommandName="Update" runat="server" 
                    ImageUrl="~/images/eip_save.gif"/> |  
                <asp:ImageButton ID="Cancel" CommandName="Cancel"  runat="server" 
                    ImageUrl="~/images/delete.gif"/>
            </EditItemTemplate>
            <HeaderTemplate>
                Điều khiển
            </HeaderTemplate>
            <ItemStyle Width="8%" HorizontalAlign="Center"/>
            <FooterStyle Width="8%" HorizontalAlign="Center" Font-Bold="true"/>
        </asp:TemplateField>
    </Columns>
    <RowStyle HorizontalAlign="Center" />
</asp:GridView>
<div style="text-align:center">
<asp:Button ID="btnDeleteAll" runat="server" Text="Xóa hết dữ liệu lịch thi" 
        onclick="btnDeleteAll_Click" />
</div>
    <table style="width:100%;">
    <thead><tr><td colspan="2"><b>Thêm lịch thi cho lớp</b></td></tr></thead>
        <tr>
            <td class="style1">
                Mã lớp:</td>
            <td>
                <asp:TextBox ID="txtClassID" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Ngày thi:</td>
            <td>
                <asp:Calendar ID="calDate" runat="server" BackColor="White" 
                    BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" 
                    Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="16px" 
                    Width="150px">
                    <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                    <NextPrevStyle VerticalAlign="Bottom" />
                    <OtherMonthDayStyle ForeColor="#808080" />
                    <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                    <SelectorStyle BackColor="#CCCCCC" />
                    <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                    <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <WeekendDayStyle BackColor="#FFFFCC" />
                </asp:Calendar>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Ca thi:</td>
            <td>
                <asp:TextBox ID="txtPeriod" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Phòng thi:</td>
            <td>
                <asp:TextBox ID="txtRoom" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                <asp:Button ID="btnUpdate" runat="server" onclick="btnUpdate_Click" 
                    Text="Thêm" />
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        Đang thực thi...
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </td>
        </tr>
    </table>

    <br />
    <p>
    </p>
    <p>
        <asp:SqlDataSource ID="SqlDataSourceExam" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
            DeleteCommand="DELETE FROM [ExamSchedule] WHERE [ClassID] = @ClassID" 
            InsertCommand="INSERT INTO [ExamSchedule] ([ClassID], [Date], [Period], [Room]) VALUES (@ClassID, @Date, @Period, @Room)" SelectCommand="SELECT * FROM [ExamSchedule]
Order by ClassID" 
            UpdateCommand="UPDATE [ExamSchedule] SET [Date] = @Date, [Period] = @Period, [Room] = @Room WHERE [ClassID] = @ClassID">
            <DeleteParameters>
                <asp:Parameter Name="ClassID" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ClassID" Type="String" />
                <asp:Parameter Name="Date" Type="DateTime" />
                <asp:Parameter Name="Period" Type="String" />
                <asp:Parameter Name="Room" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Date" Type="DateTime" />
                <asp:Parameter Name="Period" Type="String" />
                <asp:Parameter Name="Room" Type="String" />
                <asp:Parameter Name="ClassID" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        &nbsp;</p>
    <p>
    </p>
    <p>
    </p>
    <p>
    </p>
</p>
    </ContentTemplate>
    </asp:UpdatePanel>