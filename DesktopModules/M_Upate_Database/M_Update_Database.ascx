
<%@ Control Language="C#" AutoEventWireup="true" CodeFile="M_Update_Database.ascx.cs" Inherits="DesktopModules_M_Upate_Database_M_Update_Database" %>

<style type="text/css">
    .style1
    {
        width: 300;
    }
    .style2
    {
        width: 200px;
    }
</style>
<table bgcolor="#FFFF99" border="0" class="style1" cellpadding="5" 
    cellspacing="0">
    <tr>
        <td colspan="2" style="text-align: center" width="100%">
            <asp:Label ID="lblError" runat="server" Text=""></asp:Label>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
        </td>
    </tr>
    <tr>
        <td width="200">
<asp:Label ID="lblSubId" runat="server" Text="Mã môn học hiện tại"></asp:Label>
        </td>
        <td>
<asp:TextBox ID="txtSubId" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="style2">
<asp:Label ID="lblNewSubId" runat="server" Text="Mã môn học mới"></asp:Label>
        </td>
        <td>
<asp:TextBox ID="txtNewSubId" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="style2">
<asp:Label ID="lblCourse" runat="server" Text="Mã khóa"></asp:Label>
&nbsp;(2 số đầu MSSV)</td>
        <td>
<asp:TextBox ID="txtCourse" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="style2">
<asp:Label ID="lblDept" runat="server" Text="Mã KHOA"></asp:Label>
        </td>
        <td>
<asp:TextBox ID="txtDept" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="style2">
<asp:Label ID="lblTC" runat="server" Text="Số TC"></asp:Label>
        </td>
        <td>
<asp:TextBox ID="txtTC" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="style2">
            &nbsp;</td>
        <td>
<asp:Button ID="btnUpdate" runat="server" Text="Cập nhật" onclick="btnUpdate_Click" 
                style="margin-left: 0px" />
        </td>
    </tr>
</table>
<br />
