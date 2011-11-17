<%@ Control Language="vb" AutoEventWireup="false" Inherits="DotNetNuke.Modules.Help.HelpEdit" CodeBehind="HelpEdit.ascx.vb" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/labelcontrol.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/texteditor.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.UI.WebControls" Assembly="DotNetNuke.WebControls" %>
<table cellspacing="0" cellpadding="0" width="600" summary="Edit Tutorials Design Table">
    <tr valign="top">
        <td class="SubHead" width="150">
            <dnn:Label ID="plTitle" runat="server" ControlName="txtTitle" Suffix=":"></dnn:Label>
        </td>
        <td width="450">
            <asp:TextBox ID="txtTitle" runat="server" MaxLength="100" Columns="30" Width="500"
                CssClass="NormalTextBox"></asp:TextBox>
            <asp:RequiredFieldValidator ID="valTitle" resourcekey="Title.ErrorMessage" runat="server"
                CssClass="NormalRed" ControlToValidate="txtTitle" ErrorMessage="You Must Enter A Title For The Announcement"
                Display="Dynamic"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr valign="top">
        <td class="SubHead" width="150">
            <dnn:Label ID="plShortDescription" runat="server" ControlName="txtShortDescription"
                Suffix=":"></dnn:Label>
        </td>
        <td>
            <asp:TextBox ID="teShortDescription" runat="server" Width="600" Height="100"></asp:TextBox>
        </td>
    </tr>
    <tr valign="top">
        <td class="SubHead" width="150">
            <dnn:Label ID="plDescription" runat="server" ControlName="txtDescription" Suffix=":">
            </dnn:Label>
        </td>
        <td>
            <dnn:TextEditor id="teDescription" runat="server" width="600" height="500">
            </dnn:TextEditor>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            &nbsp;
        </td>
    </tr>
    <tr valign="top">
        <td class="SubHead" width="150">
            <dnn:Label ID="plKeywords" runat="server" ControlName="txtKeyWords" Suffix=":"></dnn:Label>
        </td>
        <td width="450">
            <asp:TextBox ID="txtKeyWords" runat="server" MaxLength="100" Columns="30" Width="500"
                CssClass="NormalTextBox" TextMode="MultiLine"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="SubHead" width="150">
            <dnn:Label ID="plCategories" runat="server" Suffix=":"></dnn:Label>
        </td>
        <td>
            <dnn:DnnTree ID="DNNTree1" runat="server" CssClass="CommandButton">
            </dnn:DnnTree>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <asp:Label ID="lblErrorMessage" runat="server" CssClass="NormalRed"></asp:Label>
        </td>
    </tr>
</table>
<asp:LinkButton ID="cmdUpdate" CssClass="CommandButton" runat="server" BorderStyle="None"
    resourcekey="cmdUpdate">Update</asp:LinkButton>
<asp:LinkButton ID="cmdCancel" CssClass="CommandButton" runat="server" CausesValidation="False"
    BorderStyle="None" resourcekey="cmdCancel">Cancel</asp:LinkButton>
<asp:LinkButton ID="cmdDelete" CssClass="CommandButton" runat="server" CausesValidation="False"
    BorderStyle="None" Visible="False" resourcekey="cmdDelete">Delete</asp:LinkButton>
