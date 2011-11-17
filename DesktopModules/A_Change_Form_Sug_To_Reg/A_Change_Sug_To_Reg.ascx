
<%@ Control Language="C#" AutoEventWireup="true" CodeFile="A_Change_Sug_To_Reg.ascx.cs" Inherits="DesktopModules_A_Change_Form_Sug_To_Reg_A_Change_Sug_To_Reg" %>
<style type="text/css">
    .style1
    {
        width: 100%;
    }
</style>
<asp:UpdatePanel runat="server" ID = "Panel">
<ContentTemplate>
<table class="style1">
    <tr>
        <td width="70">
            <asp:Button ID="Change" runat="server" Text="Button" onclick="Change_Click" />
        </td>
        <td>
            <asp:TextBox ID="ClassID" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>
            Số tối đa : 
        </td>
        <td>
            <asp:TextBox ID="Max" runat="server" Text="100"></asp:TextBox>
        </td>
    </tr>
</table>
<asp:UpdateProgress ID="RegCrepdateProgress0" runat="server" AssociatedUpdatePanelID="Panel">
    <ProgressTemplate>
        <asp:Image ID="Image1" runat="server" ImageUrl="~/images/dnnanim.gif" />
    </ProgressTemplate>
</asp:UpdateProgress>
<br />
<asp:Label ID="ShowInfo" runat="server" style="color: #CC6600"></asp:Label>
</ContentTemplate>
</asp:UpdatePanel>