﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RegisterReg.ascx.cs" Inherits="DesktopModules_RegisterReg_RegisterReg" %>
<!-- Style CSS -->
<style type="text/css">
 .RegColorStyle
 {
     color: #CC3300;
 }
 .Regstyle
 {
     font-weight: 700;
 }
    .style1
    {
        width: 100%;
    }
</style>

<!-- Main Panel 1 -->
<asp:UpdatePanel ID="RegCreUpdatePanel" runat="server">
<ContentTemplate>
<asp:SqlDataSource ID="StudentDataSource" runat="server"
    ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
    OnLoad="StudentDataSource_Load" 
    SelectCommand="SELECT * FROM [Student] WHERE ([StuId] = @StuID)">
    <SelectParameters>
        <asp:Parameter Name="StuId" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
<br />

<div>
    <!-- Student Info List -->
    <asp:DataList ID="StudentData" runat="server" DataKeyField="StuId" 
        DataSourceID="StudentDataSource" Width="100%">
        <ItemTemplate>
            <p class="meta">
                <span class="date"><strong>Mã số :&nbsp;
                    <%# Server.HtmlDecode(Eval("StuId") as string) %></strong>
                </span>
                <hr />
                <table width="100%">
                    <tr>
                        <td width="9%">
                            Họ tên&nbsp; :</td>
                        <td width="20%">
                            <span class="RegColorStyle">
                                <strong>
                                    <asp:Label Text='<%# Server.HtmlDecode(Eval("StuNm") as string)%>' ID="StuNmLB" runat="server" />
                                </strong>
                            </span>
                        </td>
                        <td width="30%" align="right" colspan="2">
                            Khoa :&nbsp;
                            <span class="RegColorStyle">
                                <strong>
                                    <asp:Label Text='<%# GetDept(Eval("Dept") as string)%>' ID="DeptLB" runat="server"/>
                                </strong>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Ngày sinh :</td>
                        <td width="20%">
                            <span class="RegColorStyle">
                                <strong>
                                    <%# Eval("BDay", "{0:dd/MM/yyyy}")%>
                                </strong>
                            </span>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
        </ItemTemplate>
    </asp:DataList>
 </div>

<!-- Show some info about this registry -->
<table width="100%">
    <tr>
        <td width="42%">
            <span class="style21"><strong style="font-size: 13pt">
            <br />
            </strong></span><span class="style22">
            <strong>Đăng kí học phần : </strong>
            </span>&nbsp;<span class="style92">( HK <%= getTerm() %> Năm <%= getYear() %> ) <br /> 
            <br />
            <asp:Label ID="Label3" runat="server" Text=""></asp:Label>
            <asp:DropDownList 
                ID="DropDownList1" runat="server" 
                onselectedindexchanged="DropDownList1_SelectedIndexChanged" 
                style="margin-left: 6px" AutoPostBack="True">
                <asp:ListItem Value="1">Đại cương</asp:ListItem>
                <asp:ListItem Value="2">Căn bản</asp:ListItem>
                <asp:ListItem Value="3">Cơ sở</asp:ListItem>
                <asp:ListItem Value="4">Chuyên nghành</asp:ListItem>
                <asp:ListItem Value="*" Selected="True">Tất cả</asp:ListItem>
            </asp:DropDownList>
            </span>
        </td>
    </tr>
</table>

<!-- Main gridview to show schedule and registry -->
<div style='vertical-align: top; height:<%= getHiV() %>; width:100%; overflow:auto;' id="DIV" >
    <br />
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" DataKeyNames="ClassID" 
        DataSourceID="SqlDataSource1" HorizontalAlign="Center" onload="GridView1_Load" 
        Width="98%" ondatabound="GridView1_DataBound">
        <Columns>
            <asp:BoundField DataField="ClassID" HeaderText="Lớp" >
                <ItemStyle HorizontalAlign="Center" Width="12%" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Môn" ItemStyle-HorizontalAlign="Center" >
                <ItemTemplate>
                    <asp:HiddenField ID="Type" runat="server" value='<%#Eval("Typ")%>'/>
                    <asp:HiddenField ID="SubID" runat="server" value='<%#Eval("SubID")%>'/>
                    <asp:LinkButton ID="SubNm" runat="server" Text='<%#Eval("SubNm")%>'/>
                    <asp:HiddenField ID="ClassID" runat="server" value='<%#Eval("ClassID")%>'/>
                </ItemTemplate>
                <HeaderTemplate>
                    Môn
                </HeaderTemplate>
                <HeaderStyle ForeColor="Black" />
                <ItemStyle HorizontalAlign="Center" Width="27%" />
            </asp:TemplateField>
            <asp:BoundField DataField="Credits" HeaderText="Số TC">
            <ItemStyle HorizontalAlign="Center" Width="4%" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Giảng viên" ItemStyle-HorizontalAlign="Center" >
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" Text='<%#getCenter(Eval("LecNm")as string)%>' />
                </ItemTemplate>
                <HeaderTemplate>
                    Giảng viên
                </HeaderTemplate>
                <HeaderStyle ForeColor="Black" />
                <ItemStyle HorizontalAlign="Center" Width="23%" />
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Thứ" ItemStyle-HorizontalAlign="Center" >
                <ItemTemplate>
                    <asp:Label ID="Day" runat="server" Text='<%#getCenter(Eval("Day") as string) %>'/>
                </ItemTemplate>
                <HeaderStyle ForeColor="Black" />
                <ItemStyle HorizontalAlign="Center" Width="5%" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Ca" ItemStyle-HorizontalAlign="Center" >
                <ItemTemplate>
                    <asp:Label ID="Period" runat="server" Text='<%#getCenter(Eval("Period") as string) %>'/>
                </ItemTemplate>
                <HeaderStyle ForeColor="Black" />
                <ItemStyle HorizontalAlign="Center" Width="5%" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Phòng" ItemStyle-HorizontalAlign="Center" >
                <ItemTemplate>
                    <asp:Label ID="Room" runat="server" Text='<%#getCenter(Eval("Room") as string) %>'/>
                </ItemTemplate>
                <HeaderStyle ForeColor="Black" />
                <ItemStyle HorizontalAlign="Center" Width="7%" />
            </asp:TemplateField>

            <asp:BoundField DataField="StuMx" HeaderText="Tối đa">
            <ItemStyle HorizontalAlign="Center" Width="5%" />
            </asp:BoundField>
            <asp:BoundField DataField="CurNm" HeaderText="Đã đk" >
            <ItemStyle HorizontalAlign="Center" Width="5%" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Select" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <asp:CheckBox ID="chkSelect" runat="server"/>
                </ItemTemplate>
                <HeaderTemplate>
                    ĐK
                </HeaderTemplate>
                <HeaderStyle ForeColor="Black" />
                <ItemStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" Width="5%" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</div>
<br />

<!-- Show total info about credits of student -->
<table width="100%" >
    <tr>
        <td colspan="2" class="RegColorStyle" width="36%">
            <strong>Tính đến <%= getTermYear() %></strong></td>
        <td colspan="2" class="RegColorStyle" width="36%">
            <strong>Đăng kí HK <%= getTerm() %>&nbsp; <%=getYear2() %> </strong>
        </td>
        <td colspan="2" class="RegColorStyle">
            <strong>Tính đến HK <%=getTerm() %>&nbsp; <%=getYear2() %></strong></td>
    </tr>
    <tr>
        <td>
            Số TC đã học&nbsp; :</td>
        <td >
            <asp:Label ID="Dahoc" runat="server" CssClass="Regstyle" Text="0"></asp:Label>
        </td>
        <td width="18%">
            Số TC cần tích lũy :</td>
        <td >
            <asp:Label ID="CanTL" runat="server" CssClass="Regstyle" Text="0"></asp:Label>
        </td>
        <td width="20%">
            Tổng số TC&nbsp; học :</td>
        <td >
            <asp:Label ID="Sum" runat="server" CssClass="Regstyle" Text="0"></asp:Label>
        </td>
    </tr>
    <tr>
        <td width="16%">
            Số TC tích lũy&nbsp; :</td>
        <td >
            <asp:Label ID="DaTL" runat="server" CssClass="Regstyle" Text="0"></asp:Label>
        </td>
        <td>
            Số TC đăng kí :</td>
        <td class="RegColorStyle0">
            <asp:Label ID="DK" runat="server" CssClass="Regstyle" Text="0"></asp:Label>
        </td>
        <td>
            Tổng số TC tích lũy :</td>
        <td >
            <asp:Label ID="SumTL" runat="server" CssClass="Regstyle" Text="0"></asp:Label>
        </td>
    </tr>
</table>
<br />&nbsp;
<asp:Label ID="ShowInfo" runat="server" ForeColor="#CC3300"></asp:Label>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
    OldValuesParameterFormatString="original_{0}" onload="SqlDataSource1_Load" >
</asp:SqlDataSource>

<!-- Two main button for all process -->
<p class="meta1">
    <table class="style1">
        <tr>
            <td>
                <span class="posted"><asp:LinkButton ID="EditButton1" runat="server" 
                    onclick="EditButton1_Click" style="font-weight: 700" 
                    Text="Đăng kí"  />
                </span>
                <asp:Label  runat = "server" ID="Seperate" Text='&nbsp;|'/>
                <span class="posted">
                <asp:LinkButton ID="PrintButton1" runat="server" 
                    onclick="PrintButton_Click" style="font-weight: 700" Text="Hủy" />
                </span>
                <asp:Label  runat = "server" ID="Seperate1" Text='&nbsp;|' Visible="false"/>
                <span class="posted">
                <asp:LinkButton ID="Download" runat="server"  onclick="Download_Click"
                    OnClientClick="javascript:return confirm('Chú ý : Sinh viên chỉ được xuất file một lần khi đã chắc chắn các thông tin !\nBạn có chắc muốn xuất file này không ? ')" 
                    style="font-weight: 700" Text = "Tải file" Visible="false"/>
                 </span>
            </td>
        </tr>
    </table>
</ContentTemplate>
</asp:UpdatePanel>

<!-- Main Panel 2 : Suggest subject info -->
<asp:UpdatePanel ID="UpdatePanel2" runat="server">
<ContentTemplate>
 <p class="meta1">
    &nbsp;<table class="style23">
        <tr>
            <td colspan="2" width="100%">
                Đề nghị mở lớp mới
            <hr />
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="Suggest" 
                    DataTextField="SubNm" DataValueField="SubID">
                </asp:DropDownList>
            </td>
            <td align="right" width="100%">
        <span class="posted">
        <asp:LinkButton ID="EditButton2" runat="server" onclick="LinkButton3_Click" 
            Text="Đề nghị" OnClientClick="javascript: return confirm('Chú ý : nếu lớp được mở , bạn sẽ có tên trong danh sách lớp đó !\nBạn có muốn đề nghị mở lớp này không ?')"/>
        &nbsp;&nbsp;&nbsp;
                <asp:Label ID="ShowInfoAboutSug" runat="server" ForeColor="#990000" 
                    style="color: #CC3300"></asp:Label>
        </span>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <br/>
    <br/>
    <asp:Label ID="NoticeLabel" runat="server" ForeColor="#990000" 
                    style="color: #CC3300"/>
    <asp:UpdateProgress ID="UpdateProgress2" runat="server" 
            AssociatedUpdatePanelID="UpdatePanel2">
        <ProgressTemplate>
            <asp:Image ID="Image3" runat="server" ImageUrl="~/images/dnnanim.gif" />
        </ProgressTemplate>
        </asp:UpdateProgress>
    <span class="posted">&nbsp;&nbsp; </span>
    <asp:SqlDataSource ID="Suggest" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
        SelectCommand="SELECT DISTINCT [SubNm], [SubId] FROM [Subject] ORDER BY [SubNm]">
    </asp:SqlDataSource>
 </p>
</ContentTemplate>
    <Triggers>
        <asp:PostBackTrigger ControlID="Download" />
    </Triggers>
</asp:UpdatePanel>
