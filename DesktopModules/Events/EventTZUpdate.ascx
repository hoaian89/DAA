<%@ Control Language="vb" AutoEventWireup="false" Codebehind="EventTZUpdate.ascx.vb" Inherits="DotNetNuke.Modules.Events.EventTZUpdate" %>
<P><asp:label id="lblDescription" resourcekey="lblDescription" runat="server" ForeColor="Red"
		Font-Bold="True">CAUTION: This process will update the module Event TimeZones for ALL Events (does not update the date/time)</asp:label></P>
<P><asp:label id="lblTimeZone" resourcekey="lblTimeZone" runat="server" CssClass="SubHead">Select TimeZone:</asp:label>&nbsp;
	<asp:dropdownlist id="cboTimeZone" runat="server" width="300" Font-Size="8pt" cssclass="NormalTextBox"></asp:dropdownlist></P>
<P><asp:linkbutton id="cmdUpdate" resourcekey="cmdUpdate" BorderStyle="None" runat="server" CssClass="CommandButton">Update</asp:linkbutton>&nbsp;
	<asp:linkbutton id="returnButton" runat="server" resourcekey="returnButton" CssClass="CommandButton"
		BorderStyle="none" CausesValidation="False" Text="Delete this item">
										Return</asp:linkbutton></P>
