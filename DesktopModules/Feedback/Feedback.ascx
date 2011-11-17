<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" Codebehind="Feedback.ascx.vb" Inherits="DotNetNuke.Modules.Feedback.Feedback" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls"%>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<asp:Panel runat="server" ID="pnlFeedbackFormFields">
<table cellspacing="0" cellpadding="4" border="0" summary="Feedback Design Table" width="100%">
	<tr valign="top">
		<td class="SubHead" style="white-space:nowrap;">
			<dnn:label id="plEmail" runat="server" controlname="txtEmail" suffix=":"></dnn:label>
			<asp:textbox id="txtEmail" runat="server"  cssclass="NormalTextBox" columns="35"
				maxlength="100"></asp:textbox>
			<asp:requiredfieldvalidator id="valEmail1" runat="server" cssclass="NormalRed" display="Dynamic" errormessage="<br\>Email Is Required."
				controltovalidate="txtEmail" resourcekey="valEmail1" ValidationGroup="FeedbackForm"></asp:requiredfieldvalidator>
			<asp:regularexpressionvalidator id="valEmail2" runat="server" cssclass="NormalRed" display="Dynamic" errormessage="<br\>Email Must be Valid."
				controltovalidate="txtEmail" resourcekey="valEmail2" ValidationGroup="FeedbackForm" validationexpression="[\w\.-]+(\+[\w-]*)?@([\w-]+\.)+[\w-]+"></asp:regularexpressionvalidator>

		</td>
	</tr>
	<tr valign="top">
		<td class="SubHead">
			<dnn:label id="plName" runat="server" controlname="txtName" suffix=":"></dnn:label>
			<asp:textbox id="txtName" runat="server"  cssclass="NormalTextBox" columns="35"
				maxlength="100"></asp:textbox>
			<asp:requiredfieldvalidator id="valName" runat="server" cssclass="NormalRed" display="Dynamic" errormessage="<br\>Name Is Required."
				controltovalidate="txtName" Enabled="false" resourcekey="valName" ValidationGroup="FeedbackForm"></asp:requiredfieldvalidator>
		
		</td>
	</tr>
	<tr valign="top" id="trSubject" runat="server" visible="false">
		<td class="SubHead">
			<dnn:label id="plSubject" runat="server" controlname="cboSubject" suffix=":"></dnn:label>
			<asp:DropDownList id="cboSubject" runat="server" cssclass="NormalTextBox"></asp:DropDownList>
		</td>
	</tr>
	<tr valign="top" id="trSubject2" runat="server">
		<td class="SubHead">
			<dnn:label id="plSubject2" runat="server" controlname="txtSubject" suffix=":"></dnn:label>
			<asp:textbox id="txtSubject" runat="server"  cssclass="NormalTextBox" columns="35"
				maxlength="100"></asp:textbox>
		</td>
	</tr>
	<tr valign="top" id="trCategory" runat="Server">
		<td class="SubHead" style="white-space:nowrap;">
			<dnn:label id="plCategory" runat="server" controlname="cboCategory" suffix=":"></dnn:label>
			<asp:DropDownList id="cboCategory" runat="server" CssClass="normaltextbox"></asp:DropDownList>
		</td>
	</tr>
	<tr valign="top">
		<td class="SubHead">
			<dnn:label id="plBody" runat="server" controlname="txtBody" suffix=":"></dnn:label>
			<asp:textbox id="txtBody" runat="server"  columns="35" textmode="Multiline" rows="10"
				cssclass="NormalTextBox"></asp:textbox>
			<asp:requiredfieldvalidator id="rfvBody" runat="server" cssclass="NormalRed" display="Dynamic" errormessage=""
				controltovalidate="txtBody" resourcekey="valBody" ValidationGroup="FeedbackForm"></asp:requiredfieldvalidator>
		
		</td>
	</tr>
	<tr valign="top" id="trCopy" runat="server">
		<td class="SubHead" style="white-space:nowrap;">
			<asp:CheckBox id="chkCopy" Runat="server" cssclass="NormalTextBox"></asp:CheckBox><dnn:label id="plCopy" runat="server" controlname="chkCopy" suffix="?"></dnn:label>
		</td>
	</tr>
	<tr id="trCaptcha1" runat="server">
		<td class="SubHead" align="center"><dnn:label id="plCaptcha" controlname="ctlCaptcha" runat="server" text="Captcha:"></dnn:label></td>
	</tr>
	<tr id="trCaptcha2" runat="server">
		<td  align="center"><dnn:captchacontrol  id="ctlCaptcha" captchawidth="130" captchaheight="40" cssclass="Normal" runat="server" errorstyle-cssclass="NormalRed"  /></td>
	</tr>
	<tr valign="top">
		<td align="center">
			
			<asp:linkbutton id="cmdSend" ValidationGroup="FeedbackForm" resourcekey="cmdSend" runat="server" cssclass="CommandButton" causesvalidation="True">Send</asp:linkbutton>
		</td>
	</tr>
</table>
</asp:Panel>

<table cellspacing="0" cellpadding="4" border="0" summary="Feedback Submit Table" width="100%">
	<tr valign="top">
		<td align="center" colspan="2">
			<asp:label id="lblMessage" runat="server" cssclass="NormalRed"></asp:label><br />
			<asp:linkbutton id="cmdCancel" ValidationGroup="FeedbackForm" Visible="false" resourcekey="cmdCancel" runat="server" cssclass="CommandButton" causesvalidation="False">Cancel</asp:linkbutton>
			&nbsp;
		</td>
	</tr>
</table>