<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Control Inherits="DotNetNuke.Modules.Survey.EditSurvey" CodeFile="EditSurvey.ascx.vb" language="vb" AutoEventWireup="false" Explicit="True" %>
<%@ Register TagPrefix="Portal" TagName="Audit" Src="~/controls/ModuleAuditControl.ascx" %>
<br>
<table class="Settings" cellspacing="0" cellpadding="2" border="0">
	<tr>
		<td class="SubHead" width="165"><dnn:label id="plQuestion" text="Question:" controlname="txtQuestion" runat="server" /></td>
		<td><asp:textbox id="txtQuestion" runat="server" cssclass="NormalTextBox" textmode="MultiLine" rows="3"
				maxlength="500" width="300"></asp:textbox></td>
	</tr>
	<tr>
		<td class="SubHead" width="165"><dnn:label id="plOptionType" text="Type:" controlname="cboOptionType" runat="server" /></td>
		<td valign="top">
			<asp:dropdownlist id="cboOptionType" runat="server" cssclass="NormalTextBox" width="300">
				<asp:listitem resourcekey="SingleSelection" value="R">Single Selection</asp:listitem>
				<asp:listitem resourcekey="MultipleSelection" value="C">Multiple Selection</asp:listitem>
			</asp:dropdownlist>
		</td>
	</tr>
	<tr>
		<td class="SubHead" width="165"><dnn:label id="plViewOrder" text="View Order:" controlname="txtViewOrder" runat="server" /></td>
		<td><asp:textbox id="txtViewOrder" runat="server" cssclass="NormalTextBox" maxlength="128" width="44px"></asp:textbox></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td class="SubHead" width="165"><dnn:label id="plOption" text="New Option:" controlname="txtOption" runat="server" /></td>
		<td>
			<asp:textbox id="txtOption" runat="server" cssclass="NormalTextBox" textmode="MultiLine" rows="3"
				maxlength="500" width="300px"></asp:textbox>
		</td>
	</tr>
	<tr>
		<td class="SubHead" width="165">&nbsp;</td>
		<td class="SubHead" width="300" align="center">
			<asp:CheckBox ID="chkCorrect" Runat="server" CssClass="SubHead" Text="Option Is Correct Answer?" resourcekey="chkCorrect"></asp:CheckBox>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<asp:linkbutton id="cmdAddOption" text="Add Option" resourcekey="cmdAddOption" runat="server" class="CommandButton"
				borderstyle="none">Add Option</asp:linkbutton>
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td class="SubHead" width="165"><dnn:label id="plOptions" text="Options:" controlname="lstOptions" runat="server" /></td>
		<td>
			<table cellspacing="0" cellpadding="0" border="0">
				<tr valign="top">
					<td><asp:listbox id="lstOptions" runat="server" rows="10" datatextfield="OptionName" datavaluefield="SurveyOptionId"
							cssclass="NormalTextBox" width="300px"></asp:listbox></td>
					<td>&nbsp;&nbsp;</td>
					<td height="100%">
						<table height="100%">
							<tr>
								<td valign="top"><asp:imagebutton id="cmdUp" resourcekey="cmdUp" runat="server" alternatetext="Move Option Up" commandname="up"
										imageurl="~/images/up.gif"></asp:imagebutton></td>
							</tr>
							<tr>
								<td valign="top"><asp:imagebutton id="cmdDown" resourcekey="cmdDown" runat="server" alternatetext="Move Option Down"
										commandname="down" imageurl="~/images/dn.gif"></asp:imagebutton></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td valign="bottom"><asp:imagebutton id="cmdDeleteOption" key="cmdDeleteOption" runat="server" alternatetext="Delete Option"
										imageurl="~/images/delete.gif"></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<p>
	<asp:linkbutton id="cmdUpdate" resourcekey="cmdUpdate" runat="server" cssclass="CommandButton" text="Update"
		borderstyle="none"></asp:linkbutton>&nbsp;
	<asp:linkbutton id="cmdCancel" resourcekey="cmdCancel" runat="server" cssclass="CommandButton" text="Cancel"
		borderstyle="none" causesvalidation="False"></asp:linkbutton>&nbsp;
	<asp:linkbutton id="cmdDelete" resourcekey="cmdDelete" runat="server" cssclass="CommandButton" text="Delete"
		borderstyle="none" causesvalidation="False"></asp:linkbutton>
</p>
<portal:audit id="ctlAudit" runat="server" />

