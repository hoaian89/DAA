<%@ Control language="vb" AutoEventWireup="false" Inherits="DotNetNuke.Modules.Gallery.FlashPlayer" Codebehind="FlashPlayer.ascx.vb" %>
<%@ Register TagPrefix="dnn" TagName="ControlFlashPlayer" Src="./Controls/ControlFlashPlayer.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
	<table cellspacing="0" cellpadding="0" style="vertical-align:middle" class="Gallery_Container">
		<tr>
			<td id="VU" class="Gallery_Row" align="center" style="width:100%; height:100%; text-align: center; margin-left:auto; margin-right:auto">
				<dnn:ControlFlashPlayer id="ctlFlashPlayer" runat="server"></dnn:ControlFlashPlayer>
			</td>
		</tr>
		<tr>
			<td class="Gallery_Header" valign="middle" align="center" style="white-space:nowrap; height:28px">
			    <asp:button id="btnBack" runat="server" Text="Back" ResourceKey="btnBack" CssClass="Gallery_BackButton" ></asp:button>
			</td>
		</tr>
	</table>
	<asp:Label id="ErrorMessage" CssClass="NormalRed" runat="server" Visible="False"></asp:Label>
