<%@ Control language="vb" CodeBehind="~/admin/Skins/skin.vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>
<%@ Register TagPrefix="dnn" TagName="LOGO" Src="~/Admin/Skins/logo.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGIN" Src="~/Admin/Skins/login.ascx" %>
<%@ Register TagPrefix="dnn" TagName="BREADCRUMB" Src="~/Admin/Skins/breadcrumb.ascx" %>
<%@ Register TagPrefix="dnn" TagName="ARTMENU" Src="~/DesktopModules/ArtMenuSO/ArtMenuSO.ascx" %>
<%@ Register TagPrefix="dnn" TagName="STYLES" Src="~/Admin/Skins/Styles.ascx" %>
<%@ Register TagPrefix="dnn" TagName="COPYRIGHT" Src="~/admin/Skins/copyright.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TERMS" Src="~/admin/Skins/terms.ascx" %>
<%@ Register TagPrefix="dnn" TagName="PRIVACY" Src="~/admin/Skins/privacy.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TEXT" Src="~/admin/Skins/Text.ascx" %>

<script runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.Page.ClientScript.RegisterClientScriptInclude("script.js", Me.TemplateSourceDirectory & "/script.js")
    End Sub
    
    Private Function CollapseSidebars() As String
        Return String.Empty
    End Function
</script>

<div id="art-page-background-simple-gradient">
    <div id="art-page-background-gradient"></div>
</div>
<div id="art-page-background-glare">
    <div id="art-page-background-glare-image"></div>
</div>
<div id="art-main">
<div class="art-sheet">
    <div class="art-sheet-tl"></div>
    <div class="art-sheet-tr"></div>
    <div class="art-sheet-bl"></div>
    <div class="art-sheet-br"></div>
    <div class="art-sheet-tc"></div>
    <div class="art-sheet-bc"></div>
    <div class="art-sheet-cl"></div>
    <div class="art-sheet-cr"></div>
    <div class="art-sheet-cc"></div>
    <div class="art-sheet-body">
        <div id="ControlPanel" runat="server"></div>
        <div class="art-header">
    <div class="art-header-png"></div>
    <div class="art-header-jpeg"></div>
<script type="text/javascript" src="<%= Regex.Replace(Me.SkinPath, "[Cc]ontainers", "Skins") %>swfobject.js"></script>
<div id="art-flash-area">
<div id="art-flash-container">
<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="1046" height="175" id="art-flash-object">
	<param name="movie" value="<%= Regex.Replace(Me.SkinPath, "[Cc]ontainers", "Skins") %>container.swf" />
	<param name="quality" value="high" />
	<param name="scale" value="default" />
	<param name="wmode" value="transparent" />
	<param name="flashvars" value="color1=0xFFFFFF&amp;alpha1=.50&amp;framerate1=24&amp;clip=<%= Regex.Replace(Me.SkinPath, "[Cc]ontainers", "Skins") %>images/flash.swf&amp;radius=39&amp;clipx=0&amp;clipy=-43&amp;initalclipw=900&amp;initalcliph=225&amp;clipw=1046&amp;cliph=261&amp;width=1046&amp;height=175&amp;textblock_width=0&amp;textblock_align=no" />
    <param name="swfliveconnect" value="true" />
	<!--[if !IE]>-->
	<object type="application/x-shockwave-flash" data="<%= Regex.Replace(Me.SkinPath, "[Cc]ontainers", "Skins") %>container.swf" width="1046" height="175">
	    <param name="quality" value="high" />
	    <param name="scale" value="default" />
	    <param name="wmode" value="transparent" />
    	<param name="flashvars" value="color1=0xFFFFFF&amp;alpha1=.50&amp;framerate1=24&amp;clip=<%= Regex.Replace(Me.SkinPath, "[Cc]ontainers", "Skins") %>images/flash.swf&amp;radius=39&amp;clipx=0&amp;clipy=-43&amp;initalclipw=900&amp;initalcliph=225&amp;clipw=1046&amp;cliph=261&amp;width=1046&amp;height=175&amp;textblock_width=0&amp;textblock_align=no" />
        <param name="swfliveconnect" value="true" />
	<!--<![endif]-->
		<div class="art-flash-alt"><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a></div>
	<!--[if !IE]>-->
	</object>
	<!--<![endif]-->
</object>
</div>
</div>
<script type="text/javascript">swfobject.switchOffAutoHideShow();swfobject.registerObject("art-flash-object", "9.0.0", "<%= Regex.Replace(Me.SkinPath, "[Cc]ontainers", "Skins") %>expressInstall.swf");</script>

</div>
<dnn:ARTMENU ID="ArtMenu1" ShowHiddenTabs="False" ShowAdminTabs="True" ShowDeletedTabs="False" ShowLoginTab="True" ShowUserTab="True" runat="server" /><div class="art-content-layout">
    <div class="art-content-layout-row">
<div class="art-layout-cell art-content<%= CollapseSidebars() %>">
<div id="ContentPane" runat="server"></div>
</div>

    </div>
</div>
<div class="cleared"></div>
<div class="art-footer">
    <div class="art-footer-inner">
        <div class="art-footer-text">
<p><dnn:TERMS runat="server" ID="dnnTerms" />
    | <dnn:PRIVACY ID="dnnPrivacy" runat="server" /><br />
    <dnn:COPYRIGHT runat="server" id="dnnCopyright" /></p>

        </div>
    </div>
    <div class="art-footer-background"></div>
</div>

		<div class="cleared"></div>
    </div>
</div>
<div class="cleared"></div>
<p class="art-page-footer"></p>

</div>


<dnn:STYLES runat="server" ID="style" Name="style" StyleSheet="style-admin.css" UseSkinPath="true" />
<dnn:STYLES runat="server" ID="styleIE6" Name="styleIE6" Condition="IE 6" StyleSheet="style.ie6.css" UseSkinPath="true" />
<dnn:STYLES runat="server" ID="styleIE7" Name="styleIE7" Condition="IE 7" StyleSheet="style.ie7.css" UseSkinPath="true" />

