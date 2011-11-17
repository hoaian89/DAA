<%@ Control Language="vb" CodeBehind="EditLinks.ascx.vb" AutoEventWireup="false"
    Explicit="True" Inherits="DotNetNuke.Modules.Links.EditLinks" %>
<%@ Register Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" TagPrefix="DNNWC" %>
<%@ Register TagPrefix="Portal" TagName="Tracking" Src="~/controls/URLTrackingControl.ascx" %>
<%@ Register TagPrefix="Portal" TagName="Audit" Src="~/controls/ModuleAuditControl.ascx" %>
<%@ Register TagPrefix="Portal" TagName="URL" Src="~/controls/URLControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<table width="560" cellspacing="0" cellpadding="0" border="0" summary="Edit Links Design Table">
    <tr>
        <td colspan="2">
            &nbsp;
        </td>
    </tr>
    <tr>
        <td class="SubHead" width="160">
            <dnn:Label ID="plTitle" runat="server" ControlName="txtTitle" Suffix=":"></dnn:Label>
        </td>
        <td width="365">
            <asp:TextBox ID="txtTitle" CssClass="NormalTextBox" Width="300" Columns="30" MaxLength="100"
                runat="server" />
            <br>
            <asp:RequiredFieldValidator ID="valTitle" resourcekey="valTitle.ErrorMessage" Display="Dynamic"
                ErrorMessage="You Must Enter a Title For The Link" ControlToValidate="txtTitle"
                runat="server" CssClass="NormalRed" />
        </td>
    </tr>
    <tr>
        <td class="SubHead" width="160">
            <dnn:Label ID="plURL" runat="server" ControlName="ctlURL" Suffix=":"></dnn:Label>
        </td>
        <td width="365">
            <Portal:URL ID="ctlURL" runat="server" Width="250" ShowNewWindow="True" ShowUsers="True" />
        </td>
    </tr>
    <tr height="10">
        <td colspan="2">
        </td>
    </tr>
    <tr>
        <td class="SubHead" width="160">
            <dnn:Label ID="plDescription" runat="server" ControlName="txtDescription" Suffix=":">
            </dnn:Label>
        </td>
        <td width="365">
            <asp:TextBox ID="txtDescription" CssClass="NormalTextBox" Width="300" Columns="30"
                Rows="5" TextMode="MultiLine" MaxLength="2000" runat="server" />
        </td>
    </tr>
    <tr>
        <td class="SubHead" width="160">
            <dnn:Label ID="plViewOrder" runat="server" ControlName="txtViewOrder" Suffix=":">
            </dnn:Label>
        </td>
        <td width="365">
            <asp:TextBox ID="txtViewOrder" CssClass="NormalTextBox" Width="300" Columns="30"
                MaxLength="3" runat="server" />
            <br>
            <asp:CompareValidator ID="valViewOrder" resourcekey="valViewOrder.ErrorMessage" runat="server" 
                Display="Dynamic" ControlToValidate="txtViewOrder" CssClass="NormalRed" 
                ErrorMessage="View Order must be a Number or an Empty String" Type="Integer" 
                Operator="DataTypeCheck"></asp:CompareValidator>
        </td>
    </tr>
</table>
<p>
    <DNNWC:CommandButton ID="cmdUpdate" runat="server" ImageUrl="~/images/save.gif" ResourceKey="cmdUpdate" />
    &nbsp;
    <DNNWC:CommandButton ID="cmdCancel" ResourceKey="cmdCancel" runat="server" CausesValidation="False"
        ImageUrl="~/images/action_export.gif" />
    &nbsp;
    <DNNWC:CommandButton ID="cmdDelete" ResourceKey="cmdDelete" runat="server" CssClass="CommandButton"
        CausesValidation="False" ImageUrl="~/images/delete.gif" />
</p>
<Portal:Audit ID="ctlAudit" runat="server" />
<br>
<br>
<Portal:Tracking ID="ctlTracking" runat="server" />
