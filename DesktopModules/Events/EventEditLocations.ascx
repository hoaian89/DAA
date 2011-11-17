<%@ Control Language="vb" AutoEventWireup="false" Codebehind="EventEditLocations.ascx.vb" Inherits="DotNetNuke.Modules.Events.EventEditLocations" %>
<%@ Register Src="~/controls/LabelControl.ascx" TagName="Label" TagPrefix="dnn" %>
<asp:Panel ID="pnlEventsModuleLocations" runat="server">
<table id="Table1" border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr valign="top">
        <td style="white-space:nowrap;width:50%">
            <table id="Table2" cellspacing="0" cellpadding="0" border="0">
                <tr>
                    <td class="SubHead" valign="top" style="width:125px">
                        <dnn:Label ID="lblLocationCap" runat="server" CssClass="SubHead" ResourceKey="plLocation" Text="Location"></dnn:Label>
                    </td>
                    <td class="SubHead" valign="top">
                        <asp:TextBox ID="txtLocationName" runat="server" CssClass="NormalTextBox" Width="200px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="SubHead" valign="top">
                        <dnn:Label ID="lblMapURLCap" runat="server" CssClass="SubHead" ResourceKey="plMapURL" Text="Map URL" />
                    </td>
                    <td class="SubHead" valign="top">
                        <asp:TextBox ID="txtMapURL" runat="server" CssClass="NormalTextBox" Width="200px"></asp:TextBox></td>
                </tr>
            </table>
            <asp:LinkButton ID="cmdAdd" runat="server" CssClass="CommandButton" resourcekey="cmdAdd">Add</asp:LinkButton>&nbsp;
            <asp:LinkButton ID="cmdUpdate" resourcekey="cmdUpdate" runat="server" CssClass="CommandButton" Visible="false">Update</asp:LinkButton>&nbsp;
            <asp:LinkButton ID="returnButton" CssClass="CommandButton" runat="server" resourcekey="returnButton" BorderStyle="none" CausesValidation="False">Return</asp:LinkButton></td>
        <td style="white-space:nowrap;width:50%">
            <asp:DataGrid ID="GrdLocations" runat="server" AutoGenerateColumns="False" BorderStyle="Outset" BorderWidth="1px" CssClass="Normal"
                DataKeyField="Location" GridLines="Horizontal" OnDeleteCommand="GrdLocations_DeleteCommand" OnItemCommand="GrdLocations_ItemCommand"
                Width="250px">
                <EditItemStyle VerticalAlign="Bottom"></EditItemStyle>
                <AlternatingItemStyle BackColor="WhiteSmoke"></AlternatingItemStyle>
                <ItemStyle VerticalAlign="Top"></ItemStyle>
                <HeaderStyle Font-Bold="True" BackColor="Silver"></HeaderStyle>
                <Columns>
                    <asp:TemplateColumn>
                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                        <ItemTemplate>
                            <asp:ImageButton ID="DeleteButton" runat="server" CommandArgument="Delete" CommandName="Delete" AlternateText="Delete" resourcekey="DeleteButton"
                                CausesValidation="false" ImageUrl="~/images/delete.gif"></asp:ImageButton>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn Visible="False" HeaderText="PortalID">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text="<%# Container.DataItem.PortalID.ToString %>">
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn Visible="False" HeaderText="Location">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text="<%# Container.DataItem.Location.ToString %>">
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Location Name">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkLocationName" CommandName="Select" CommandArgument="Select" Text="<%# Container.DataItem.LocationName %>"
                                runat="server">
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Map URL">
                        <ItemTemplate>
                            <asp:HyperLink ID="lnkMapURL" Target="_blank" NavigateUrl="<%# Container.DataItem.MapURL.ToString() %>" runat="server">
									<%# Container.DataItem.MapURL.ToString() %>
                            </asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
            </asp:DataGrid>
            <asp:Label ID="lblEditMessage" CssClass="SubHead" runat="server" resourcekey="lblEditMessage">(Select Item Link to Edit)</asp:Label></td>
    </tr>
</table>
</asp:Panel>