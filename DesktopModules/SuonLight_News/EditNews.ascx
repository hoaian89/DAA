<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditNews.ascx.cs" Inherits="SuonLight.Modules.News.EditNews" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx"%> 
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx"%> 

<style type="text/css">
    .style1
    {
        width: 664px;
    }
</style>

<asp:ValidationSummary ID="validattionSummary" runat="server" ShowSummary="true" ValidationGroup="summary" />
<table cellpadding="0" cellspacing="3">
<tr>
    <td class="SubHead" width="150"><dnn:label id="lblTitle" runat="server" controlname="txtTitle" suffix=":" ResourceKey="lblTitle"></dnn:label></td>
    <td valign="bottom" class="style1" width="100%" >
        <asp:Textbox id="txtTitle" cssclass="NormalTextBox" width="390" columns="30" MaxLength="600" runat="server" />
        <asp:RequiredFieldValidator ID="RequiredTitle" runat="server" ErrorMessage="Nhập tựa đề bản tin" ControlToValidate="txtTitle" ValidationGroup="summary" Display="None"><span style="color:Red">(*)</span></asp:RequiredFieldValidator>
    </td>
</tr>
<tr>
    <td class="SubHead" width="150"><dnn:label id="lblKeywords" runat="server" controlname="txtKeywords" suffix=":" ResourceKey="lblKeywords"></dnn:label></td>
    <td valign="bottom" class="style1" width="100%" >
        <asp:Textbox id="txtKeywords" cssclass="NormalTextBox" width="390" columns="30" MaxLength="250" runat="server" />                
    </td>
</tr>
<tr>
    <td class="SubHead" width="150"><dnn:label id="lblCategory" runat="server" controlname="ddlCategory" suffix=":" ResourceKey="lblCategory"></dnn:label></td>
    <td valign="bottom" class="style1" width="100%" >
        <asp:DropDownList ID="ddlCategory" runat="server" Width="390px"></asp:DropDownList>
        <asp:RequiredFieldValidator ID="RequiredCategory" runat="server"  ControlToValidate="ddlCategory" ErrorMessage="Chọn danh mục" Display="None" ValidationGroup="summary" InitialValue="0"></asp:RequiredFieldValidator>
    </td>
</tr>
<tr>
    <td class="SubHead" width="150"><dnn:label id="lblPublished" runat="server" controlname="chbPublished" suffix=":" ResourceKey="lblPublished"></dnn:label></td>
    <td valign="bottom" class="style1" width="100%" >
        <asp:CheckBox ID="chbPublished" runat="server"  Checked="true"/>
    </td>
</tr>
<tr>
    <td class="SubHead" width="150"><dnn:label id="lblImage" runat="server" controlname="fuFileUpload" suffix=":" ResourceKey="fuFileUpload"></dnn:label></td>
    <td valign="bottom" class="style1" width="100%" >
        <asp:FileUpload ID="fuFileUpload" runat="server" />
        <br />
        <div runat="server" id="Thumbnail" visible="false">
            <asp:Image ID="iThumbnail" runat="server" Width="90" Height="90" />
        </div>
    </td>
</tr>
<tr>
    <td class="SubHead" width="150"><dnn:label id="lblDescription" runat="server" controlname="txtDescription" suffix=":" ResourceKey="lblDescription"></dnn:label></td>
    <td valign="bottom" class="style1" width="100%" >
        <asp:Textbox id="txtDescription" cssclass="NormalTextBox" width="390" columns="30" TextMode="MultiLine" Rows="6" runat="server" />
        <asp:RequiredFieldValidator ID="RequiredDescription" runat="server" ErrorMessage="Nhập mô tả tóm tắt bản tin" ControlToValidate="txtDescription" Display="None" ValidationGroup="summary"><span style="color:Red">(*)</span></asp:RequiredFieldValidator>
    </td>
</tr>
<tr>
    <td class="SubHead" width="150"><dnn:label id="lblContent" runat="server" controlname="txtContent" suffix=":" ResourceKey="lblContent"></dnn:label></td>
    <td valign="bottom" class="style1" width="100%" >
        <dnn:TextEditor ID="txtContent" runat="server" ChooseMode="true" ChooseRender="true" HtmlEncode="true" Height="800px" Width="100%"/>
        <asp:RequiredFieldValidator ID="RequiredContent" runat="server" ErrorMessage="Nhập nội dung tin" ControlToValidate="txtContent" Display="None" ValidationGroup="summary"><span style="color:Red">(*)</span></asp:RequiredFieldValidator>
    </td>
</tr>
<tr runat="server" id="showModifiedDate">
     <td class="SubHead" width="150"><dnn:label id="lblModifiedDateLabel" runat="server" controlname="lblModifiedDate" suffix=":" ResourceKey="lblModifiedDate"></dnn:label></td>
    <td valign="bottom" class="style1" width="100%" >
        <asp:Label id="lblModifiedDate" cssclass="NormalTextBox" width="390" columns="30" TextMode="MultiLine" Rows="6" MaxLength="2000" runat="server" />
    </td>
</tr>
<tr runat="server" id="showTotalView">
     <td class="SubHead" width="150"><dnn:label id="lblTotalView2" runat="server" controlname="lblTotalView" suffix=":" ResourceKey="lblTotalView2"></dnn:label></td>
    <td valign="bottom" class="style1" width="100%" >
        <asp:Label id="lblTotalView" cssclass="NormalTextBox" width="390" columns="30" TextMode="MultiLine" Rows="6" MaxLength="2000" runat="server" />
    </td>
</tr>
</table>

<p>
    <asp:linkbutton cssclass="CommandButton" id="cmdUpdate" resourcekey="cmdUpdate" runat="server" borderstyle="none" text="Update" OnClick="cmdUpdate_Click" ValidationGroup="summary"></asp:linkbutton>&nbsp;
    <asp:linkbutton cssclass="CommandButton" id="cmdCancel" resourcekey="cmdCancel" runat="server" borderstyle="none" text="Cancel" causesvalidation="False" OnClick="cmdCancel_Click"></asp:linkbutton>&nbsp;
    <asp:linkbutton cssclass="CommandButton" id="cmdDelete" resourcekey="cmdDelete" runat="server" borderstyle="none" text="Delete" causesvalidation="False" OnClick="cmdDelete_Click"></asp:linkbutton>