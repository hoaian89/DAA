
<%@ Control Language="C#" AutoEventWireup="true" CodeFile="A_Edit_RegisterInfo.ascx.cs" Inherits="DesktopModules_A_Edit_RegisterInfo_A_Edit_RegisterInfo" %>

<!-- Type -->
<style type="text/css">
    .style1
    {
        color: #CC3300;
        font-size: large;
    }
</style>
<asp:UpdatePanel runat="server" ID = "Panel">
<ContentTemplate>

<!-- Main Form -->
<strong><span class="style1">Thông tin sinh viên&nbsp;</span>
<asp:Label ID="ShowInfo" runat="server" style="color: #CC3300"></asp:Label>
</strong>
<hr />
<table width="100%">
    <tr>
        <td class="style5" width="20%">
            <strong>Tìm theo MSSV :</strong></td>
        <td class="style6">
            <strong>
<asp:TextBox ID="FindItem" runat="server" Width="161px"></asp:TextBox>
&nbsp;<asp:ImageButton ID="ImageButton1" runat="server" 
    ImageUrl="~/images/action_source.gif" onclick="ImageButton1_Click" />
&nbsp;<asp:Label ID="Label1" runat="server" style="color: #CC3300"></asp:Label>
</strong> 
        </td>
        <td align="right" class="style6">
            <strong>
            <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/add.gif" />
</strong> 
        </td>
    </tr>
</table>
<asp:UpdateProgress ID="RegCrepdateProgress0" runat="server" AssociatedUpdatePanelID="Panel">
<ProgressTemplate>
    <asp:Image ID="Image1" runat="server" ImageUrl="~/images/dnnanim.gif" />
</ProgressTemplate>
</asp:UpdateProgress>
<br/>

<!-- Main Grid -->
<asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
    DataSourceID="EditMarkSource" onload="GridView2_Load" 
    ShowFooter="True" AllowPaging="False" PageSize="30" 
    >
    <Columns>
        <asp:TemplateField HeaderText="Họ tên">
            <ItemTemplate>
	<%# Eval("StuNm") %>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Ngày sinh">
            <ItemTemplate>
                <%#Eval("Bday") %>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Quê quán">
            <ItemTemplate>
                <%#Eval("Native") %>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Khoa">
            <ItemTemplate>
                <%#Eval("Dept") %>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

<!-- Data Source -->
<asp:SqlDataSource ID="EditMarkSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings : SiteSqlServer %>" 
    SelectCommand="SELECT * From [Student] where StuID = @StuID"
    OnLoad="SqlDataSource1_Load">
    <SelectParameters>
        <asp:ControlParameter ControlID="FindItem" Name="StuID"/>
    </SelectParameters>
</asp:SqlDataSource>
</ContentTemplate>
</asp:UpdatePanel>