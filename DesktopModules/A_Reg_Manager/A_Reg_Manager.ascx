
<%@ Control Language="C#" AutoEventWireup="true" CodeFile="A_Reg_Manager.ascx.cs" Inherits="DesktopModules_A_Reg_Manager_A_Reg_Manager" %>

<style type="text/css">
    .style1
    {
        width: 100%;
    }
    .style2
    {
        color: #CC3300;
    }
    .style3
    {
        color: #CC3300;
        font-size: large;
    }
    .style4
    {
        color: #CC3300;
        height: 33px;
    }
    .style5
    {
        height: 33px;
    }
</style>

<strong><span class="style3">Quản lí đăng kí học phần</span>
<hr />
</strong>
<asp:UpdatePanel runat="server" ID = "Panel">
<ContentTemplate>
<asp:DataList ID="DataList1" runat="server" DataSourceID="RegManageDB" 
    Width="100%">
    <ItemTemplate>
        <table class="style1">
            <tr>
                <td class="style2" width="140px">
                    Mở ĐKHP :</td>
                <td>
                    <asp:CheckBox ID="Status" runat="server" Checked ='<%# Eval("Status")%>' />
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Học kì&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            :&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
                <td>
                    <asp:TextBox ID="Term" runat="server" Text = '<%# Server.HtmlDecode(Eval("Term")as string) %>'/>
                    &nbsp;( 1 , 2 , hoặc Hè )</td>
            </tr>
            <tr>
                <td class="style2">
                    Năm học&nbsp;&nbsp;&nbsp; :
                </td>
                <td>
                    <asp:TextBox ID="Year" runat="server" Text='<%# Eval("Year") %>'/>
                    &nbsp;( VD : năm học 2009 - 2010 --&gt; điền vào : 2009)</td>
            </tr>
            <tr>
                <td class="style2">
                    Số TC tối đa :</td>
                <td>
                    <asp:TextBox ID="MaxCre" runat="server" Text='<%# Eval("MaxCre")%>'/>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Số TC tối thiểu :</td>
                <td>
                    <asp:TextBox ID="MinCre" runat="server" Text='<%# Eval("MinCre") %>'/>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Đối tượng :</td>
                <td>
                    <asp:DropDownList ID="User" runat="server" 
                    SelectedValue='<%# Eval("User") %>'>
                        <asp:ListItem Value="0">Sinh viên chính qui</asp:ListItem>
                        <asp:ListItem Value="1">ĐH từ xa</asp:ListItem>
                        <asp:ListItem Value="2">Cao học</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Lần :</td>
                <td>
                    <asp:DropDownList ID="Times" runat="server" 
                    SelectedValue='<%# Eval("Times") %>'>
                        <asp:ListItem Value="1">1</asp:ListItem>
                        <asp:ListItem Value="2">2</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style2" valign="top">
                    Ghi chú :
                </td>
                <td valign="middle">
                    <asp:TextBox ID="Notice" runat="server" Height="102px" 
                TextMode="MultiLine" Width="100%" 
                        Text='<%# Server.HtmlDecode(Eval("Notice") as string ) %>'/>
                    &nbsp;</td>
            </tr>
            <tr>
                <td align="left" class="style2">
                    <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click" 
                style="font-weight: 700">Lưu</asp:LinkButton>
                </td>
                <td >
                    <table width="100%">
                    <tr>
                        <td width="200px">
                            <asp:UpdateProgress ID="RegCrepdateProgress0" runat="server" AssociatedUpdatePanelID="Panel">
                                <ProgressTemplate>
                                    <asp:Image ID="Image1" runat="server" ImageUrl="~/images/dnnanim.gif" />
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </td >
                    </tr>
                    <tr>
                        <td width="140px">
                            <asp:Label ID="ShowInfo" runat="server" style="color: #CC3300" Width="20%"></asp:Label>
                        </td>
                    </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left" class="style2">
                    <asp:LinkButton ID="LinkButton6" runat="server" onclick="LinkButton6_Click" 
                    OnClientClick = "javascript:return confirm('Chú ý : Module đăng kí học phần sẽ được mở \nđồng thời mọi dữ liệu đăng kí cũ sẽ được xóa !\nBạn có chắc muốn khởi động không ?')"
                    style="font-weight: 700">Khởi động</asp:LinkButton>
                </td>
                <td>
                    <asp:CheckBox ID="Start_Confirm" runat="server" Checked = "false"/>
                    (Lưu ý : nút khởi động chỉ được nhấn lần đầu đối với mỗi lần đăng kí , vì dữ 
            liệu đăng kí sẽ được xóa )</td>
            </tr>
            <tr>
                <td align="left" class="style2" colspan="2">
                    <hr />
                </td>
            </tr>
            <tr>
                <td align="left" class="style4" height="30px">
                    Xóa dữ liệu :</td>
                <td class="style5" height="30px">
                    <asp:CheckBox ID="Del_Confirm" runat="server" Checked = "false"/>
                    <asp:LinkButton ID="LinkButton4" runat="server" onclick="LinkButton4_Click" 
                    OnClientClick = "javascript:return confirm('Chú ý : mọi dữ liệu đăng kí sẽ được xóa ! Bạn có chắc không ?')"
                    style="font-weight: 700" >Xóa</asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td align="left" class="style2" height="30px">
                    Sao lưu dữ liệu :</td>
                <td height="30px">
                    &nbsp;
                    <asp:LinkButton ID="LinkButton7" runat="server" onclick="LinkButton7_Click" 
                        style="font-weight: 700">Sao lưu</asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td align="left" class="style2" height="30px">
                    Phục hồi dữ liệu :</td>
                <td height="30px">
                    
                    <asp:DropDownList ID="BackupDrop" runat="server" DataSourceID="BackupLogDB" 
                        DataTextField="Log" DataValueField="Backup" >
                        <asp:ListItem Value="0">Sinh viên chính qui</asp:ListItem>
                        <asp:ListItem Value="1">ĐH từ xa</asp:ListItem>
                        <asp:ListItem Value="2">Cao học</asp:ListItem>
                    </asp:DropDownList>
                    <asp:CheckBox ID="Restore_Confirm" runat="server" Checked = "false"/>
                    &nbsp;<asp:LinkButton ID="LinkButton8" runat="server" onclick="Restore_Click" 
                        OnClientClick = "javascript:return confirm('Dữ liệu hiện thời sẽ bị mất ! Bạn có chắc muốn phục hồi dữ liệu không ?')"
                        style="font-weight: 700">Phục hồi</asp:LinkButton>
                        <asp:SqlDataSource ID="BackupLogDB" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
                        SelectCommand="SELECT * FROM [BackupLog] order by Log"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="left" class="style2" colspan="2">
                    <hr />
                </td>
            </tr>
        </table>
    </ItemTemplate>
</asp:DataList>
</ContentTemplate>
</asp:UpdatePanel>
<table class="style1">
    <tr >
        <td class="style2" width="140px">
            1. DS số lượng ĐK :</td>
        <td height="30px">
            &nbsp;
            <asp:ImageButton ID="ImageButton3" runat="server" AlternateText="Tải về" 
                ImageUrl="~/images/action_bottom.gif" onclick="Down_List_Each_Class" />
            &nbsp;Tải về</td>
        </tr>
        <tr>
            <td align="left" class="style2" height="30px">
                2. DS đóng học phí :</td>
            <td height="30px">
                &nbsp;
                <asp:ImageButton ID="ImageButton1" runat="server" AlternateText="Tải về" 
                    ImageUrl="~/images/action_bottom.gif" onclick="Down_List_Fee" />
                &nbsp;Tải về</td>
        </tr>
        <tr>
            <td align="left" class="style2" height="30px">
                3. Danh sách lớp :</td>
            <td height="30px">
                &nbsp;
                <asp:ImageButton ID="ImageButton2" runat="server" 
            ImageUrl="~/images/action_bottom.gif" onclick="Down_List_Class" />
                &nbsp;Tải về</td>
        </tr>
</table>
<asp:SqlDataSource ID="RegManageDB" runat="server" OnLoad="RegManageDB_Load"
    ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
    SelectCommand="SELECT Top 1 * FROM [RegManage]"
    UpdateCommand="Update [RegManage] set Status = @Status,Term = @Term,Year = @Year,MaxCre = @MaxCre,MinCre = @MinCre,[User] = @User ,Notice = @Notice,Times = @Times"
    DeleteCommand=" Delete From RegisterInfo ">
    <UpdateParameters>
        <asp:Parameter Name="Status" />
        <asp:Parameter Name="Term" />
        <asp:Parameter Name="Year" />
        <asp:Parameter Name="MaxCre" />
        <asp:Parameter Name="MinCre" />
        <asp:Parameter Name="User" />
        <asp:Parameter Name="Notice" />
        <asp:Parameter Name="Times" />
    </UpdateParameters>
</asp:SqlDataSource>
