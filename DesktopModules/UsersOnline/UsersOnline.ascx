<%@ Control language="vb" autoeventwireup="false" inherits="DotNetNuke.Modules.UsersOnline.UsersOnline" codebehind="UsersOnline.ascx.vb" %>
<table cellspacing="0" cellpadding="4" width="100%">
	<tr class="Normal">
		<td>
			<asp:Panel runat="server" id="pnlMembership" visible="False">
				<table cellspacing="0" cellpadding="0" border="0">
					<tr>
						<td align="center" width="25"><img id="imgMembership" height="14" alt="Membership" src="Images/uoGroup1.gif" width="17" align="middle" runat="server" resourcekey="imgMembership" /></td>
						<td class="NormalBold">
							<asp:Label id="MembershipLabel" runat="server" resourcekey="MembershipLabel">Membership:</asp:Label>
						</td>
					</tr>
					<tr>
						<td align="center" width="25"><img id="imgLatest" height="14" alt="Latest New User" src="Images/uoLatest.gif" width="17" align="middle" runat="server" resourcekey="imgLatest" /></td>
						<td class="Normal">
							<asp:Label id="LatestUserLabel" runat="server" resourcekey="LatestUserLabel">Latest:</asp:Label>
							<asp:Label id="lblLatestUserName" runat="server" cssclass="NormalBold"></asp:Label>
						</td>
					</tr>
					<tr>
						<td align="center" width="25"><img id="imgNewToday" height="14" alt="New Today" src="Images/uoNewToday.gif" width="17" align="middle" runat="server" resourcekey="imgNewToday" /></td>
						<td class="Normal">
							<asp:Label id="NewTodayLabel" runat="server" resourcekey="NewTodayLabel">New Today:</asp:Label>
							<asp:Label id="lblNewToday" runat="server" cssclass="NormalBold"></asp:Label>
						</td>
					</tr>
					<tr>
						<td align="center" width="25"><img id="imgNewYesterday" height="14" alt="New Yesterday" src="Images/uoNewYesterday.gif" width="17" align="middle" runat="server" resourcekey="imgNewYesterday" /></td>
						<td class="Normal">
							<asp:Label id="NewYesterdayLabel" runat="server" resourcekey="NewYesterdayLabel">New Yesterday:</asp:Label>
							<asp:Label id="lblNewYesterday" runat="server" cssclass="NormalBold"></asp:Label>
						</td>
					</tr>
					<tr>
						<td align="center" width="25"><img id="imgUserCount" height="14" alt="Overall Users" src="Images/uoOverall.gif" width="17" align="middle" runat="server" resourcekey="imgUserCount" /></td>
						<td class="Normal">
							<asp:Label id="OverallLabel" runat="server" resourcekey="OverallLabel">Overall:</asp:Label>
							<asp:Label id="lblUserCount" runat="server" cssclass="NormalBold"></asp:Label>
						</td>
					</tr>
				</table>
				<hr />
			</asp:Panel>
			<asp:Panel runat="server" id="pnlUsersOnline" visible="False">
				<table cellspacing="0" cellpadding="0" border="0">
					<tr>
						<td align="center" width="25"><img id="imgPeopleOnline" height="14" alt="People Online" src="Images/uoGroup2.gif" width="17" align="middle" runat="server" resourcekey="imgPeopleOnline" /></td>
						<td class="NormalBold">
							<asp:Label id="PeopleOnlineLabel" runat="server" resourcekey="PeopleOnlineLabel">People Online:</asp:Label>
						</td>
					</tr>
					<tr>
						<td align="center" width="25"><img id="imgVisitors" height="14" alt="Visitors" src="Images/uoVisitors.gif" width="17" align="middle" runat="server" resourcekey="imgVisitors" /></td>
						<td class="Normal">
							<asp:Label id="VisitorsLabel" runat="server" resourcekey="VisitorsLabel">Visitors:</asp:Label>
							<asp:Label id="lblGuestCount" runat="server" cssclass="NormalBold"></asp:Label>
						</td>
					</tr>
					<tr>
						<td align="center" width="25"><img id="imgMemberCount" height="14" alt="Members" src="Images/uoMembers.gif" width="17" align="middle" runat="server" resourcekey="imgMemberCount" /></td>
						<td class="Normal">
							<asp:Label id="MembersLabel" runat="server" resourcekey="MembersLabel">Members:</asp:Label>
							<asp:Label id="lblMemberCount" runat="server" cssclass="NormalBold"></asp:Label>
						</td>
					</tr>
					<tr>
						<td align="center" width="25"><img id="imgTotalCount" height="14" alt="Total Users" src="Images/uoTotal.gif" width="17" align="middle" runat="server" resourcekey="imgTotalCount" /></td>
						<td class="Normal">
							<asp:Label id="TotalLabel" runat="server" resourcekey="TotalLabel">Total:</asp:Label>
							<asp:Label id="lblTotalCount" runat="server" cssclass="NormalBold"></asp:Label>
						</td>
					</tr>
				</table>
				<hr />
			</asp:Panel>
			<asp:Panel runat="server" id="pnlOnlineNow" visible="False">
				<table cellspacing="0" cellpadding="0" border="0">
					<tr>
						<td align="center" width="25"><img id="imgOnlineNow" resourcekey="imgOnlineNow" runat="server" height="14" src="Images/uoGroup3.gif" width="17" align="middle" alt="Onine Now" /></td>
						<td class="Normal">
							<asp:Label id="OnlineNowLabel" runat="server" resourcekey="OnlineNowLabel" cssclass="NormalBold">Online Now:</asp:Label><br />
						</td>
					</tr>
					<asp:Repeater id="rptOnlineNow" runat="server" enableviewstate="False">
						<ItemTemplate>
							<tr>
								<td id="tdPrefix" runat="server" class="Normal" align="center" width="25" />
								<td id="tdName" runat="server" class="Normal" />
							</tr>
						</ItemTemplate>
					</asp:Repeater>
				</table>
			</asp:Panel>
		</td>
	</tr>
</table>
