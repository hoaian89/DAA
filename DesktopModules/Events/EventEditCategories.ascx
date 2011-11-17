<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Events.WebControls" Assembly="DotNetNuke.Events.WebControls" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="EventEditCategories.ascx.vb" Inherits="DotNetNuke.Modules.Events.EventEditCategories" %>
<%@ Register Src="~/controls/LabelControl.ascx" TagName="Label" TagPrefix="dnn" %>
<asp:Panel ID="pnlEventsModuleCategories" runat="server">
<table id="Table1" cellspacing="0" cellpadding="0" width="100%" border="0">
    <tr valign="top">
        <td style="white-space:nowrap;width:50%;">
            <table id="Table2" cellspacing="0" cellpadding="2" border="0">
                <tr>
                    <td class="SubHead" valign="top" style="width:125px">
                        <dnn:Label ID="lblCategoryCap" runat="server" CssClass="SubHead" ResourceKey="plCategory" Text="Category:" />
                    </td>
                    <td class="SubHead" valign="top">
                        <asp:TextBox ID="txtCategoryName" runat="server" CssClass="NormalTextBox"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="SubHead" valign="top">
                        <dnn:Label ID="lblColorCap" runat="server" CssClass="SubHead" ResourceKey="plColor" Text="Color:" />
                    </td>
                    <td class="SubHead" valign="top">
                        <asp:TextBox ID="txtCategoryColor" runat="server" CssClass="NormalTextBox"></asp:TextBox>&nbsp;
                        <dnn:DNNColorDropDown ID="ddlCategoryColor" runat="server" DisplayColorText="false" DisplaySelectColorItem="True" Palette="WebSafe"
                            SortOption="ByValue" DisplaySelectColorItemText="[None]"></dnn:DNNColorDropDown>
                </tr>
                <tr>
                    <td class="SubHead" valign="top">
                        <dnn:Label ID="lblFontColorCap" runat="server" CssClass="SubHead" ResourceKey="plFontColor" Text="Font Color:" />
                    </td>
                    <td class="SubHead" valign="top">
                        <asp:TextBox ID="txtCategoryFontColor" runat="server" CssClass="NormalTextBox"></asp:TextBox>&nbsp;
                        <dnn:DNNColorDropDown ID="ddlCategoryFontColor" runat="server" DisplayColorText="false" DisplaySelectColorItem="True" Palette="WebSafe"
                            SortOption="ByValue" DisplaySelectColorItemText="[None]"></dnn:DNNColorDropDown>
                </tr>
                <tr>
                    <td class="SubHead" valign="top">
                        <dnn:Label ID="lblPreview" runat="server" CssClass="SubHead" ResourceKey="plPreview" Text="Preview:" />
                    </td>
                    <td id="previewpane" class="SubHead" valign="top" style="text-align:center;">
                        <span ID="lblPreviewCat"></span>
                    </td>
                </tr>

            </table>
            <asp:LinkButton ID="cmdAdd" runat="server" CssClass="CommandButton" resourcekey="cmdAdd">Add</asp:LinkButton>&nbsp;
            <asp:LinkButton ID="cmdUpdate" runat="server" CssClass="CommandButton" resourcekey="cmdUpdate" Visible="false">Update</asp:LinkButton>&nbsp;
            <asp:LinkButton ID="returnButton" resourcekey="returnButton" CssClass="CommandButton" runat="server" BorderStyle="none" CausesValidation="False">Return</asp:LinkButton></td>
        <td style="width:50%">
            <asp:DataGrid ID="GrdCategories" runat="server" AutoGenerateColumns="False" BorderStyle="Outset" BorderWidth="1px" CssClass="Normal"
                DataKeyField="Category" GridLines="Horizontal" OnDeleteCommand="GrdCategories_DeleteCommand" OnItemCommand="GrdCategories_ItemCommand"
                Width="250px">
                <EditItemStyle VerticalAlign="Bottom" />
                <AlternatingItemStyle BackColor="WhiteSmoke" />
                <ItemStyle VerticalAlign="Top" />
                <HeaderStyle BackColor="Silver" Font-Bold="True" />
                <Columns>
                    <asp:TemplateColumn>
                        <ItemStyle HorizontalAlign="Left" />
                        <ItemTemplate>
                            <asp:ImageButton ID="DeleteButton" runat="server" AlternateText="Delete" CausesValidation="false" CommandArgument="Delete"
                                CommandName="Delete" ImageUrl="~/images/delete.gif" resourcekey="DeleteButton" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="PortalID" Visible="False">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text="<%# Container.DataItem.PortalID.ToString %>">
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Category" Visible="False">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text="<%# Container.DataItem.Category.ToString %>">
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Category Name">
                        <ItemTemplate>
                            <asp:Panel runat="server" BackColor="<%# GetColor(Container.DataItem.Color) %>">
                                <asp:LinkButton ID="lnkCategoryName" runat="server" forecolor="<%# GetColor(Container.DataItem.FontColor) %>" CommandArgument="Select"
                                    CommandName="Select" Text="<%# Container.DataItem.CategoryName %>">
                                </asp:LinkButton>
                            </asp:Panel>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
            </asp:DataGrid>
            <asp:Label ID="lblEditMessage" runat="server" CssClass="SubHead" resourcekey="lblEditMessage">(Select Item Link to Edit)</asp:Label>
        </td>
    </tr>
</table>
</asp:Panel>