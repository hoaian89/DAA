<%@ Control Language="C#" AutoEventWireup="true" CodeFile="C_LichThi_Xem.ascx.cs" Inherits="DesktopModules_C_LichThi_Xem_C_LichThi_Xem" %>
<p>
    Lịch thi của <b>
    <asp:Label ID="lblStuID" runat="server"></asp:Label>
    </b>
</p>
<p>
    Học kỳ:
    <asp:Label ID="lblSemester" runat="server"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    Năm học:
    <asp:Label ID="lblYear" runat="server"></asp:Label>
</p>
<p>
    Cập nhật lúc:
    <asp:Label ID="lblLastUpdatedTime" runat="server"></asp:Label>
</p>
<p>
    <asp:GridView ID="GridExamSchedule" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="ClassID" DataSourceID="SqlDataSourceExam" 
        EnableModelValidation="True" Width="100%">
        <Columns>
            <asp:BoundField DataField="ClassID" HeaderText="Mã lớp"/>
            <asp:BoundField DataField="SubNm" HeaderText="Tên lớp" ReadOnly="True" 
                SortExpression="SubNm" >
            <ControlStyle Width="40%" />
            </asp:BoundField>
            <asp:BoundField DataField="Date" DataFormatString="{0:dd-MM-yyyy}" 
                HeaderText="Ngày thi" SortExpression="Date" />
            <asp:BoundField DataField="Period" HeaderText="Ca thi" 
                SortExpression="Period" />
            <asp:BoundField DataField="Room" HeaderText="Phòng thi" SortExpression="Room" />
        </Columns>
        <RowStyle HorizontalAlign="Center" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceExam" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" SelectCommand="Select ex.ClassID, sub.SubNm, ex.Date, ex.Period, ex.Room
from ExamSchedule ex JOIN RegisterInfo r ON ex.ClassID = r.ClassID
JOIN ScheduleM s ON ex.ClassID = s.ClassID 
JOIN Subject sub ON sub.SubID = s.SubID
where r.StuID = @StuID">
        <SelectParameters>
            <asp:Parameter Name="StuID" />
        </SelectParameters>
    </asp:SqlDataSource>
</p>
<p>
    &nbsp;</p>

