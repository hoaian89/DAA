<%@ Control inherits="DotNetNuke.Modules.UsersOnline.Settings" codebehind="Settings.ascx.vb" language="vb" autoeventwireup="false" explicit="true" %>
<%@ Register tagprefix="dnn" tagname="Label" src="~/controls/LabelControl.ascx" %>
<table cellspacing="0" cellpadding="4" border="0">
	<tr>
		<td class="SubHead" width="150">
			<dnn:label id="plStatus" text="Status:" controlname="lblStatus" runat="server" />
		</td>
		<td valign="top">
			<p>
				<asp:Image id="imgStatus" runat="server" />
				<asp:Label id="lblStatus" runat="server" cssclass="Normal" />
			</p>
		</td>
	</tr>
	<tr>
		<td class="SubHead" width="150">
			<dnn:label id="plNameDisplayMode" text="Name Display Mode:" controlname="ddlNameDisplayMode" runat="server" />
		</td>
		<td valign="top">
			<asp:DropDownList id="ddlNameDisplayMode" runat="server" cssclass="NormalTextbox" />
		</td>
	</tr>
	<tr>
		<td class="SubHead" width="150">
			<dnn:label id="plNamePrefix" text="Name Prefix:" controlname="ddlNamePrefix" runat="server" />
		</td>
		<td valign="top">
			<asp:DropDownList id="ddlNamePrefix" runat="server" cssclass="NormalTextbox" />
		</td>
	</tr>
	<tr>
		<td class="SubHead" width="150">
			<dnn:label id="plIncludeHosts" text="Show Super Users:" controlname="chkIncludeHosts" runat="server" />
		</td>
		<td valign="top">
			<asp:CheckBox id="chkIncludeHosts" cssclass="NormalBold" runat="server"></asp:CheckBox>
		</td>
	</tr>
	<tr>
		<td class="SubHead" width="150">
			<dnn:label id="plShowMembership" text="Show Membership:" controlname="chkShowMembership" runat="server" />
		</td>
		<td valign="top">
			<asp:CheckBox id="chkShowMembership" cssclass="NormalBold" runat="server"></asp:CheckBox>
		</td>
	</tr>
	<tr>
		<td class="SubHead" width="150">
			<dnn:label id="plShowPeopleOnline" text="Show People Online:" controlname="chkShowPeopleOnline" runat="server" />
		</td>
		<td valign="top">
			<asp:CheckBox id="chkShowPeopleOnline" cssclass="NormalBold" runat="server"></asp:CheckBox>
		</td>
	</tr>
	<tr>
		<td class="SubHead" width="150">
			<dnn:label id="plShowUsersOnline" text="Show Users Online:" controlname="chkShowUsersOnline" runat="server" />
		</td>
		<td valign="top">
			<asp:CheckBox id="chkShowUsersOnline" cssclass="NormalBold" runat="server"></asp:CheckBox>
		</td>
	</tr>
	<%--<tr>
		<td class="SubHead" width="150">
			<dnn:label id="plUserProfileUrl" text="User Profile Url:" controlname="txtUserProfileUrl" runat="server" />
		</td>
		<td valign="top">
			<asp:TextBox id="txtUserProfileUrl" runat="server" cssclass="NormalTextbox" width="350px" />
		</td>
	</tr>--%>
</table>
