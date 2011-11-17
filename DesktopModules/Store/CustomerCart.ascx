<%@ Control language="c#" CodeBehind="CustomerCart.ascx.cs" Inherits="DotNetNuke.Modules.Store.WebControls.CustomerCart" AutoEventWireup="True" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<div class="Store-Cart-Entity">
  <table cellspacing="0" cellpadding="0" border="0" width="100%" class="CartMasterTABLE">
    <tr>
      <td valign="top" nowrap="nowrap" class="ListContainer-Title"><dnn:label id="lblParentTitle" runat="server" visible="False" controlname="lblParentTitle"></dnn:label>
        <asp:placeholder id="plhCart" runat="server" />
      </td>
    </tr>
    <tr>
      <td class="Store-Cart-BtnViewCartMasterTD">
        <table cellspacing="0" cellpadding="0" border="0" class="Store-Cart-BtnViewCart">
          <tbody>
            <tr>
              <td class="Store-Boutton-left"></td>
              <td class="Store-Boutton-spacer">&nbsp;</td>
              <td nowrap="nowrap" class="Store-Boutton-back"><asp:linkbutton id="btnCheckout" runat="server" cssclass="Normal">Checkout</asp:linkbutton>
              </td>
              <td class="Store-Boutton-spacer">&nbsp;</td>
              <td class="Store-Boutton-right"></td>
            </tr>
            <tr>
                <td colspan="5">
                    <asp:Label ID="lblInfos" runat="server" CssClass="NormalBold"></asp:Label>
                </td>
            </tr>
          </tbody>
        </table>
      </td>
    </tr>
  </table>
</div>
