<%@ Control language="vb" AutoEventWireup="false" Inherits="DotNetNuke.Modules.Gallery.MediaPlayer" Codebehind="MediaPlayer.ascx.vb" %>
<%@ Register TagPrefix="dnn" TagName="ControlMediaPlayer" Src="./Controls/ControlMediaPlayer.ascx" %>
	<table cellspacing="0" cellpadding="0" width="400px" style="vertical-align:middle" class="Gallery_Container">
		<tr>
			<td id="VU" class="Gallery_Row" align="center" style="width:100%; height:100%">
				<dnn:ControlMediaPlayer id="ctlMediaPlayer" runat="server"></dnn:ControlMediaPlayer>
			</td>
		</tr>
		<tr>
			<td class="Gallery_Header" valign="middle" align="center" style="white-space:nowrap; height:28px">
			    <asp:button id="btnBack" runat="server" Text="Back" ResourceKey="btnBack" CssClass="Gallery_BackButton" ></asp:button>
			</td>
		</tr>
	</table>
	<asp:Label id="ErrorMessage" cssclass="NormalRed" runat="server" visible="False"></asp:Label>
