<%@ Import namespace="DotNetNuke.Modules.Gallery" %>
<%@ Control language="vb" Inherits="DotNetNuke.Modules.Gallery.WebControls.Pager" AutoEventWireup="false" Codebehind="ControlPager.ascx.vb" %>
<table id="tbPager" cellspacing="0" cellpadding="0" style="width:100%" border="0" runat="server">
	<tr id="rowPager" runat="server" visible="false">
		<td style="width:100%; height:28px">
			<asp:label id="lblPageInfo" runat="server" cssClass="Gallery_NormalGrey"></asp:label>
			<asp:datalist id="dlPager" runat="server" repeatdirection="Horizontal" repeatlayout="Flow" cssclass="Normal">
				<selecteditemtemplate>
					<asp:label id="lblText" CssClass="Gallery_NormalGrey" runat="server">
						<%# Ctype(Container.DataItem, PagerDetail).Text %>
					</asp:label>
				</selecteditemtemplate>
				<itemtemplate>					
					<asp:hyperlink id="hlStrip" CssClass="CommandButton" runat="server" navigateurl='<%# Ctype(Container.DataItem, PagerDetail).URL %>'>
						<%# Ctype(Container.DataItem, PagerDetail).Text %>
					</asp:hyperlink>
				</itemtemplate>
			</asp:datalist>
		</td>
	</tr>
</table>
