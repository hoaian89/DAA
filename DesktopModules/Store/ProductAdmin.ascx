<%@ Control language="c#" CodeBehind="ProductAdmin.ascx.cs" Inherits="DotNetNuke.Modules.Store.WebControls.ProductAdmin" AutoEventWireup="True" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<span><dnn:label id="lblParentTitle" runat="server" controlname="lblParentTitle" visible="False"></dnn:label></span>
<table cellspacing="0" cellpadding="0" width="100%" border="0">
  <tbody>
    <asp:panel id="panelList" runat="server" Visible="true">
    <tr>
      <td valign="top" noWrap align="center"><table cellspacing="3" cellpadding="0" border="0">
          <tr>
            <td class="NormalBold" noWrap width="100"><dnn:label id="lblCategory" controlname="lblCategory" runat="server" cssclass="NormalBold" suffix=":"></dnn:label>
            </td>
            <td><asp:DropDownList id="cmbCategory" runat="server" Width="200" AutoPostBack="true" DataTextField="CategoryName" DataValueField="CategoryID"></asp:DropDownList>
            </td>
          </tr>
        </table>
        <br />
        <asp:datagrid id="grdProducts" runat="server" showheader="true" showfooter="false" autogeneratecolumns="false" width="100%" AllowPaging="True" cellpadding="5">
          <columns>
          <asp:TemplateColumn>
            <HeaderTemplate>
              <asp:Label id="lblProductName" runat="server" resourcekey="lblProductName" cssclass="NormalBold">Product Name</asp:Label>
            </HeaderTemplate>
            <ItemTemplate>
              <asp:label id="labelProductTitle" runat="server" cssclass="Normal"> <%# DataBinder.Eval(Container.DataItem, "ProductTitle") %> </asp:label>
            </ItemTemplate>
          </asp:TemplateColumn>
          <asp:TemplateColumn>
            <HeaderTemplate>
              <asp:Label id="lblSummary" runat="server" resourcekey="lblSummary" cssclass="NormalBold">Summary</asp:Label>
            </HeaderTemplate>
            <ItemTemplate>
              <asp:label id="labelSummary" runat="server" cssclass="Normal"> <%# DataBinder.Eval(Container.DataItem, "Summary") %> </asp:label>
            </ItemTemplate>
          </asp:TemplateColumn>
          <asp:TemplateColumn>
            <HeaderTemplate>
              <asp:Label id="lblArchived" runat="server" resourcekey="lblArchived" cssclass="NormalBold">Archived</asp:Label>
            </HeaderTemplate>
            <ItemTemplate>
              <asp:label id="labelArchived" runat="server" cssclass="Normal"> </asp:label>
            </ItemTemplate>
          </asp:TemplateColumn>
          <asp:TemplateColumn>
            <HeaderTemplate>
              <asp:Label id="lblFeatured" runat="server" resourcekey="lblFeatured" cssclass="NormalBold">Featured</asp:Label>
            </HeaderTemplate>
            <ItemTemplate>
              <asp:label id="labelFeatured" runat="server" cssclass="Normal"> </asp:label>
            </ItemTemplate>
          </asp:TemplateColumn>
          <asp:TemplateColumn>
            <HeaderTemplate>
              <asp:Label id="lblPrice" runat="server" resourcekey="lblPrice" cssclass="NormalBold">Price</asp:Label>
            </HeaderTemplate>
            <ItemTemplate>
              <asp:label id="labelPrice" runat="server" cssclass="Normal"> </asp:label>
            </ItemTemplate>
          </asp:TemplateColumn>
          <asp:TemplateColumn>
            <ItemTemplate>
              <asp:HyperLink id="linkEdit" resourcekey="linkEdit" runat="server" cssclass="Normal"></asp:HyperLink>
            </ItemTemplate>
          </asp:TemplateColumn>
          </columns>
          <PagerStyle mode="NumericPages" horizontalalign="Center" cssclass="NormalBold"></PagerStyle>
        </asp:datagrid>
      </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td align="center"><asp:linkbutton id="linkAddImage" runat="server" cssclass="Normal">
          <asp:Image id="imageAdd" runat="server" ImageUrl="~/images/edit.gif" AlternateText="Add" resourcekey="Add" />
        </asp:linkbutton>
        <asp:linkbutton id="linkAddNew" runat="server" resourcekey="linkAddNew" cssclass="Normal">Add Product</asp:linkbutton>
        <br />
        <br />
      </td>
    </tr>
    </asp:panel>
  <asp:panel id="panelEdit" runat="server" Visible="false">
    <tr>
      <td><asp:PlaceHolder id="editControl" runat="server"></asp:PlaceHolder>
      </td>
    </tr>
    </asp:panel>
  </tbody>
  
</table>
