<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Settings.ascx.vb" Inherits="DotNetNuke.Modules.Announcements.Settings" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="Portal" TagName="URL" Src="~/controls/URLControl.ascx" %>
<table cellspacing="0" cellpadding="2" border="0" summary="Edit Links Design Table" style="width: 650px">
    <tr>
        <td class="SubHead" valign="top" style="width: 200px; vertical-align: top;">
            <dnn:Label ID="plHistory" runat="server" ControlName="txtHistory" Suffix=":"></dnn:Label>
        </td>
        <td valign="top" style="vertical-align: top">
            <asp:TextBox ID="txtHistory" runat="server" Columns="20" Width="64px" CssClass="NormalTextBox"
                Text=""></asp:TextBox>
            <asp:CompareValidator ID="valHistory" resourcekey="History.ErrorMessage" runat="server"
                CssClass="NormalRed" ControlToValidate="txtHistory" ErrorMessage="<br>You Must Enter A Valid Number Of Days"
                Display="Dynamic" Type="Integer" Operator="DataTypeCheck"></asp:CompareValidator>
        </td>
        <td style="white-space: nowrap; vertical-align: bottom; width: 84px;">
        </td>
    </tr>
    <tr>
        <td class="SubHead" valign="top" style="width: 200px; vertical-align: top;">
            <dnn:Label ID="plDefaultView" runat="server" ControlName="ddlViewType" Suffix=":"></dnn:Label>
        </td>
        <td valign="top" style="vertical-align: top">
            <asp:DropDownList ID="ddlViewType" CssClass="NormalTextBox" runat="server"></asp:DropDownList></td>
        <td style="white-space: nowrap; vertical-align: bottom; width: 84px;">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="SubHead" valign="top" style="width: 200px; vertical-align: top;">
            <dnn:Label ID="plDescriptionLength" Suffix=":" ControlName="txtDescriptionLength"
                runat="server"></dnn:Label>
        </td>
        <td valign="top" style="vertical-align: top">
            <asp:TextBox ID="txtDescriptionLength" runat="server" Width="64px"></asp:TextBox>
            <asp:CompareValidator ID="valDescriptionLength" runat="server" Operator="DataTypeCheck"
                Type="Integer" Display="Dynamic" ErrorMessage="<br>You must enter a valid integer"
                ControlToValidate="txtDescriptionLength" CssClass="NormalRed" resourcekey="Integer.ErrorMessage"></asp:CompareValidator></td>
        <td style="white-space: nowrap; vertical-align: bottom; width: 84px;">
        </td>
    </tr>
    <tr>
        <td class="SubHead" valign="top" style="width: 200px; vertical-align: top;">
            <dnn:Label ID="plEditorHeight" Suffix=":" ControlName="txtEditorHeight"
                runat="server"></dnn:Label>
        </td>
        <td valign="top" style="vertical-align: top">
            <asp:TextBox ID="txtEditorHeight" runat="server" Width="64px"></asp:TextBox>
            <asp:CompareValidator ID="valEditorHeight" runat="server" Operator="DataTypeCheck"
                Type="Integer" Display="Dynamic" ErrorMessage="<br>You must enter a valid integer"
                ControlToValidate="txtEditorHeight" CssClass="NormalRed" 
                resourcekey="Integer.ErrorMessage"></asp:CompareValidator></td>
        <td style="white-space: nowrap; vertical-align: bottom; width: 84px;">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="SubHead" valign="top" style="width: 200px; vertical-align: top;">
            <dnn:Label ID="plHeaderTemplate" runat="server" ControlName="txtHeaderTemplate" Suffix=":"></dnn:Label>
        </td>
        <td valign="top" style="vertical-align: top">
            <asp:TextBox ID="txtHeaderTemplate" CssClass="NormalTextBox" Width="350" Columns="30" TextMode="MultiLine"
                Rows="10" MaxLength="2000" runat="server" />
        </td>
        <td style="white-space: nowrap; vertical-align: bottom; width: 84px;">
            <asp:LinkButton ID="cmdLoadDefHeader" runat="server" CausesValidation="False" CssClass="commandButton" resourcekey="LoadDefault" >Load Default</asp:LinkButton></td>
    </tr>
    <tr>
        <td class="SubHead" valign="top" style="width: 200px; vertical-align: top;">
            <dnn:Label ID="plTemplate" runat="server" ControlName="txtTemplate" Suffix=":"></dnn:Label>
        </td>
        <td valign="top" style="vertical-align: top">
            <asp:TextBox ID="txtTemplate" CssClass="NormalTextBox" Width="350" Columns="30" TextMode="MultiLine"
                Rows="10" MaxLength="2000" runat="server" />
        </td>
        <td style="white-space: nowrap; vertical-align: bottom; width: 84px;">
            <asp:LinkButton ID="cmdLoadDefItemTemplate" runat="server" CausesValidation="False" CssClass="commandButton" resourcekey="LoadDefault">Load Default</asp:LinkButton></td>
    </tr>
    <tr>
        <td class="SubHead" valign="top" style="width: 200px; vertical-align: top;">
            <dnn:Label ID="plAltItemTemplate" runat="server" ControlName="txtAltItemTemplate" Suffix=":"></dnn:Label>
        </td>
        <td valign="top" style="vertical-align: top">
            <asp:TextBox ID="txtAltItemTemplate" CssClass="NormalTextBox" Width="350" Columns="30" TextMode="MultiLine"
                Rows="10" MaxLength="2000" runat="server" />
        </td>
        <td style="white-space: nowrap; vertical-align: bottom; width: 84px;">
            <asp:LinkButton ID="cmdLoadDefAltItemTemplate" runat="server" CausesValidation="False" CssClass="commandButton" resourcekey="LoadDefault">Load Default</asp:LinkButton></td>
    </tr>
    <tr>
        <td class="SubHead" valign="top" style="width: 200px; vertical-align: top;">
            <dnn:Label ID="plSeparator" runat="server" ControlName="txtSeparator" Suffix=":"></dnn:Label>
        </td>
        <td valign="top" style="vertical-align: top">
            <asp:TextBox ID="txtSeparator" CssClass="NormalTextBox" Width="350" Columns="30" TextMode="MultiLine"
                Rows="10" MaxLength="2000" runat="server" />
        </td>
        <td style="white-space: nowrap; vertical-align: bottom; width: 84px;">
            <asp:LinkButton ID="cmdLoadDefSeparator" runat="server" CausesValidation="False" CssClass="commandButton" resourcekey="LoadDefault">Load Default</asp:LinkButton></td>
    </tr>
    <tr>
        <td class="SubHead" style="width: 200px; vertical-align: top;">
            <dnn:Label ID="plFooterTemplate" runat="server" ControlName="txtFooterTemplate" Suffix=":"></dnn:Label>
        </td>
        <td style="vertical-align: top">
            <asp:TextBox ID="txtFooterTemplate" CssClass="NormalTextBox" Width="350" Columns="30" TextMode="MultiLine"
                Rows="10" MaxLength="2000" runat="server" />
        </td>
        <td style="white-space: nowrap; vertical-align: bottom; width: 84px;">
            <asp:LinkButton ID="cmdLoadDefFooterTemplate" runat="server" CausesValidation="False" CssClass="commandButton" resourcekey="LoadDefault">Load Default</asp:LinkButton></td>
    </tr>
</table>
