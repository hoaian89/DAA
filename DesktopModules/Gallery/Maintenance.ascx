<%@ Control language="vb" Inherits="DotNetNuke.Modules.Gallery.Maintenance" AutoEventWireup="false" Codebehind="Maintenance.ascx.vb" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Reference Control="~/DesktopModules/Gallery/Controls/ControlGalleryMenu.ascx" %>
<!-- Following meta added to remove xhtml validation errors - needs to be removed in DDN 5.0 GAL8522 - HWZassenhaus -->
<meta http-equiv="Content-Style-Type" content="text/css"/>
	<script type="text/javascript" language="javascript" src='<%= Page.ResolveUrl("DesktopModules/Gallery/Popup/gallerypopup.js") %>'></script>
	<table class="Gallery_Container" cellspacing="1" cellpadding="0" width="780px" style="vertical-align:middle">
		<tbody>
			<tr>
				<td style="width:100%; height:28px">
					<table id="tblMain" cellspacing="0" cellpadding="1" style="width:100%" border="0">
						<tr>
							<td class="Gallery_Header" id="celGalleryMenu" runat="server" valign="middle"
								align="center" style="width:28px; white-space:nowrap">
							</td>
							<td class="Gallery_Header" id="celBreadcrumbs" runat="server" valign="middle"
								align="left" style="width:70%; white-space:nowrap">
							</td>
							<td class="Gallery_Header" valign="middle" align="right" style="width:30%; height:28px">
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="Gallery_Header" style="width:100%;height:28px; white-space:nowrap">
					<asp:imagebutton id="ClearCache1" resourcekey="ClearCache1.AlternateText" runat="server" imageurl="~/DesktopModules/Gallery/Images/s_refresh.gif"
						tooltip="Refresh gallery view..." AlternateText='""'></asp:imagebutton></td>
			</tr>
			<tr>
				<td>
					<table cellspacing="1" cellpadding="1" style="width:100%" border="0">
						<tr>
							<td class="Gallery_SubHeader" style="width:120px">
								<dnn:label id="plPath" text="Path:" runat="server" resourcekey="plPath" controlname="txtPath"></dnn:label>
							</td>
							<td class="Gallery_Row" align="left">
								<asp:TextBox id="txtPath" runat="server" cssclass="NormalTextBox" enabled="False" width="100%"></asp:TextBox></td>
						</tr>
						<tr>
							<td class="Gallery_SubHeader" style="width:120px"><dnn:label id="plName" text="Name:" runat="server" resourcekey="plName" controlname="txtName"></dnn:label></td>
							<td class="Gallery_Row" align="left" style="height:22px"><asp:textbox id="txtName" runat="server" enabled="False" cssclass="NormalTextBox" width="100%"></asp:textbox></td>
						</tr>
						<tr>
							<td class="Gallery_SubHeader" style="width:120px" valign="top">
								<dnn:label id="plAlbumInfo" text="Album Info:" runat="server" resourcekey="plAlbumInfo" controlname="lblAlbumInfo"></dnn:label>
							</td>
							<td class="Gallery_Row" align="left">
								<asp:label id="lblAlbumInfo" runat="server" width="90%" cssclass="Gallery_Row"></asp:label></td>
						</tr>
						<tr>
							<td class="Gallery_Header" style="width:200px; height:28px" align="center" valign="middle">
								<asp:LinkButton id="btnSyncAll" runat="server" CommandName="back" cssclass="CommandButton"></asp:LinkButton>
								<asp:LinkButton id="btnDeleteAll" runat="server" commandname="delete" cssclass="CommandButton"></asp:LinkButton>
							</td>
							<td class="Gallery_Header" align="right" valign="top">
								<asp:checkbox id="chkSelectAll" cssclass="Normal" runat="server" 
									enabled="True" autopostback="True" checked="False" textalign="Left"></asp:checkbox>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>&nbsp;<asp:datagrid id="grdContent" resourcekey="grdContent" runat="server" DataKeyField="Name" AutoGenerateColumns="False" BorderWidth="1"
						CellPadding="2" CellSpacing="0" style="width:100%">
						<Columns>
							<asp:TemplateColumn HeaderText="">
								<HeaderStyle height="28px" HorizontalAlign="Center" Width="28px" CssClass="Gallery_Header"></HeaderStyle>
								<ItemStyle height="22px" CssClass="Gallery_Row"></ItemStyle>
								<ItemTemplate>
									<asp:HyperLink runat="server" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "IconURL")%>' NavigateUrl='<%# BrowserURL(Container.DataItem)%>' ID="lnkView"  ToolTip ="<% #lnkViewText %>">
									</asp:HyperLink>
								</ItemTemplate>
							</asp:TemplateColumn>
							<asp:BoundColumn DataField="Name" HeaderText="Name">
								<HeaderStyle HorizontalAlign="Left" Height="28px" CssClass="Gallery_Header"></HeaderStyle>
								<ItemStyle HorizontalAlign="Left" Height="22px" Width="60%" CssClass="Gallery_Row"></ItemStyle>
							</asp:BoundColumn>
							<asp:TemplateColumn HeaderText="Info">
								<HeaderStyle Height="28px" Width="22px" CssClass="Gallery_Header"></HeaderStyle>
								<ItemStyle Wrap="False" HorizontalAlign="Center" Height="22px" Width="40%" CssClass="Gallery_RowHighLight"></ItemStyle>
								<ItemTemplate>
									<asp:Label id="lblFileInfo" Text='<%# FileInfo(Container.DataItem)%>' CssClass="Gallery_RowHighLight" Runat="server">
									</asp:Label>
								</ItemTemplate>
							</asp:TemplateColumn>
							<asp:TemplateColumn HeaderText="Thumb">
								<HeaderStyle Height="28px" Width="22px" CssClass="Gallery_Header"></HeaderStyle>
								<ItemStyle Wrap="False" HorizontalAlign="Center" Height="22px" CssClass="Gallery_Row"></ItemStyle>
								<ItemTemplate>
									<asp:CheckBox id="chkThumb" Checked='<%# DataBinder.Eval(Container.DataItem, "ThumbExists")%>' Enabled="False" Runat="server">
									</asp:CheckBox>
								</ItemTemplate>
							</asp:TemplateColumn>
							<asp:TemplateColumn HeaderText="Album">
								<HeaderStyle Height="28px" Width="22px" CssClass="Gallery_Header"></HeaderStyle>
								<ItemStyle Wrap="False" HorizontalAlign="Center" Height="22px" CssClass="Gallery_Row"></ItemStyle>
								<ItemTemplate>
									<asp:CheckBox id="chkFile" Checked='<%# DataBinder.Eval(Container.DataItem, "FileExists")%>' Enabled="False" Runat="server">
									</asp:CheckBox>
								</ItemTemplate>
							</asp:TemplateColumn>
							<asp:TemplateColumn HeaderText="Source">
								<HeaderStyle Height="28px" Width="22px" CssClass="Gallery_Header"></HeaderStyle>
								<ItemStyle Wrap="False" HorizontalAlign="Center" Height="22px" CssClass="Gallery_Row"></ItemStyle>
								<ItemTemplate>
									<asp:CheckBox id="chkSource" Checked='<%# DataBinder.Eval(Container.DataItem, "SourceExists")%>' Enabled="False" Runat="server">
									</asp:CheckBox>
								</ItemTemplate>
							</asp:TemplateColumn>
							<asp:TemplateColumn HeaderText="">
								<HeaderStyle Height="28px" Width="22px" CssClass="Gallery_Header"></HeaderStyle>
								<ItemStyle Wrap="False" HorizontalAlign="Center" Height="22px" CssClass="Gallery_Row"></ItemStyle>
								<ItemTemplate>
									<asp:CheckBox id="chkSelect" Runat="server"></asp:CheckBox>
								</ItemTemplate>
							</asp:TemplateColumn>
						</Columns>
					</asp:datagrid>
				</td>
			</tr>
			<tr valign="top">
				<td colspan="2" align="center" class="Gallery_MFooter">
					<asp:LinkButton id="cmdReturn" cssclass="CommandButton" resourcekey="cmdReturn" text="Cancel" runat="server" />
				</td>
			</tr>
		</tbody></table>
