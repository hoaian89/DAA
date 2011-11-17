<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EditAnnouncements.ascx.vb"
    Inherits="DotNetNuke.Modules.Announcements.EditAnnouncements" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Tracking" Src="~/controls/URLTrackingControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Audit" Src="~/controls/ModuleAuditControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="URL" Src="~/controls/URLControl.ascx" %>
<%@ Register Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" TagPrefix="dnn" %>
<table cellspacing="0" cellpadding="0" width="600" summary="Edit Announcements Design Table">
    <tr valign="top">
        <td class="SubHead" style="width: 150px">
            <dnn:Label ID="plTitle" runat="server" ControlName="txtTitle" Suffix=":"></dnn:Label>
        </td>
        <td style="width: 450px">
            <asp:TextBox ID="txtTitle" runat="server" MaxLength="100" Columns="30" Width="400px"
                CssClass="NormalTextBox"></asp:TextBox>
            <asp:RequiredFieldValidator ID="valTitle" resourcekey="Title.ErrorMessage" runat="server"
                CssClass="NormalRed" ControlToValidate="txtTitle" ErrorMessage="You Must Enter A Title For The Announcement"
                Display="Dynamic"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="plImage" runat="server" ControlName="urlImage" Suffix=":"></dnn:Label>
        </td>
        <td>
            <dnn:URL ID="urlImage" runat="server" Width="300" Required="False" ShowTabs="False"
                ShowFiles="True" ShowUrls="True" ShowLog="False" ShowNone="true" ShowNewWindow="False"
                ShowTrack="False" />
        </td>
    </tr>
    <tr valign="top">
        <td class="SubHead" colspan="2" style="width: 600px">
            <dnn:Label ID="plDescription" runat="server" ControlName="teDescription" Suffix=":">
            </dnn:Label>
        </td>
    </tr>
    <tr>
        <td class="SubHead" style="width: 600px" colspan="2">
            <dnn:TextEditor ID="teDescription" runat="server" Width="550" Height="300"></dnn:TextEditor>
            <asp:RequiredFieldValidator ID="valDescription" resourcekey="Description.ErrorMessage"
                runat="server" CssClass="NormalRed" ControlToValidate="teDescription" ErrorMessage="You Must Enter A Description Of The Announcement"
                Display="Dynamic"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="SubHead" style="width: 150px">
            <dnn:Label ID="plURL" runat="server" ControlName="ctlURL" Suffix=":"></dnn:Label>
        </td>
        <td style="width: 450px">
            <dnn:URL ID="ctlURL" runat="server" Width="225" ShowNone="true" />
        </td>
    </tr>
    <tr>
        <td class="SubHead" style="width: 150px">
            <dnn:Label ID="plPublishDate" Suffix=":" ControlName="txtPublishDate" runat="server">
            </dnn:Label>
        </td>
        <td style="width: 450px">
            <asp:TextBox ID="txtPublishDate" runat="server" CssClass="NormalTextBox" Width="72px"></asp:TextBox>&nbsp;
            <asp:HyperLink ID="cmdCalendar" resourcekey="Calendar" CssClass="CommandButton" runat="server">Calendar</asp:HyperLink><br />
            <asp:DropDownList ID="ddlHoursPublish" runat="server">
            </asp:DropDownList>
            &nbsp
            <asp:DropDownList ID="ddlMinutesPublish" runat="server">
            </asp:DropDownList>
            <asp:PlaceHolder ID="phAmPmPublish" runat="server">&nbsp<asp:DropDownList ID="ddlAmPmPublish"
                runat="server">
            </asp:DropDownList>
            </asp:PlaceHolder>
            <asp:CompareValidator ID="valPublishDate" resourcekey="PublishDate.ErrorMessage"
                runat="server" CssClass="NormalRed" ControlToValidate="txtPublishDate" ErrorMessage="<br>You have entered an invalid date!"
                Display="Dynamic" Type="Date" Operator="DataTypeCheck"></asp:CompareValidator>
            <asp:RequiredFieldValidator ID="valPublishDateRequired" runat="server" Display="Dynamic"
                ErrorMessage="You must enter a date" ControlToValidate="txtPublishDate" CssClass="NormalRed"
                resourcekey="PublishDateRequired.ErrorMessage"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td>
            </br>
        </td>
    </tr>
    <tr>
        <td class="SubHead" style="width: 150px">
            <dnn:Label ID="plExpireDate" Suffix=":" ControlName="txtPublishDate" runat="server">
            </dnn:Label>
        </td>
        <td style="width: 450px">
            <asp:TextBox ID="txtExpireDate" runat="server" CssClass="NormalTextBox" Width="72px"></asp:TextBox>&nbsp;
            <asp:HyperLink ID="cmdCalendar2" CssClass="CommandButton" resourcekey="Calendar"
                runat="server">Calendar</asp:HyperLink><br />
            <asp:DropDownList ID="ddlHoursExpire" runat="server">
            </asp:DropDownList>
            &nbsp
            <asp:DropDownList ID="ddlMinutesExpire" runat="server">
            </asp:DropDownList>
            <asp:PlaceHolder ID="phAmPmExpire" runat="server">&nbsp<asp:DropDownList ID="ddlAmPmExpire"
                runat="server">
            </asp:DropDownList>
            </asp:PlaceHolder>
            <asp:CompareValidator ID="valExpireDate" runat="server" Display="Dynamic" ErrorMessage="<br>You have entered an invalid date!"
                ControlToValidate="txtExpireDate" CssClass="NormalRed" resourcekey="PublishDate.ErrorMessage"
                Operator="DataTypeCheck" Type="Date"></asp:CompareValidator>
        </td>
    </tr>
    <tr>
        <td>
            </br>
        </td>
    </tr>
    <tr>
        <td class="SubHead" style="width: 150px">
            <dnn:Label ID="plViewOrder" runat="server" ControlName="txtViewOrder" Suffix=":">
            </dnn:Label>
        </td>
        <td style="width: 450px">
            <asp:TextBox ID="txtViewOrder" runat="server" MaxLength="3" Columns="20" Width="72px"
                CssClass="NormalTextBox"></asp:TextBox>
            <asp:CompareValidator ID="valViewOrder" resourcekey="ViewOrder.ErrorMessage" runat="server"
                CssClass="NormalRed" ControlToValidate="txtViewOrder" ErrorMessage="<br>View order must be an integer value."
                Display="Dynamic" Type="Integer" Operator="DataTypeCheck"></asp:CompareValidator>
        </td>
    </tr>
</table>
<p>
    <dnn:CommandButton ID="cmdUpdate" runat="server" ResourceKey="cmdUpdate" Text="Update"
        ImageUrl="~/images/save.gif" />
    &nbsp;
    <dnn:CommandButton ID="cmdCancel" runat="server" ResourceKey="cmdCancel" Text="Cancel"
        ImageUrl="~/images/lt.gif" CausesValidation="False" />
    &nbsp;
    <dnn:CommandButton ID="cmdDelete" runat="server" ResourceKey="cmdDelete" Text="Delete"
        ImageUrl="~/images/delete.gif" />
</p>
<dnn:Audit ID="ctlAudit" runat="server" />
<br />
<br />
<dnn:Tracking ID="ctlTracking" runat="server" />
