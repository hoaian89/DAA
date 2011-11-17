<%@ Control Language="C#" AutoEventWireup="true" CodeFile="M_Collect_Info_Eng.ascx.cs" Inherits="DesktopModules_C_Collect_Info_Eng_M_Collect_Info_Eng" %>
<style type="text/css">
    .style1
    {
        color: #CC3300;
        font-size: large;
    }
</style>
<p>
    <span class="style1"><strong>Khảo sát trình độ Anh văn</strong></span>
    <hr />
    <br/>
    Sinh viên chọn một trong các mục sau :
</p>
<br/>
<br/>
<asp:RadioButtonList ID="RadioButtonList1" runat="server">
    <asp:ListItem Selected="True">Các môn tiếng Anh tại trường đều đạt 5.0 trở lên
    </asp:ListItem>
    <asp:ListItem>TOEFL ITP &gt;= 400 do ETS cấp </asp:ListItem>
    <asp:ListItem>TOEFL iBT &gt;= 40 do ETS cấp</asp:ListItem>
    <asp:ListItem>TOEIC &gt;= 500 do ETS cấp</asp:ListItem>
    <asp:ListItem>Các chứng chỉ khác </asp:ListItem>
    <asp:ListItem>Chưa đạt bằng nào</asp:ListItem>
</asp:RadioButtonList>
<br />
<asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
    Text="Chọn" />
<p>
    &nbsp;</p>
<p>
    <asp:Label ID="ShowInfo" runat="server" style="color: #990000"></asp:Label>
</p>

