<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Events.ascx.vb" Inherits="DotNetNuke.Modules.Events.Events" %>
<table cellspacing="0" cellpadding="0" width="100%" border="0">
    <tr>
        <td valign="top" align="center">
            <asp:Panel ID="pnlEventsModule" runat="server">
                <asp:PlaceHolder ID="phMain" runat="server"></asp:PlaceHolder><br />
            </asp:Panel>
        </td>
    </tr>
    <tr>
        <td valign="top" align="center">
            <asp:Label ID="lblModuleSettings" runat="server" resourcekey="lblModuleSettings" ForeColor="Red" Visible="False">Please update module settings...contact Portal Admin.</asp:Label>
        </td>
    </tr>
</table>
