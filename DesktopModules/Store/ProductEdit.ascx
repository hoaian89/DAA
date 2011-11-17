<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx"%>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register TagPrefix="portal" TagName="URL" Src="~/controls/URLControl.ascx" %>
<%@ Control Language="c#" AutoEventWireup="False" Codebehind="ProductEdit.ascx.cs" Inherits="DotNetNuke.Modules.Store.WebControls.ProductEdit" targetSchema="http://schemas.microsoft.com/intellisense/ie5" %>

<table width="500" border="0" align="center" cellspacing="5">
  <tr valign="top">
    <td class="NormalBold" nowrap="nowrap"><dnn:label id="labelManufacturer" runat="server" controlname="labelManufacturer" suffix=":"></dnn:label>
    </td>
    <td class="Normal" nowrap="nowrap"><asp:TextBox ID="txtManufacturer" Runat="server" Width="300" MaxLength="50" CssClass="NormalTextBox"></asp:TextBox>
    </td>
  </tr>
  <tr valign="top">
    <td class="NormalBold" nowrap="nowrap"><dnn:label id="labelModelName" runat="server" controlname="labelModelName" suffix=":"></dnn:label>
    </td>
    <td class="Normal" nowrap="nowrap"><asp:TextBox ID="txtModelName" Runat="server" Width="300" MaxLength="50" CssClass="NormalTextBox"></asp:TextBox>
    </td>
  </tr>
  <tr valign="top">
    <td class="NormalBold" nowrap="nowrap"><dnn:label id="labelModelNumber" runat="server" controlname="labelModelNumber" suffix=":"></dnn:label>
    </td>
    <td class="Normal" nowrap="nowrap"><asp:TextBox ID="txtModelNumber" Runat="server" Width="300" MaxLength="50" CssClass="NormalTextBox"></asp:TextBox>
    </td>
  </tr>
  <tr valign="top">
    <td class="NormalBold" nowrap="nowrap"><dnn:label id="labelSummary" runat="server" controlname="labelSummary" suffix=":"></dnn:label>
    </td>
    <td class="Normal" nowrap="nowrap"><asp:TextBox ID="txtSummary" Runat="server" Width="300" Height="50" MaxLength="1000" TextMode="MultiLine" CssClass="NormalTextBox"></asp:TextBox>
    </td>
  </tr>
  <tr valign="top">
    <td class="NormalBold" nowrap="nowrap"><dnn:label id="labelUnitPrice" runat="server" controlname="txtUnitPrice" suffix=":"></dnn:label>
    </td>
    <td class="Normal" nowrap="nowrap"><asp:TextBox ID="txtUnitPrice" Runat="server" Width="100" MaxLength="25" CssClass="NormalTextBox"></asp:TextBox>
      <asp:CompareValidator id="validatorUnitPrice" runat="server" ErrorMessage="Error! Please enter a valid price."
				resourcekey="validatorUnitPrice" Type="Currency" ControlToValidate="txtUnitPrice" Operator="DataTypeCheck"
				Display="Dynamic"></asp:CompareValidator>
      <asp:RequiredFieldValidator id="validatorRequireUnitPrice" runat="server" ControlToValidate="txtUnitPrice" ErrorMessage="* Price is required."
				resourcekey="validatorRequireUnitPrice" Display="Dynamic"></asp:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td class="NormalBold" nowrap="nowrap"><dnn:label id="labelUnitWeight" runat="server" suffix=":"></dnn:label>
    </td>
    <td class="Normal" nowrap="nowrap"><asp:TextBox ID="txtUnitWeight" Runat="server" Width="100" MaxLength="25" CssClass="NormalTextBox"></asp:TextBox>
      <asp:CompareValidator id="validatorUnitWeight" runat="server" ErrorMessage="Error! Please enter a valid weight."
				Type="Double" ControlToValidate="txtUnitWeight" Operator="DataTypeCheck" resourcekey="validatorUnitWeight"
				Display="Dynamic"></asp:CompareValidator>
      <asp:RequiredFieldValidator id="validatorRequireUnitWeight" runat="server" ControlToValidate="txtUnitWeight" ErrorMessage="* Weight is required."
				resourcekey="validatorRequireUnitWeight" Display="Dynamic"></asp:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td class="NormalBold" nowrap="nowrap"><dnn:label id="labelUnitHeight" runat="server" suffix=":"></dnn:label>
    </td>
    <td class="Normal" nowrap="nowrap"><asp:TextBox ID="txtUnitHeight" Runat="server" Width="100" MaxLength="25" CssClass="NormalTextBox"></asp:TextBox>
      <asp:CompareValidator id="validatorUnitHeight" runat="server" ErrorMessage="Error! Please enter a valid height."
				Type="Double" ControlToValidate="txtUnitHeight" Operator="DataTypeCheck" resourcekey="validatorUnitHeight"
				Display="Dynamic"></asp:CompareValidator>
      <asp:RequiredFieldValidator id="validatorRequireUnitHeight" runat="server" ControlToValidate="txtUnitHeight" ErrorMessage="* Height is required."
				resourcekey="validatorRequireUnitHeight" Display="Dynamic"></asp:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td class="NormalBold" nowrap="nowrap"><dnn:label id="labelUnitLength" runat="server" suffix=":"></dnn:label>
    </td>
    <td class="Normal" nowrap="nowrap"><asp:TextBox ID="txtUnitLength" Runat="server" Width="100" MaxLength="25" CssClass="NormalTextBox"></asp:TextBox>
      <asp:CompareValidator id="validatorUnitLength" runat="server" ErrorMessage="Error! Please enter a valid length."
				Type="Double" ControlToValidate="txtUnitLength" Operator="DataTypeCheck" resourcekey="validatorUnitLength"
				Display="Dynamic"></asp:CompareValidator>
      <asp:RequiredFieldValidator id="validatorRequireUnitLength" runat="server" ControlToValidate="txtUnitLength" ErrorMessage="* Length is required."
				resourcekey="validatorRequireUnitLength" Display="Dynamic"></asp:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td class="NormalBold" nowrap="nowrap"><dnn:label id="labelUnitWidth" runat="server" suffix=":"></dnn:label>
    </td>
    <td class="Normal" nowrap="nowrap"><asp:TextBox ID="txtUnitWidth" Runat="server" Width="100" MaxLength="25" CssClass="NormalTextBox"></asp:TextBox>
      <asp:CompareValidator id="validatorUnitWidth" runat="server" ErrorMessage="Error! Please enter a valid width."
				Type="Double" ControlToValidate="txtUnitWidth" Operator="DataTypeCheck" resourcekey="validatorUnitWidth"
				Display="Dynamic"></asp:CompareValidator>
      <asp:RequiredFieldValidator id="validatorRequireUnitWidth" runat="server" ControlToValidate="txtUnitWidth" ErrorMessage="* Width is required."
				resourcekey="validatorRequireUnitWidth" Display="Dynamic"></asp:RequiredFieldValidator>
    </td>
  </tr>
  <tr valign="top">
    <td class="NormalBold" nowrap="nowrap"><dnn:label id="labelCategory" runat="server" controlname="labelCategory" suffix=":"></dnn:label>
    </td>
    <td class="Normal" nowrap="nowrap"><asp:DropDownList ID="cmbCategory" Runat="server" Width="200" DataTextField="CategoryPathName" DataValueField="CategoryID"></asp:DropDownList>
    </td>
  </tr>
  <tr valign="top">
    <td class="NormalBold" nowrap="nowrap"><dnn:label id="labelArchived" runat="server" controlname="labelArchived" suffix=":"></dnn:label>
    </td>
    <td class="Normal" nowrap="nowrap"><asp:CheckBox ID="chkArchived" Runat="server"></asp:CheckBox>
    </td>
  </tr>
  <tr valign="top">
    <td class="NormalBold" nowrap="nowrap"><dnn:label id="labelFeatured" runat="server" controlname="labelFeatured" suffix=":"></dnn:label>
    </td>
    <td class="Normal"  nowrap="nowrap"><asp:CheckBox ID="chkFeatured" Runat="server"></asp:CheckBox>
    </td>
  </tr>
  <tr>
    <td colspan="2"><hr />
    </td>
  </tr>
  <tr>
    <td colspan="2"><dnn:sectionhead id="dshSpecialOffer" runat="server" resourcekey="dshSpecialOffer" cssclass="NormalBold" text="Special Offer Pricing"
				section="tblSpecialOffer" includerule="false" isexpanded="false"></dnn:sectionhead>
      <table  width="500" border="0" align="center" cellspacing="5" id="tblSpecialOffer" runat="server" >
        <tr valign="top">
          <td class="NormalBold" nowrap="nowrap"><dnn:label id="labelSalePrice" runat="server" controlname="labelSalePrice" suffix=":"></dnn:label>
          </td>
          <td class="Normal" nowrap="nowrap"><asp:TextBox ID="txtSalePrice" Runat="server" Width="100" MaxLength="25" OnTextChanged="txtSalePrice_TextChanged" CssClass="NormalTextBox"></asp:TextBox>
            <asp:CompareValidator id="validatorSalePrice" runat="server" ErrorMessage="Error! Please enter a valid price."
				            resourcekey="validatorSalePrice" Type="Currency" ControlToValidate="txtSalePrice" Operator="DataTypeCheck"
				            Display="Dynamic"></asp:CompareValidator>
          </td>
        </tr>
        <tr valign="top">
          <td class="NormalBold" nowrap="nowrap"><dnn:label id="labelSaleStartDate" runat="server" controlname="labelSaleStartDate" suffix=":"></dnn:label>
          </td>
          <td class="Normal" nowrap="nowrap"><asp:Calendar ID="calSaleStartDate" runat="server" CssClass="Normal" SelectionMode="Day" OnSelectionChanged="calSaleStartDate_SelectionChanged" OnVisibleMonthChanged="calSaleStartDate_VisibleMonthChanged"></asp:Calendar>
            <asp:Button ID="btnClearStartDate" runat="server" resourcekey="btnClearStartDate" Text="Clear start date" OnClick="btnClearStartDate_Click" CssClass="Normal" />
          </td>
        </tr>
        <tr valign="top">
          <td class="NormalBold" nowrap="nowrap"><dnn:label id="labelSaleEndDate" runat="server" controlname="labelSaleEndDate" suffix=":"></dnn:label>
          </td>
          <td class="Normal" nowrap="nowrap"><asp:Calendar ID="calSaleEndDate" runat="server" CssClass="Normal" SelectionMode="Day" OnSelectionChanged="calSaleEndDate_SelectionChanged" OnVisibleMonthChanged="calSaleEndDate_VisibleMonthChanged"></asp:Calendar>
            <asp:Button ID="btnClearEndDate" runat="server" resourcekey="btnClearEndDate" Text="Clear end date" OnClick="btnClearEndDate_Click" CssClass="Normal" />
          </td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td colspan="2"><hr />
    </td>
  </tr>
  <tr valign="top">
    <td class="NormalBold" nowrap="nowrap"><dnn:label id="labelImage" runat="server" controlname="labelImage" suffix=":"></dnn:label>
    </td>
    <td class="Normal" nowrap="nowrap">&nbsp;
      <portal:URL id="image1" runat="server" width="300" /></td>
  </tr>
  <tr valign="top">
    <td class="NormalBold" colspan="2" nowrap="nowrap"><hr />
      <dnn:label id="labelDescription" runat="server" controlname="labelDescription" suffix=":"></dnn:label>
    </td>
  </tr>
  <tr>
    <td class="Normal" colspan="2" nowrap="nowrap"><dnn:TextEditor id="txtDescription" runat="server" width="500" height="500"></dnn:TextEditor>
    </td>
  </tr>
  <tr>
    <td colspan="2" align="center" nowrap="nowrap"><asp:linkbutton id="cmdUpdate" CssClass="CommandButton" runat="server" BorderStyle="None" resourcekey="cmdUpdate">Update</asp:linkbutton>
      <asp:linkbutton id="cmdCancel" CssClass="CommandButton" runat="server" CausesValidation="False"
				BorderStyle="None" resourcekey="cmdCancel">Cancel</asp:linkbutton>
      <asp:linkbutton id="cmdDelete" CssClass="CommandButton" runat="server" CausesValidation="False"
				BorderStyle="None" Visible="False" resourcekey="cmdDelete">Delete</asp:linkbutton>
    </td>
  </tr>
</table>
