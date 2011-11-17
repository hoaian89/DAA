<%@ Control Language="vb" AutoEventWireup="false" Codebehind="EditEntry.ascx.vb" Inherits="DotNetNuke.Modules.Blog.EditEntry" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx"%>
<asp:validationsummary id="valSummary" CssClass="NormalRed" EnableClientScript="False" Runat="server" DisplayMode="BulletList"></asp:validationsummary>
<asp:requiredfieldvalidator id="valTitle" EnableClientScript="False" Runat="server" ResourceKey="valTitle.ErrorMessage"
	Display="None" ControlToValidate="txtTitle" ErrorMessage="Title is required"></asp:requiredfieldvalidator>
<asp:requiredfieldvalidator id="valDescription" EnableClientScript="False" Runat="server" ResourceKey="valDescription.ErrorMessage"
	Display="None" ControlToValidate="txtDescription" ErrorMessage="Description is required"></asp:requiredfieldvalidator>
<asp:customvalidator id="valEntry" EnableClientScript="False" Runat="server" ResourceKey="valEntry.ErrorMessage"
	Display="None" ErrorMessage="Entry is Required"></asp:customvalidator>
<asp:customvalidator id="valUpload" EnableClientScript="False" Runat="server" Display="None" ErrorMessage="Valid File Types Include JPG, GIF and PNG"></asp:customvalidator>
<asp:requiredfieldvalidator id="valEntryDate" EnableClientScript="False" Runat="server" ResourceKey="valEntryDate.ErrorMessage"
	Display="None" ControlToValidate="txtEntryDate" ErrorMessage="Entry Date is required"></asp:requiredfieldvalidator>
<asp:customvalidator id="valEntryDateData" EnableClientScript="False" Runat="server" ResourceKey="valEntryDateData.ErrorMessage"
	Display="None" ErrorMessage="Entry Date is not a valid date"></asp:customvalidator>
<table id="Table1" cellspacing="1" cellpadding="1" width="80%" border="0">
	<tr>
		<td nowrap width="10%"><asp:label id="lblEntryDate" CssClass="SubHead" ResourceKey="lblEntryDate" runat="server">Entry Date:</asp:label></td>
		<td width="40%"><asp:textbox id="txtEntryDate" CssClass="NormalTextBox" runat="server" Width="100%"></asp:textbox></td>
		<td nowrap width="10%"><asp:label id="lblChildBlog" CssClass="SubHead" ResourceKey="lblChildBlog" runat="server">Parent Blog:</asp:label></td>
		<td width="40%"><asp:dropdownlist id="cboChildBlogs" CssClass="NormalTextBox" runat="server" Width="100%" ResourceKey="cboChildBlogs.DataTextField"
				DataValueField="BlogID" DataTextField="Title"></asp:dropdownlist></td>
	</tr>
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="4"><asp:label id="lblTitle" ResourceKey="lblTitle" runat="server" cssclass="SubHead">Title:</asp:label></td>
	</tr>
	<tr>
		<td colspan="4"><asp:textbox id="txtTitle" runat="server" cssclass="NormalTextBox" width="100%"></asp:textbox></td>
	</tr>
	<tr>
		<td colspan="4"><hr width="100%" size="1">
			<br>
		</td>
	</tr>
	<tr>
		<td colspan="4"><asp:label id="lblSummary" ResourceKey="lblSummary" runat="server" cssclass="SubHead">Summary:</asp:label></td>
	</tr>
	<tr>
		<td colspan="4"><asp:label id="txtDescriptionOptional" CssClass="Normal" Runat="server" ResourceKey="txtDescriptionOptional"
				Visible="False">(The summary is optional, if you choose to not supply one, a short summary will be generated from your entry.) </asp:label></td>
	</tr>
	<tr>
		<td colspan="4"><dnn:texteditor id="txtDescription" runat="server" width="100%" height="200"></dnn:texteditor></td>
	</tr>
	<tr>
		<td colspan="4"><hr width="100%" size="1">
			<br>
		</td>
	</tr>
	<tr>
		<td colspan="4"><asp:label id="lblDescription" ResourceKey="lblDescription" runat="server" cssclass="SubHead">Blog:</asp:label></td>
	</tr>
	<tr>
		<td colspan="4"><dnn:texteditor id="teBlogEntry" runat="server" width="100%" height="400"></dnn:texteditor></td>
	</tr>
	<asp:panel id="pnlUploads" Runat="server" Visible="true">
		<TR>
			<TD colSpan="4"></TD>
		</TR>
		<TR>
			<TD colSpan="4">
				<dnn:sectionhead id="secUploadOption" runat="server" cssclass="SubHead" text="Upload Option" isExpanded="false"
					includerule="True" resourcekey="secUploadOption" section="tblUploadOptions"></dnn:sectionhead>
				<TABLE id="tblUploadOptions" runat="server">
					<TR>
						<TD noWrap width="20%">
							<asp:Label id="lblAddPicture" Runat="server" CssClass="Normal" ResourceKey="lblAddPicture">Picture:</asp:Label></TD>
						<TD width="50%"><INPUT id="picFilename" type="file" size="40" name="picFilename" runat="server">
						</TD>
						<TD width="30%">
							<asp:Button id="btnUploadPicture" Runat="server" ResourceKey="btnUploadPicture" Text="Upload"></asp:Button></TD>
					</TR>
					<TR>
						<TD>
							<asp:Label id="lblAltText" Runat="server" CssClass="Normal" ResourceKey="lblAltText">Alt Text:</asp:Label></TD>
						<TD>
							<asp:TextBox id="txtAltText" Runat="server" CssClass="Normal" size="40"></asp:TextBox></TD>
						<TD></TD>
					</TR>
					<TR>
						<TD noWrap width="20%">
							<asp:Label id="lblAddAttachment" Runat="server" CssClass="Normal" ResourceKey="lblAddAttachment">Attachment:</asp:Label></TD>
						<TD width="50%"><INPUT id="attFilename" type="file" size="40" name="attFilename" runat="server">
						</TD>
						<TD width="30%">
							<asp:Button id="btnUploadAttachment" Runat="server" ResourceKey="btnUploadAttachment" Text="Upload"></asp:Button></TD>
					</TR>
					<TR>
						<TD>
							<asp:Label id="lblAttachmentDescription" Runat="server" CssClass="Normal" ResourceKey="lblAttachmentDescription">Description</asp:Label></TD>
						<TD>
							<asp:TextBox id="txtAttachmentDescription" Runat="server" CssClass="Normal" size="40"></asp:TextBox></TD>
						<TD></TD>
					</TR>
				</TABLE>
			</TD>
		</TR>
		<TR>
			<TD colSpan="4">
				<dnn:sectionhead id="secLinkedFiles" runat="server" cssclass="SubHead" text="Linked Files" isExpanded="false"
					includerule="True" resourcekey="secLinkedFiles" section="tblLinkedFiles"></dnn:sectionhead>
				<TABLE id="tblLinkedFiles" width="100%" runat="server">
					<TR>
						<TD width="100%">
							<asp:DataGrid id="dgLinkedFiles" runat="server" Width="100%" AutoGenerateColumns="False" BorderStyle="Solid"
								ShowFooter="False" GridLines="Horizontal">
								<Columns>
									<asp:TemplateColumn HeaderText="Filename" ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="normal"
										HeaderStyle-CssClass="SubHead">
										<ItemTemplate>
											<asp:Label id=lblFileName runat="server" Text='<%# DataBinder.Eval(Container, "DataItem") %>'>
											</asp:Label>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn ItemStyle-HorizontalAlign="Right">
										<ItemTemplate>
											<asp:ImageButton id="lnkDeleteFile" runat="server" ResourceKey="lnkDeleteFile.AlternateText" AlternateText="Delete File" OnCommand="lnkDeleteFile_Command" CommandName='<%# DataBinder.Eval(Container, "DataItem") %>'>
											</asp:ImageButton>
										</ItemTemplate>
									</asp:TemplateColumn>
								</Columns>
							</asp:DataGrid></TD>
					</TR>
				</TABLE>
			</TD>
		</TR>
	</asp:panel>
	<TR>
	<tr>
		<td colspan="4"><dnn:sectionhead id="secEntryOptions" runat="server" cssclass="SubHead" text="Entry Options" isExpanded="true"
				includerule="True" resourcekey="secEntryOptions" section="tblEntryOptions"></dnn:sectionhead>
			<table id="tblEntryOptions" width="100%" runat="server">
				<tr>
					<td colspan="4"><asp:checkbox id="chkPublished" CssClass="Normal" ResourceKey="chkPublished" runat="server" checked="True"
							text="Published (If not checked, only you will see this entry)"></asp:checkbox>
						<br>
						<asp:checkbox id="chkAllowComments" CssClass="Normal" ResourceKey="chkAllowComments" runat="server"
							Text="Allow users to comment on this entry (overrides Blog Setting)"></asp:checkbox>
						<br>
						<asp:checkbox id="chkDisplayCopyright" CssClass="Normal" ResourceKey="chkDisplayCopyright" runat="server"
							Text="Display Copyright notice at the bottom of your entry." AutoPostBack="True"></asp:checkbox>
						<asp:panel id="pnlCopyright" Runat="server" Visible="False">
							<asp:Label id="lblCopyright" Runat="server" CssClass="Normal" ResourceKey="lblCopyright">Copyright: </asp:Label>
							<asp:TextBox id="txtCopyright" Runat="server" CssClass="NormalTextBox" Width="280px"></asp:TextBox>
						</asp:panel>
					</td>
				</tr>
				<tr id="trTrackingUrl" runat="server">
					<td colspan="4"><asp:Label ID="lblTrackbackUrl" Runat="server" ResourceKey="lblTrackbackUrl" CssClass="Normal">Trackback Url:</asp:Label>
						<asp:TextBox ID="txtTrackBackUrl" Runat="server" cssclass="NormalTextBox" width="100%"></asp:TextBox>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<asp:linkbutton id="cmdUpdate" ResourceKey="cmdUpdate" runat="server" cssclass="CommandButton" borderstyle="None">Update</asp:linkbutton>
&nbsp;
<asp:linkbutton id="cmdCancel" ResourceKey="cmdCancel" runat="server" cssclass="CommandButton" borderstyle="None"
	causesvalidation="False">Cancel</asp:linkbutton>
&nbsp;
<asp:linkbutton id="cmdDelete" ResourceKey="cmdDelete" runat="server" cssclass="CommandButton" borderstyle="None"
	causesvalidation="False" visible="False">Delete</asp:linkbutton>
