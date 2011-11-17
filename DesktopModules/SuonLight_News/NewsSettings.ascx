<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NewsSettings.ascx.cs" Inherits="SuonLight.Modules.News.NewsSettings" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<table cellpadding="0" cellspacing="0" id="tblTemplateHelp" runat="server">
<tr>
    <td class="SubHead"><dnn:Label ID="lblSourceArticle" runat="server" ResourceKey="lblSourceArticle" 
    Suffix=":" ControlName="chkSource" /></td>
    <td><asp:CheckBox ID="chkSourceArticle"  runat="server"/></td>
</tr>
<tr>
    <td class="SubHead"><dnn:Label ID="lblArticle" runat="server" ResourceKey="lblArticle" 
    Suffix=":"  ControlName="ddlArticles"/></td>
    <td><asp:DropDownList ID="ddlArticles" runat="server" ></asp:DropDownList></td>
</tr>
<tr>
    <td class="SubHead"><dnn:Label ID="lblOrtherArticles" runat="server" ResourceKey="lblOtherArticles" 
    Suffix=":" ControlName="chkOrtherArticles" /></td>
    <td><asp:CheckBox ID="chkOrtherArticles"  runat="server"/></td>
</tr>
<tr>
    <td class="SubHead"><dnn:Label ID="lblCountOrtherArticles" runat="server" ResourceKey="lblCountOrtherArticles" 
    Suffix=":" ControlName="txtCountOrtherArticles" /></td>
    <td>
    <asp:TextBox ID="txtCountOrtherArticles"  runat="server"/>
    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" 
        FilterType="Numbers" TargetControlID="txtCountOrtherArticles">
        </cc1:FilteredTextBoxExtender>
    </td>
</tr>
</table>
    