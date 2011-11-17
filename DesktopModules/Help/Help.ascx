<%@ Control Language="vb" AutoEventWireup="false" Inherits="DotNetNuke.Modules.Help.Help"
    Codebehind="Help.ascx.vb" %>
<asp:Panel ID="pnlSettings" runat="server">
    <asp:Label ID="lblConfigurationMessage" CssClass="NormalRed" runat="server"></asp:Label>
</asp:Panel>
<asp:Panel ID="pnlControls" runat="server">
    <asp:Panel ID="pnlList" runat="server">
        <asp:Label ID="lblCategoryName" runat="server" CssClass="SubSubHead" Visible="true"></asp:Label>
        <br />
        <asp:Label ID="lblCategoryDescription" runat="server" CssClass="Normal" Visible="true"></asp:Label>
        <br />
        <br />
        <asp:DataList ID="lstTutorials" runat="server" DataKeyField="TutorialID" CellPadding="4"
            EnableViewState="False">
            <ItemTemplate>
                <asp:HyperLink ID="editLink" NavigateUrl='<%# EditTutorialUrl(DataBinder.Eval(Container.DataItem, "TutorialID")) %>'
                    Visible="<%#IsEditable%>" runat="server">
                    <asp:Image ID="editLinkImage" AlternateText="Edit" Visible="<%#IsEditable%>" ImageUrl="~/images/edit.gif"
                        runat="Server" resourcekey="Edit" />
                </asp:HyperLink>
                <asp:HyperLink ID="viewOrderUp" runat="server">
                    <asp:Image ID="imgUp" AlternateText="Up" Visible="<%#IsEditable%>" ImageUrl="~/images/up.gif"
                        runat="Server" resourcekey="Edit" />
                </asp:HyperLink>
                <asp:HyperLink ID="viewOrderDown" runat="server">
                    <asp:Image ID="imgDown" AlternateText="Down" Visible="<%#IsEditable%>" ImageUrl="~/images/dn.gif"
                        runat="Server" resourcekey="Edit" />
                </asp:HyperLink>
                <span class="SubHead">
                    <%# DataBinder.Eval(Container.DataItem,"Title") %>
                </span>
                <br>
                <span class="Normal">
                    <%# Server.HtmlDecode(DataBinder.Eval(Container.DataItem,"ShortDesc")) %>
                    &nbsp;
                    <asp:HyperLink ID="moreLink" NavigateUrl='<%# FormatURL(DataBinder.Eval(Container.DataItem,"TutorialID")) %>'
                        runat="server" resourcekey="ReadMore">read more...</asp:HyperLink>
                </span>
                <hr>
            </ItemTemplate>
        </asp:DataList>
        <asp:ImageButton ID="cmdRefresh" runat="server" resourcekey="cmdRefresh.Help" AlternateText="Refresh View Order"
            CommandName="refresh" ImageUrl="~/DesktopModules/Help/refresh.gif"></asp:ImageButton>
        <asp:ImageButton ID="cmdAlphabetise" runat="server" resourcekey="cmdAlphabetise.Help"
            AlternateText="Alphabetical View Order" CommandName="Alphabetise" ImageUrl="~/DesktopModules/Help/a2z.gif">
        </asp:ImageButton>
    </asp:Panel>
    <asp:Panel ID="pnlDetail" runat="server" Visible="False" DESIGNTIMEDRAGDROP="75">
        <div align="center">
            <asp:HyperLink ID="hypPreviousTop" runat="server" CssClass="CommandButton" resourcekey="Previous"
                ImageUrl="~/images/rev.gif">Previous</asp:HyperLink>&nbsp;&nbsp;
            <asp:HyperLink ID="hypBackTop" runat="server" CssClass="CommandButton" resourcekey="BackToCategory"
                ImageUrl="~/images/stop.gif">Back to Category</asp:HyperLink>&nbsp;&nbsp;
            <asp:HyperLink ID="hypNextTop" runat="server" CssClass="CommandButton" resourcekey="Next"
                ImageUrl="~/images/fwd.gif">Next</asp:HyperLink>
            &nbsp;<asp:Label ID="lblTutorialLocationTop" runat="server" CssClass="Normal"></asp:Label>
            <asp:Label ID="lblSeparatorTop" runat="server" CssClass="Normal" resourcekey="Separator"></asp:Label>
            <asp:Label ID="lblTutorialCountTop" runat="server" CssClass="Normal"></asp:Label>
        </div>
        <asp:HyperLink ID="DetailEditLink" runat="server" Visible="<%#IsEditable%>">
            <asp:Image ID="DetailEditLinkImage" AlternateText="Edit" Visible="<%#IsEditable%>"
                ImageUrl="~/images/edit.gif" runat="Server" resourcekey="Edit" />
        </asp:HyperLink>
        <asp:Label ID="lblTitle" runat="server" CssClass="SubHead"></asp:Label>
        <br />
        <asp:Label ID="lblDescription" runat="server" CssClass="Normal"></asp:Label>
        <br />
        <div align="center">
            <asp:HyperLink ID="hypPreviousBottom" runat="server" CssClass="CommandButton" resourcekey="Previous"
                ImageUrl="~/images/rev.gif">Previous</asp:HyperLink>&nbsp;&nbsp;
            <asp:HyperLink ID="hypBackBottom" runat="server" CssClass="CommandButton" resourcekey="BackToCategory"
                ImageUrl="~/images/stop.gif">Back to Category</asp:HyperLink>&nbsp;&nbsp;
            <asp:HyperLink ID="hypNextBottom" runat="server" CssClass="CommandButton" resourcekey="Next"
                ImageUrl="~/images/fwd.gif">Next</asp:HyperLink>
            &nbsp;<asp:Label ID="lblTutorialLocationBottom" runat="server" CssClass="Normal"></asp:Label>
            <asp:Label ID="lblSeparatorBottom" runat="server" CssClass="Normal" resourcekey="Separator"></asp:Label>
            <asp:Label ID="lblTutorialCountBottom" runat="server" CssClass="Normal"></asp:Label>
        </div>
    </asp:Panel>
</asp:Panel>
