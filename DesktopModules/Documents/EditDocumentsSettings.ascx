<%@ Control language="vb" CodeBehind="EditDocumentsSettings.ascx.vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.Modules.Documents.EditDocumentsSettings" targetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<table width="560" cellspacing="0" cellpadding="0" border="0">
  <tr valign="top">
    <td class="SubHead" width="200" style="white-space: nowrap">
      <dnn:label id="plUseCategoriesList" runat="server" controlname="chkUseCategoriesList" suffix=""></dnn:label>
    </td>
    <td>
      <asp:CheckBox id="chkUseCategoriesList" runat="server"></asp:CheckBox>
    </td>
  </tr>
  <tr valign="top">
    <td class="SubHead" width="200">
      <dnn:label id="plCategoriesListName" runat="server" controlname="cboCategoriesList" suffix=""></dnn:label>
    </td>
    <td>
      <asp:DropDownList ID="cboCategoriesList" runat="server" CssClass="Normal" Width="100%">
      </asp:DropDownList>
      <asp:Label ID="lstNoListsAvailable" runat="server" Visible="False" CssClass="Normal"></asp:Label>
      <asp:Hyperlink ID="lnkEditLists" runat="server" CssClass="CommandButton" style="display: block; padding-bottom: 4px;">List Editor</asp:Hyperlink></td>
  </tr>
  <tr valign="top">
    <td class="SubHead" width="200">
      <dnn:label id="plDefaultFolder" runat="server" controlname="cboDefaultFolder" suffix=""></dnn:label>
    </td>
    <td>
      <asp:DropDownList ID="cboDefaultFolder" runat="server" CssClass="Normal" Width="100%">
      </asp:DropDownList></td>
  </tr>
  <tr valign="top">
    <td class="SubHead" width="200">
      <dnn:label id="plShowTitleLink" runat="server" controlname="chkShowTitleLink" suffix=""></dnn:label>
    </td>
    <td>
      <asp:CheckBox id="chkShowTitleLink" runat="server"></asp:CheckBox>
    </td>
  </tr>
  
  <tr valign="top">
    <td class="SubHead" width="200">
      <dnn:label id="plDisplayColumns" runat="server" controlname="grdColumns" suffix=":"></dnn:label>
    </td>
    <td>
      <asp:DataGrid id="grdDisplayColumns" runat="server" AutoGenerateColumns="False" GridLines="None"
        Width="350px">
        <Columns>
          <asp:BoundColumn DataField="LocalizedColumnName" HeaderText="Name"></asp:BoundColumn>
          <asp:TemplateColumn HeaderText="Visible">
            <HeaderStyle Width="60px"></HeaderStyle>
            <ItemTemplate>
              <asp:CheckBox id="chkVisible" runat="server" Checked='<%# DataBinder.Eval(Container.DataItem, "Visible") %>'>
              </asp:CheckBox>
            </ItemTemplate>
          </asp:TemplateColumn>
          <asp:TemplateColumn>
            <HeaderStyle Width="50px"></HeaderStyle>
            <ItemTemplate>
              <asp:ImageButton id=imgUp runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ColumnName") %>' CommandName="DisplayOrderUp" AlternateText='<%# GetLocalizedText("cmdUp.Text")%>'>
              </asp:ImageButton>
              <asp:ImageButton id=imgDown runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ColumnName") %>' CommandName="DisplayOrderDown" AlternateText='<%# GetLocalizedText("cmdDown.Text")%>'>
              </asp:ImageButton>
            </ItemTemplate>
          </asp:TemplateColumn>
        </Columns>
      </asp:DataGrid>
      <br>
    </td>
  </tr>
  <tr valign="top">
    <td class="SubHead" width="200">
      <dnn:label id="plSorting" runat="server" controlname="" suffix=":"></dnn:label>
    </td>
    <td>
      <asp:DropDownList id="lstSortFields" runat="server" CssClass="Normal"></asp:DropDownList>&nbsp;<asp:DropDownList ID="cboSortOrderDirection" runat="server"
        CssClass="Normal">
      </asp:DropDownList>&nbsp;
      <asp:LinkButton id="lnkAddSortColumn" runat="server" CssClass="CommandButton" resourcekey="cmdAdd"
        Width="100px" style="text-align: right">Add</asp:LinkButton>
      <hr>
      <asp:DataGrid id="grdSortColumns" runat="server" GridLines="None" AutoGenerateColumns="False"
        ShowHeader="False" Width="400px">
        <Columns>
          <asp:BoundColumn DataField="LocalizedColumnName" HeaderText="Name"></asp:BoundColumn>
          <asp:BoundColumn DataField="Direction" HeaderText="DirectionString"></asp:BoundColumn>
          
          <asp:ButtonColumn Text="Delete" CommandName="Delete">
            <HeaderStyle Width="70px"></HeaderStyle>
            <ItemStyle HorizontalAlign="Right"></ItemStyle>
          </asp:ButtonColumn>
        </Columns>
      </asp:DataGrid>
    </td>
  </tr>
  <tr valign="top">
    <td class="SubHead" width="200">
      <dnn:label id="plAllowUserSort" runat="server" controlname="chkAllowUserSort" suffix=""></dnn:label>
    </td>
    <td>
      <asp:CheckBox id="chkAllowUserSort" runat="server"></asp:CheckBox>
    </td>
  </tr>
</table>
