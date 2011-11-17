<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AdminCategory.ascx.cs" Inherits="SuonLight.Modules.News.AdminCategory" %>
<asp:GridView ID="lvCategories" runat="server" DataKeyNames="CatID"
    AutoGenerateColumns="False"
    onrowediting="lvCategories_RowEditing" 
    onrowdeleting="lvCategories_RowDeleting" 
    onrowdatabound="lvCategories_RowDataBound" CellPadding="4" 
    ForeColor="#333333" GridLines="None">
    <RowStyle BackColor="#EFF3FB" />
<Columns>
<asp:BoundField DataField="CatID" HeaderText="ID" ReadOnly="true" />
<asp:BoundField DataField="Category" HeaderText="Tên danh mục" />
<asp:TemplateField HeaderText="Danh mục cha">
        <ItemTemplate>
            <asp:Label ID="lblParentCategory" runat="server"></asp:Label>
        </ItemTemplate>
    </asp:TemplateField>
<asp:CommandField ShowDeleteButton="True" ShowEditButton="True" EditImageUrl="~/images/edit.gif" DeleteImageUrl="~/images/delete.gif" />
</Columns>
    <EditRowStyle BackColor="#2461BF" />
<AlternatingRowStyle BackColor="White" />
    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
<HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
</asp:GridView>
<p>
    <asp:linkbutton cssclass="CommandButton" id="cmdAdd" resourcekey="cmdAdd" runat="server" borderstyle="none" text="Add Category" OnClick="cmdAdd_Click"></asp:linkbutton>
</p>