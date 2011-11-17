<%@ Control language="vb" Inherits="DotNetNuke.Modules.Gallery.WebControls.BreadCrumbs" AutoEventWireup="false" Codebehind="ControlBreadCrumbs.ascx.vb" %>
<%@ Import namespace="DotNetNuke.Modules.Gallery" %>
<asp:Repeater ID="rptFolders" runat="server" >
    <HeaderTemplate>
        <span style="white-space: nowrap">
    </HeaderTemplate>
    <itemtemplate>
		<asp:hyperlink id="hlFolder" cssClass="Gallery_HeaderText" runat="server" navigateurl='<%# Ctype(Container.DataItem, FolderDetail).URL %>'>
			<%# Ctype(Container.DataItem, FolderDetail).Name %>
		</asp:hyperlink>
	</itemtemplate>
	<FooterTemplate>
	    </span>
	</FooterTemplate>
</asp:Repeater>
