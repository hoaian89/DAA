<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Control language="vb" CodeBehind="CommentSettings.ascx.vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.Modules.Feedback.CommentSettings" %>
<table cellspacing="0" cellpadding="2" summary="Feedback Settings Design Table" border="0">
	<tr valign="top">
		<td class="SubHead" width="175"><dnn:label id="plCategory" runat="server" controlname="cboCategory" suffix=":" /></td>
		<td valign="bottom" width="325">
			<asp:DropDownList id="cboCategory" runat="server" cssclass="normal" />
		</td>
	</tr>
	<tr valign="top">
		<td class="SubHead" width="175"><dnn:label id="plHideEmail" runat="server" controlname="checkBoxHideEmail" suffix=":" /></td>
		<td valign="bottom" width="325">
			<asp:CheckBox id="checkBoxHideEmail" runat="server" />
		</td>
	</tr>
	<tr valign="top">
		<td class="SubHead" style="width:175px;"><dnn:label id="plHideName" runat="server" controlname="checkBoxHideName" suffix=":" /></td>
		<td valign="bottom" style="width:325px;">
			<asp:CheckBox id="checkBoxHideName" runat="server" />
		</td>
	</tr>
	<tr valign="top">
		<td class="SubHead" style="width:175px;" ><dnn:label id="plHideSubject" runat="server" controlname="checkBoxHideSubject" suffix=":" /></td>
		<td valign="bottom" style="width:325px;">
			<asp:CheckBox id="checkBoxHideSubject" runat="server" />
		</td>
	</tr>
</table>
