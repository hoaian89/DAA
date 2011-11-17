<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Router.ascx.vb" Inherits="DotNetNuke.Modules.Wiki.Router" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<table id="Table1" cellspacing="2" width="100%" border="0" cellpadding="5">
	<tr>
		<td valign="top"><asp:Panel id="LinksPanel" runat="server" CssClass="WikiLinksPanel">
				<asp:HyperLink id="HomeBtn" runat="server" CssClass="CommandButton"></asp:HyperLink>
				<br />
				<asp:HyperLink id="SearchBtn" runat="server" CssClass="CommandButton"></asp:HyperLink>
				<br />
				<asp:HyperLink id="RecChangeBtn" runat="server" CssClass="CommandButton"></asp:HyperLink>
				<br />
				<asp:LinkButton id="IndexBtn" runat="server" CssClass="CommandButton"></asp:LinkButton>
				<br />
				<asp:Literal id="IndexList" runat="server"></asp:Literal>			
			</asp:Panel>
		</td>
		<td style="BORDER-RIGHT: darkgray thin solid; WIDTH: 12px" valign="top" align="right"><asp:ImageButton id="ImageButton1" runat="server"></asp:ImageButton></td>
		<td width="100%" style="MARGIN-LEFT: 5px" valign="top"><asp:PlaceHolder id="PlaceHolder1" runat="server" /></td>
	</tr>
</table>
