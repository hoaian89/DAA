<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="Portal" TagName="URL" Src="~/controls/URLControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="HelpButton" Src="~/controls/HelpButtonControl.ascx" %>
<%@ Control Language="c#" AutoEventWireup="false" Codebehind="BTBRandomImageEdit.ascx.cs" Inherits="BiteTheBullet.DNN.Modules.BTBRandomImage.BTBRandomImageEdit" %>
<P><asp:panel id="pnlAddImage" runat="server" Visible="False">
		<TABLE cellSpacing="0" cellPadding="0" width="560">
			<TR>
				<TD class="SubHead" valign="top">
					<dnn:label id="plURL" runat="server" controlname="ctlURL" suffix=":"></dnn:label></TD>
				<TD width="400">
					<portal:url id="ctlURL" runat="server" width="300" showtabs="False" showfiles="True" showUrls="True"
						urltype="F" showlog="False" shownewwindow="False" showtrack="False"></portal:url></TD>
			</TR>
			<TR vAlign="top">
				<TD class="SubHead" width="125">
					<dnn:label id="plAlt" runat="server" controlname="txtAlt" suffix=":"></dnn:label></TD>
				<TD width="400">
					<asp:textbox id="txtAlt" runat="server" columns="50" cssclass="NormalTextBox"></asp:textbox>
					<asp:RequiredFieldValidator id="rfvAlt" runat="server" ControlToValidate="txtAlt" ErrorMessage="RequiredFieldValidator"
						CssClass="NormalRed" resourcekey="Alt.ErrorMessage"></asp:RequiredFieldValidator></TD>
			</TR>
			<TR>
				<TD class="SubHead" width="125" valign="top">
				  <dnn:label id="plLink" runat="server" controlname="ctlLink" suffix=":"></dnn:label>
				</TD>
				<TD>
				  <portal:url id="ctlLink" runat="server" width="300" shownone="true" showtabs="true" showfiles="True" showUrls="True"
						urltype="N" showlog="False" shownewwindow="true" showtrack="False"></portal:url>
				</TD>
			</TR>
		</TABLE>
		<P>
			<asp:linkbutton id="cmdUpdate" runat="server" CssClass="CommandButton" resourcekey="cmdUpdate" BorderStyle="None">Update</asp:linkbutton>
			<asp:linkbutton id="cmdCancel" runat="server" CssClass="CommandButton" resourcekey="cmdCancel" BorderStyle="None"
				CausesValidation="False">Cancel</asp:linkbutton></P>
	</asp:panel>
<P></P>
<P>&nbsp;</P>
<P>
	<table cellSpacing="0" cellPadding="0" width="560">
		<tr>
			<td colSpan="3"><asp:label id="lblImages" runat="server" CssClass="SubHead"></asp:label></td>
		</tr>
		<tr>
			<td width="350"><asp:listbox id="lstImages" runat="server" DataTextField="ImageSrc" DataValueField="ImageID"
					Width="350px" Rows="5"></asp:listbox></td>
			<td vAlign="top" colspan="2"><asp:imagebutton id="cmdDeleteImage" runat="server" ImageUrl="~/images/delete.gif" AlternateText="Delete Selected Image"></asp:imagebutton>
				<dnn:helpbutton id="hbtnDeleteImageHelp" runat="server" resourcekey="cmdDeleteImage"></dnn:helpbutton></td>
		</tr>
	</table>
</P>
<P><asp:linkbutton id="cmdDone" runat="server" resourcekey="cmdDone" CssClass="CommandButton">Done</asp:linkbutton>&nbsp;
	<asp:linkbutton id="cmdAddImage" runat="server" resourcekey="cmdAddImage" CssClass="CommandButton">Add Image</asp:linkbutton></P>
