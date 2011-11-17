<%@ Register TagPrefix="dnnsc" Namespace="DotNetNuke.UI.WebControls" Assembly="DotNetNuke" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="ViewComments.ascx.vb" Inherits="DotNetNuke.Modules.Feedback.ViewComments" TargetSchema="http://schemas.microsoft.com/intellisense/ie3-2nav3-0" %>
<asp:Panel ID="pnlModuleContent" Runat="server">
	<table width="100%" border="0">
	
		<tr>
			<td style="white-space:nowrap;" >
				<asp:Label id="Label5" Runat="server" resourcekey="RecordsPage" CssClass="SubHead">Records Per Page:</asp:Label>
				<asp:DropDownList id="ddlRecordsPerPage" Runat="server" AutoPostBack="True">
					<asp:ListItem Value="10">10</asp:ListItem>
					<asp:ListItem Value="25">25</asp:ListItem>
					<asp:ListItem Value="50">50</asp:ListItem>
					<asp:ListItem Value="100">100</asp:ListItem>
					<asp:ListItem Value="250">250</asp:ListItem>
				</asp:DropDownList></td>
			<td style="white-space:nowrap;" >
				<dnnsc:PagingControl id="ctlPagingControl" runat="server"></dnnsc:PagingControl></td>
		</tr>
		<tr>
			<td colspan="2">
				<asp:datalist id="dlComments" runat="server"  RepeatColumns="1">
					<ItemTemplate>
						<table border="0" >
							<tr>
								<td colspan="2">
									<asp:label id="lblAuthor" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "CreatedByName") %>' CssClass="head" />&nbsp;&nbsp;
									<asp:label id="lblEmail" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "CreatedByEmail") %>' CssClass="head" />&nbsp;&nbsp;
									<asp:label id="lblCategory" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "CategoryValue") %>' CssClass="subhead" />&nbsp;&nbsp;
									<asp:label id="lblDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DateCreated") %>' CssClass="subhead" />
									<asp:label id="lblFeedbackID" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FeedbackID") %>' Visible="False" /><br/>
									<asp:label id="lblSubject" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Subject") %>' CssClass="subhead" />
									<asp:label id="lblMessage" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Message") %>' CssClass="Normal" />
								</td>	
							</tr>
						</table>
						<hr style="width:100%; size:1;" />
					</ItemTemplate>
				</asp:datalist></td>
		</tr>
	</table>
</asp:Panel>
