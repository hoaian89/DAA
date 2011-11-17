<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="SelectCategory.ascx.vb" Inherits="DotNetNuke.Modules.Events.SelectCategory" %>
<table cellspacing="0" cellpadding="0" border="0">
    <tr>
		<td class="SubHead" style="white-space:nowrap" align="right">
			<dnn:label id="lblCategory" runat="server"></dnn:label>
		</td>
		<td style="white-space:nowrap">
			<asp:DropDownList id="ddlCategories" runat="server" AutoPostBack="True" Font-Size="8pt" CssClass="NormalTextBox"
				DataValueField="CategoryName" DataTextField="CategoryName"></asp:DropDownList>
		</td>
	</tr>
</table>
