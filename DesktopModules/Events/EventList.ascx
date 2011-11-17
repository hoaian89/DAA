<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EventList.ascx.vb" Inherits="DotNetNuke.Modules.Events.EventList" %>
<%@ Register TagPrefix="evt" TagName="Category" Src="~/DesktopModules/Events/SelectCategory.ascx" %>
<%@ Register TagPrefix="evt" TagName="Icons" Src="~/DesktopModules/Events/EventIcons.ascx" %>
<div>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td style="white-space:nowrap;width:33%" align="center">
                &nbsp;
            </td>
            <td align="center" style="height:19px;width:33%">
                <evt:Category ID="SelectCategory" runat="server"></evt:Category>
            </td>
            <td align="right" style="white-space:nowrap;width:33%">
                <evt:Icons ID="EventIcons" runat="server"></evt:Icons>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="3">
                <asp:GridView ID="gvEvents" AllowPaging="True" PageSize="25" AllowSorting="True" GridLines="None" runat="server" CssClass="ListDataGrid" Width="100%" AutoGenerateColumns="False">
                    <AlternatingRowStyle CssClass="ListAlternate" />
		    <RowStyle CssClass="ListNormal"/>
                    <PagerStyle CssClass="ListPager" />
			
                    <Columns>
                        <asp:TemplateField>
                            <HeaderStyle CssClass="ListHeader"></HeaderStyle>
                            <ItemStyle CssClass="ListEdit"></ItemStyle>
                            <ItemTemplate>
                                <asp:ImageButton ID="btnEventEdit" runat="server" CausesValidation="false" CommandName="Edit" CommandArgument='<%# DataBinder.Eval(Container.DataItem,"EventId") %>'
                                    ImageUrl="~/images/edit.gif" visible='<%# DataBinder.Eval(Container.DataItem,"EditVisibility") %>'/>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField SortExpression="EventDateBegin" HeaderText="Event Start">
                            <HeaderStyle CssClass="ListHeader"></HeaderStyle>
                            <ItemStyle CssClass="ListDate"></ItemStyle>
                            <ItemTemplate>
                                <asp:Label ID="lblEventBegin" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"txtEventTimeBegin") %>'>
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField SortExpression="EventDateEnd" HeaderText="Event End">
                            <HeaderStyle CssClass="ListHeader"></HeaderStyle>
                            <ItemStyle CssClass="ListDate"></ItemStyle>
                            <ItemTemplate>
                                <asp:Label ID="lblEventEnd" Text='<%# DataBinder.Eval(Container.DataItem,"txtEventDateEnd") %>' runat="server">
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField SortExpression="EventName" HeaderText="Title">
                            <HeaderStyle CssClass="ListHeader"></HeaderStyle>
                            <ItemStyle CssClass="ListTitle"></ItemStyle>
                            <ItemTemplate>
                            <asp:Panel runat="server" backcolor='<%# DataBinder.Eval(Container.DataItem,"CategoryColor") %>'>
                            <%#Eval("Icons")%>
                                <asp:HyperLink CssClass="ListTitle" ID="lnkEvent" runat="Server" NavigateUrl='<%# DataBinder.Eval(Container.DataItem,"URL") %>' Target='<%# DataBinder.Eval(Container.DataItem,"Target") %>' 
                                    Text='<%# DataBinder.Eval(Container.DataItem,"EventName") %>' forecolor='<%# DataBinder.Eval(Container.DataItem,"CategoryFontColor") %>'>
                                </asp:HyperLink>
                            </asp:Panel>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField >
                            <HeaderStyle CssClass="ListHeader"></HeaderStyle>
                            <ItemStyle Wrap="False" CssClass="ListLink"></ItemStyle>
                            <ItemTemplate>
                                <asp:Image ID="imgEvent" runat="server" Visible='<%# DataBinder.Eval(Container.DataItem,"ImageDisplay") %>' 
                                    ImageUrl='<%# DataBinder.Eval(Container.DataItem,"ImageURL") %>' GenerateEmptyAlternateText="true">
                                </asp:Image>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField SortExpression="Duration" HeaderText="Duration">
	                        <HeaderStyle CssClass="ListHeader"></HeaderStyle>
	                        <ItemStyle CssClass="ListDuration"></ItemStyle>
	                        <ItemTemplate>
		                        <asp:Label id="lblDuration" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"DisplayDuration") %>'>
		                        </asp:Label>
	                        </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField SortExpression="CategoryName" HeaderText="Category">
	                        <HeaderStyle CssClass="ListHeader"></HeaderStyle>
	                        <ItemStyle CssClass="ListCategory" ></ItemStyle>
	                        <ItemTemplate>
		                        <asp:Label id="lblCategory" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"CategoryName") %>' backcolor='<%# DataBinder.Eval(Container.DataItem,"CategoryColor") %>' forecolor='<%# DataBinder.Eval(Container.DataItem,"CategoryFontColor") %>'>
		                        </asp:Label>
	                        </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField SortExpression="LocationName" HeaderText="Location">
	                        <HeaderStyle CssClass="ListHeader"></HeaderStyle>
	                        <ItemStyle CssClass="ListLocation" ></ItemStyle>
	                        <ItemTemplate>
		                        <asp:Label id="lblLocation" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"LocationName") %>'>
		                        </asp:Label>
	                        </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField SortExpression="CustomField1" HeaderText="CustomField1">
	                        <HeaderStyle CssClass="ListHeader"></HeaderStyle>
	                        <ItemStyle CssClass="ListCustomField1"></ItemStyle>
	                        <ItemTemplate>
		                        <asp:Label id="lblCustomField1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"CustomField1") %>'>
		                        </asp:Label>
	                        </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField SortExpression="CustomField2" HeaderText="CustomField2">
	                        <HeaderStyle CssClass="ListHeader"></HeaderStyle>
	                        <ItemStyle CssClass="ListCustomField2"></ItemStyle>
	                        <ItemTemplate>
		                        <asp:Label id="lblCustomField2" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"CustomField2") %>'>
		                        </asp:Label>
	                        </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField SortExpression="Description" HeaderText="Description">
                            <HeaderStyle CssClass="ListHeader"></HeaderStyle>
                            <ItemStyle CssClass="ListDescription"></ItemStyle>
                            <ItemTemplate>
                                <asp:Label ID="lblDescription" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"DecodedDesc") %>'>
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField SortExpression="RecurText" HeaderText="RecurText">
                            <HeaderStyle CssClass="ListHeader"></HeaderStyle>
                            <ItemStyle CssClass="ListDescription"></ItemStyle>
                            <ItemTemplate>
                                <asp:Label ID="lblRecurText" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"RecurText") %>'>
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField SortExpression="RecurUntil" HeaderText="RecurUntil">
                            <HeaderStyle CssClass="ListHeader"></HeaderStyle>
                            <ItemStyle CssClass="ListDate"></ItemStyle>
                            <ItemTemplate>
                                <asp:Label ID="lblRecurUntil" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"RecurUntil") %>'>
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td style="white-space:nowrap;width:0px" align="center" colspan="3">
                <evt:Icons ID="EventIcons2" runat="server"></evt:Icons>
            </td>
        </tr>
    </table>
</div>