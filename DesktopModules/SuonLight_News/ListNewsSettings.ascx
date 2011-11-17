<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListNewsSettings.ascx.cs" Inherits="SuonLight.Modules.News.ListNewsSettings" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<dnn:sectionhead id="Sectionhead1" runat="server" cssclass="Head" text="Appearance" section="AppearanceSection" includerule="false" isexpanded="false" resourcekey="AppearanceSettings"></dnn:sectionhead>
<table id="AppearanceSection" runat="server" width="100%" cellspacing="5" cellpadding="0" border="0">
    <tr>
        <td class="SubHead"><dnn:Label ID="lblColumns" runat="server" ResourceKey="lblColumns" 
        Suffix=":"  ControlName="ddlColumns"/></td>
        <td>
            <asp:DropDownList ID="ddlColumns" runat="server">            
                <asp:ListItem  Text="1" Value="1"></asp:ListItem> 
                <asp:ListItem  Text="2" Value="2" Selected="True"></asp:ListItem> 
                <asp:ListItem  Text="3" Value="3"></asp:ListItem> 
            </asp:DropDownList>            
        </td>
    </tr>
    <tr>
        <td class="SubHead"><dnn:Label ID="lblShowImage" runat="server" ResourceKey="lblShowImage" 
        Suffix=":"  ControlName="chkShowImage"/></td>
        <td><asp:CheckBox ID="chkShowImage"  runat="server"/></td>
    </tr>
    <tr>
        <td class="SubHead"><dnn:Label ID="lblIncludeNewIcon" runat="server" ResourceKey="lblIncludeNewIcon" 
        Suffix=":"  ControlName="chkIncludeNewIcon"/></td>
        <td><asp:CheckBox ID="chkIncludeNewIcon"  runat="server"/></td>
    </tr>
    <tr>
        <td class="SubHead"><dnn:Label ID="lblShowDescription" runat="server" ResourceKey="lblShowDescription" 
        Suffix=":"  ControlName="chkShowDescription"/></td>
        <td><asp:CheckBox ID="chkShowDescription"  runat="server"/></td>
    </tr>
    <tr>
        <td class="SubHead"><dnn:Label ID="lblShowDate" runat="server" ResourceKey="lblShowDate" 
        Suffix=":"  ControlName="chkShowDate"/></td>
        <td><asp:CheckBox ID="chkShowDate"  runat="server"/></td>
    </tr>
</table>
<table cellpadding="0" cellspacing="0" runat="server" summary="Configuration Category">
<tr>
    <td class="SubHead"><dnn:Label ID="lblSourceCategory" runat="server" ResourceKey="lblSourceCategory" 
    Suffix=":" ControlName="chkSourceCategory" /></td>
    <td><asp:CheckBox ID="chkSourceCategory"  runat="server"/></td>
</tr>
<tr>
    <td class="SubHead"><dnn:Label ID="lblCategory" runat="server" ResourceKey="lblCategory" 
    Text="Choose Category" Suffix=":"  ControlName="ddlCategories"/></td>
    <td><asp:DropDownList ID="ddlCategories" runat="server" ></asp:DropDownList></td>
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
<tr>
    <td class="SubHead"><dnn:Label ID="lblPaging" runat="server" ResourceKey="lblPaging" 
    Suffix=":" ControlName="chkPaging" /></td>
    <td><asp:CheckBox ID="chkPaging"  runat="server"/></td>
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