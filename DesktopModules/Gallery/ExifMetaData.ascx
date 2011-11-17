<%@ Control Language="vb" AutoEventWireup="false"
	Inherits="DotNetNuke.Modules.Gallery.ExifMetaData" Codebehind="ExifMetaData.ascx.vb" %>
<%@ Register TagPrefix="dnn" TagName="ControlExif" Src="./Controls/ControlExif.ascx" %>
<table class="Gallery_Container" cellspacing="0" cellpadding="0" style="vertical-align:middle">
	<tr>
		<td class="Gallery_Row">
			<dnn:ControlExif ID="ctlExif" runat="server"></dnn:ControlExif>
		</td>
	</tr>
	<tr>
		<td class="Gallery_Header" valign="middle" align="center" style="white-space:nowrap; height:28px">
			<asp:button id="btnBack" runat="server" Text="Back" ResourceKey="btnBack" CssClass="Gallery_BackButton" ></asp:button>
		</td>
	</tr>
</table>
