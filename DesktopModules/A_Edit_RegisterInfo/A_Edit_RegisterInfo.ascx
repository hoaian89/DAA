
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
<strong><span class="style1">Cập nhật thông tin đăng kí học phần&nbsp;</span>
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
    OnRowUpdating="GridView2_RowUpdating" OnRowEditing="GridView2_RowEditing"
    OnRowDeleting="GridView2_RowDeleting" OnRowCommand="GridView2_RowCommand"
    ShowFooter="True" AllowPaging="False" PageSize="30" 
    >
    <Columns>
        <asp:TemplateField HeaderText="Mã lớp">
            <ItemTemplate>
                <asp:Label runat = "server"  ID ="ClassID" Text='<%# Eval("ClassID") %>'/>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="ClassidEdit" runat="server" Text ='<%#Eval("ClassID")%>' Width="98%"/>
                <asp:HiddenField runat = "server"  ID ="ClassidHidden" Value='<%# Eval("ClassID") %>'/>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="ClassidFooter" runat="server" Text=''  Width="98%"/>
            </FooterTemplate>
            <ItemStyle Width="15%" HorizontalAlign="Center"/>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Mã môn">
            <ItemTemplate>
                <%#Eval("SubID") %>
            </ItemTemplate>
            <ItemStyle Width="15%" HorizontalAlign="Center"/>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="ĐK lại">
            <ItemTemplate>
                <%#Eval("Rereg") %>
            </ItemTemplate>
            <ItemStyle Width="15%" HorizontalAlign="Center"/>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Ngày ĐK">
            <ItemTemplate>
                <%#Eval("Date") %>
            </ItemTemplate>
            <ItemStyle Width="20%" HorizontalAlign="Center"/>
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
    SelectCommand="SELECT * From [RegisterInfo] where StuID = @StuID"
    DeleteCommand = "DELETE RegisterInfo Where ClassID = @ClassID and StuID = @StuID"
    UpdateCommand = "Update RegisterInfo Set ClassID = @NewClassID ,SubID = @SubID , Rereg = @Rereg where StuID = @StuID and ClassID = @OldClassID"
    InsertCommand = "Insert into RegisterInfo(StuID,ClassID,SubID,Rereg,Date) values(@StuID,@ClassID,@SubID,@Rereg,getDate())"
    OnLoad="SqlDataSource1_Load">
    <SelectParameters>
        <asp:ControlParameter ControlID="FindItem" Name="StuID"/>
    </SelectParameters>
    <InsertParameters>
        <asp:ControlParameter ControlID="FindItem" Name="StuID"/>
        <asp:Parameter Name = "ClassID" />
        <asp:Parameter Name = "SubID" />
        <asp:Parameter Name = "Rereg" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name = "NewClassID" />
        <asp:Parameter Name = "OldClassID" />
        <asp:ControlParameter ControlID="FindItem" Name="StuID"/>
        <asp:Parameter Name = "SubID" />
        <asp:Parameter Name = "Rereg" />
    </UpdateParameters>
    <DeleteParameters>
        <asp:ControlParameter ControlID="FindItem" Name="StuID"/>
        <asp:Parameter Name = "ClassID" />
    </DeleteParameters>
</asp:SqlDataSource>
</ContentTemplate>
</asp:UpdatePanel>