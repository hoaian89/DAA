<%@ Control language="vb" CodeBehind="Settings.ascx.vb" AutoEventWireup="false" Explicit="true" Inherits="DotNetNuke.Modules.Feedback.Settings" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>



<table id="tblFeedbackSettings" runat="server" cellspacing="0" cellpadding="2" summary="Feedback Settings Design Table" border="0">
	<tr>
	    <td colspan="2"><asp:Label ID="lblErrorMsg" runat="server" visible="false"></asp:Label></td>
	</tr>
	<tr valign="top">
		<td class="SubHead"  style="width:175pt"><dnn:label id="plSendTo" runat="server" controlname="txtSendTo" suffix=":"></dnn:label></td>
		<td valign="bottom" style="width:325pt"><asp:textbox id="txtSendTo" runat="server" width="300px" cssclass="NormalTextBox" columns="35"
				maxlength="100"></asp:textbox>
			<asp:regularexpressionvalidator id="valSendTo" resourcekey="valSendTo.ErrorMessage" runat="server" cssclass="NormalRed" controltovalidate="txtSendTo"
				errormessage="<br/>Email Must be Valid" validationexpression="[\w\.-]+(\+[\w-]*)?@([\w-]+\.)+[\w-]+" display="Dynamic"></asp:regularexpressionvalidator>
		</td>
	</tr>
	<tr valign="top">
		<td class="SubHead"  style="width:175pt"><dnn:label id="plSendFrom" runat="server" controlname="txtSendFrom" suffix=":"></dnn:label></td>
		<td valign="bottom" style="width:325pt"><asp:textbox id="txtSendFrom" runat="server" width="300px" cssclass="NormalTextBox" columns="35"
				maxlength="100"></asp:textbox>
			<asp:regularexpressionvalidator id="valSendFrom" resourcekey="valSendFrom.ErrorMessage" runat="server" cssclass="NormalRed" controltovalidate="txtSendFrom"
				errormessage="<br/>Email Must be Valid" validationexpression="[\w\.-]+(\+[\w-]*)?@([\w-]+\.)+[\w-]+" display="Dynamic"></asp:regularexpressionvalidator>
		</td>
	</tr>
	<tr valign="top" >
		<td class="SubHead" style="width:175pt"><dnn:label id="plWidth" runat="server" controlname="txtWidth" suffix=":"></dnn:label></td>
		<td valign="bottom" style="width:325pt"><asp:textbox id="txtWidth" runat="server" width="300px" cssclass="NormalTextBox" columns="35"
				maxlength="100"></asp:textbox>
	        		<asp:regularexpressionvalidator id="valWidth" resourcekey="valWidth.ErrorMessage" runat="server" cssclass="NormalRed" controltovalidate="txtWidth"
				errormessage="" validationexpression="^\d{1,}$|(^(100|\d{1,2}((\.\d{1,2})?)?)%$)" display="Dynamic"></asp:regularexpressionvalidator>
	
    	</td>
	</tr>
	<tr valign="top">
		<td class="SubHead" style="width:175pt"><dnn:label id="plRows" runat="server" controlname="txtrows" suffix=":"></dnn:label></td>
		<td valign="bottom" style="width:325pt"><asp:textbox id="txtrows" runat="server" width="300px" cssclass="NormalTextBox" columns="35"
				maxlength="100"></asp:textbox>
			<asp:regularexpressionvalidator id="valRows" resourcekey="valRows.ErrorMessage" controltovalidate="txtrows" validationexpression="^[1-9]+[0-9]*$"
				display="Dynamic" cssclass="NormalRed" errormessage="<br/>Rows Must Be A Valid Integer" runat="server" />
		</td>
	</tr>
	<tr valign="top">
		<td class="SubHead" style="width:175pt"><dnn:label id="plSendCopy" runat="server" controlname="chkSendCopy" suffix=":"></dnn:label></td>
		<td valign="bottom" style="width:325pt" >
			<asp:CheckBox id="chkSendCopy" runat="server" cssclass="normal"></asp:CheckBox>
		</td>
	</tr>
	<tr valign="top">
		<td class="SubHead" style="width:175pt; height:27pt;"><dnn:label id="plOptout" runat="server" controlname="chkOptout" suffix=":"></dnn:label></td>
		<td valign="bottom" style="width:325pt;height:27pt;">
			<asp:CheckBox id="chkOptout" runat="server" cssclass="normal"></asp:CheckBox>
		</td>
	</tr>
	<tr valign="top">
		<td class="SubHead" style="width:175pt"><dnn:label id="plCategory" runat="server" controlname="cboCategory" suffix=":"></dnn:label></td>
		<td valign="bottom" style="width:325pt">
			<asp:DropDownList id="cboCategory" runat="server" cssclass="normal"></asp:DropDownList>
		</td>
	</tr>
	<tr valign="top">
		<td class="SubHead" style="width:175pt"><dnn:label id="plCategorySelectable" runat="server" controlname="chkCategory" suffix=":"></dnn:label></td>
		<td valign="bottom" style="width:325pt">
			<asp:CheckBox id="chkCategory" runat="server" cssclass="normal"></asp:CheckBox>
		</td>
	</tr>
	<tr valign="top">
		<td class="SubHead" style="width:175pt"><dnn:label id="plUseCategoryAsEmail" runat="server" controlname="chkCategoryMailto" suffix=":"></dnn:label></td>
		<td valign="bottom" style="width:325pt">
			<asp:CheckBox id="chkCategoryMailto" runat="server" cssclass="normal"></asp:CheckBox>
		</td>
	</tr>
	<tr valign="top">
		<td class="SubHead" style="width:175pt"><dnn:label id="plSubject" runat="server" controlname="txtSubject" suffix=":"></dnn:label></td>
		<td valign="bottom" style="width:325pt">
			<asp:DropDownList id="cboSubject" runat="server" cssclass="normal"/>
		</td>
	</tr>
	<tr valign="top">
		<td class="SubHead" style="width:175pt"><dnn:label id="plSubjectSelectable" runat="server" controlname="chkSubjectListVisible" suffix=":"></dnn:label></td>
		<td valign="bottom" style="width:325pt">
			<asp:RadioButton GroupName ="SubjectSelectable" id="rbSubjectListVisible" runat="server" cssclass="normal" />
		</td>
	</tr>
	<tr valign="top">
		<td class="SubHead" style="width:175pt"><dnn:label id="plSubjectEditable" runat="server" controlname="chkSubject" suffix=":"></dnn:label></td>
		<td valign="bottom" style="width:325pt">
			<asp:RadioButton  GroupName ="SubjectSelectable" id="rbSubject" runat="server" cssclass="normal" />
		</td>
	</tr>
	<tr valign="top">
		<td class="SubHead" style="width:175pt"><dnn:label id="plSubjectHidden" runat="server" controlname="rbSubjectHidden" suffix=":"></dnn:label></td>
		<td valign="bottom" style="width:325pt">
			<asp:RadioButton  GroupName ="SubjectSelectable" id="rbSubjectHidden" runat="server" cssclass="normal" />
		</td>
	</tr>
	<tr valign="top">
		<td class="SubHead" style="width:175pt"><dnn:label id="plModerated" runat="server" controlname="chkModerated" suffix=":"></dnn:label></td>
		<td valign="bottom" style="width:325pt">
			<asp:CheckBox id="chkModerated" runat="server" cssclass="normal"></asp:CheckBox>
		</td>
	</tr>
	<tr valign="top">
		<td class="SubHead" style="width:175pt"><dnn:label id="plModerationCategory" runat="server" controlname="cboModerationCategory" suffix=":"></dnn:label></td>
		<td valign="bottom" style="width:325pt">
			<asp:DropDownList id="cboModerationCategory" runat="server" cssclass="normal"></asp:DropDownList>
		</td>
	</tr>
	<tr valign="top">
		<td class="SubHead" style="width:175pt"><dnn:label id="plAsync" runat="server" controlname="chkAsync" suffix=":"></dnn:label></td>
		<td valign="bottom" style="width:325pt">
			<asp:CheckBox id="chkAsync" runat="server" cssclass="normal"></asp:CheckBox>
		</td>
	</tr>
	<tr valign="top">
		<td class="SubHead" style="width:175pt"><dnn:label id="plUseCaptcha" runat="server" controlname="chkUseCaptcha" suffix=":"></dnn:label></td>
		<td valign="bottom" style="width:325pt">
			<asp:CheckBox id="chkUseCaptcha" runat="server" cssclass="normal"></asp:CheckBox>
		</td>
	</tr>
	<tr valign="top">
		<td class="SubHead" style="width:175pt"><dnn:label id="plRequireNameField" runat="server" controlname="chkRequireNameField" suffix=":"></dnn:label></td>
		<td valign="bottom" style="width:325pt">
			<asp:CheckBox id="chkRequireNameField" runat="server" cssclass="normal"></asp:CheckBox>
		</td>
	</tr>
</table>
