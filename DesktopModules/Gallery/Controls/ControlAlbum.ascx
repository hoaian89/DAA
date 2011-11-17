<%@ Control Language="vb" Inherits="DotNetNuke.Modules.Gallery.WebControls.Album" AutoEventWireup="false" Codebehind="ControlAlbum.ascx.vb" %>
<%@ Import Namespace="DotNetNuke.Modules.Gallery" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<meta http-equiv="Content-Script-Type" content="type"/>

<table id="tblAlbumGrid" cellspacing="0" cellpadding="0" style="width:100%" border="0">
    <tr>
        <td class="AltHeader">
            <dnn:sectionhead id="scnAlbumGrid" runat="server" text="Sub-Albums And Files Currently Contained In This Album" resourcekey="scnAlbumGrid"
					includerule="False" section="rowContent" CssClass="Gallery_AltHeaderText"></dnn:sectionhead>
        </td>
    </tr>
	<tr id="rowContent" runat="server">
		<td style="padding-top: 4px">
			<asp:DataGrid ID="grdContent" resourcekey="grdContent" runat="server" EnableViewState="False" DataKeyField="Name"
				AutoGenerateColumns="False" BorderWidth="0" CellPadding="3" CellSpacing="1" Width="100%">
				<Columns>
					<asp:TemplateColumn>
						<HeaderStyle Height="28px" Width="22px" CssClass="Gallery_Header"></HeaderStyle>
						<ItemStyle HorizontalAlign="Center" Height="22px" Width="22px" CssClass="Gallery_Row">
						</ItemStyle>
						<ItemTemplate>
							<asp:ImageButton  ID="Imagebutton1" Visible="<%# CanEdit(Container.DataItem) %>" ImageUrl='<%# Ctype(Container.DataItem, IGalleryObjectInfo).IconURL %>'
								resourcekey="cmdEdit" runat="server" CommandName="edit" CommandArgument='<%# CType(DataBinder.Eval(Container.DataItem, "Index"), String) %>' AlternateText='""' />
							<asp:Image Visible="<%# Not CanEdit(Container.DataItem) %>" ImageUrl='<%# Ctype(Container.DataItem, IGalleryObjectInfo).IconURL %>'
								runat="server" ID="imgIcon" AlternateText=""></asp:Image>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Name">
						<HeaderStyle Height="28px" Width="150px" CssClass="Gallery_Header"></HeaderStyle>
						<ItemStyle Height="22px" CssClass="Gallery_Row"></ItemStyle>
						<ItemTemplate>
							<asp:Label ID="lblName" runat="server" Text='<%# Ctype(Container.DataItem, IGalleryObjectInfo).Name %>'>
							</asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Title">
						<HeaderStyle Height="28px" Width="150px" CssClass="Gallery_Header"></HeaderStyle>
						<ItemStyle Height="22px" CssClass="Gallery_Row"></ItemStyle>
						<ItemTemplate>
							<asp:Label ID="lblTitle" runat="server" Text='<%# Ctype(Container.DataItem, IGalleryObjectInfo).Title %>'>
							</asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Categories">
						<HeaderStyle Height="28px" Width="150px" CssClass="Gallery_Header"></HeaderStyle>
						<ItemStyle Height="22px" CssClass="Gallery_Row"></ItemStyle>
						<ItemTemplate>
							<asp:Label ID="lblCategory" runat="server" Text='<%# Ctype(Container.DataItem, IGalleryObjectInfo).Categories %>'>
							</asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Size">
						<HeaderStyle Height="28px" Width="50px" CssClass="Gallery_Header"></HeaderStyle>
						<ItemStyle Height="22px" HorizontalAlign="Center" CssClass="Gallery_Row"></ItemStyle>
						<ItemTemplate>
							<asp:Label ID="lblSize" runat="server" Text="<%# Ctype(Container.DataItem, IGalleryObjectInfo).Size %>">
							</asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Approved Date">
						<HeaderStyle Height="28px" Width="150px" CssClass="Gallery_Header"></HeaderStyle>
						<ItemStyle Height="22px" HorizontalAlign="Center" CssClass="Gallery_Row"></ItemStyle>
						<ItemTemplate>
							<asp:Label ID="lblApprovedDate" runat="server" Text="<%# Utils.DateToText(Ctype(Container.DataItem, IGalleryObjectInfo).ApprovedDate) %>">
							</asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderStyle Height="28px" Width="24px" CssClass="Gallery_Header"></HeaderStyle>
						<ItemStyle Wrap="False" HorizontalAlign="Center" Height="22px" CssClass="Gallery_Row">
						</ItemStyle>
						<ItemTemplate>
							<asp:ImageButton ID="btnEdit" Visible="<%# CanEdit(Container.DataItem) %>" ImageUrl="~/images/Edit.gif"
								runat="server" CommandName="edit" CommandArgument='<%# CType(DataBinder.Eval(Container.DataItem, "Index"), String) %>'
								resourcekey="cmdEdit" AlternateText='""' />
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderStyle Height="28px" Width="24px" CssClass="Gallery_Header"></HeaderStyle>
						<ItemStyle Wrap="False" HorizontalAlign="Center" Height="22px" CssClass="Gallery_Row">
						</ItemStyle>
						<ItemTemplate>
							<asp:ImageButton ID="btnDelete" Visible="<%# CanEdit(Container.DataItem) %>" ImageUrl="~/images/Delete.gif"
								runat="server" CommandName="delete" CommandArgument='<%# CType(DataBinder.Eval(Container.DataItem, "Index"), String) %>'
								resourcekey="cmdDelete" AlternateText='""' />
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:DataGrid>
		</td>
	</tr>
</table>
