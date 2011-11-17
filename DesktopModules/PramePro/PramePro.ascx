<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PramePro.ascx.cs" Inherits="DesktopModules_PramePro_PramePro" %>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1" Width="100%">
            <ItemTemplate>
                <table  width="100%">
                    <tr>
                        <td>
                            <strong>MSSV : <%# Eval("StuId")%></strong></td>
                        <td align="right">
                            <strong>Khoa : 
                                <asp:Label ID="Dept" runat="server" 
                                Text='<%# GetDept(Eval("Dept") as string) %>' style="color: #CC3300"></asp:Label>
                                </strong>
                        </td>
                    </tr>
                </table>
                <hr />
            </ItemTemplate>
        </asp:DataList>
          <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
            SelectCommand="SELECT [Dept], [StuId] FROM [Student] WHERE ([StuId] = @StuId)">
              <SelectParameters>
                  <asp:Parameter Name="StuId" Type="String" />
              </SelectParameters>
        </asp:SqlDataSource>
        
          <asp:UpdateProgress ID="RegCrepdateProgress0" runat="server" 
            AssociatedUpdatePanelID="UpdatePanel1">
            <ProgressTemplate>
                <asp:Image ID="Image2" runat="server" ImageUrl="~/images/dnnanim.gif" />
            </ProgressTemplate>
        </asp:UpdateProgress>
        <br/>
        Xem theo :
        <asp:DropDownList ID="DropDownList1" runat="server" 
            meta:resourcekey="DropDownList1Resource1" 
            onselectedindexchanged="DropDownList1_SelectedIndexChanged" 
            AutoPostBack="True" Width="100px">
            <asp:ListItem Value="Term" meta:resourcekey="ListItemResource1">Học kì</asp:ListItem>
            <asp:ListItem Value="Type" meta:resourcekey="ListItemResource2">Loại môn</asp:ListItem>
        </asp:DropDownList>
        &nbsp;&nbsp;
        <br />
        <br />
        Tổng số môn đã học :
        <asp:Label ID="Label1" runat="server" CssClass="s" 
            meta:resourcekey="Label1Resource1" style="font-weight: 700;color:#CC6600" 
            Text=""></asp:Label>
        <br />
        Tổng số TC cần tích lũy toàn khóa :
        <asp:Label ID="Label3" runat="server" style="font-weight: 700; color: #CC6600" 
            Text="" meta:resourcekey="Label3Resource1"></asp:Label>
        <br />
        Tổng số TC đã tích lũy trong chương trình khoa :
        <asp:Label ID="Label2" runat="server" style="font-weight: 700; color: #CC6600" 
            Text="" meta:resourcekey="Label2Resource1"></asp:Label>
        <br />
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="PromeProDatabase" meta:resourcekey="GridView1Resource1" EmptyDataText="Dữ liệu của bạn không tồn tại !" 
            >
            <Columns>
                <asp:BoundField DataField="OrdTerm" HeaderText="TT" HeaderStyle-HorizontalAlign="Center">
                <HeaderStyle BackColor="#33CCCC" ForeColor="White" />
                <ItemStyle HorizontalAlign="Center" BackColor="#33CCCC" Font-Bold="True" 
                    ForeColor="White" />
                </asp:BoundField>
                <asp:BoundField DataField="Ord" HeaderText="TT" Visible="false" HeaderStyle-HorizontalAlign="Center">
                <HeaderStyle BackColor="#33CCCC" Font-Bold="True" ForeColor="White" />
                <ItemStyle HorizontalAlign="Center" BackColor="#33CCCC" Font-Bold="True" 
                    ForeColor="White" />
                </asp:BoundField>
                <asp:BoundField DataField="Typ" HeaderText="Loại" SortExpression="Typ" 
                    meta:resourcekey="BoundFieldResource7"  Visible="false" HeaderStyle-HorizontalAlign="Center">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Term" HeaderText="Học kỳ" SortExpression="Term" HeaderStyle-HorizontalAlign="Center"
                    meta:resourcekey="BoundFieldResource1">
                <ControlStyle/>
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="SubID" HeaderText="Mã môn" SortExpression="SubID" 
                    meta:resourcekey="BoundFieldResource2" HeaderStyle-HorizontalAlign="Center">
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Tên môn" HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                         &nbsp;&nbsp;<%#Eval("SubNm")%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Regedits" HeaderText="Số TC" HeaderStyle-HorizontalAlign="Center"
                    SortExpression="Regedits" meta:resourcekey="BoundFieldResource4" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Thoer" HeaderText="Lý thuyết" SortExpression="Thoer" HeaderStyle-HorizontalAlign="Center"
                    meta:resourcekey="BoundFieldResource5" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Prac" HeaderText="Thực hành" SortExpression="Prac" HeaderStyle-HorizontalAlign="Center"
                    meta:resourcekey="BoundFieldResource6" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:ImageField HeaderStyle-HorizontalAlign="Center"
                    HeaderText="Điểm">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:ImageField>
                <asp:ImageField HeaderStyle-HorizontalAlign="Center"
                    HeaderText="Đạt">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:ImageField>                
            </Columns>
            <HeaderStyle Font-Bold="True" ForeColor="#CC3300" />
        </asp:GridView>
        <asp:SqlDataSource ID="PromeProDatabase" runat="server" 
            ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
            SelectCommand="SELECT [SubID], [Ord],[OrdTerm], [SubNm], [Regedits], [Thoer], [Prac], [Term], [Typ] FROM [FramePro] as F,[Student] as S WHERE (F.Ace = S.Dept) and (S.StuID = @StuID) ORDER BY [OrdTerm]">
            <SelectParameters>
                <asp:Parameter Name="StuID" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
    </ContentTemplate>
</asp:UpdatePanel>