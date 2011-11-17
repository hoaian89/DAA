
<%@ Control Language="C#" AutoEventWireup="true" CodeFile="A_Edit_Subject.ascx.cs" Inherits="DesktopModules_A_Edit_Subject_A_Edit_Subject" %>

<!-- Main Grid -->
<style type="text/css">
    .style1
    {
        color: #CC3300;
        font-size: large;
    }
</style>
<asp:UpdatePanel runat="server" ID = "Panel">
<ContentTemplate>
<strong><span class="style1">Cập nhật thông tin môn học&nbsp;</span>
<asp:Label ID="ShowInfo" runat="server" style="color: #CC3300"></asp:Label>
</strong>
<hr />
<table width="100%">
    <tr>
        <td class="style5" width="20%">
            <strong>Tìm theo mã môn :</strong></td>
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

<asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
    DataSourceID="EditMarkSource" onload="GridView2_Load" 
    OnRowUpdating="GridView2_RowUpdating" OnRowEditing="GridView2_RowEditing"
    OnRowDeleting="GridView2_RowDeleting" OnRowCommand="GridView2_RowCommand"
    ShowFooter="True" AllowPaging="True" PageSize="30" 
    >
    <Columns>
        <asp:TemplateField HeaderText="Mã môn">
            <ItemTemplate>
                <asp:Label runat = "server"  ID ="lSubID" Text='<%# Eval("SubID") %>'/>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="SubidEdit" runat="server" Text ='<%#Eval("SubID")%>' Width="98%"/>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="SubidFooter" runat="server" Text=''  Width="98%"/>
            </FooterTemplate>
            <ItemStyle Width="15%" HorizontalAlign="Center"/>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Môn">
            <ItemTemplate>
                <%#Eval("SubNm") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="SubnmEdit" runat="server" Text ='<%#Eval("SubNm")%>' Width="98%"/>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="SubnmFooter" runat="server" Text='' Width="98%"/>
            </FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Số TC">
            <ItemTemplate>
                <%#Eval("Credits") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="CreditsEdit" runat="server" Text ='<%#Eval("Credits")%>' Width="95%"/>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="CreditsFooter" runat="server" Text='' Width="95%"/>
            </FooterTemplate>
            <ItemStyle Width="10%" HorizontalAlign="Center"/>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Loại">
            <ItemTemplate>
                <%#Eval("Typ") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="TypEdit" runat="server" Text ='<%#Eval("Typ")%>' Width="96%"/>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="TypFooter" runat="server" Text='' Width="96%"/>
            </FooterTemplate>
            <ItemStyle Width="15%"  HorizontalAlign="Center"/>
        </asp:TemplateField>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:ImageButton ID ="EditButton" CommandName="Edit" ImageUrl="~/images/edit.gif" runat="server" />
                <asp:ImageButton ID="DeleteButton" CommandName="Delete" ImageUrl="~/images/delete.gif" runat="server" 
                OnClientClick="return Confirm('Bạn có chắc muốn xóa mục này không ?');"/>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:ImageButton ID ="Update" CommandName="Update" runat="server" ImageUrl="~/images/eip_save.gif"/> |  
                <asp:ImageButton ID="Cancel" CommandName="Cancel"  runat="server" ImageUrl="~/images/delete.gif"/>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:LinkButton ID="LinkButton1" Text="Insert" runat="server" CommandName="InsertNew"/>
            </FooterTemplate>
            <HeaderTemplate>
                Điều khiển
            </HeaderTemplate>
            <ItemStyle Width="8%" HorizontalAlign="Center"/>
            <FooterStyle Width="8%" HorizontalAlign="Center" Font-Bold="true"/>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

<!-- Data Source -->
<asp:SqlDataSource ID="EditMarkSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings : SiteSqlServer %>" 
    SelectCommand="SELECT * From [Subject]"
    DeleteCommand = "DELETE Subject Where SubID = @SubID"
    UpdateCommand = "Update Subject Set SubID = @SubID ,SubNm = @SubNm, Credits = @Credits ,Typ = @Typ where SubID = @SubID"
    InsertCommand = "Insert into Subject(SubID,SubNm,Credits,Typ) values(@SubId,@SubNm,@Credits,@Typ)"
    OnLoad="SqlDataSource1_Load">
    <InsertParameters>
        <asp:Parameter Name = "SubID" />
        <asp:Parameter Name = "SubNm" />
        <asp:Parameter Name = "Credits" />
        <asp:Parameter Name = "Typ" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name = "SubID" />
        <asp:Parameter Name = "SubNm" />
        <asp:Parameter Name = "Credits" />
        <asp:Parameter Name = "Typ" />
    </UpdateParameters>
    <DeleteParameters>
        <asp:Parameter Name = "SubID" />
    </DeleteParameters>
</asp:SqlDataSource>
</ContentTemplate>
</asp:UpdatePanel>