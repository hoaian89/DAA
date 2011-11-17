<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EventDay.ascx.vb" Inherits="DotNetNuke.Modules.Events.EventDay" %>
<%@ Register TagPrefix="evt" TagName="Category" Src="~/DesktopModules/Events/SelectCategory.ascx" %>
<%@ Register TagPrefix="evt" TagName="Icons" Src="~/DesktopModules/Events/EventIcons.ascx" %>
<asp:Panel ID="pnlEventsModuleDay" runat="server">
    <div align="center">
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td style="white-space:nowrap;width:33%" align="center">
                    &nbsp;
                </td>
                <td align="center" style="width:33%">
                    <evt:Category id="SelectCategory" runat="server"></evt:Category>
                </td>
                <td style="white-space:nowrap;width:33%" align="center">
                    <evt:Icons ID="EventIcons" runat="server"></evt:Icons>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:DataGrid ID="lstEvents" CellPadding="2" AutoGenerateColumns="False" GridLines="None" runat="server" ShowHeader="False"
                        CssClass="ListDataGrid" DataKeyField="EventID" Width="100%">
           		        <AlternatingItemStyle CssClass="ListAlternate"></AlternatingItemStyle>
                        <Columns>
                            <asp:TemplateColumn>
                                <HeaderStyle CssClass="ListHeader"></HeaderStyle>
                                <ItemStyle CssClass="ListEdit"></ItemStyle>
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnEventEdit" runat="server" CausesValidation="false" CommandName="Edit" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"EventID") %>'
                                        ImageUrl="~/images/edit.gif" visible='<%# DataBinder.Eval(Container.DataItem,"EditVisibility") %>'/>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Event Start">
                                <HeaderStyle CssClass="ListHeader"></HeaderStyle>
                                <ItemStyle CssClass="ListDate"></ItemStyle>
                                <ItemTemplate>
                                    <asp:Label ID="lblEventBegin" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"txtEventTimeBegin") %>'>
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Event End">
                                <HeaderStyle CssClass="ListHeader"></HeaderStyle>
                                <ItemStyle CssClass="ListDate"></ItemStyle>
                                <ItemTemplate>
                                    <asp:Label ID="lblEventEnd" Text='<%# DataBinder.Eval(Container.DataItem,"txtEventDateEnd") %>' runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Title">
                                <HeaderStyle CssClass="ListHeader"></HeaderStyle>
                                <ItemStyle CssClass="ListTitle"></ItemStyle>
                                <ItemTemplate>
                                    <asp:Panel runat="server" backcolor='<%# DataBinder.Eval(Container.DataItem,"CategoryColor") %>'>
                                    <asp:label ID="lblIcons" Text='<%# Databinder.Eval(Container.DataItem, "Icons")%>' runat="server"></asp:label>
                                    <asp:HyperLink ID="lnkEvent" runat="Server" NavigateUrl='<%# DataBinder.Eval(Container.DataItem,"URL") %>' Target='<%# DataBinder.Eval(Container.DataItem,"Target") %>'
                                        Text='<%# DataBinder.Eval(Container.DataItem,"EventName") %>' forecolor='<%# DataBinder.Eval(Container.DataItem,"CategoryFontColor") %>'>
                                    </asp:HyperLink>
                                    </asp:Panel>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn>
                                <HeaderStyle CssClass="ListHeader"></HeaderStyle>
                                <ItemStyle Wrap="False" CssClass="ListLink"></ItemStyle>
                                <ItemTemplate>
                                    <asp:Image ID="imgEvent" runat="server" Visible='<%# DataBinder.Eval(Container.DataItem,"ImageDisplay") %>' 
                                       ImageUrl='<%# DataBinder.Eval(Container.DataItem,"ImageURL") %>' GenerateEmptyAlternateText="true">
                                    </asp:Image>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Duration">
	                            <HeaderStyle CssClass="ListHeader"></HeaderStyle>
	                            <ItemStyle CssClass="ListDuration"></ItemStyle>
	                            <ItemTemplate>
		                            <asp:Label id="lblDuration" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"DisplayDuration") %>'>
		                            </asp:Label>
	                            </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Category">
	                            <HeaderStyle CssClass="ListHeader"></HeaderStyle>
	                            <ItemStyle CssClass="ListCategory"></ItemStyle>
	                            <ItemTemplate>
		                            <asp:Label id="lblCategory" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"CategoryName") %>' backcolor='<%# DataBinder.Eval(Container.DataItem,"CategoryColor") %>' forecolor='<%# DataBinder.Eval(Container.DataItem,"CategoryFontColor") %>'>
		                            </asp:Label>
	                            </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Location">
	                            <HeaderStyle CssClass="ListHeader"></HeaderStyle>
	                            <ItemStyle CssClass="ListLocation"></ItemStyle>
	                            <ItemTemplate>
		                            <asp:Label id="lblLocation" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"LocationName") %>'>
		                            </asp:Label>
	                            </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="CustomField1">
	                            <HeaderStyle CssClass="ListHeader"></HeaderStyle>
	                            <ItemStyle CssClass="ListCustomField1"></ItemStyle>
	                            <ItemTemplate>
		                            <asp:Label id="lblCustomField1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"CustomField1") %>'>
		                            </asp:Label>
	                            </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="CustomField2">
	                            <HeaderStyle CssClass="ListHeader"></HeaderStyle>
	                            <ItemStyle CssClass="ListCustomField2"></ItemStyle>
	                            <ItemTemplate>
		                            <asp:Label id="lblCustomField2" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"CustomField2") %>'>
		                            </asp:Label>
	                            </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Description">
                                <HeaderStyle CssClass="ListHeader"></HeaderStyle>
                                <ItemStyle CssClass="ListDescription"></ItemStyle>
                                <ItemTemplate>
                                    <asp:Label ID="lblDescription" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"DecodedDesc") %>'>
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="RecurText">
                                <HeaderStyle CssClass="ListHeader"></HeaderStyle>
                                <ItemStyle CssClass="ListDescription"></ItemStyle>
                                <ItemTemplate>
                                    <asp:Label ID="lblRecurText" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"RecurText") %>'>
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="RecurUntil">
                                <HeaderStyle CssClass="ListHeader"></HeaderStyle>
                                <ItemStyle CssClass="ListDate"></ItemStyle>
                                <ItemTemplate>
                                    <asp:Label ID="lblRecurUntil" Text='<%# DataBinder.Eval(Container.DataItem,"RecurUntil") %>' runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                        </Columns>
                    </asp:DataGrid>
                </td>
            </tr>
            <tr>
                <td style="white-space:nowrap;width:0px" align="center" colspan="3">
                    <evt:Icons ID="EventIcons2" runat="server"></evt:Icons>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:LinkButton ID="returnButton" runat="server" CssClass="CommandButton" Text="Return" CausesValidation="False" resourcekey="returnButton"
                        BorderStyle="none">Return</asp:LinkButton>
                    <asp:Label ID="lblMessage" runat="server" Visible="False" resourcekey="lblMessage" CssClass="SubHead">&nbsp;No Events for this day...</asp:Label>
                </td>
            </tr>
        </table>
    </div>
</asp:Panel>
