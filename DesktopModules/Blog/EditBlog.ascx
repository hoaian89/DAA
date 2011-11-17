<%@ Control Language="vb" AutoEventWireup="false" Codebehind="EditBlog.ascx.vb" Inherits="DotNetNuke.Modules.Blog.EditBlog" %>
<asp:validationsummary id="valSummary" EnableClientScript="True" Runat="server" CssClass="NormalRed"></asp:validationsummary>
<asp:requiredfieldvalidator id="valTitle" Runat="server" Display="None" ErrorMessage="Title is Required" ControlToValidate="txtTitle"
	resourcekey="valTitle.ErrorMessage"></asp:requiredfieldvalidator>
<asp:requiredfieldvalidator id="valTitleDescription" Runat="server" Display="None" ErrorMessage="Title Description is Required"
	resourcekey="valTitleDescription.ErrorMessage" ControlToValidate="txtDescription"></asp:requiredfieldvalidator>
<TABLE class="Normal" id="Table2" cellSpacing="1" cellPadding="1" width="500" border="0">
	<tr>
		<td><asp:label id="lblOptions" cssclass="SubHead" runat="server" ResourceKey="lblOptions">Blog Options:</asp:label></td>
	</tr>
	<TR>
		<TD><asp:label id="lblOptionsDescription" runat="server" ResourceKey="lblOptionsDescription">These options control the main blog features.</asp:label></TD>
	</TR>
	<TR>
		<TD>&nbsp;</TD>
	</TR>
	<TR>
		<TD><asp:label id="lblTitle" cssclass="SubHead" runat="server" ResourceKey="lblTitle">Title:</asp:label></TD>
	</TR>
	<TR>
		<TD><asp:label id="lblTitleDescription" runat="server" ResourceKey="lblTitleDescription">This is the display title for your blog. It will display at the top of your 
			entry list and in the blog directory.</asp:label></TD>
	</TR>
	<TR>
		<TD><asp:textbox id="txtTitle" cssclass="NormalTextBox" runat="server" width="100%" ResourceKey="txtTitle"></asp:textbox></TD>
	</TR>
	<TR>
		<TD>&nbsp;</TD>
	</TR>
	<TR>
		<TD><asp:label id="lblDescription" cssclass="SubHead" runat="server" ResourceKey="lblDescription">Description:</asp:label></TD>
	</TR>
	<TR>
		<TD><asp:label id="lblDescriptionDescription" runat="server" ResourceKey="lblDescriptionDescription">This is a brief summary description of your blog. It's a good place to describe 
			your intentions with your blog and what information readers can expect.</asp:label></TD>
	</TR>
	<TR>
		<TD><asp:textbox id="txtDescription" cssclass="NormalTextBox" runat="server" width="100%" rows="5"
				textmode="MultiLine"></asp:textbox></TD>
	</TR>
	<TR>
		<TD>&nbsp;</TD>
	</TR>
	<TR>
		<TD><asp:checkbox id="chkPublic" cssclass="Normal" runat="server" text="Make this blog public" ResourceKey="chkPublic"></asp:checkbox></TD>
	</TR>
	<TR>
		<TD>&nbsp;</TD>
	</TR>
	<TR>
		<TD><asp:label id="lblUserIdentity" runat="server" ResourceKey="lblUserIdentity">When displaying your identity use:</asp:label><br>
			<asp:radiobuttonlist id="rdoUserName" CssClass="Normal" runat="server" RepeatDirection="Horizontal">
				<asp:ListItem Value="False" Selected="True" ResourceKey="rdoUserName_UserName">User Name</asp:ListItem>
				<asp:ListItem Value="True" ResourceKey="rdoUserName_FullName">Full Name</asp:ListItem>
			</asp:radiobuttonlist></TD>
	</TR>
	<tr>
		<td>
			<hr>
			<br>
		</td>
	</tr>
	<tr>
		<td><asp:label id="lblMetaWeblogOptions" cssclass="SubHead" runat="server" ResourceKey="lblMetaWeblogOptions">MetaWeblog Options:</asp:label></td>
	</tr>
	<TR>
		<TD><asp:label id="lblMetaWeblogOptionsDescription" runat="server" ResourceKey="lblMetaWeblogOptionsDescription">Use the following URL to connect to your blog using a MetaWeblog enabled client such as Windows Live Writer or Word 2007.  Change the tabid parameter as needed if this blog appears on a different tab.</asp:label></TD>
	</TR>
	<TR>
		<TD><br>
			<asp:label id="lblMetaWeblogUrl" runat="server">http://www.yourdomain.com/desktopmodules/blog/blogpost.ashx</asp:label></TD>
	</TR>
	<tr>
		<td>
			<hr>
			<br>
		</td>
	</tr>
	<tr>
	<tr>
		<td><asp:label id="lblCommentOptions" cssclass="SubHead" runat="server" ResourceKey="lblCommentOptions">Comment Options:</asp:label></td>
	</tr>
	<TR>
		<TD><asp:label id="lblCommentOptionsDescription" runat="server" ResourceKey="lblCommentOptionsDescription">These options control the comment related settings.</asp:label></TD>
	</TR>
	<TR>
		<TD>
			<P>
				<asp:checkbox id="chkComments" cssclass="Normal" runat="server" text="Allow users to post comments"
					AutoPostBack="True" ResourceKey="chkComments"></asp:checkbox><br>
				<asp:checkbox id="chkMustApproveComments" cssclass="Normal" runat="server" Enabled="False" text="Approval for user comments required"
					ResourceKey="chkMustApproveComments"></asp:checkbox><br>
				<asp:checkbox id="chkAllowAnonymous" cssclass="Normal" runat="server" Text="Allow anonymous users to post comments"
					AutoPostBack="True" ResourceKey="chkAllowAnonymous"></asp:checkbox><br>
				<asp:checkbox id="chkMustApproveAnonymous" cssclass="Normal" runat="server" Enabled="False" Text="Approval for anonymous comments required"
					ResourceKey="chkMustApproveAnonymous"></asp:checkbox><br>
				<asp:checkbox id="chkAllowTrackbacks" cssclass="Normal" runat="server" Text="Allow Trackback comments"
					AutoPostBack="True" ResourceKey="chkAllowTrackbacks"></asp:checkbox><br>
				<asp:checkbox id="chkMustApproveTrackbacks" cssclass="Normal" runat="server" Enabled="False" Text="Approval for Trackback Comments required"
					ResourceKey="chkMustApproveTrackbacks"></asp:checkbox><br>
				<asp:checkbox id="chkEmailNotification" cssclass="Normal" runat="server" Text="Send mail notification after comments are posted"
					ResourceKey="chkEmailNotification"></asp:checkbox><br>
				<asp:checkbox id="chkCaptcha" cssclass="Normal" runat="server" Text="Use CAPTCHA for comments"
					ResourceKey="chkCaptcha"></asp:checkbox><br>
			</P>
			<P></P>
		</TD>
	</TR>
	<tr>
		<td>
			<hr>
			<br>
		</td>
	</tr>
	<tr>
		<td><asp:label id="lblTrackbackOptions" cssclass="SubHead" runat="server" ResourceKey="lblTrackbackOptions">Trackback Options:</asp:label></td>
	</tr>
	<TR>
		<TD><asp:label id="lblTrackbackOptionsDescription" runat="server" ResourceKey="lblTrackbackOptionsDescription">These options control the Trackback related settings.</asp:label></TD>
	</TR>
	<TR>
		<TD>
			<P>
				<asp:checkbox id="chkAutoTrackbacks" cssclass="Normal" runat="server" Text="Auto Discovery (Client Mode)"
					ResourceKey="chkAutoTrackbacks"></asp:checkbox></P>
			<P></P>
		</TD>
	</TR>
	<tr>
		<td>
			<hr>
			<br>
		</td>
	</tr>
	<TR>
		<TD><asp:label id="lblSyndicationOptions" CssClass="SubHead" runat="server" ResourceKey="lblSyndicationOptions">Syndication Options:</asp:label></TD>
	</TR>
	<TR>
		<TD>
			<p><asp:checkbox id="chkSyndicate" cssclass="Normal" runat="server" text="Syndicate this blog." ResourceKey="chkSyndicate"></asp:checkbox><br>
				<asp:checkbox id="chkSyndicateIndependant" cssclass="Normal" runat="server" text="Syndicate independantly<br />(If not checked it will be syndicated as a category of the parent blog)"
					ResourceKey="chkSyndicateIndependant"></asp:checkbox></p>
			<p class="Normal"><asp:label id="lblSyndicationEmail" runat="server" ResourceKey="lblSyndicationEmail">Use this email for the "ManagingEditor" rss field:</asp:label><br>
				<asp:textbox class="NormalTextBox" id="txtSyndicationEmail" Runat="server" Width="300px"></asp:textbox></p>
		</TD>
	</TR>
	<TR>
		<TD>
			<HR>
			&nbsp;</TD>
	</TR>
	<TR>
		<TD><asp:label id="lblDateTime" CssClass="SubHead" runat="server" ResourceKey="lblDateTime">Date and Time Options:</asp:label></TD>
	</TR>
	<TR>
		<TD><asp:label id="lblDateTimeDescription" runat="server" ResourceKey="lblDateTimeDescription">These options control how date and time are displayed within your blog. This 
			setting effects all categories and entries within your blog.</asp:label></TD>
	</TR>
	<TR>
		<TD>
			<TABLE id="Table3" cellSpacing="1" cellPadding="1" width="100%" border="0">
				<TR>
					<TD height="20"><asp:label id="lblTimeZone" CssClass="SubHead" runat="server" ResourceKey="lblTimeZone">Time Zone:</asp:label></TD>
					<TD height="20"><asp:dropdownlist id="cboTimeZone" width="400px" CssClass="NormalTextBox" runat="server" AutoPostBack="True"></asp:dropdownlist></TD>
				</TR>
				<TR>
					<TD><asp:label id="lblCulture" CssClass="SubHead" runat="server" ResourceKey="lblCulture">Culture:</asp:label></TD>
					<TD><asp:dropdownlist id="cboCulture" width="400px" CssClass="NormalTextBox" runat="server" AutoPostBack="True"></asp:dropdownlist></TD>
				</TR>
				<TR>
					<TD><asp:label id="lblDateFormat" CssClass="SubHead" runat="server" ResourceKey="lblDateFormat">Date Format:</asp:label></TD>
					<TD><asp:dropdownlist id="cboDateFormat" width="400px" CssClass="NormalTextBox" runat="server"></asp:dropdownlist></TD>
				</TR>
			</TABLE>
		</TD>
	</TR>
	<tr>
		<td>
			<hr>
			<br>
		</td>
	</tr>
	<TR>
		<TD><asp:label id="lblRegenerate" cssclass="SubHead" runat="server" ResourceKey="lblRegenerate">Regenerate Blog PermaLinks:</asp:label></TD>
	</TR>
	<TR>
		<TD><asp:label id="lblRegenerateDescription" runat="server" ResourceKey="lblRegenerateDescription">Regenerate all blog permalinks.  This link can be used after the Friendly URLs setting has been changed for the site.</asp:label></TD>
	</TR>
	<TR>
		<TD><asp:linkbutton id="cmdGenerateLinks" runat="server" CausesValidation="False" BorderStyle="none"
				Text="Regenerate Blog Permalinks" ResourceKey="cmdGenerateLinks" CssClass="CommandButton"></asp:linkbutton></TD>
	</TR>
	<tr>
		<td>
			<hr>
			<br>
		</td>
	</tr>
	<asp:panel id="pnlChildBlogs" Runat="server">
		<TR>
			<TD>
				<asp:label id="lblChildBlogs" ResourceKey="lblChildBlogs" runat="server" cssclass="SubHead">Child Blogs:</asp:label></TD>
		</TR>
		<TR>
			<TD>
				<asp:label id="lblChildBlogsDescription" ResourceKey="lblChildBlogsDescription" runat="server">If you would like to break your blog up into different categories, this is 
				where you define them. Having&nbsp;Child-Blogs allows you to create 
				sub-blogs&nbsp;within your blog. Each one has it's own options for publication 
				and can syndicated separately from your root blog.</asp:label></TD>
		</TR>
		<TR>
			<TD>
				<TABLE id="Table1" cellSpacing="1" cellPadding="0" width="100%" border="0">
					<TR>
						<TD width="100%" rowSpan="3">
							<asp:ListBox id="lstChildBlogs" CssClass="NormalTextBox" runat="server" Width="100%" Rows="5"></asp:ListBox></TD>
						<TD width="40">
							<asp:Button id="btnAddChildBlog" CssClass="Normal" runat="server" Enabled="False" Text="Add"
								Width="70px" resourceKey="cmdAdd"></asp:Button></TD>
					</TR>
					<TR>
						<TD width="40">
							<asp:Button id="btnEditChildBlog" CssClass="Normal" runat="server" Enabled="False" Text="Edit"
								Width="70px" resourceKey="cmdEdit"></asp:Button></TD>
					</TR>
					<TR>
						<TD width="40">
							<asp:Button id="btnDeleteChildBlog" CssClass="Normal" runat="server" Enabled="False" Text="Delete"
								Width="70px" resourceKey="cmdDelete"></asp:Button></TD>
					</TR>
				</TABLE>
			</TD>
		</TR>
		<TR>
			<TD>
				<HR>
				<BR>
			</TD>
		</TR>
	</asp:panel></TABLE>
<asp:linkbutton id="cmdUpdate" cssclass="CommandButton" runat="server" borderstyle="None" ResourceKey="cmdUpdate">Update</asp:linkbutton>&nbsp;
<asp:linkbutton id="cmdCancel" cssclass="CommandButton" runat="server" causesvalidation="False"
	borderstyle="None" ResourceKey="cmdCancel">Cancel</asp:linkbutton>&nbsp;
<asp:linkbutton id="cmdDelete" cssclass="CommandButton" runat="server" causesvalidation="False"
	borderstyle="None" visible="False" ResourceKey="cmdDelete">Delete</asp:linkbutton>
