<%@ Control language="c#" CodeBehind="ProductDetail.ascx.cs" Inherits="DotNetNuke.Modules.Store.WebControls.ProductDetail" AutoEventWireup="True" %>

<table cellSpacing="0" cellPadding="0" width="100%" border="0">
  <tr>
    <td nowrap><asp:placeholder id="plhDetails" runat="server" />
      <asp:Panel ID="pnlReviews" runat="server">
        <asp:Label ID="labelReviews" CssClass="ListContainer-Title" Runat="server" resourcekey="labelReviews">Reviews</asp:Label>
        <p><asp:PlaceHolder ID="plhReviews" Runat="server"></asp:PlaceHolder></p>
        </asp:Panel>
    </td>
  </tr>
  <tr>
    <td align="center"><asp:Panel ID="pnlReturn" runat="server">
        <asp:hyperlink id="lnkReturn" runat="server" cssclass="NormalBold" resourcekey="lnkReturn">Return To Category</asp:hyperlink>
        </asp:Panel>
    </td>
  </tr>
</table>
