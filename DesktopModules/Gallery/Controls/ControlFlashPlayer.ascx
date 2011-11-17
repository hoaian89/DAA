<%@ Control language="vb" AutoEventWireup="false" Inherits="DotNetNuke.Modules.Gallery.WebControls.FlashPlayer" Codebehind="ControlFlashPlayer.ascx.vb" %>

<table cellspacing="0" cellpadding="0" style="width:100%; text-align: center; vertical-align:middle">
  <tr>
	<td class="Gallery_Header" align="center" style="width:100%">
		<asp:label id="Title" runat="server" cssclass="Gallery_HeaderText"></asp:label>
	</td>
  </tr>
  <tr>
    <td>
        <object id="objFlashPlayer" type="application/x-shockwave-flash"
             data="<%=FlashUrl %>" width="<%=FixedWidth %>px" height="<%=FixedHeight %>px">
            <param name="allowScriptAccess" value="sameDomain" />
            <param name="movie" value="<%=FlashUrl %>" />
            <param name="play" value="true" />
            <param name="loop" value="true" />
            <param name="quality" value="high" />
            <param name="bgcolor" value="#fffff" />
            <param name="scale" value="showall" />
            <param name="salign" value="lt" />
        <!--[if !IE]>-->
		  <object type="application/x-shockwave-flash" data="<%=FlashUrl %>" width="<%=FixedWidth %>" height="<%=FixedHeight %>px">
	    <!--<![endif]-->
	        <a href="http://www.adobe.com/go/getflashplayer">
			   <img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" />
		    </a>
        <!--[if !IE]>-->
		  </object>
		<!--<![endif]-->
        </object>
     </td>
   </tr>
</table>