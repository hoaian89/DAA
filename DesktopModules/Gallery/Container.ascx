<%@ Control Language="VB" Inherits="DotNetNuke.Modules.Gallery.Container" AutoEventWireup="false" Codebehind="Container.ascx.vb" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="dnn" TagName="ControlPager" Src="./Controls/ControlPager.ascx" %>
<%@ Reference Control="~/DesktopModules/Gallery/Controls/ControlGalleryMenu.ascx" %>
<%@ Reference Control="~/DesktopModules/Gallery/Controls/ControlBreadCrumbs.ascx" %>
<%@ Register TagPrefix="gal" Namespace="DotNetNuke.Modules.Gallery.Views" Assembly="Dotnetnuke.Modules.Gallery" %>
<!-- Following meta added to remove xhtml validation errors - needs to be removed in DDN 5.0 GAL8522 - HWZassenhaus -->
<meta http-equiv="Content-Style-Type" content="text/css"/>

<!-- JIMJ Gallery module patches by James Jegers, www.Jegers.com -->

<script type="text/javascript" language="javascript" src='<%=Page.ResolveUrl("DesktopModules/Gallery/Popup/gallerypopup.js")%>'></script>

<!--No rightclick function added by Matthias Schlomann-->
<%--Commented out by NES. The function interferes with the rest of the page--%>
<%--  <script type="text/javascript">
  // Set the message for the Right-Click alert box
  var am = "<%= Localization.GetString("NoRightClick" , Me.LocalResourceFile) %>";
  var bV  = parseInt(navigator.appVersion);
  var bNS = navigator.appName=="Netscape";
  var bIE = navigator.appName=="Microsoft Internet Explorer";

  function noRightClick(e) {
     if (bNS && e.which > 1){
        alert(am)
        return false
     } else if (bIE && (event.button >1)) {
           alert(am)
        return false;
     }
  }
  document.onmousedown = noRightClick;
  if (document.layers) window.captureEvents(Event.MOUSEDOWN);
  if (bNS && bV<5) window.onmousedown = noRightClick;
  </script>
--%> 
<table id="tbContent" cellspacing="0" cellpadding="0" width="100%"  border = "0" runat="server">
	<!-- Main header row -->
	<tr id="rowFolders1" runat="server">
		<td class="Gallery_HeaderCapLeft" id="celHeaderLeft" runat="server">
			<img alt="" src='<%=Page.ResolveUrl(GalleryConfig.GetImageURL("spacer_left.gif"))%>' /></td>
		<td class="Gallery_HeaderImage" id="celGalleryMenu" align="center" runat="server" style="width: 50px">
		<!-- Menu gets put here -->
		</td>
		<td class="Gallery_Header" id="celBreadcrumbs" runat="server" align="left" style="width:100%" colspan="2">
		</td>
		<td class="Gallery_HeaderCapRight" id="celHeaderRight"><img 
		    alt="" src='<%=Page.ResolveUrl(GalleryConfig.GetImageURL("spacer_right.gif"))%>' width = "0" /></td>
	</tr>
	<!-- Top row above gallery -->
	<tr id="rowPager1" runat="server">
		<td class="Gallery_AltHeaderCapLeft" id="celAltHeaderLeft" valign="top">
		</td>
		<td class="Gallery_AltHeaderImage" align="center" style="width: 50px">
			<asp:ImageButton ID="ClearCache1" runat="server" ImageUrl="~/DesktopModules/Gallery/Images/s_Refresh.gif"
				resourcekey="ClearCache.Text" AlternateText='""'></asp:ImageButton>
		</td>
		<td class="Gallery_AltHeaderImage" align="left" style="width: 300px">
			<dnn:ControlPager ID="ctlControlPager1" runat="server"></dnn:ControlPager>
		</td>
		<td class="Gallery_AltHeaderImage" align="right">
            &nbsp;<asp:Label ID="lblView" CssClass="Normal" Text="View " resourcekey="View.Text" runat="server"></asp:Label>
			<asp:DropDownList ID="ddlGalleryView" runat="server" AutoPostBack="True" Width="112px"
				CssClass="NormalTextBox">
			</asp:DropDownList>&nbsp;
			<asp:Label ID="lblSortBy" CssClass="Normal" Text="Sort By " resourcekey="SortBy.Text"
				runat="server"></asp:Label>
			<asp:DropDownList ID="ddlGallerySort" runat="server" AutoPostBack="True" Width="112px"
				CssClass="NormalTextBox">
			</asp:DropDownList>
			<asp:CheckBox ID="chkDESC" runat="server" AutoPostBack="True" Text="Desc" resourcekey="chkDESC"
				CssClass="Normal"></asp:CheckBox>&nbsp;
		</td>
		<td class="Gallery_AltHeaderCapRight" id="celAltHeaderRight" valign="top">
		</td>
	</tr>
	<!-- Middle row with main gallery -->
	<tr id="rowContent" runat="server">
		<td class="Gallery_RowCapLeft" id="celBodyLeft" valign="top" style="height: 19px">
		</td>
		<td class="Gallery_RowContent" id="celContent" valign="top" align="center" colspan="3" style="height: 19px">
		<!-- Main control that displays the album's and images -->
			<gal:GalleryControl ID="ctlGallery" runat="server" />
		</td>
		<td class="Gallery_RowCapRight" id="celBodyRight" valign="top" style="height: 19px">
		</td>
	</tr>
	<!-- Bottom Pager -->
    <tr id="rowPager2" runat="server">
		<td class="Gallery_FooterCapLeft" id="celFooterLeft" valign="top">
		</td>
		<td class="Gallery_Footer" align="center" style="width: 50px">
		    <asp:ImageButton 
		    ID="ClearCache2" runat="server" ImageUrl="~/DesktopModules/Gallery/Images/s_Refresh.gif"
			resourcekey="ClearCache.Text" AlternateText='""'></asp:ImageButton>
		</td>
		<td class="Gallery_Footer" align="left" style="width: 300px">
			<dnn:ControlPager ID="ctlControlPager2" runat="server"></dnn:ControlPager>
		</td>
		<td class="Gallery_Footer" align="right">
            &nbsp;<asp:Label ID="lblStats" runat="server" CssClass="Gallery_NormalGrey"></asp:Label>
		</td>
		<td class="Gallery_FooterCapRight" id="celFooterRight" valign="top">
		    <img src ="<%=TemplateSourceDirectory & "/Themes/" & GalleryConfig.Theme %>/Images/spacer_right.gif" alt="" />
        </td>
	</tr>
	<!-- Bottom Row -->
	<tr>
		<td class="Gallery_BottomCapLeft" id="celleftBottomLeft" valign="top" align="left" style="height: 19px" >
		</td>
		<td class="Gallery_Bottom" id="celBottum" colspan="3" valign="top" align="center" style="width:100%; height: 19px;" ></td>
		<td class="Gallery_BottomCapRight" id="celBottomRight"  valign="top" align="right" style="height: 19px"></td>
	</tr>
</table>
