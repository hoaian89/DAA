<%@ Control Language="vb" Inherits="DotNetNuke.Modules.Repository.Repository" Codebehind="Repository.ascx.vb" AutoEventWireup="False" Explicit="True" %>

<script src="<%= Page.ResolveUrl("DesktopModules/Repository/js/pngfix.js") %>"></script>

<asp:Label ID="lblDescription" runat="server" CssClass="normal" />
<asp:Table ID="HeaderTable" Width="100%" runat="server" CssClass="normal" CellSpacing="0" CellPadding="0" border="0">
    <asp:TableRow>
        <asp:TableCell>
            <asp:PlaceHolder ID="hPlaceholder" runat="server"  />
        </asp:TableCell>
    </asp:TableRow>
</asp:Table>
<asp:Table ID="DataTable" Width="100%" runat="server" CssClass="normal" CellSpacing="0"
    CellPadding="0" border="0">
    <asp:TableRow>
        <asp:TableCell>
            <asp:DataGrid ID="lstObjects" runat="server" AllowSorting="True" Width="100%" AllowPaging="True"
                OnItemCommand="lstObjects_ItemCommand" BorderWidth="0" BorderStyle="None" OnPageIndexChanged="lstObjects_PageIndexChanged"
                ItemStyle-CssClass="normal" AlternatingItemStyle-CssClass="normal" AutoGenerateColumns="False"
                PageSize="5" PagerStyle-Visible="False" Visible="True" EnableViewState="True"
                Style="border-collapse: separate;" ShowHeader="False">
                <HeaderStyle CssClass="normal" />
                <FooterStyle CssClass="normal" />
                <Columns>
                    <asp:TemplateColumn>
                        <ItemTemplate>
                            <asp:Label ID="TheFileName" runat="server" Visible="False">
						        <%# DataBinder.Eval(Container.DataItem,"FileName")%>
                            </asp:Label>
                            <asp:PlaceHolder ID="PlaceHolder" runat="server" Visible="False"  />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
            </asp:DataGrid>
        </asp:TableCell>
    </asp:TableRow>
</asp:Table>
<asp:Table ID="FooterTable" Width="100%" runat="server" CssClass="normal" CellSpacing="0" CellPadding="0">
    <asp:TableRow>
        <asp:TableCell>
            <asp:PlaceHolder ID="fPlaceHolder" runat="server"  />
        </asp:TableCell>
    </asp:TableRow>
</asp:Table>
