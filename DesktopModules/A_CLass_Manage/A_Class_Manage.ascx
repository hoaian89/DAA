
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
    .style7
    {
        font-weight: 700;
    }
    .style11
    {
        width: 100%;
    }
    .style24
    {
    }
    .style25
    {
        width: 36px;
    }
    .style26
    {
        width: 194px;
    }
    .style27
    {
        width: 152px;
    }
</style>
<asp:UpdatePanel runat="server" ID = "Panel">
<ContentTemplate>
<!-- Main Form -->
<strong><span class="style1">Quản lí thông tin lớp học&nbsp;</span>
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
            <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click" 
                style="font-weight: 700">Sort</asp:LinkButton>
        </td>
    </tr>
</table>

<asp:UpdateProgress ID="RegCrepdateProgress0" runat="server" AssociatedUpdatePanelID="Panel">
<ProgressTemplate>
    &nbsp;&nbsp;&nbsp;
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
            <FooterTemplate>
                <asp:TextBox ID="StuidFooter" runat="server" Text=''  Width="98%"  CssClass="style2"/>
            </FooterTemplate>
            <ItemStyle Width="11%" HorizontalAlign="Left"/>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Tên sinh viên">
            <ItemTemplate>
                &nbsp; &nbsp;<%#Eval("StuNm") %>
            </ItemTemplate>
            <ItemStyle Width="25%" HorizontalAlign="Left"/>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Ngày đăng kí">
            <ItemTemplate>
                <%#Eval("Date") %>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="DateEdit" runat="server" Text='<%#Eval("Date") %>' Width="98%"/>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="DateFooter" runat="server" Text='<%# getDate() %>' Width="98%"/>
            </FooterTemplate>
            <ItemStyle Width="15%" HorizontalAlign="Center"/>
        </asp:TemplateField>
        
        <asp:TemplateField>
            <ItemTemplate>
                <asp:ImageButton ID ="EditButton" CommandName="Edit" ImageUrl="~/images/edit.gif" runat="server" />
                <asp:ImageButton ID="DeleteButton" CommandName="Delete" ImageUrl="~/images/delete.gif" runat="server" 
                OnClientClick="javascript:return confirm('Bạn có chắc muốn xóa sinh viên này không ?');"/>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:ImageButton ID ="Update" CommandName="Update" runat="server" ImageUrl="~/images/eip_save.gif"/> |  
                <asp:ImageButton ID="Cancel" CommandName="Cancel"  runat="server" ImageUrl="~/images/delete.gif"/>
            </EditItemTemplate>
            <FooterTemplate>
                <asp:ImageButton ID="InsertNew" CommandName="InsertNew"  runat="server" ImageUrl="~/images/add.gif"/>
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
    SelectCommand = "SELECT R.StuID,StuNm,Date From [RegisterInfo] as R , Student as S where ClassID = @ClassID and S.StuID = R.StuID order by date"
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
<br/>
<hr />
</strong> 
<table class="style11">
    <tr>
        <td class="style24" colspan="2">
                <strong style="color: #CC3300">* Chuyển lớp : </strong>
            </td>
        <td rowspan="5">
                <asp:TextBox ID="In" runat="server" Height="135px" TextMode="MultiLine" 
                    Width="100%" style="margin-left: 0px"></asp:TextBox>
            </td>
    </tr>
    <tr>
        <td class="style25" width="150">
            Từ :<strong>
                </strong>
        </td>
        <td class="style27">
            <strong>
                <asp:DropDownList ID="From" runat="server"
                    DataSourceID="ListClassID" DataTextField="ClassID" 
                    DataValueField="ClassID">
                </asp:DropDownList>
                </strong>
            </td>
    </tr>
    <tr>
        <td class="style25" width="150">
            Đến <strong>
                :</strong></td>
        <td class="style27">
            <strong>
                <asp:DropDownList ID="To" runat="server" DataSourceID="ListClassID" 
                    DataTextField="ClassID" DataValueField="ClassID">
                </asp:DropDownList>
                </strong>
            </td>
    </tr>
    <tr>
        <td class="style25" width="150">
            &nbsp;</td>
        <td class="style27">
                <asp:LinkButton ID="LinkButton4" runat="server" CssClass="style7" 
                    onclick="LinkButton3_Click">Chuyển</asp:LinkButton>
            </td>
    </tr>
    <tr>
        <td class="style25" width="150">
            &nbsp;</td>
        <td class="style27">
                &nbsp;</td>
    </tr>
</table>
<hr />
<table class="style11">
    <tr>
        <td class="style26">
            <strong style="color: #CC3300">* Xóa khỏi lớp :</strong></td>
        <td rowspan="5">
                <asp:TextBox ID="Out" runat="server" Height="120px" TextMode="MultiLine" 
                    Width="100%" style="margin-left: 0px"></asp:TextBox>
            </td>
    </tr>
    <tr>
        <td class="style26">
                <asp:LinkButton ID="LinkButton3" runat="server" CssClass="style7" 
                    onclick="LinkButton2_Click">Xóa</asp:LinkButton>
            &nbsp;<strong><asp:DropDownList ID="DropDownList3" runat="server" 
                    DataSourceID="ListClassID" DataTextField="ClassID" 
                    DataValueField="ClassID">
                </asp:DropDownList>
                </strong>
            </td>
    </tr>
    <tr>
        <td class="style26">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style26">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style26">
            &nbsp;</td>
    </tr>
</table>
<hr />
<table class="style11">
    <tr>
        <td class="style26">
            <strong style="color: #CC3300">* Thêm vào lớp :</strong></td>
        <td rowspan="5">
                <asp:TextBox ID="InID" runat="server" Height="120px" TextMode="MultiLine" 
                    Width="100%" style="margin-left: 0px">Chức năng đang cập nhật</asp:TextBox>
            </td>
    </tr>
    <tr>
        <td class="style26">
                <asp:LinkButton ID="LinkButton5" runat="server" CssClass="style7" 
                    onclick="LinkButton9_Click">Thêm</asp:LinkButton>
            &nbsp;<strong><asp:DropDownList ID="AddTo" runat="server" 
                    DataSourceID="ListClassID" DataTextField="ClassID" 
                    DataValueField="ClassID">
                </asp:DropDownList>
                </strong>
            </td>
    </tr>
    <tr>
        <td class="style26">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style26">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style26">
            &nbsp;</td>
    </tr>
</table>
<hr />
<table class="style11">
    <tr>
        <td class="style26">
            <strong style="color: #CC3300">* Thêm :</strong></td>
        <td rowspan="5">
                <asp:TextBox ID="TextBox1" runat="server" Height="120px" TextMode="MultiLine" 
                    Width="100%" style="margin-left: 0px"></asp:TextBox>
            </td>
    </tr>
    <tr>
        <td class="style26">
                <asp:LinkButton ID="LinkButton2" runat="server" CssClass="style7" 
                    onclick="LinkButton5_Click">Thêm</asp:LinkButton>
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style26">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style26">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style26">
            &nbsp;</td>
    </tr>
</table>
<hr />
<table class="style11">
    <tr>
        <td class="style26">
            <strong style="color: #CC3300">* Xóa :</strong></td>
        <td rowspan="5">
                <asp:TextBox ID="TextBox2" runat="server" Height="120px" TextMode="MultiLine" 
                    Width="100%" style="margin-left: 0px"></asp:TextBox>
            </td>
    </tr>
    <tr>
        <td class="style26">
                <asp:LinkButton ID="LinkButton6" runat="server" CssClass="style7" 
                    onclick="LinkButton4_Click">Xóa</asp:LinkButton>
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style26">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style26">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style26">
            &nbsp;</td>
    </tr>
</table>
<p>
    <strong>Số dòng tác động :
    <asp:Label ID="ShowInf" runat="server"></asp:Label>
    </strong>
</p>
</ContentTemplate>
</asp:UpdatePanel>

