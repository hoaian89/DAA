<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx"%>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="Portal" TagName="URL" Src="~/controls/URLControl.ascx" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Settings.ascx.vb" Inherits="DotNetNuke.Modules.Repository.Settings" TargetSchema="http://schemas.microsoft.com/intellisense/ie3-2nav3-0" %>
<TABLE cellSpacing="0" cellPadding="2" border="0" class="normal">
	<tr valign="top">
		<td class="normal">
			<br>
			<dnn:label id="plDescription" runat="server" controlname="txtDesktopHTML" suffix=":"></dnn:label><br>
			<dnn:texteditor id="teContent" runat="server" height="200" width="560"></dnn:texteditor>
			<br>
			<BR>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<asp:Table ID="tblCategories" Runat="server" width="100%">
				<asp:TableRow>
					<asp:TableCell HorizontalAlign="Left" VerticalAlign="Top" CssClass="normal" ColumnSpan="2">
						<dnn:label id="plCategory" runat="server" controlname="txtNewCategory" suffix=":"></dnn:label><br>
						<asp:DropDownList ID="ddlParentCategory" Runat="server" CssClass="normal" width="400" AutoPostBack="True"></asp:DropDownList><br>
						<asp:TextBox ID="txtNewCategory" Runat="server" CssClass="normal" TextMode="SingleLine" Width="400"></asp:TextBox>&nbsp;
						<asp:LinkButton ID="lbAddCategory" Runat="server" CssClass="normal">Add NEW Category</asp:LinkButton>
						&nbsp;
						<asp:LinkButton ID="lbCancelCategory" Runat="server" CssClass="normal" Visible="False">CANCEL</asp:LinkButton>
						<br>
				</asp:TableCell>
				</asp:TableRow>
				<asp:TableRow>
					<asp:TableCell Width="400" HorizontalAlign="Left" VerticalAlign="Top" CssClass="normal">
						<asp:ListBox ID="lstCategories" Runat="server" CssClass='normal"' Width="400" DataTextField="Category"
							DataValueField="ItemId"></asp:ListBox>
						<br>
					</asp:TableCell>
					<asp:TableCell Width="100%" HorizontalAlign="Left" VerticalAlign="Top" CssClass="normal">
						<asp:imagebutton id="cmdUp" runat="server" AlternateText="Move Category Up" CommandName="up" ImageUrl="~/images/up.gif"
							BorderColor="white" BorderWidth="0"></asp:imagebutton>
						<br>
						<asp:imagebutton id="cmdDown" runat="server" AlternateText="Move Category Down" CommandName="down"
							ImageUrl="~/images/dn.gif" BorderColor="white" BorderWidth="0"></asp:imagebutton>
						<br>
						<asp:imagebutton id="cmdEdit" runat="server" AlternateText="Edit Category" ImageUrl="~/images/edit.gif"
							BorderColor="white" BorderWidth="0"></asp:imagebutton>
						<br>
						<asp:imagebutton id="cmdDelete" runat="server" AlternateText="Delete Category" ImageUrl="~/images/delete.gif"
							BorderColor="white" BorderWidth="0"></asp:imagebutton>
						<br>
					</asp:TableCell>
				</asp:TableRow>
			</asp:Table>
			<asp:Label ID="lblCategoryMsg" Runat="server" CssClass="normalred"></asp:Label>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<dnn:label id="lblAllFiles" runat="server" controlname="cbAllFiles" suffix=":"></dnn:label><br>
			<asp:CheckBox ID="cbAllFiles" Runat="server" CssClass="normal" Text="Allow user to view All Files" />
			<BR>
			<br>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<asp:Table ID="tblAtrributes" Runat="server" width="100%">
				<asp:TableRow>
					<asp:TableCell HorizontalAlign="Left" VerticalAlign="Top" CssClass="normal" ColumnSpan="2">
						<dnn:label id="plAttribute" runat="server" suffix=":"></dnn:label><br>
						<asp:TextBox ID="txtNewAttribute" Runat="server" CssClass="normal" TextMode="SingleLine" Width="175"></asp:TextBox>&nbsp;
						<asp:LinkButton ID="lbAddAttribute" Runat="server" CssClass="normal">Add NEW Attribute</asp:LinkButton>
						&nbsp;
						<asp:LinkButton ID="lbCancelAttribute" Runat="server" CssClass="normal" Visible="False">CANCEL</asp:LinkButton>
						<br>
					</asp:TableCell>
					<asp:TableCell HorizontalAlign="Left" VerticalAlign="Top" CssClass="normal" ColumnSpan="2">
						<dnn:label id="plValues" runat="server" suffix=":"></dnn:label><br>
						<asp:TextBox ID="txtNewValue" Runat="server" CssClass="normal" TextMode="SingleLine" Width="175"></asp:TextBox>&nbsp;
						<asp:LinkButton ID="lbAddValue" Runat="server" CssClass="normal">Add NEW Value</dnn:label></asp:LinkButton>
						&nbsp;
						<asp:LinkButton ID="lbCancelValue" Runat="server" CssClass="normal" Visible="False">CANCEL</asp:LinkButton>
						<br>
					</asp:TableCell>
				</asp:TableRow>
				<asp:TableRow>
					<asp:TableCell Width="205" HorizontalAlign="Left" VerticalAlign="Top" CssClass="normal">
						<asp:ListBox ID="lstAttributes" Runat="server" CssClass='normal"' Width="300" DataTextField="AttributeName"
							DataValueField="ItemId" AutoPostBack="True"></asp:ListBox>
						<br>
					</asp:TableCell>
					<asp:TableCell Width="100%" HorizontalAlign="Left" VerticalAlign="Top" CssClass="normal">
						<asp:imagebutton id="cmdEditAttr" runat="server" AlternateText="Edit Attribute" ImageUrl="~/images/edit.gif"
							BorderColor="white" BorderWidth="0"></asp:imagebutton>
						<br>
						<asp:imagebutton id="cmdDeleteAttr" runat="server" AlternateText="Delete Attribute" ImageUrl="~/images/delete.gif"
							BorderColor="white" BorderWidth="0"></asp:imagebutton>
						<br>
					</asp:TableCell>
					<asp:TableCell Width="205" HorizontalAlign="Left" VerticalAlign="Top" CssClass="normal">
						<asp:ListBox ID="lstValues" Runat="server" CssClass='normal"' Width="300" DataTextField="ValueName"
							DataValueField="ItemId"></asp:ListBox>
						<br>
					</asp:TableCell>
					<asp:TableCell Width="100%" HorizontalAlign="Left" VerticalAlign="Top" CssClass="normal">
						<asp:imagebutton id="cmdEditValue" runat="server" AlternateText="Edit Value" ImageUrl="~/images/edit.gif"
							BorderColor="white" BorderWidth="0"></asp:imagebutton>
						<br>
						<asp:imagebutton id="cmdDeleteValue" runat="server" AlternateText="Delete Value" ImageUrl="~/images/delete.gif"
							BorderColor="white" BorderWidth="0"></asp:imagebutton>
						<br>
					</asp:TableCell>
				</asp:TableRow>
			</asp:Table>
			<br>
			<BR>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<dnn:label id="plDefaultSort" runat="server" suffix=":"></dnn:label><br>
			<asp:DropDownList ID="ddlDefaultSort" Runat="server" CssClass="normal" Width="200px">
				<asp:ListItem Value="date">Last Updated</asp:ListItem>
				<asp:ListItem Value="downloads">Downloads</asp:ListItem>
				<asp:ListItem Value="rating">User Rating</asp:ListItem>
				<asp:ListItem Value="title">Title</asp:ListItem>
				<asp:ListItem Value="author">Author</asp:ListItem>
				<asp:ListItem Value="cdate">Uploaded Date</asp:ListItem>
			</asp:DropDownList>
			<br>
			<br>
			<BR>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<dnn:label id="plPageSize" runat="server" controlname="txtPageSize" suffix=":"></dnn:label><br>
			<asp:TextBox ID="txtPageSize" Runat="server" CssClass="normal" Width="50"></asp:TextBox>
			<br>
			<br>
			<BR>
		</td>
	</tr>
	<!--
	<tr>
		<td valign="top">
			<dnn:label id="plUploadFields" runat="server" suffix=":"></dnn:label><br>
			<asp:CheckBoxList ID="cblUploadTypes" Runat="server" CssClass="normal">
				<asp:ListItem Value="F">Files</asp:ListItem>
				<asp:ListItem Value="U">Links (URLs)</asp:ListItem>
				<asp:ListItem Value="I">Images</asp:ListItem>
				<asp:ListItem Value="L">Image Links (URLs)</asp:ListItem>
			</asp:CheckBoxList>
			<br>
			<BR>
		</td>
	</tr>
	-->
	<tr>
		<td valign="top">
			<dnn:label id="plSecurityRoles" runat="server" suffix=":"></dnn:label><br>
			<br>
			<asp:label ID="lbModRole" Runat="server" CssClass="normalbold"></asp:label><br>
			<asp:checkboxlist id="chkModerationRoles" runat="server" CssClass="normal" cellspacing="0" cellpadding="0"
				RepeatColumns="5"></asp:checkboxlist><br>
			<asp:label ID="lbDownloadRole" Runat="server" CssClass="normalbold"></asp:label><br>
			<asp:checkboxlist id="chkDownloadRoles" runat="server" CssClass="normal" cellspacing="0" cellpadding="0"
				RepeatColumns="5"></asp:checkboxlist><br>
			<asp:label ID="lbUploadRole" Runat="server" CssClass="normalbold"></asp:label><br>
			<asp:checkboxlist id="chkUploadRoles" runat="server" CssClass="normal" cellspacing="0" cellpadding="0"
				RepeatColumns="5"></asp:checkboxlist><br>
			<asp:label ID="lbRatingRole" Runat="server" CssClass="normalbold"></asp:label><br>
			<asp:checkboxlist id="chkRatingRoles" runat="server" CssClass="normal" cellspacing="0" cellpadding="0"
				RepeatColumns="5"></asp:checkboxlist><br>
			<asp:label ID="lbCommentRole" Runat="server" CssClass="normalbold"></asp:label><br>
			<asp:checkboxlist id="chkCommentRoles" runat="server" CssClass="normal" cellspacing="0" cellpadding="0"
				RepeatColumns="5"></asp:checkboxlist><br>
			<br>
			<BR>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<dnn:label id="plViewComments" runat="server" suffix=":"></dnn:label><br>
			<asp:DropDownList ID="ddlViewComments" Runat="server" CssClass="normal" Width="200px">
				<asp:ListItem Value="roles">Only Authorized Roles</asp:ListItem>
				<asp:ListItem Value="all">All Users</asp:ListItem>
			</asp:DropDownList>
			<br>
			<br>
			<BR>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<dnn:label id="plViewRatings" runat="server" suffix=":"></dnn:label><br>
			<asp:DropDownList ID="ddlViewRatings" Runat="server" CssClass="normal" Width="200px">
				<asp:ListItem Value="roles">Only Authorized Roles</asp:ListItem>
				<asp:ListItem Value="all">All Users</asp:ListItem>
			</asp:DropDownList>
			<br>
			<br>
			<BR>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<dnn:label id="plSkin" runat="server" controlname="cboTemplate" suffix=":"></dnn:label><br>
			<asp:DropDownList ID="cboTemplate" Runat="server" CssClass="normal" Width="200px"></asp:DropDownList>
			<br>
			<br>
			<BR>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<dnn:label id="plRatingImage" runat="server" controlname="cboRatingsImages" suffix=":"></dnn:label><br>
			<asp:DropDownList ID="cboRatingsImages" Runat="server" CssClass="normal" Width="200px"></asp:DropDownList>
			<br>
			<br>
			<BR>
		</td>
	</tr>
	<tr id="FileLocationRow" runat="server">
		<td valign="top">
			<dnn:label id="plFolders" runat="server" suffix=":"></dnn:label><br>
			<b>
				<dnn:label id="plApprovedFolder" runat="server" suffix=":"></dnn:label></b><br>
			<asp:TextBox ID="txtFolderLocation" Runat="server" CssClass="normal" Width="512"></asp:TextBox><br>
			<br>
			&nbsp;&nbsp;&nbsp;&nbsp;<dnn:label id="plUserFolders" runat="server" suffix=":"></dnn:label>
			&nbsp;&nbsp;&nbsp;&nbsp;<asp:CheckBox ID="cbUserFolders" Runat="server" CssClass="normal" Text="YES, store each user's approved files in their own folder" />
			<br>
			<br>
			<b>
				<dnn:label id="plUnapprovedFolder" runat="server" suffix=":"></dnn:label></b><br>
			<asp:TextBox ID="txtPendingLocation" Runat="server" CssClass="normal" Width="512"></asp:TextBox>
			<br>
			<b>
				<dnn:label id="plAnonymousFolder" runat="server" suffix=":"></dnn:label></b><br>
			<asp:TextBox ID="txtAnonymousLocation" Runat="server" CssClass="normal" Width="512"></asp:TextBox>
			<br>
			<br>
			<BR>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<dnn:label id="plNoImage" runat="server" controlname="ctlURL" suffix=":"></dnn:label><br>
			<portal:url id="ctlURL" runat="server" width="250" shownewwindow="False" ShowLog="False" ShowTrack="False"
				ShowTabs="False" />
			<br>
			<br>
			<BR>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<br>
			<asp:Label id="lblMessage" Runat="server" CssClass="normalred"></asp:Label>
			<br>
			<br>
		</td>
	</tr>
</TABLE>
