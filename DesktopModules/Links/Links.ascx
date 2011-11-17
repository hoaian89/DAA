<%@ Control Language="vb" Inherits="DotNetNuke.Modules.Links.Links" CodeBehind="Links.ascx.vb"
    AutoEventWireup="false" Explicit="True" %>
<asp:Panel ID="pnlList" runat="server">
    <asp:DataList ID="lstLinks" runat="server" ItemStyle-VerticalAlign="Top" CellPadding="0">
        <ItemTemplate>
            <table border="0" cellpadding="4" cellspacing="0" summary="Links Design Table" class="LinksDesignTable">
                <tr>
                    <td <%# NoWrap %>>
                        <asp:HyperLink ID="editLink" NavigateUrl='<%# EditURL("ItemID",DataBinder.Eval(Container.DataItem,"ItemID")) %>'
                            Visible="<%# IsEditable %>" runat="server">
                            <asp:Image ID="editLinkImage" ImageUrl="~/images/edit.gif" AlternateText="Edit" Visible="<%# IsEditable %>"
                                runat="server" /></asp:HyperLink>
                        <asp:Image ImageUrl="<%# FormatIcon() %>" Visible="<%# DisplayIcon() %>" runat="server" resourcekey="imgLinkIcon.Text"/>
                        <asp:HyperLink CssClass="Normal" Text='<%# DataBinder.Eval(Container.DataItem,"Title") %>'
                            NavigateUrl='<%# FormatURL(DataBinder.Eval(Container.DataItem,"Url"),DataBinder.Eval(Container.DataItem,"TrackClicks")) %>'
                            ToolTip='<%# DisplayToolTip(DataBinder.Eval(Container.DataItem,"Description")) %>'
                            Target='<%# IIF(DataBinder.Eval(Container.DataItem,"NewWindow"),"_blank","_self") %>'
                            runat="server" /><span id="spnSelect" runat="server" Visible='<%# DisplayInfo(DataBinder.Eval(Container.DataItem,"Description")) %>'>&nbsp;<asp:LinkButton id="cmdMoreInfo" runat="server" CssClass="CommandButton" Text='...' resourcekey="MoreInfo.Text" CommandName="Select"/></span>
                    </td>
                </tr>
                <tr id="pnlDescription" visible="false" runat="server">
                    <td>
                        <asp:Label runat="server" CssClass="Normal" Text='<%# HtmlDecode(DataBinder.Eval(Container.DataItem, "Description")) %>'
                            ID="Label1" />
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
</asp:Panel>
<asp:Panel ID="pnlDropdown" runat="server">
    <table cellspacing="0" cellpadding="4" summary="Links Design Table" border="0" class="LinksDesignTable">
        <tr>
            <td <%# NoWrap %>>
                <asp:ImageButton ID="cmdEdit" runat="server" ImageUrl="~/images/edit.gif" AlternateText="Edit"
                    resourcekey="Edit"></asp:ImageButton>
                <label style="display: none" for="<%=cboLinks.ClientID%>">
                    Link</label>
                <asp:DropDownList ID="cboLinks" runat="server" DataTextField="Title" DataValueField="ItemID"
                    CssClass="NormalTextBox">
                </asp:DropDownList>
                &nbsp;
                <asp:LinkButton ID="cmdGo" runat="server" CssClass="CommandButton" resourcekey="cmdGo"></asp:LinkButton>&nbsp;
                <asp:LinkButton ID="cmdInfo" runat="server" CssClass="CommandButton" Text="..."></asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblDescription" runat="server" CssClass="Normal"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Panel>
