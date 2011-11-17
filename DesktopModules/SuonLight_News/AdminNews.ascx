<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AdminNews.ascx.cs" Inherits="SuonLight.Modules.News.AdminNews" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx"%> 
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.UI.WebControls" Assembly="DotNetNuke" %>
<style type="text/css">
    .style1
    {
        width: 262px;
    }
</style>
<table cellpadding="0" cellspacing="0">
<tr>
    <td class="SubHead" width="150"><dnn:label id="lblTitle" runat="server" controlname="txtTitle" suffix=":" ResourceKey="lblTitle"></dnn:label></td>
    <td valign="bottom" class="style1" >
        <asp:TextBox ID="txtTitle" runat="server" Width="60%"></asp:TextBox>   
        <asp:Button ID="btnFind" runat="server" onclick="btnFind_Click"  Text="Find"/>    
    </td>
</tr>
</table>
<asp:GridView ID="grNews" runat="server" DataKeyNames="ID" 
    AutoGenerateColumns="False" 
    onrowdeleting="grNews_RowDeleting" onrowediting="grNews_RowEditing" 
    onrowdatabound="grNews_RowDataBound" CellPadding="4" ForeColor="#333333" 
    GridLines="None">
<Columns>
    <asp:BoundField DataField="ID" HeaderText="ID" />
    <asp:BoundField DataField="Title" HeaderText='Title' />    
    <asp:CheckBoxField DataField="Published" HeaderText="Published" />
    <asp:TemplateField HeaderText="Category">
        <ItemTemplate>
            <asp:Label ID="lblCategory" runat="server"></asp:Label>
        </ItemTemplate>
    </asp:TemplateField>
    <asp:BoundField DataField="TotalView" HeaderText="TotalView" />
    <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" />
</Columns>
<RowStyle BackColor="#EFF3FB" />
    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <EditRowStyle BackColor="#2461BF" />
    <AlternatingRowStyle BackColor="White" />
</asp:GridView>    
<dnn:PagingControl ID="pagingControl" runat="server" PageSize="20" />
<p>
    <asp:linkbutton cssclass="CommandButton" id="cmdAdd" resourcekey="cmdAdd" runat="server" borderstyle="none" OnClick="cmdAdd_Click"></asp:linkbutton>
</p>