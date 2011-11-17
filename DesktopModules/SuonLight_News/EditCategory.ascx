<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditCategory.ascx.cs" Inherits="SuonLight.Modules.News.EditCategory" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="categoryValidate"/>
<table cellpadding="0" cellspacing="0">
<tr>
    <td class="SubHead" width="150"><dnn:label id="lblCategory" runat="server" controlname="txtCategory" suffix=":" Text="Category" ResourceKey="lblCategory"></dnn:label></td>
    <td valign="bottom" >
        <asp:Textbox id="txtCategory" cssclass="NormalTextBox" width="390" columns="30" MaxLength="20" runat="server" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Nhập tên danh mục" ControlToValidate="txtCategory" ValidationGroup="categoryValidate" Display="None"></asp:RequiredFieldValidator>
    </td>
</tr>
<tr>
    <td class="SubHead" width="150"><dnn:label id="lblParent" runat="server" controlname="ddlParent" suffix=":" ResourceKey="lblParent"></dnn:label></td>
    <td valign="bottom" >
        <asp:DropDownList ID="ddlParent" runat="server"></asp:DropDownList>        
    </td>
</tr>
<tr>
    <td class="SubHead" width="150"><dnn:label id="lblPublished" runat="server" controlname="lblPublished" suffix=":" ResourceKey="lblPublished"></dnn:label></td>
    <td valign="bottom" >
        <asp:CheckBox ID="chbPublished" runat="server" />
    </td>
</tr>
<tr>
    <td class="SubHead" width="150"><dnn:label id="lblDescription" runat="server" controlname="txtDescription" suffix=":" ResourceKey="lblDescription"></dnn:label></td>
    <td valign="bottom" >
        <asp:Textbox id="txtDescription" cssclass="NormalTextBox" width="390" columns="30" TextMode="MultiLine" Rows="6" MaxLength="2000" runat="server" />
    </td>
</tr>
<tr>
    <td class="SubHead" width="150"><dnn:label id="lblOrder" runat="server" controlname="txtOrder" suffix=":" ResourceKey="lblOrder"></dnn:label></td>
    <td valign="bottom" >
        <asp:Textbox id="txtOrder" cssclass="NormalTextBox" width="390" MaxLength="2" runat="server" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Nhập thứ tự danh mục" ControlToValidate="txtOrder" ValidationGroup="categoryValidate" Display="None"></asp:RequiredFieldValidator>
        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" TargetControlID="txtOrder" FilterType="Numbers">
        </cc1:FilteredTextBoxExtender>
    </td>
</tr>
</table>

<p>
    <asp:linkbutton cssclass="CommandButton" id="cmdUpdate" resourcekey="cmdUpdate" runat="server" borderstyle="none" text="Update" OnClick="cmdUpdate_Click" ValidationGroup="categoryValidate"></asp:linkbutton>&nbsp;
    <asp:linkbutton cssclass="CommandButton" id="cmdCancel" resourcekey="cmdCancel" runat="server" borderstyle="none" text="Cancel" causesvalidation="False" OnClick="cmdCancel_Click"></asp:linkbutton>&nbsp;
    <asp:linkbutton cssclass="CommandButton" id="cmdDelete" resourcekey="cmdDelete" runat="server" borderstyle="none" text="Delete" causesvalidation="False" OnClick="cmdDelete_Click"></asp:linkbutton>&nbsp;
</p>