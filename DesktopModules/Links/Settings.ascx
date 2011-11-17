<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Settings.ascx.vb" Inherits="DotNetNuke.Modules.Links.Settings"
    TargetSchema="http://schemas.microsoft.com/intellisense/ie3-2nav3-0" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="Portal" TagName="URL" Src="~/controls/URLControl.ascx" %>
<table cellspacing="0" cellpadding="2" border="0" summary="Edit Links Design Table">
    <tr>
        <td class="SubHead" width="150">
            <dnn:Label ID="plControl" runat="server" ControlName="optControl" Suffix=":"></dnn:Label>
        </td>
        <td valign="bottom">
            <asp:RadioButtonList ID="optControl" runat="server" CssClass="NormalTextBox" RepeatDirection="Horizontal">
                <asp:ListItem resourcekey="List" Value="L">List</asp:ListItem>
                <asp:ListItem resourcekey="Dropdown" Value="D">Dropdown</asp:ListItem>
            </asp:RadioButtonList>
        </td>
    </tr>
    <tr>
        <td class="SubHead" width="150">
            <dnn:Label ID="ploptView" runat="server" ControlName="optView" Suffix=":"></dnn:Label>
        </td>
        <td valign="bottom">
            <asp:RadioButtonList ID="optView" runat="server" CssClass="NormalTextBox" RepeatDirection="Horizontal">
                <asp:ListItem resourcekey="Vertical" Value="V">Vertical</asp:ListItem>
                <asp:ListItem resourcekey="Horizontal" Value="H">Horizontal</asp:ListItem>
            </asp:RadioButtonList>
        </td>
    </tr>
    <tr>
        <td class="SubHead" width="150">
            <dnn:Label ID="plInfo" runat="server" ControlName="optInfo" Suffix=":"></dnn:Label>
        </td>
        <td valign="bottom">
            <asp:RadioButtonList ID="optInfo" runat="server" CssClass="NormalTextBox" RepeatDirection="Horizontal">
                <asp:ListItem resourcekey="Yes" Value="Y">Yes</asp:ListItem>
                <asp:ListItem resourcekey="No" Value="N">No</asp:ListItem>
            </asp:RadioButtonList>
        </td>
    </tr>
    <tr>
        <td class="SubHead" width="150">
            <dnn:Label ID="plNoWrap" runat="server" ControlName="optNoWrap" Suffix=":"></dnn:Label>
        </td>
        <td valign="bottom">
            <asp:RadioButtonList ID="optNoWrap" runat="server" CssClass="NormalTextBox" RepeatDirection="Horizontal">
                <asp:ListItem resourcekey="Wrap" Value="W">Wrap</asp:ListItem>
                <asp:ListItem resourcekey="NoWrap" Value="NW">No Wrap</asp:ListItem>
            </asp:RadioButtonList>
        </td>
    </tr>
    <tr>
        <td class="SubHead" width="150">
            <dnn:Label ID="plIcon" runat="server" ControlName="ctlIcon" Suffix=":"></dnn:Label>
        </td>
        <td width="365">
            <Portal:URL ID="ctlIcon" runat="server" Width="250" ShowUrls="False" ShowTabs="False"
                ShowLog="False" ShowTrack="False" Required="False" />
        </td>
    </tr>
</table>
