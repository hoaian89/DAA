<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewMeta.ascx.cs" Inherits="SuonLight.Modules.News.ViewMeta" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<table id="templateUrl" runat="server" width="100%" cellspacing="5" cellpadding="0" border="0">
    <tr>
        <td class="SubHead"><dnn:Label ID="lblCategoryUrl" runat="server" ResourceKey="lblCategoryUrl" 
        Suffix=":"  ControlName="txtCategoryUrl"/></td>
        <td>
            <asp:TextBox ID="txtCategoryUrl" runat="server" Columns="50"></asp:TextBox><br />
            <%--<asp:Label ID="lblNote" Text="Ex: ~/Tin-tuc/<catid>/<category>.aspx" runat="server"></asp:Label>--%>
        </td>
    </tr>
    <tr>
        <td class="SubHead"><dnn:Label ID="lblArticleUrl" runat="server" ResourceKey="lblArticleUrl" 
        Suffix=":"  ControlName="txtArticleUrl"/></td>
        <td>
            <asp:TextBox ID="txtArticleUrl" runat="server" Columns="50"></asp:TextBox><br />
            <%--<asp:Label ID="lblNote1" Text="Ex: ~/Tin-tuc/<category>-<newsid>/<title>.aspx" runat="server"></asp:Label>--%>
        </td>
    </tr>
    <tr>
        <td class="SubHead"><dnn:Label ID="lblPagingUrl" runat="server" ResourceKey="lblPagingUrl" 
        Suffix=":"  ControlName="txtPagingUrl"/></td>
        <td>
            <asp:TextBox ID="txtPagingUrl" runat="server" Columns="50"></asp:TextBox><br />
            <%--<asp:Label ID="lblNote2" Text="Ex: ~/Tin-tuc/<tabid>-<mid>-<currentpage>/<category>.aspx" runat="server"></asp:Label>--%>
        </td>
    </tr>
</table>

<p>
    <asp:linkbutton cssclass="CommandButton" id="cmdUpdate" resourcekey="cmdUpdate" 
        runat="server" borderstyle="none" text="Update" ValidationGroup="summary" 
        onclick="cmdUpdate_Click" style="height: 19px"></asp:linkbutton>&nbsp;    
</p>