<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SmallListNewsSetting.ascx.cs" Inherits="SuonLight.Modules.News.SmallListNewsSetting" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<table id="Table1" cellpadding="0" cellspacing="0" runat="server" summary="Configuration Category">
<tr>
    <td class="SubHead"><dnn:Label ID="lblCategory" runat="server" ResourceKey="lblCategory" 
    Suffix=":"  ControlName="ddlCategories"/></td>
    <td><asp:DropDownList ID="ddlCategories" runat="server" ></asp:DropDownList></td>
</tr>
<tr>
    <td class="SubHead"><dnn:Label ID="lblArticleTemplate" runat="server" ResourceKey="lblArticleTemplate" 
    Suffix=":"  ControlName="ddlArticleTemplates"/></td>
    <td><asp:DropDownList ID="ddlArticleTemplates" runat="server" ></asp:DropDownList></td>
</tr>
<tr>
    <td class="SubHead"><dnn:Label ID="lblCountArticles" runat="server" ResourceKey="lblCountArticles" 
    Suffix=":"  ControlName="ddlCategories"/></td>
    <td>
        <asp:TextBox ID="txtCountArticles" runat="server"></asp:TextBox>
        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" 
        FilterType="Numbers" TargetControlID="txtCountArticles">
        </cc1:FilteredTextBoxExtender>
    </td>
</tr>
</table>