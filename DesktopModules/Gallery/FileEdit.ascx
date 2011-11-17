<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Control language="vb" Inherits="DotNetNuke.Modules.Gallery.FileEdit" AutoEventWireup="false" Codebehind="FileEdit.ascx.vb" %>
<%@ Reference Control="~/DesktopModules/Gallery/Controls/ControlBreadCrumbs.ascx" %>
<!-- Colling meta added to remove xhtml validation errors - needs to be removed in DDN 5.0 GAL8522 - HWZassenhaus -->
	<meta http-equiv="Content-Style-Type" content="text/css"/>
<script type="text/javascript" language="javascript" src='<%= Page.ResolveUrl("DesktopModules/Gallery/Popup/gallerypopup.js") %>'></script>
	<table class="Gallery_Container" cellspacing="1" cellpadding="0" width="780px" style="vertical-align:middle"
		id="tblMain">
		<tr id="rowTitle" runat="server">
			<td colspan="2" class="Gallery_Header" id="celBreadcrumbs" runat="server" align="left"
				valign="middle" style="width:100%">
			</td>
		</tr>
		<tr>
			<td colspan="2" style="height:28px">
				<asp:hyperlink id="cmdMovePrevious" runat="server"></asp:hyperlink>
				<asp:hyperlink id="cmdMoveNext" runat="server"></asp:hyperlink></td>
		</tr>
		<tr>
			<td class="Gallery_Header" style="height:28px" colspan="2">
				<asp:Label id="lblInfo" cssclass="NormalRed" runat="server"></asp:Label>
			</td>
		</tr>
		<tr id="rowInfo" runat="server">
			<td>
				<table cellspacing="1" cellpadding="0" style="width:100%" border="0" id="tblDetails">
					<tr>
						<td class="Gallery_SubHeader" style="width:120px">&nbsp;
							<dnn:label id="plPath" text="Path:" runat="server" controlname="txtPath"></dnn:label>
						</td>
						<td class="Gallery_Row" align="left">
							<asp:TextBox id="txtPath" runat="server" cssclass="NormalTextBox" enabled="False" width="100%"></asp:TextBox>
						</td>
					</tr>
					<tr>
						<td class="Gallery_SubHeader" style="width:120px">&nbsp;
							<dnn:label id="plName" text="Name:" runat="server" controlname="txtName"></dnn:label>
						</td>
						<td class="Gallery_Row" align="left" style="height:22px">
							<asp:textbox id="txtName" runat="server" enabled="False" cssclass="NormalTextBox" width="100%"></asp:textbox>
						</td>
					</tr>
					<tr>
						<td class="Gallery_SubHeader" style="width:120px">&nbsp;
							<dnn:label id="plTitle" text="Title:" runat="server" controlname="txtTitle"></dnn:label>
						</td>
						<td class="Gallery_Row" align="left" style="height:22px">
							<asp:textbox id="txtTitle" runat="server" cssclass="NormalTextBox" Width="100%"></asp:textbox>
						</td>
					</tr>
					<tr>
						<td class="Gallery_SubHeader" style="width:120px">&nbsp;
							<dnn:label id="plAuthor" text="Author:" runat="server" controlname="txtAuthor"></dnn:label>
						</td>
						<td class="Gallery_Row" align="left">
							<asp:textbox id="txtAuthor" runat="server" width="100%" cssclass="NormalTextBox"></asp:textbox>
						</td>
					</tr>
					<tr>
						<td class="Gallery_SubHeader" style="width:120px">&nbsp;
							<dnn:label id="plClient" text="Client:" runat="server" controlname="txtClient"></dnn:label>
						</td>
						<td class="Gallery_Row" align="left">
							<asp:textbox id="txtClient" runat="server" width="100%" cssclass="NormalTextBox"></asp:textbox>
						</td>
					</tr>
					<tr>
						<td class="Gallery_SubHeader" style="width:120px">&nbsp;
							<dnn:label id="plLocation" text="Location:" runat="server" controlname="txtLocation"></dnn:label>
						</td>
						<td class="Gallery_Row" align="left">
							<asp:textbox id="txtLocation" runat="server" width="100%" cssclass="NormalTextBox"></asp:textbox>
						</td>
					</tr>
					<tr>
						<td class="Gallery_SubHeader" style="width:120px">&nbsp;
							<dnn:label id="plDescription" text="Description:" runat="server" controlname="txtDescription"></dnn:label>
						</td>
						<td class="Gallery_Row" align="left" style="height:22px">
							<asp:textbox id="txtDescription" runat="server" cssclass="NormalTextBox" width="100%" textmode="MultiLine"></asp:textbox>
						</td>
					</tr>
					<tr>
						<td class="Gallery_SubHeader" style="width:120px">&nbsp;
							<dnn:label id="plCreatedDate" text="Created Date:" runat="server" controlname="txtCreatedDate"></dnn:label>
						</td>
						<td class="Gallery_Row" align="left">
							<asp:TextBox id="txtCreatedDate" runat="server" cssclass="NormalTextBox" width="180px"></asp:TextBox>
							<asp:hyperlink id="cmdCreatedDate" runat="server" imageurl="~/DesktopModules/Gallery/Images/m_calendar.gif"
							    resourcekey="cmdCreatedDate"></asp:hyperlink>
							<asp:rangevalidator ID="valCreatedDate" runat="server" CssClass="NormalRed" ControlToValidate="txtCreatedDate" Type="Date"
							      ErrorMessage="Invalid Date" ResourceKey="valInvalidDate.ErrorMessage" Display="Dynamic"></asp:rangevalidator>
						</td>
					</tr>
					<tr id="rowApprovedDate" runat="server">
						<td class="Gallery_SubHeader" style="width:120px">&nbsp;
							<dnn:label id="plApprovedDate" text="ApprovedDate:" runat="server" controlname="txtApprovedDate"></dnn:label>
						</td>
						<td class="Gallery_Row" align="left">
							<asp:textbox id="txtApprovedDate" runat="server" width="180px" cssclass="NormalTextBox"></asp:textbox>
							<asp:hyperlink id="cmdApprovedDate" runat="server" imageurl="~/DesktopModules/Gallery/Images/m_calendar.gif"
								resourcekey="cmdApprovedDate"></asp:hyperlink>
						    <asp:rangevalidator ID="valApprovedDate" runat="server" CssClass="NormalRed" ControlToValidate="txtApprovedDate" Type="Date"
							      ErrorMessage="Invalid Date" ResourceKey="valInvalidDate.ErrorMessage" Display="Dynamic"></asp:rangevalidator>						
						</td>
					</tr>
					<tr>
						<td class="Gallery_SubHeader" style="width:120px">&nbsp;
							<dnn:label id="plCategories" text="Categories:" runat="server" controlname="lstCategories"></dnn:label>
						</td>
						<td class="Gallery_Row" align="left">
							<asp:checkboxlist id="lstCategories" cssclass="Normal" runat="server" width="100%" repeatcolumns="1"></asp:checkboxlist>
						</td>
					</tr>
				</table>
			</td>
			<td class="Gallery_Row" valign="middle" align="center" style="width:150px">
				<table cellspacing="1" cellpadding="0" style="width:100%" border="0" id="tblImageEdit">
					<tr>
						<td valign="middle" align="center" style="width:100%; height:100%">
							<asp:hyperlink id="imgFile" runat="server" resourcekey="EditImage"></asp:hyperlink></td>
					</tr>
					<tr>
						<td valign="middle" align="center">
							<asp:hyperlink id="lnkEditImage" cssclass="CommandButton" runat="server" resourcekey="EditImage">Edit Image</asp:hyperlink></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr valign="middle">
			<td class="Gallery_Header" align="center" colspan="2">
				<asp:LinkButton id="cmdSave" cssclass="CommandButton" resourcekey="cmdUpdate" text="Update" runat="server" />&nbsp;
				<asp:LinkButton id="cmdReturn" cssclass="CommandButton" resourcekey="cmdCancel" text="Cancel" runat="server" CausesValidation="false" />
			</td>
		</tr>
	</table>
