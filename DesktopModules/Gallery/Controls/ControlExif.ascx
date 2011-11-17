<%@ Control language="vb" AutoEventWireup="false" Inherits="DotNetNuke.Modules.Gallery.WebControls.Exif" Codebehind="ControlExif.ascx.vb" %>
<table class="Gallery_Border" cellspacing="1"  cellpadding="1" >
    <tr>
		<td class="Gallery_Header" align="center" style="width:100%">
			<asp:label id="Title" runat="server" cssclass="Gallery_HeaderText"></asp:label></td>
	</tr>
	<tr>
		<td class="Gallery_Row" valign="middle" align="center"><asp:image id="imgExif" Runat="server" AlternateText='""'></asp:image></td>
	</tr>
	<tr id="rowGrid" runat="server">
		<td style="width:100%">
			<table cellspacing="1" cellpadding="0" style="width:100%" border="0" runat="server">
				<tr>
					<td class="Gallery_Row" align="center"><asp:datagrid id="grdExif" runat="server" AutoGenerateColumns="False" BorderWidth="1" CellPadding="4"
							DataKeyField="ID" CellSpacing="0">
							<Columns>
								<asp:TemplateColumn>
									<HeaderStyle HorizontalAlign="Left" Height="28px" CssClass="Gallery_Header"></HeaderStyle>
									<ItemTemplate>
										<asp:Image id="Image1" ImageUrl="~/images/help.gif" Runat="server" Title='<%# ExifHelp(Databinder.eval(Container,"Dataitem.name")) %>'>
										</asp:Image>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:BoundColumn DataField="ID" HeaderText="ID">
									<HeaderStyle HorizontalAlign="Left" Height="28px" CssClass="Gallery_Header"></HeaderStyle>
									<ItemStyle HorizontalAlign="Left" Height="25px" CssClass="Gallery_Row"></ItemStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="Category" HeaderText="Category">
									<HeaderStyle HorizontalAlign="Left" Height="28px" Width="120px" CssClass="Gallery_Header"></HeaderStyle>
									<ItemStyle HorizontalAlign="Left" Height="25px" Width="120px" CssClass="Gallery_Row"></ItemStyle>
								</asp:BoundColumn>
								<asp:TemplateColumn HeaderText="Name">
									<HeaderStyle HorizontalAlign="Left" Height="28px" Width="180px" CssClass="Gallery_Header"></HeaderStyle>
									<ItemStyle HorizontalAlign="Left" Height="25px" Width="180px" CssClass="Gallery_Row"></ItemStyle>
									<ItemTemplate>
										<asp:label id="plPropertyName" runat="server" text='<%# ExifText(Databinder.eval(Container,"Dataitem.name")) %>'>
										</asp:label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:BoundColumn DataField="Value" HeaderText="Value">
									<HeaderStyle HorizontalAlign="Left" Height="28px" Width="360px" CssClass="Gallery_Header"></HeaderStyle>
									<ItemStyle HorizontalAlign="Left" Height="25px" Width="360px" CssClass="Gallery_Row"></ItemStyle>
								</asp:BoundColumn>
							</Columns>
							<PagerStyle Height="28px" HorizontalAlign="Center" CssClass="Gallery_Header"></PagerStyle>
						</asp:datagrid></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
