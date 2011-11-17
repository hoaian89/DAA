<%@ Control Language="vb" CodeBehind="EditMedia.ascx.vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.Modules.Media.EditMedia" %>
<%@ Register TagPrefix="dnn" TagName="Tracking" Src="~/controls/URLTrackingControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Url" Src="~/controls/URLControl.ascx" %>
<table id="tblDnnMediaOptions" cellspacing="0" cellpadding="0" summary="Edit Image Design Table" class="Normal">
	<tr>
		<td class="SubHead"><dnn:label id="plAlignment" runat="server" controlname="ddlImageAlignment" suffix=":" /></td>
		<td><asp:DropDownList ID="ddlImageAlignment" Runat="server" Width="200" /></td>
	</tr>
	<tr>
		<td class="SubHead"><dnn:Label id="plURL" runat="server" controlname="ctlURL" suffix=":" /></td>
		<td><dnn:Url id="ctlURL" runat="server" width="300" showtabs="False" showfiles="True" showUrls="True"
				urltype="F" showlog="False" shownewwindow="False" showtrack="False" /></td>
	</tr>
	<tr>
		<td class="SubHead"><dnn:Label id="plAlt" runat="server" controlname="txtAlt" suffix=":" /></td>
		<td>
			<asp:TextBox id="txtAlt" CssClass="NormalTextBox dnnmedia_textbox" runat="server" />
			<asp:RequiredFieldValidator id="valAltText" resourcekey="valAltText.ErrorMessage" runat="server" controltovalidate="txtAlt"
				display="Dynamic" cssclass="NormalRed" errormessage="<br />Alternate Text Is Required" />
		</td>
	</tr>
	<tr>
		<td class="SubHead"><dnn:Label id="plWidth" runat="server" controlname="txtWidth" suffix=":" /></td>
		<td>
			<asp:TextBox id="txtWidth" CssClass="NormalTextBox dnnmedia_textbox" runat="server" /> <span class="NormalRed"><%=Me.GetLocalizedString("VideoDimsRequired.Text")%></span>
			<asp:RegularExpressionValidator id="valWidth" resourcekey="valWidth.ErrorMessage" controltovalidate="txtWidth" validationexpression="^[1-9]+[0-9]*$"
				display="Dynamic" cssclass="NormalRed" errormessage="<br />Width Must Be A Valid Integer" runat="server" />
		</td>
	</tr>
	<tr>
		<td class="SubHead"><dnn:Label id="plHeight" runat="server" controlname="txtHeight" suffix=":" /></td>
		<td>
			<asp:TextBox id="txtHeight" CssClass="NormalTextBox dnnmedia_textbox" runat="server" /> <span class="NormalRed"><%=Me.GetLocalizedString("VideoDimsRequired.Text")%></span>
			<asp:RegularExpressionValidator id="valHeight" resourcekey="valHeight.ErrorMessage" controltovalidate="txtHeight"
				validationexpression="^[1-9]+[0-9]*$" display="Dynamic" cssclass="NormalRed" errormessage="<br />Height Must Be A Valid Integer"
				runat="server" />
		</td>
	</tr>
	<tr>
	    <td colspan="2" class="SubHead">
	        <br /><asp:Label ID="lblImagesOnly" runat="server" /><hr />
	    </td>
	</tr>
	<tr>
		<td class="SubHead"><dnn:Label id="plNavigateUrl" runat="server" controlname="txtNavigateUrl" suffix=":" /></td>
		<td><dnn:Url id="ctlNavigateUrl" runat="server" width="300" required="False" showtabs="False"
				showfiles="True" showUrls="True" showlog="False" shownewwindow="False" showtrack="False" /></td>
	</tr>
	<tr>
		<td class="SubHead">&nbsp;</td>
		<td><dnn:Tracking id="ctlTracking" runat="server" /></td>
	</tr>
	<tr>
	    <td colspan="2" class="SubHead">
	        <asp:Label ID="lblVideosOnly" runat="server" /><hr />
	    </td>
	</tr>
	<tr>
	    <td class="SubHead"><dnn:Label id="lblAutoStart" runat="server" controlname="chkAutoStart" suffix=":" /></td>
	    <td><asp:CheckBox ID="chkAutoStart" runat="server" /></td>
	</tr>
	<tr>
	    <td class="SubHead"><dnn:Label id="lblLoop" runat="server" controlname="chkLoop" suffix=":" /></td>
	    <td><asp:CheckBox ID="chkLoop" runat="server" /></td>
	</tr>
	<tr>
	    <td colspan="2" class="dnnmedia_center">
	        <asp:LinkButton class="CommandButton" id="cmdUpdate" resourcekey="cmdUpdate" runat="server" borderstyle="none" text="Update" />&nbsp;
	        <asp:LinkButton class="CommandButton" id="cmdCancel" resourcekey="cmdCancel" runat="server" borderstyle="none" text="Cancel" causesvalidation="False" />
	    </td>
	</tr>
</table>