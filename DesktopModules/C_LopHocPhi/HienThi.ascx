<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HienThi.ascx.cs" Inherits="DesktopModules_C_LopHocPhi_HienThi"%>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        Chọn lớp:
        <asp:DropDownList ID="ddlLop" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSourceSubject" DataTextField="ClassID" 
            DataValueField="ClassID" onselectedindexchanged="ddlLop_SelectedIndexChanged">
        </asp:DropDownList>
        &nbsp;<asp:SqlDataSource ID="SqlDataSourceSubject" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
            SelectCommand="SELECT [ClassID] FROM [ScheduleM]"></asp:SqlDataSource>
        <asp:Panel ID="Panel1" runat="server" Height="269px" ScrollBars="Vertical">
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            <asp:GridView ID="gridDS" runat="server" DataSourceID="SqlDataSourceHocPhi" 
                EnableModelValidation="True">
            </asp:GridView>
        </asp:Panel>
        <asp:SqlDataSource ID="SqlDataSourceHocPhi" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" SelectCommand="select S.StuID, S.StuNm
from Student S join RegisterInfo R  on S.StuID = R.StuID
join MSSV_Temp M on M.MSSV = S.StuID
where R.ClassID = @ClassID">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlLop" Name="ClassID" 
                    PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </ContentTemplate>
</asp:UpdatePanel>


<p>
    <asp:Button ID="btnExport" runat="server" onclick="btnExport_Click" 
        Text="Export to Excel" />
</p>



