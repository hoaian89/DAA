<%@ Control language="vb" CodeBehind="EditDocs.ascx.vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.Modules.Documents.EditDocs" targetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register TagPrefix="Portal" TagName="URL" Src="~/controls/URLControl.ascx" %>
<%@ Register TagPrefix="Portal" TagName="Audit" Src="~/controls/ModuleAuditControl.ascx" %>
<%@ Register TagPrefix="Portal" TagName="Tracking" Src="~/controls/URLTrackingControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<table cellSpacing="0" cellPadding="0" width="560" summary="Edit Documents Design Table"
  border="0">
  <tr vAlign="top">
    <td class="SubHead" width="125"><dnn:label id="plName" runat="server" controlname="txtName" suffix=":"></dnn:label></td>
    <td width="400"><asp:textbox id="txtName" runat="server" cssclass="NormalTextBox" width="300" maxlength="150"></asp:textbox><asp:requiredfieldvalidator id="valName" runat="server" cssclass="NormalRed" resourcekey="Name.ErrorMessage"
        display="Dynamic" errormessage="<br>You Must Enter A Title For The Document" controltovalidate="txtName"></asp:requiredfieldvalidator></td>
  </tr>
  <tr vAlign="top">
    <td class="SubHead" width="125"><dnn:label id="plDescription" runat="server" controlname="txtDescription" suffix=":"></dnn:label></td>
    <td width="400"><asp:textbox id="txtDescription" runat="server" cssclass="NormalTextBox" width="300" maxlength="255"
        TextMode="MultiLine" Rows="3"></asp:textbox></td>
  </tr>
  <tr vAlign="top">
    <td class="SubHead" width="125"><dnn:label id="plCategory" runat="server" controlname="txtCategory" suffix=":"></dnn:label></td>
    <td width="400"><asp:textbox id="txtCategory" runat="server" cssclass="NormalTextBox" width="300" maxlength="50"></asp:textbox><asp:dropdownlist id="lstCategory" runat="server" Width="300px"></asp:dropdownlist></td>
  </tr>
  <tr vAlign="top">
    <td class="SubHead" width="125"><dnn:label id="plOwner" runat="server" controlname="lstOwner" suffix=":"></dnn:label></td>
    <td width="400"><asp:dropdownlist id="lstOwner" runat="server" Width="300px" Visible="False"></asp:dropdownlist><asp:label id="lblOwner" runat="server" CssClass="NormalBold"></asp:label><br>
      <asp:linkbutton id="lnkChange" runat="server" cssclass="CommandButton" resourcekey="lnkChangeOwner"
        causesvalidation="False" text="Change Owner" borderstyle="none">Change Owner</asp:linkbutton></td>
  </tr>
  <tr>
    <td class="SubHead" width="125"><dnn:label id="plURL" runat="server" controlname="ctlURL" suffix=":"></dnn:label></td>
    <td width="400">
      &nbsp;<portal:url id="ctlURL" runat="server" showtabs="False" shownone="True" urltype="F" shownewwindow="True"
        ShowSecure="True" ShowDatabase="True"></portal:url></td>
  </tr>
  <tr vAlign="top">
    <td class="SubHead" width="125"><dnn:label id="plSortIndex" runat="server" controlname="txtSortIndex" suffix=":"></dnn:label></td>
    <td width="400"><asp:textbox id="txtSortIndex" runat="server" cssclass="NormalTextBox" width="30" maxlength="3"
        TextMode="SingleLine"></asp:textbox><asp:rangevalidator id="valSortIndex" runat="server" CssClass="NormalRed" ErrorMessage="Please enter a value from 0-999."
        Display="Dynamic" ControlToValidate="txtSortIndex" Type="Integer" MaximumValue="999" MinimumValue="0"></asp:rangevalidator></td>
  </tr>
</table>
<p><asp:linkbutton id="cmdUpdate" runat="server" cssclass="CommandButton" resourcekey="cmdUpdate" text="Update"
    borderstyle="none"></asp:linkbutton>&nbsp;
  <asp:LinkButton ID="cmdUpdateOverride" runat="server" BorderStyle="none" CssClass="CommandButton"
    resourcekey="cmdUpdateOverride" Text="Update Anyway" Visible="False"></asp:LinkButton>&nbsp;
    <asp:linkbutton id="cmdCancel" runat="server" cssclass="CommandButton" resourcekey="cmdCancel" causesvalidation="False"
    text="Cancel" borderstyle="none"></asp:linkbutton>&nbsp;
  <asp:linkbutton id="cmdDelete" runat="server" cssclass="CommandButton" resourcekey="cmdDelete" causesvalidation="False"
    text="Delete" borderstyle="none"></asp:linkbutton>
  </p>
<portal:audit id="ctlAudit" runat="server"></portal:audit><asp:label id="lblAudit" runat="server" CssClass="SubHead"></asp:label><br>
<br>
<portal:tracking id="ctlTracking" runat="server"></portal:tracking>
