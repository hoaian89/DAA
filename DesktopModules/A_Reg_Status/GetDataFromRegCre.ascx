<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GetDataFromRegCre.ascx.cs" Inherits="DesktopModules_A_GetData_RegCre_GetDataFromRegCre" %>
<style type="text/css">
    .style1
    {
        color: #CC3300;
    }
    .style2
    {
        color: #000000;
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
    .style19
    {
        width: 100%;
        border-style: solid;
        border-width: 1px;
        background-color: #FFFAFA;
    }
    .style20
    {
        height: 18px;
        width: 110px;
        color: #CC3300;
    }
    .style21
    {
        height: 18px;
        width: 122px;
        color: #CC3300;
    }
</style>
<asp:Timer ID="Timer1" OnTick="Timer1_Tick" runat="server" Interval="60000">
</asp:Timer>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
<span class="style1"><b>Trạng thái đăng kí học phần</b><hr />
</span>
<table width="100%">
    <tr>
        <td class="style5">
            <span class="style2">Tìm theo mã lớp :</span></td>
        <td class="style6">
            <strong>
<asp:TextBox ID="FindItem" runat="server" Width="161px"></asp:TextBox>
&nbsp;<asp:ImageButton ID="ImageButton1" runat="server" 
    ImageUrl="~/images/action_source.gif" onclick="ImageButton1_Click" />
&nbsp;<asp:Label ID="ShowInfo" runat="server" style="color: #CC3300"></asp:Label>
</strong> 
        <asp:UpdateProgress ID="UpdateProgress2" runat="server" 
            AssociatedUpdatePanelID="UpdatePanel1">
        <ProgressTemplate>
            <asp:Image ID="Image3" runat="server" ImageUrl="~/images/dnnanim.gif" />
        </ProgressTemplate>
        </asp:UpdateProgress>

        </td>
        <td>
        <table class="style1">
                    <tr>
                        <td class="style14" >
                            <table class="style1" border="1" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td bgcolor="Red">
                                        &nbsp;</td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            &nbsp;: Lớp hủy</td>
                        <td>
                        <td class="style14" >
                            <table class="style1" border="1" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td bgcolor="Snow">
                                        &nbsp;</td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            &nbsp;: Lớp đã đầy</td>
                        <td>
                            <table border="1px" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td bgcolor="PaleGoldenrod">
                                        &nbsp;</td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            &nbsp;: Lớp đề nghị&nbsp;</td>
                    </tr>
                </table>
              </td>
    </tr>
</table>
<br/>
<asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
    AutoGenerateColumns="False"
    DataSourceID="SqlDataSource1" 
    onselectedindexchanged="GridView1_SelectedIndexChanged" 
    onrowcancelingedit="GridView1_RowCancelingEdit" onload="GridView1_Load" 
    onrowupdating="GridView1_RowUpdating" onrowediting="GridView1_RowEditing" 
    onrowdeleting="GridView1_RowDeleting" Width="100%"
    OnDataBound="GridView_Bound">
    <Columns>
         <asp:TemplateField >
                <ItemTemplate>
                    <%= getOrder() %>
                    <asp:HiddenField ID = "isClosed" runat="server" Value ='<%#Eval("isClosed")%>'></asp:HiddenField>
                </ItemTemplate>
                <HeaderTemplate>
                    TT
                </HeaderTemplate>
                <ItemStyle HorizontalAlign="Center" Width="40px" />
                <HeaderStyle HorizontalAlign ="Center" VerticalAlign="Middle"/>
            </asp:TemplateField>
            
            <asp:BoundField DataField="ClassID" HeaderText="Mã lớp" >
                <ItemStyle HorizontalAlign="Center" Width="12%"/>
                <HeaderStyle HorizontalAlign ="Center" VerticalAlign="Middle"/>
            </asp:BoundField>

            <asp:TemplateField HeaderText="Tên môn" ItemStyle-HorizontalAlign="Center" >
                <ItemTemplate>
                    <asp:HiddenField ID="Type" runat="server" value='<%#Eval("Typ")%>'/>
                    <asp:HiddenField ID="SubID" runat="server" value='<%#Eval("SubID")%>'/>
                    &nbsp;&nbsp;<asp:LinkButton ID="SubNm" runat="server" Text='<%#Eval("SubNm")%>'/>
                    <asp:HiddenField ID="ClassID" runat="server" value='<%#Eval("ClassID")%>'/>
                </ItemTemplate>
                <HeaderTemplate>
                    Môn
                </HeaderTemplate>
                <HeaderStyle ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Middle"/>
                <ItemStyle HorizontalAlign="Left" Width="27%" />
            </asp:TemplateField>

            <asp:BoundField DataField="Credits" HeaderText="Số TC">
            <ItemStyle HorizontalAlign="Center" Width="6%" />
            <HeaderStyle ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Middle"/>
            </asp:BoundField>

            <asp:TemplateField HeaderText="Giảng viên" ItemStyle-HorizontalAlign="Center" >
                <ItemTemplate>
                    &nbsp;&nbsp;<%#getCenterWithSpace(Eval("LecNm")as string)%>
                </ItemTemplate>
                <HeaderTemplate>
                    Giảng viên
                </HeaderTemplate>
                <HeaderStyle ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Middle"/>
                <ItemStyle HorizontalAlign="Left" Width="23%" ForeColor="#336699"/>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Thứ" ItemStyle-HorizontalAlign="Center" >
                <ItemTemplate>
                    <asp:Label ID="Day" runat="server" Text='<%#getCenter(Eval("Day") as string) %>'/>
                </ItemTemplate>
                <HeaderStyle ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Middle"/>
                <ItemStyle HorizontalAlign="Center" Width="5%" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Ca" ItemStyle-HorizontalAlign="Center" >
                <ItemTemplate>
                    <asp:Label ID="Period" runat="server" Text='<%#getCenter(Eval("Period") as string) %>'/>
                </ItemTemplate>
                <HeaderStyle ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Middle"/>
                <ItemStyle HorizontalAlign="Center" Width="5%" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Phòng" ItemStyle-HorizontalAlign="Center" >
                <ItemTemplate>
                    <asp:Label ID="Room" runat="server" Text='<%#getCenter(Eval("Room") as string) %>'/>
                </ItemTemplate>
                <HeaderStyle ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Middle"/>
                <ItemStyle HorizontalAlign="Center" Width="7%" />
            </asp:TemplateField>

            <asp:BoundField DataField="StuMx" HeaderText="Tối đa">
            <ItemStyle HorizontalAlign="Center" Width="5%" />
            <HeaderStyle ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Middle"/>
            </asp:BoundField>

            <asp:BoundField DataField="CurNm" HeaderText="Đã đk" >
            <ItemStyle HorizontalAlign="Center" Width="5%" />
            <HeaderStyle ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Middle"/>
            </asp:BoundField>
        <asp:TemplateField HeaderText="Phần trăm" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
            <ItemTemplate>
                <asp:Label Text="" runat="server" ID="Percen"></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
    SelectCommand="SELECT * FROM [ScheduleM] as S , Subject as Su where Su.SubID = S.SubID ORDER BY SubNM,ClassID,ROOM, DAY,PERIOD" 
    onselecting="SqlDataSource1_Selecting" onload="SqlDataSource1_Load">
</asp:SqlDataSource>
<br/>
</ContentTemplate>
<Triggers>
<asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" />
</Triggers>
</asp:UpdatePanel>