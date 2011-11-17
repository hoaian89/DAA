<%@ Control Language="vb" AutoEventWireup="false" Codebehind="EventPPEnroll.ascx.vb" Inherits="DotNetNuke.Modules.Events.EventPPEnroll" %>
<%@ Register Src="~/controls/LabelControl.ascx" TagName="Label" TagPrefix="dnn" %>
<asp:Panel ID="pnlEventsModulePayPal" runat="server">
<table id="Table1" cellspacing="0" cellpadding="2" width="85%" summary="Purchase Design Table" border="0">
    <tr valign="top">
        <td class="SubHead" style="width:150px">
            <dnn:Label ID="lblEventNameCap" runat="server" ResourceKey="plEventName" Text="Event Name"></dnn:Label>
        </td>
        <td>
            <asp:Label ID="lblEventName" runat="server" CssClass="Normal"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblEventStart" runat="server" ResourceKey="plEventStart" Text="Event Date/Time"></dnn:Label>
        </td>
        <td>
            <asp:Label ID="lblStartDate" runat="server" Width="300px" CssClass="Normal"></asp:Label>
        </td>
    </tr>
    <tr valign="top">
        <td class="SubHead">
            <dnn:Label ID="lblDescriptionCap" runat="server" ResourceKey="plDescription" Text="Description"></dnn:Label>
        </td>
        <td>
            <asp:Label ID="lblDescription" runat="server" CssClass="Normal"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblFeeCap" runat="server" ResourceKey="plFee" Text="Event Fee"></dnn:Label>
        </td>
        <td>
            <table id="Table2" cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr>
                    <td style="width:75px" align="left">
                        <asp:Label ID="lblFee" runat="server" CssClass="Normal"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblFeeCurrency" CssClass="NormalBold" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblTotalCharges" runat="server" ResourceKey="plTotal" Text="Total Charges"></dnn:Label>
        </td>
        <td>
            <table id="Table3" cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr>
                    <td style="width:75px" align="left">
                        <asp:Label ID="lblTotal" runat="server" CssClass="Normal"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblTotalCurrency" CssClass="NormalBold" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="SubHead" colspan="2">
            <asp:Panel ID="Panel1" runat="server" CssClass="SubHead" Width="100%">
                <asp:Label ID="lblPurchase" runat="server">Pressing the "Purchase" link below will take you to the PayPal secure payment form.  You will then be able to approve the payment and, after completion, will be returned back to the Event Enrollment confirmation form.</asp:Label>
            </asp:Panel>
        </td>
    </tr>
    <tr>
        <td class="SubHead" colspan="2">
            <asp:LinkButton ID="cmdReturn" runat="server" resourcekey="cmdReturn" CssClass="CommandButton" BorderStyle="none" Text="Cancel"
                CausesValidation="False" Visible="False">Return</asp:LinkButton>
        </td>
    </tr>
    <tr>
        <td class="SubHead" colspan="2">
            <asp:LinkButton CssClass="CommandButton" ID="cmdPurchase" runat="server" resourcekey="cmdPurchase" BorderStyle="none"
                Text="Update">Purchase</asp:LinkButton>&nbsp;&nbsp;
            <asp:LinkButton ID="cancelButton" runat="server" resourcekey="cancelButton" CssClass="CommandButton" BorderStyle="none" Text="Cancel"
                CausesValidation="False"></asp:LinkButton>&nbsp;
        </td>
    </tr>
</table>
</asp:Panel>
