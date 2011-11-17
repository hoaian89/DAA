<%@ Control language="vb" Inherits="DotNetNuke.Modules.Gallery.Voting" AutoEventWireup="false" Codebehind="Voting.ascx.vb" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
	<script type="text/javascript" language="javascript" src='<%= Page.ResolveUrl("DesktopModules/Gallery/Popup/gallerypopup.js") %>'></script>
	<table class="Gallery_Border" cellspacing="1" cellpadding="0" width="100%" style="vertical-align:middle;">
		<tr>
			<td id="tdTitle" runat="server" class="Gallery_Header" style="width:100%; height:28px;" colspan="2" >&nbsp;Rating</td>
		</tr>
		<tr id="rowTitle" runat="server">
			<td style="width:100%" colspan="2">
				<table id="tblTitle" cellspacing="0" cellpadding="0" style="width:100%" runat="server">
					<tr>
						<td class="Gallery_Header" valign="middle" align="left" style="width:70%; height:20px;">&nbsp;
							<asp:image id="imgTitle" runat="server" AlternateText='""'></asp:image>&nbsp;<asp:hyperlink id="lnkTitle" runat="server" cssclass="Gallery_AltHeaderText"></asp:hyperlink></td>
						<td class="Gallery_Header" valign="middle" align="right" style="width:30%; height:20px;"><asp:image id="imgVoteSummary" runat="server"></asp:image>&nbsp;
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="Gallery_Row" valign="middle" align="center" style="width:25%;"><asp:hyperlink id="lnkThumb" runat="server"></asp:hyperlink></td>
			<td valign="top" align="left" style="width:75%;">
				<table id="tblDetails" cellspacing="0" cellpadding="0" style="width:100%" runat="server">
					<tr id="rowDetails" runat="server">
						<td>
							<table id="tblViewVote" cellspacing="1" cellpadding="3" style="width:100%" runat="server">
								<tr id="rowResult" runat="server">
									<td id="tdResult" runat="server" class="Gallery_RowHighLight" valign="top" align="right" style="width:140px; height:22px;">Rating 
										Summary:
									</td>
									<td class="Gallery_Row" valign="top" align="left" style="height:22px;"><asp:label id="lblResult" runat="server" cssclass="Normal"></asp:label></td>
								</tr>
								<tr id="rowName" runat="server">
									<td id="tdName" runat="server" class="Gallery_RowHighLight" valign="top" align="right" style="width:140px; height:22px;">Name:
									</td>
									<td class="Gallery_Row" valign="top" align="left" style="height:22px;"><asp:label id="lblName" runat="server" cssclass="Normal"></asp:label></td>
								</tr>
								<tr id="rowDate" runat="server">
									<td id="tdCreatedDate" runat="server" class="Gallery_RowHighLight" valign="top" align="right" style="width:140px; height:22px;">Created 
										Date:
									</td>
									<td class="Gallery_Row" valign="top" align="left" style="height:22px;"><asp:label id="lblDate" runat="server" cssclass="Normal"></asp:label></td>
								</tr>
								<tr id="rowAuthor" runat="server">
									<td id="tdAuthor" runat="server" class="Gallery_RowHighLight" valign="top" align="right" style="width:140px; height:22px;">Author:
									</td>
									<td class="Gallery_Row" valign="top" align="left" style="height:22px;"><asp:label id="lblAuthor" runat="server" cssclass="Normal"></asp:label></td>
								</tr>
								<tr id="rowDecription" runat="server">
									<td id="tdDescription" runat="server" class="Gallery_RowHighLight" valign="top" align="right" style="width:140px; height:22px;">Description:
									</td>
									<td class="Gallery_Row" valign="top" align="left" style="height:22px;"><asp:label id="lblDescription" runat="server" cssclass="Normal"></asp:label></td>
								</tr>
								<tr>
									<td class="Gallery_SubHeader" style="width:140px;">&nbsp;</td>
									<td class="Gallery_Header" valign="bottom" align="right" style="height:28px;"><asp:Linkbutton id="btnAddVote" runat="server" cssclass="CommandButton" resourcekey="btnAddVote" text="Add Vote"></asp:Linkbutton>&nbsp;
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr id="rowAddVote" runat="server" visible="false">
						<td>
							<table id="tblAddVote" cellspacing="1" cellpadding="0" style="width:100%;" runat="server">
								<tr>
									<td id="tdYourRating" runat="server" class="Gallery_SubHeader" valign="top" style="width:140px;">&nbsp;Your Rating:</td>
									<td class="Gallery_Row" align="left"><asp:radiobuttonlist id="lstVote" runat="server" height="22px"></asp:radiobuttonlist></td>
								</tr>
								<tr>
									<td id="tdYourComments" class="Gallery_SubHeader" valign="top" style="width:140px;">&nbsp;<dnn:Label ID="plComments" runat="server" ControlName="txtComment" Text="Your Comments:" /></td>
									<td class="Gallery_Row" align="left"><asp:textbox id="txtComment" runat="server" width="100%" cssclass="NormalTextBox" textmode="MultiLine"></asp:textbox></td>
								</tr>
								<tr>
									<td class="Gallery_SubHeader" style="width:140px;">&nbsp;</td>
									<td class="Gallery_Header"  valign="bottom" align="right" style="height:28px;"><asp:Linkbutton id="cmdCancel" runat="server" text="Cancel" cssclass="CommandButton" resourcekey="cmdCancel"></asp:Linkbutton>&nbsp;
										<asp:Linkbutton id="btnSave" runat="server" text="Update" cssclass="CommandButton" resourcekey="cmdUpdate"></asp:Linkbutton>&nbsp;
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td style="width:100%" colspan="2">
			<asp:datalist id="dlVotes" runat="server" cssclass="CommandButton" style="width:100%" DataKeyField="FileName"
					EnableViewState="False" cellpadding="1" RepeatDirection="Vertical">
					<ItemStyle HorizontalAlign="Center" VerticalAlign="Top"></ItemStyle>
					<ItemTemplate>
						<table class="Gallery_Border" id="tblVote" cellpadding="1" cellspacing="0" style="width:100%"
							border="0" runat="server">
							<tr>
								<td colspan="2">
									<table cellpadding="0" cellspacing="0" style="width:100%" runat="server" id="Table1">
										<tr>
											<td align="left" valign="top" style="height:24px; width:70%;" class="Gallery_SubHeader">&nbsp;
												<asp:label id="lblItemName" cssclass="NormalBold" runat="server" text='<%# GetUserName(Container.DataItem) %>'>
												</asp:label>&nbsp;-&nbsp;
												<asp:label id="lblCreatedDate" cssclass="Normal" runat="server" text= '<%# DataBinder.Eval(Container.DataItem, "CreatedDate").ToShortDateString %>'>
												</asp:label>
											</td>
											<td align="right" valign="middle" style="height:24px; width:30%;" class="Gallery_SubHeader">
												<asp:Image id="imgScore" imageurl='<%# ScoreImage(Container.DataItem) %>' runat="server" AlternateText='""'>
												</asp:Image>&nbsp;
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="Gallery_Row" style="width:3%;"></td>
								<td valign="top" style="width:97%; height:24px;" class="Gallery_Row">
									<asp:label id="lblComment" cssclass="Normal" runat="server" text='<%# DataBinder.Eval(Container.DataItem, "Comment") %>'>
									</asp:label>
								</td>
							</tr>
						</table>
					</ItemTemplate>
				</asp:datalist></td>
		</tr>
		<tr valign="top">
			<td class="Gallery_Header" valign="bottom" align="center" colspan="2"><asp:Linkbutton id="btnBack" runat="server" cssclass="CommandButton" ResourceKey="btnBack" text="Back" commandname="back"></asp:Linkbutton>
			</td>
		</tr>
	</table>
