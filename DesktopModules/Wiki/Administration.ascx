<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Administration.ascx.vb" Inherits="DotNetNuke.Modules.Wiki.Administration" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="uc1" TagName="DualListControl" Src="~/controls/DualListControl.ascx" %>
<span class="NormalBold">
	<asp:CheckBox id="CheckBox1" runat="server" Checked="True" AutoPostBack="True"></asp:CheckBox></span><br />
<asp:Panel id="CustomRightPanel" runat="server" CssClass="Normal">
	<uc1:DualListControl id="ContentEditors" runat="server"></uc1:DualListControl>
</asp:Panel>
<br />
<br />
<table style="WIDTH: 376px; HEIGHT: 217px">
	<tr>
		<td align="left">
			<asp:CheckBox id="AllowPageComments" runat="server" AutoPostBack="True"></asp:CheckBox><br />
			&nbsp;&nbsp;&nbsp;<asp:CheckBox id="ActivateComments" Text="Activate comments on all pages after settings are saved!"
				runat="server" Visible="False" AutoPostBack="True"></asp:CheckBox><br />
			<asp:CheckBox id="AllowPageRatings" AutoPostBack="True" runat="server"></asp:CheckBox>
			<br />
			&nbsp;&nbsp;&nbsp;<asp:CheckBox id="ActivateRatings" runat="server" Visible="False" AutoPostBack="True"></asp:CheckBox><br />
		</td>
	</tr>
</table>
<br />
<br />
|&nbsp;<asp:LinkButton id="LinkButton1" runat="server" CssClass="CommandButton"></asp:LinkButton>&nbsp;|
<asp:LinkButton id="LinkButton2" runat="server" CssClass="CommandButton"></asp:LinkButton>&nbsp;|
