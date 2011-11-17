<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Control Language="VB" AutoEventWireup="false" Inherits="DotNetNuke.Modules.UserDefinedTable.Template"
    CodeBehind="Template.ascx.vb" %>
<div>
    <asp:Label CssClass="Head" ID="dshCreateTemplate" resourcekey="dshCreateTemplate"
        runat="server" />
</div>
<div>
    <hr />
</div>
<table id="tblSave" runat="server">
    <tr>
        <td colspan="2">
            <asp:Label ID="lblSaveXslError" runat="server" CssClass="normalred" Visible="False"></asp:Label>
        </td>
    </tr>
    <tr align="center">
        <td class="SubHead" valign="top" align="left">
            <dnn:Label ID="plTitle" runat="server" ControlName="txtTitle" Suffix=":"></dnn:Label>
        </td>
        <td valign="top" align="left">
            <asp:TextBox ID="txtTitle" runat="server" Columns="80"></asp:TextBox>
        </td>
    </tr>
    <tr align="center">
        <td class="SubHead" valign="top" align="left">
            <dnn:Label ID="plDescription" runat="server" ControlName="txtDescription" Suffix=":">
            </dnn:Label>
        </td>
        <td valign="top" align="left">
            <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Columns="62"
                Rows="5"></asp:TextBox>
        </td>
    </tr>
    <tr align="center">
        <td class="SubHead" valign="top" align="left">
            <dnn:Label ID="plNumberofRecords" runat="server" ControlName="txtNumbers" Suffix=":">
            </dnn:Label>
        </td>
        <td valign="top" align="left">
            <asp:TextBox ID="txtNumbers" runat="server" Columns="4" Text="1"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td />
        <td>
            <asp:LinkButton ID="cmdSaveFile" resourcekey="cmdSaveFile" runat="server" CssClass="CommandButton"></asp:LinkButton>
            
        </td>
    </tr>
    <tr align="center">
        <td colspan="2">
            <asp:Panel ID="panConfirm" runat="server" Visible="False">
                <asp:Label ID="lblConfirm" CssClass="normalred" resourcekey="lblConfirm" runat="server"></asp:Label>&nbsp;&nbsp;
                <asp:LinkButton ID="cmdConfirmOverwriteFile" CssClass="CommandButton" resourcekey="Yes"
                    runat="server"></asp:LinkButton>&nbsp;&nbsp;
                <asp:LinkButton ID="cmdDenyOverwriteFile" CssClass="CommandButton" resourcekey="No"
                    runat="server"></asp:LinkButton>
            </asp:Panel>
        </td>
    </tr>
</table>
