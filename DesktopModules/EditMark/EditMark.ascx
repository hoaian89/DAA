
<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EditMark.ascx.cs" Inherits="DesktopModules_EditMark_EditMark" %>
<style type="text/css">
    .style2
    {
        color: #000000;
    }
    .style3
    {
        font-size: large;
        color: #CC3300;
    }
    .style5
    {
        width: 121px;
        height: 18px;
    }
    .style6
    {
        height: 18px;
    }
</style>

<asp:UpdatePanel runat="server" ID = "Panel">
<ContentTemplate>
<strong><span class="style3">Cập nhật bảng điểm sinh viên&nbsp;</span><hr />
</strong>
<table width="100%">
    <tr>
        <td class="style5">
            <span class="style2">Tìm theo MSSV :</span></td>
        <td class="style6">
<asp:TextBox ID="FindItem" runat="server" Width="161px" style="font-weight: 700"></asp:TextBox>
&nbsp;<asp:ImageButton ID="ImageButton1" runat="server" 
    ImageUrl="~/images/action_source.gif" onclick="ImageButton1_Click" />
&nbsp;<asp:Label ID="ShowInfo" runat="server" style="color: #CC3300"></asp:Label>
        </td>
        <td align="right" class="style6">
            <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/add.gif" />
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
    onrowdeleting="GridView2_RowDeleting" onrowediting="GridView2_RowEditing" 
    onrowupdating="GridView2_RowUpdating" ShowFooter="True" 
    onrowcommand="GridView2_RowCommand" >
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
                <%#Eval("SubNm") %>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="SubnmFooter" runat="server" Text='' Width="98%"/>
            </FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Điểm">
            <ItemTemplate>
                <%#Eval("Mark") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="MarkEdit" runat="server" Text ='<%#Eval("Mark")%>' Width="95%"/>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="MarkFooter" runat="server" Text='' Width="95%"/>
            </FooterTemplate>
            <ItemStyle Width="10%" HorizontalAlign="Center"/>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Học kì">
            <ItemTemplate>
                <%#Eval("Term") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="TermEdit" runat="server" Text ='<%#Eval("Term")%>' Width="96%"/>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="TermFooter" runat="server" Text='' Width="96%"/>
            </FooterTemplate>
            <ItemStyle Width="15%"  HorizontalAlign="Center"/>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Năm học">
            <ItemTemplate>
                <%#Eval("Ayear") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="AyearEdit" runat="server" Text ='<%#Eval("AYear")%>' Width="97%"/>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="AyearFooter" runat="server" Text='' Width="97%"/>
            </FooterTemplate>
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
                <asp:LinkButton Text="Insert" runat="server" CommandName="InsertNew"/>
            </FooterTemplate>
            <HeaderTemplate>
                Điều khiển
            </HeaderTemplate>
            <ItemStyle Width="8%" HorizontalAlign="Center"/>
            <FooterStyle Width="8%" HorizontalAlign="Center" Font-Bold="true"/>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
<asp:SqlDataSource ID="EditMarkSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
    SelectCommand="SELECT S.SubId ,S.SubNm as SubNm,[Mark], [Term], [AYear] FROM [Mark] as M , Subject as S WHERE (S.SubID = M.SubID)and ([StuId] = @StuId)"
    DeleteCommand = "DELETE MARK Where StuID = @StuID and  SubID = @SubID"
    UpdateCommand = "Update Mark Set SubID = @SubID , Term = @Term , Mark = @Mark ,Ayear = @Ayear where StuId = @StuID and SubID = @SubID"
    InsertCommand = "Insert into Mark (StuID,SubID,Term,Ayear,Mark) values(@StuId,@SubID,@Term,@Ayear,@Mark)"
    OnLoad="SqlDataSource1_Load">
    <InsertParameters>
        <asp:Parameter Name = "SubID" />
        <asp:ControlParameter ControlID="FindItem" Name="StuId" PropertyName="Text" 
            Type="String" />
        <asp:Parameter Name = "Mark" />
        <asp:Parameter Name = "Term" />
        <asp:Parameter Name = "Ayear" />
    </InsertParameters>
    <SelectParameters>
        <asp:ControlParameter ControlID="FindItem" Name="StuId" PropertyName="Text" 
            Type="String" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name = "SubID" />
        <asp:ControlParameter ControlID="FindItem" Name="StuId" PropertyName="Text" 
            Type="String" />
        <asp:Parameter Name = "Mark" />
        <asp:Parameter Name = "Term" />
        <asp:Parameter Name = "AYear" />
    </UpdateParameters>
    <DeleteParameters>
        <asp:Parameter Name = "SubID" />
        <asp:ControlParameter ControlID="FindItem" Name="StuId" PropertyName="Text" 
            Type="String" />
    </DeleteParameters>
</asp:SqlDataSource>
</ContentTemplate>
</asp:UpdatePanel>