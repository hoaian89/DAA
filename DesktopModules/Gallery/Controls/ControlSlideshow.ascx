<%@ Control language="vb" AutoEventWireup="false" Inherits="DotNetNuke.Modules.Gallery.WebControls.Slideshow" Codebehind="ControlSlideshow.ascx.vb" %>


<!-- JIMJ fixed javascript code -->           
<script type="text/javascript" language="javascript">
		function runSlideShow(){
		    if (document.all){
				document.images.SlideShow.style.filter="blendTrans(duration=2)";
				document.images.SlideShow.style.filter="blendTrans(duration=crossFadeDuration)";
				document.images.SlideShow.filters.blendTrans.Apply();
			}
			document.images.SlideShow.src = preLoad[j].src;
			if (document.getElementById) document.getElementById("TitleBox").innerHTML=Title[j].replace("^", "'");
			if (document.getElementById) document.getElementById("CaptionBox").innerHTML=Description[j].replace("^", "'");
			if (document.all){
				document.images.SlideShow.filters.blendTrans.Play();
			}
			j = j + 1;
			if (j > (p-1)) j=0;
			t = setTimeout('runSlideShow()', slideShowSpeed);
		}						
</script>
<table style="text-align:center; margin-left:auto; margin-right:auto; width:100%"><tr><td>
	<table class="Gallery_Border" cellspacing="1" cellpadding="1"  style="vertical-align:middle; width:100%">
		<tr>
			<td class="Gallery_Header" id="TitleBox" align="center" style="width:100%">
			    <asp:Label ID="lblTitleBox" runat="server" CssClass="Gallery_HeaderText"></asp:Label>
			</td>
		</tr>
		<tr>
			<td class="Gallery_Row" style="height:24px" id="CaptionBox" align="center"></td>
		</tr>
		<tr>
			<td class="Gallery_Image">
				<table cellspacing="0" cellpadding="0" style="text-align:center; margin-left:auto; margin-right:auto"  border="0">
					<tr>
						<td class="Gallery_PictureTL"><img alt="" src='<%=Page.ResolveUrl(GalleryConfig.GetImageURL("picture_spacer_left.gif"))%>' style="border-width:0" /></td>
						<td class="Gallery_PictureTC"><img alt="" src='<%=Page.ResolveUrl(GalleryConfig.GetImageURL("picture_spacer_center.gif"))%>' style="border-width:0" /></td>
						<td class="Gallery_PictureTR"><img alt="" src='<%=Page.ResolveUrl(GalleryConfig.GetImageURL("picture_spacer_left.gif"))%>' style="border-width:0" /></td>
					</tr>
					<tr>
						<td class="Gallery_PictureML">&nbsp;</td>
						<td class="Gallery_Picture" valign="middle" align="center" id="celPicture" runat="server">
							<asp:Label id="ImageSrc" runat="server"></asp:Label>
						</td>
						<td class="Gallery_PictureMR">&nbsp;</td>
					</tr>
					<tr>
						<td class="Gallery_PictureBL">&nbsp;</td>
						<td class="Gallery_PictureBC"><img alt="" src='<%=Page.ResolveUrl(GalleryConfig.GetImageURL("picture_spacer_center.gif"))%>' style="border-width:0" /></td>
						<td class="Gallery_PictureBR">&nbsp;</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	</td></tr></table>
	<asp:Label id="ErrorMessage" runat="server" CssClass="NormalRed" Visible="False"></asp:Label>
