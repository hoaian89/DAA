<%@ Register TagPrefix="dnn" TagName="ControlViewer" Src="./Controls/ControlViewer.ascx" %>
<%@ Control language="vb" AutoEventWireup="false" Inherits="DotNetNuke.Modules.Gallery.Viewer" Codebehind="Viewer.ascx.vb" %>
	<table class="Gallery_Container" cellspacing="0" cellpadding="0" style="vertical-align:middle">
		<tr>
	    	<td class="Gallery_Row">
				<dnn:ControlViewer id="ctlViewer" runat="server"></dnn:ControlViewer>
			</td>
		</tr>
		<tr>
			<td class="Gallery_Header" valign="middle" align="center" style="white-space:nowrap; height:28px">
			    <asp:button id="btnBack" runat="server" Text="Back" ResourceKey="btnBack" CssClass="Gallery_BackButton" ></asp:button>
			</td>
		</tr>
	</table>
