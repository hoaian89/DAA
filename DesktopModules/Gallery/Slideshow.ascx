<%@ Control language="vb" AutoEventWireup="false" Inherits="DotNetNuke.Modules.Gallery.Slideshow" Codebehind="Slideshow.ascx.vb" %>
<%@ Register TagPrefix="dnn" TagName="ControlSlideshow" Src="./Controls/ControlSlideshow.ascx" %>
	<table class="Gallery_Container" cellspacing="0" cellpadding="0" style="vertical-align:middle">
		<tr>
			<td class="Gallery_Row" id="showContent">
			   <dnn:ControlSlideshow id="ctlSlideshow" runat="server"></dnn:ControlSlideshow>
			</td>
		</tr>
		<tr>
			<td class="Gallery_Header" valign="middle" align="center" style="white-space:nowrap; height:28px">
			    <asp:button id="btnBack" runat="server" Text="Back" ResourceKey="btnBack" CssClass="Gallery_BackButton" ></asp:button>
			</td>
		</tr>
	</table>
