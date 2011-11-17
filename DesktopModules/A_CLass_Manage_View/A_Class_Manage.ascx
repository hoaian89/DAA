
<%@ Control Language="C#" AutoEventWireup="true" CodeFile="A_Class_Manage.ascx.cs" Inherits="DesktopModules_A_CLass_Manage_A_Class_Manage" %>
<style type="text/css">
    .style1
    {
        color: #CC3300;
        font-size: large;
    }
    .style2
    {
        text-align:left;
    }
</style>
<asp:UpdatePanel runat="server" ID = "Panel">
<ContentTemplate>

<!-- Main Form -->
<strong><span class="style1">Danh sách l&#7899;p h&#7885;c </span>
&nbsp;
    <asp:Label ID="ShowInfo0" runat="server" style="color: #CC3300"></asp:Label>
</strong>
<hr />
<table width="100%">
    <tr>
        <td class="style5" width="20%">
             <strong>Danh sách lớp :</strong></td>
        <td class="style6" width="35%">
            <strong><asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
                    DataSourceID="ListClassID" DataTextField="ClassID" DataValueField="ClassID"></asp:DropDownList>
            </strong> 
        </td>
        <td class="style6" width="40%">
            <strong>Tìm SV : </strong>
            <asp:TextBox ID="FindItem" runat="server"></asp:TextBox>
            &nbsp;<asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/view.gif" 
                onclick="ImageButton1_Click" />
        </td>
        <td align="right" class="style6">
           
        </td>
    </tr>
</table>

<asp:UpdateProgress ID="RegCrepdateProgress0" runat="server" AssociatedUpdatePanelID="Panel">
<ProgressTemplate>
    <asp:Image ID="Image1" runat="server" ImageUrl="~/images/dnnanim.gif" />
</ProgressTemplate>
</asp:UpdateProgress>
        
<asp:SqlDataSource ID="ListClassID" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
    SelectCommand="SELECT [ClassID] FROM [ScheduleM]"></asp:SqlDataSource>
        
<br/>

<!-- Main Grid -->
<asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
    DataSourceID="EditMarkSource" onload="GridView2_Load" 
    OnRowUpdating="GridView2_RowUpdating" OnRowEditing="GridView2_RowEditing"
    OnRowDeleting="GridView2_RowDeleting" OnRowCommand="GridView2_RowCommand"
    ShowFooter="True" AllowPaging="False" PageSize="30" 
    >
    <Columns>
        <asp:TemplateField HeaderText="Số TT">
            <ItemTemplate>
                <%= Count() %>
            </ItemTemplate>
            <ItemStyle Width="5%" HorizontalAlign="Center"/>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="MSSV">
            <ItemTemplate>
                &nbsp; &nbsp; <asp:Label runat = "server"  ID ="StuID" Text='<%# Eval("StuID") %>'/>
            </ItemTemplate>
            <ItemStyle Width="11%" HorizontalAlign="Left"/>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Tên sinh viên">
            <ItemTemplate>
                &nbsp; &nbsp;<%#Eval("StuNm") %>
            </ItemTemplate>
            <ItemStyle Width="25%" HorizontalAlign="Left"/>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="&#272;K">
            <ItemTemplate>
                &nbsp; &nbsp;<%#Eval("Date") %>
            </ItemTemplate>
            <ItemStyle Width="20%" HorizontalAlign="Center"/>
        </asp:TemplateField>  
    </Columns>
</asp:GridView>

<!-- Data Source -->
<asp:SqlDataSource ID="EditMarkSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings : SiteSqlServer %>" 
    SelectCommand = "SELECT R.StuID,StuNm,Date From [RegisterInfo] as R , Student as S where ClassID = @ClassID and S.StuID = R.StuID order by Date"
    DeleteCommand = "DELETE From RegisterInfo Where ClassID = @ClassID and StuID = @StuID"
    UpdateCommand = "Update RegisterInfo Set Date = @Date where StuID = @StuID and ClassID = @ClassID"
    InsertCommand = "Insert into RegisterInfo(StuID,ClassID,SubID,Rereg,Date) values(@StuID,@ClassID,@SubID,@Rereg,getDate())"
    OnLoad="SqlDataSource1_Load">
    <SelectParameters>
        <asp:ControlParameter ControlID="DropDownList1" Name="ClassID"/>
    </SelectParameters>
    <InsertParameters>
        <asp:ControlParameter ControlID="DropDownList1" Name="ClassID"/>
        <asp:Parameter Name = "StuID" />
        <asp:Parameter Name = "SubID" />
        <asp:Parameter Name = "Rereg" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name = "StuID" />
        <asp:ControlParameter ControlID="DropDownList1" Name="ClassID"/>
        <asp:Parameter Name = "Date" />
    </UpdateParameters>
    <DeleteParameters>
        <asp:ControlParameter ControlID="DropDownList1" Name="ClassID"/>
        <asp:Parameter Name = "StuID" />
    </DeleteParameters>
</asp:SqlDataSource>
<strong>
<asp:Label ID="ShowInfo" runat="server" style="color: #CC3300"></asp:Label>
</strong> 
</p>
</ContentTemplate>
</asp:UpdatePanel>