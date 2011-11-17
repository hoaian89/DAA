<%@ Control Inherits="DotNetNuke.Modules.Survey.Settings" CodeFile="Settings.ascx.vb"
    Language="vb" AutoEventWireup="false" Explicit="true" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<table cellspacing="0" cellpadding="4" border="0">
    <tr>
        <td class="SubHead" width="200">
            <dnn:Label ID="plClosingDate" Text="Survey Closing Date:" ControlName="txtClosingDate"
                runat="server" />
        </td>
        <td valign="top">
            <asp:TextBox ID="txtClosingDate" runat="server" CssClass="NormalTextBox" CausesValidation="True"></asp:TextBox>
            <asp:HyperLink ID="cmdCalendar" resourcekey="Calendar" CssClass="CommandButton" runat="server">Calendar</asp:HyperLink>&nbsp;
        </td>
    </tr>
    <tr>
        <td class="SubHead" width="200">
            <dnn:Label ID="plGraphWidth" Text="Maximum Bar Graph Width:" ControlName="txtGraphWidth"
                runat="server" />
        </td>
        <td valign="top">
            <asp:TextBox ID="txtGraphWidth" runat="server" CssClass="NormalTextBox"></asp:TextBox></td>
    </tr>
    <tr>
        <td class="SubHead" width="200">
            <dnn:Label ID="plPersonal" Text="Vote Tracking:" ControlName="rblstPersonal" runat="server" />
        </td>
        <td valign="top" height="36">
            <asp:RadioButtonList ID="rblstPersonal" CssClass="NormalTextBox" runat="server" Width="216px">
                <asp:ListItem resourcekey="No" Value="0" Selected="true">Vote tracking via cookie</asp:ListItem>
                <asp:ListItem resourcekey="Yes" Value="1">1 Vote/Registered User</asp:ListItem>
            </asp:RadioButtonList>
        </td>
    </tr>
    <tr>
        <td class="SubHead" width="200">
            <dnn:Label ID="plSurveyResults" Text="Survey Results:" ControlName="rblstSurveyResults"
                runat="server" />
        </td>
        <td valign="top" height="36">
            <asp:RadioButtonList ID="rblstSurveyResults" CssClass="NormalTextBox" Width="216px"
                runat="server" RepeatDirection="Horizontal">
                <asp:ListItem resourcekey="PublicResults" Value="0" Selected="true">Public</asp:ListItem>
                <asp:ListItem resourcekey="PrivateResults" Value="1">Private</asp:ListItem>
            </asp:RadioButtonList>
        </td>
    </tr>
    <tr>
        <td class="SubHead" width="200">
            <dnn:Label ID="plSurveyResultTemplate" Text="Survey Results Template:" ControlName="rblstSurveyResultTemplate"
                runat="server" />
        </td>
        <td height="36" valign="top">
            <asp:TextBox ID="txtSurveyResultsTremplate" runat="server" Columns="60" CssClass="NormalTextBox"
                Rows="8" TextMode="MultiLine"></asp:TextBox></td>
    </tr>
    <tr>
        <td class="SubHead" valign="top" width="200">
            <dnn:Label ID="plResultsData" Text="Survey Results Data:" ControlName="GvResults"
                runat="server" />
        </td>
        <td valign="top">
            <asp:LinkButton ID="lnkExport" runat="server" resourcekey="cmdExport" CssClass="CommandButton">Export</asp:LinkButton></td>
    </tr>
    <tr>
        <td class="SubHead" valign="top" width="200">
            <dnn:Label ID="plClearData" Text="Clear Results Data:" ControlName="GvClear"
                runat="server" />
        </td>
        <td valign="top">
            <asp:LinkButton ID="lnkClear" runat="server" CssClass="CommandButton" resourcekey="cmdClear">Clear</asp:LinkButton></td>
    </tr>
</table>
