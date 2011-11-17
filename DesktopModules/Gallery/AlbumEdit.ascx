<%@ Control language="vb" Inherits="DotNetNuke.Modules.Gallery.AlbumEdit" AutoEventWireup="false" Codebehind="AlbumEdit.ascx.vb" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="GalleryControlUpload" Src="./Controls/ControlUpload.ascx" %>
<%@ Register TagPrefix="dnn" TagName="GalleryControlAlbum" Src="./Controls/ControlAlbum.ascx" %>
<%@ Register TagPrefix="TTP" TagName="LookupControl" Src="./Controls/ControlLookup.ascx" %>
<%@ Reference Control="~/DesktopModules/Gallery/Controls/ControlGalleryMenu.ascx" %>

<!-- Colling meta added to remove xhtml validation errors - needs to be removed in DDN 5.0 GAL8522 - HWZassenhaus -->
<meta http-equiv="Content-Style-Type" content="text/css"/>


	<script type="text/javascript"  language="javascript" src='<%= Page.ResolveUrl("DesktopModules/Gallery/Popup/gallerypopup.js") %>'></script>
	<table class="Gallery_Border" id="Table1" cellspacing="0" cellpadding="0" width="780px" style="text-align:center">
		<tr id="rowMain" runat="server">
			<td style="width:100%; height:28px">
				<table id="tblMain" cellspacing="0" cellpadding="1" style="width:100%" border="0">
					<tr id="trNavigation"  runat="server">
						<td class="Gallery_Header" id="celGalleryMenu" valign="middle" align="right" style="white-space:nowrap; width:30"
							runat="server"></td>
						<td class="Gallery_Header" id="celBreadcrumbs" valign="middle" align="left" style="width:70%" runat="server"></td>
						<td class="Gallery_Header" valign="top" align="right" style="white-space:nowrap; width:30%; height:28px"></td>
					</tr>
					<tr>
						<td class="AltHeader" colspan="3" style="height:28px">&nbsp;
							<asp:label id="lblInfo" runat="server" cssClass="Gallery_AltHeaderText"></asp:label>
						</td>						
					</tr>
				</table>
			</td>
		</tr>
		<tr id="rowDetails" runat="server">
			<td style="width:100%; height:28px">
				<table id="tblDetails" cellspacing="1" cellpadding="1" style="text-align: left; width:100%" border="0">
					<tr>
						<td class="Gallery_SubHeader" style="width:120px; height: 43px;"><dnn:label id="plName" Text="Name:" Runat="server" resourcekey="plName" controlname="txtName"></dnn:label></td>
						<td class="Gallery_Row" align="left" style="height:43px"><asp:textbox id="txtName" runat="server" Enabled="False" CssClass="NormalTextBox" Width="95%"></asp:textbox>
                            <asp:Label ID="lblAlbumName" runat="server" CssClass="Normal" ForeColor="Red"></asp:Label>
                            <asp:RequiredFieldValidator ID="rqdFieldValidatorTxtName" runat="server" ControlToValidate="txtName" CssClass="NormalRed" ResourceKey="rqdFieldValidatorTxtName.ErrorMessage" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="validateCharacters4txtName" runat="server" ControlToValidate="txtName" CssClass="NormalRed" ResourceKey="validateCharacters4txtName.ErrorMessage" Display="Dynamic" ValidationExpression='^[a-zA-Z0-9][^\000-\037\\/:*?"><|&]*$'></asp:RegularExpressionValidator></td>
					</tr>
					<tr>
						<td class="Gallery_SubHeader" style="width:120px"><dnn:label id="plTitle" text="Title:" Runat="server" resourcekey="plTitle" controlname="txtTitle"></dnn:label></td>
						<td class="Gallery_Row" align="left" style="height:22px"><asp:textbox id="txtTitle" runat="server" CssClass="NormalTextBox" Width="95%"></asp:textbox><br />
                            <asp:RequiredFieldValidator ID="rqdFieldValidatorTxtTitle" runat="server" ControlToValidate="txtTitle" CssClass="NormalRed" ResourceKey="rqdFieldValidatorTxtTitle.ErrorMessage"></asp:RequiredFieldValidator></td>
					</tr>
					<tr>
						<td class="Gallery_SubHeader" style="width:120px"><dnn:label id="plAuthor" Text="Author:" Runat="server" resourcekey="plAuthor" controlname="txtAuthor"></dnn:label></td>
						<td class="Gallery_Row" align="left"><asp:textbox id="txtAuthor" runat="server" Width="95%" cssclass="NormalTextBox"></asp:textbox></td>
					</tr>
					<tr>
						<td class="Gallery_SubHeader" style="width:120px"><dnn:label id="plClient" Text="Client:" Runat="server" resourcekey="plClient" controlname="txtClient"></dnn:label></td>
						<td class="Gallery_Row" align="left"><asp:textbox id="txtClient" runat="server" Width="95%" cssclass="NormalTextBox"></asp:textbox></td>
					</tr>
					<tr>
						<td class="Gallery_SubHeader" style="width:120px; white-space:nowrap"><dnn:label id="plLocation" Text="Location:" Runat="server" resourcekey="plLocation" controlname="txtLocation"></dnn:label></td>
						<td class="Gallery_Row" align="left"><asp:textbox id="txtLocation" runat="server" Width="95%" cssclass="NormalTextBox"></asp:textbox></td>
					</tr>
					<tr>
						<td class="Gallery_SubHeader" style="width:120px"><dnn:label id="plDescription" Text="Description:" Runat="server" resourcekey="plDescription"
								controlname="txtDescription"></dnn:label></td>
						<td class="Gallery_Row" align="left" style="height:22px"><asp:textbox id="txtDescription" runat="server" CssClass="NormalTextBox" Width="95%" TextMode="MultiLine"></asp:textbox></td>
					</tr>
					<tr id="rowApprovedDate" runat="server">
						<td class="Gallery_SubHeader" style="width:120px"><dnn:label id="plApprovedDate" Text="ApprovedDate:" Runat="server" resourcekey="plApprovedDate"
								controlname="txtApprovedDate"></dnn:label></td>
						<td class="Gallery_Row" valign="Bottom" align="left">
						     <asp:textbox id="txtApprovedDate" runat="server" Width="180px" cssclass="NormalTextBox"></asp:textbox><asp:hyperlink id="cmdApprovedDate" runat="server" imageurl="~/DesktopModules/Gallery/Images/m_calendar.gif"
								      resourcekey="cmdApprovedDate"></asp:hyperlink>
						      <asp:rangevalidator ID="valApprovedDate" runat="server" CssClass="NormalRed" ControlToValidate="txtApprovedDate" Type="Date"
							      ErrorMessage="Invalid Date" ResourceKey="valApprovedDate.ErrorMessage" Display="Dynamic"></asp:rangevalidator>							
						</td>
					</tr>
					<tr id="rowOwner" runat="server" visible="false">
						<td class="Gallery_SubHeader" style="width:120px"><dnn:label id="plOwner" Text="Owner:" Runat="server" resourcekey="plOwner" controlname="ctlOwnerLookup"></dnn:label></td>
						<td class="Gallery_Row" align="left" style="height:25px"><TTP:LOOKUPCONTROL id="ctlOwnerLookup" runat="server"></TTP:LOOKUPCONTROL></td>
					</tr>
					<tr>
						<td class="Gallery_SubHeader" style="width:120px"><dnn:label id="plCategories" Text="Categories:" Runat="server" resourcekey="plCategories" controlname="lstCategories"></dnn:label></td>
						<td class="Gallery_Row" align="left"><asp:checkboxlist id="lstCategories" runat="server" Width="95%" RepeatColumns="1" Font-Names="Verdana,Arial"
								Font-Size="8pt"></asp:checkboxlist></td>
					</tr>
					
					<tr valign="top">
			            <td class="Gallery_MFooter" colspan="2" valign="middle" align="center">&nbsp;</td>
		            </tr>
				</table>
			</td>
		</tr>
		<tr id="rowUpload" runat="server">
			<td><dnn:GALLERYCONTROLUPLOAD id="galControlUpload" runat="server"></dnn:GALLERYCONTROLUPLOAD></td>
		</tr>
		<tr>
			<td class="AltHeader" align="right" style="height:27px">
				<asp:LinkButton id="cmdUpdate" runat="server" CssClass="CommandButton" text="Update" resourcekey="cmdUpdate"></asp:LinkButton>&nbsp;
				<asp:LinkButton id="cmdCancel" runat="server" CssClass="CommandButton" resourcekey="cmdCancel" text="Cancel" CausesValidation="false"></asp:LinkButton>
		    </td>
		</tr>
		<tr id="rowAlbumGrid" runat="server">
			<td><dnn:GALLERYCONTROLALBUM id="ControlAlbum1" runat="server"></dnn:GALLERYCONTROLALBUM></td>
		</tr>
		<tr id="rowRefuse" runat="server" visible="False">
			<td>
				<table id="Table3" cellspacing="1" cellpadding="3" style="width:100%" border="0">
					<tr>
						<td class="Gallery_Header" align="center" style="width:100%">
							<DNN:LABEL id="plRefuseTitle" Text="Private Gallery" Runat="server" resourcekey="plRefuseTitle"></DNN:LABEL></td>
					</tr>
					<tr>
						<td class="Gallery_Row" align="center"><asp:label id="lblRefuse" CssClass="Normal" Width="84%" Runat="server" resourcekey="lblRefuse"></asp:label></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
