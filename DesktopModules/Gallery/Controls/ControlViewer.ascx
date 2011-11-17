<%@ Control language="vb" AutoEventWireup="false" Inherits="DotNetNuke.Modules.Gallery.WebControls.Viewer" Codebehind="ControlViewer.ascx.vb" %>
<table cellspacing="0" cellpadding="0" style="vertical-align:middle; width:100%">
	<tr>
		<td class="Gallery_Header" align="center" style="width:100%">
			<asp:label id="Title" runat="server" cssclass="Gallery_HeaderText"></asp:label></td>
	</tr>
	<tr>
		<td class="Gallery_Row" valign="middle" align="center" style="height:22px">
			<asp:hyperlink id="MovePrevious" runat="server"></asp:hyperlink>&nbsp;
			<asp:hyperlink id="MoveNext" runat="server"></asp:hyperlink>&nbsp;
			<asp:hyperlink id="ZoomOut" runat="server"></asp:hyperlink>&nbsp;
			<asp:hyperlink id="ZoomIn" runat="server"></asp:hyperlink>&nbsp;
			<asp:hyperlink id="RotateLeft" runat="server"></asp:hyperlink>&nbsp;
			<asp:hyperlink id="RotateRight" runat="server"></asp:hyperlink>&nbsp;
			<asp:hyperlink id="FlipX" runat="server"></asp:hyperlink>&nbsp;
			<asp:hyperlink id="FlipY" runat="server"></asp:hyperlink>&nbsp;
			<asp:hyperlink id="BWMinus" runat="server"></asp:hyperlink>&nbsp;
			<asp:hyperlink id="Color" runat="server"></asp:hyperlink>&nbsp;
			<asp:hyperlink id="BWPlus" runat="server"></asp:hyperlink>&nbsp;
			<asp:hyperlink id="UpdateButton" runat="server" visible="False"></asp:hyperlink>
		</td>
	</tr>
	<tr>
		<td style="width:100%" class="Gallery_Image">
			<table cellspacing="0" cellpadding="0" style="width:100%; text-align:left" border="0">
				<tr>
					<td class="Gallery_PictureTL"><img alt="" src='<%=Page.ResolveUrl(GalleryConfig.GetImageURL("picture_spacer_left.gif"))%>' style="border-width:0" /></td>
					<td class="Gallery_PictureTC"><img alt="" src='<%=Page.ResolveUrl(GalleryConfig.GetImageURL("picture_spacer_center.gif"))%>' style="border-width:0" /></td>
					<td class="Gallery_PictureTR"><img alt="" src='<%=Page.ResolveUrl(GalleryConfig.GetImageURL("picture_spacer_left.gif"))%>' style="border-width:0" /></td>
				</tr>
				<tr>
					<td class="Gallery_PictureML">&nbsp;</td>
					<td class="Gallery_Picture" valign="middle" align="center">
						<img alt="" style="border:0" src="<%=ImageUrl() %>" />
					</td>
					<td class="Gallery_PictureMR">&nbsp;</td>
				</tr>
				<tr>
					<td class="Gallery_PictureBL">&nbsp;</td>
					<td class="Gallery_PictureBC"><img alt="" src='<%=Page.ResolveUrl(GalleryConfig.GetImageURL("picture_spacer_center.gif"))%>'  style="border-width:0"/></td>
					<td class="Gallery_PictureBR">&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td class="Gallery_Row" valign="middle" align="center" style="height:22px">
			<asp:label id="lblInfo" cssclass="Normal" runat="server"></asp:label>
		</td>
	</tr>
</table>
