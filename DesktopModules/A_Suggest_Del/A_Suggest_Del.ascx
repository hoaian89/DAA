
<%@ Control Language="C#" AutoEventWireup="true" CodeFile="A_Suggest_Del.ascx.cs" Inherits="DesktopModules_A_Suggest_Del_A_Suggest_Del" %>

<!-- Main Form -->
<style type="text/css">
    .style1
    {
        color: #CC3300;
        font-size: medium;
    }
    .style2
    {
        color: #CC3300;
        font-size: small;
    }
</style>

<asp:UpdatePanel runat="server" ID = "Panel">
<ContentTemplate>
<span class="style1" ><strong>Đề nghị hủy môn &nbsp; </strong></span>
    <asp:Label runat="server" id = "ShowInfo" Text="" style="color: #CC3300"></asp:Label>
<hr />
<br/>

<asp:UpdateProgress ID="RegCrepdateProgress0" runat="server" AssociatedUpdatePanelID="Panel">
<ProgressTemplate>
    <asp:Image ID="Image1" runat="server" ImageUrl="~/images/dnnanim.gif" />
</ProgressTemplate>
</asp:UpdateProgress>

<!-- Main Grid -->
<asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
    DataSourceID="EditMarkSource" OnRowDeleting="GridView2_RowDeleting">
    <Columns>
        <asp:TemplateField HeaderText="Số TT">
            <ItemTemplate>
                <asp:Label runat = "server"  ID ="Order" Text='<%# getOrder() %>'/>
            </ItemTemplate>
            <ItemStyle Width="15%" HorizontalAlign="Center"/>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Mã lớp">
            <ItemTemplate>
                <asp:Label runat = "server"  ID ="ClassID" Text='<%# Eval("ClassID") %>'/>
            </ItemTemplate>
            <ItemStyle Width="15%" HorizontalAlign="Center"/>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Mã môn">
            <ItemTemplate>
                <asp:Label runat = "server"  ID ="SubID" Text='<%# Eval("SubID") %>'/>
            </ItemTemplate>
            <ItemStyle Width="15%" HorizontalAlign="Center"/>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Số TC">
            <ItemTemplate>
                <asp:Label runat = "server"  ID ="Credits" Text='<%# Eval("Credits") %>'/>
            </ItemTemplate>
            <ItemStyle Width="20%" HorizontalAlign="Center"/>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Đề nghị hủy môn">
            <ItemTemplate>
                <asp:ImageButton ID="DeleteButton" CommandName="Delete" ImageUrl="~/images/delete.gif" runat="server" 
                OnClientClick="javascript: confirm('Bạn có chắc muốn đề nghị hủy lớp này không ? ( Đề nghị của bạn sẽ được xem xét và điều chỉnh trong thời gian tới)')"/>
            </ItemTemplate>
            <ItemStyle Width="20%" HorizontalAlign="Center"/>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

<br/>
<span class="style2" ><strong>Các lớp đề nghị hủy :</strong></span>    
<!-- Main Grid -->
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    DataSourceID="EditMarkSource1">
    <Columns>
        <asp:TemplateField HeaderText="Mã lớp">
            <ItemTemplate>
                <asp:Label runat = "server"  ID ="ClassID" Text='<%# Eval("ClassID") %>'/>
            </ItemTemplate>
            <ItemStyle  HorizontalAlign="Center"/>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

<!-- Data Source -->
<asp:SqlDataSource ID="EditMarkSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings : SiteSqlServer %>" 
    SelectCommand="SELECT ClassID,R.SubId,Credits From RegisterInfo as R , Subject as S where R.SubID = S.SubID  and StuID = @StuID"
    DeleteCommand = "Insert into SuggestDel values(@StuID,@ClassID)"
    OnLoad="SqlDataSource1_Load">
    <SelectParameters>
        <asp:Parameter Name = "StuID" />
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name = "StuID" />
        <asp:Parameter Name = "ClassID" />
    </DeleteParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="EditMarkSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings : SiteSqlServer %>" 
    SelectCommand="SELECT Distinct ClassID from suggestdel where StuID = @StuID"
    OnLoad="SqlDataSource2_Load">
    <SelectParameters>
        <asp:Parameter Name = "StuID" />
    </SelectParameters>
</asp:SqlDataSource>
</ContentTemplate>
</asp:UpdatePanel>