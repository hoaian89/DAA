<%@ Control Language="C#" AutoEventWireup="true" CodeFile="StudyResults.ascx.cs"
    Inherits="daa.StudyResults" %>
<%@ Import Namespace="daa" %>

<asp:SqlDataSource ID="StudentSource" runat="server" ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>"
    SelectCommand="SELECT [StuNm], [Amark0], [Amark1], [StuId] FROM [Student] WHERE ([StuId] = @StuId)">
    <SelectParameters>
        <asp:Parameter Name="StuId" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
<strong>Nhập họ tên sinh viên</strong> : 
<asp:TextBox ID="nameTxb" runat="server" Width="30%"></asp:TextBox>
<asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/view.gif" 
                onclick="ImageButton1_Click" />
<asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
    <ProgressTemplate>
        <asp:Image ID="Image2" runat="server" ImageUrl="~/images/dnnanim.gif" />
    </ProgressTemplate>
</asp:UpdateProgress>
<br/><br />
<asp:GridView ID="ShowList" runat="server" DataSourceID = "SqlDataSource1" OnRowCommand="GridView1Command"
AutoGenerateColumns="False" EnableSortingAndPagingCallbacks="True">
    <Columns>
        <asp:TemplateField HeaderText="MSSV">
           <ItemTemplate >
                <asp:LinkButton ID="StuID" runat="server" Text='<%# Eval("STUID") %>' CommandName="SHOW" />
           </ItemTemplate>
           <ItemStyle Width="20%" HorizontalAlign="Center"/>
           <HeaderStyle HorizontalAlign = "Center" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Họ tên sinh viên">
           <ItemTemplate >
                &nbsp;&nbsp;<asp:LinkButton ID="StuNm" runat="server" Text='<%# Eval("STUNM") %>' CommandName="SHOW"/>
           </ItemTemplate>
           <ItemStyle Width="50%" />
           <HeaderStyle HorizontalAlign = "Center" />
        </asp:TemplateField>
    </Columns>
    <EmptyDataTemplate>
        Nhập vào tên sinh viên cần tìm !
    </EmptyDataTemplate>
</asp:GridView>

<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>"
    SelectCommand="SELECT STUNM , STUID FROM STUDENT WHERE STUNM LIKE @NAME">
    <SelectParameters>
        <asp:Parameter Name = "name" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>

<p>
<br />
<table width="100%"> 
    <tr>
        <td width = "35%"><hr/></td> 
        <td align="center"> <strong>*** Thông Tin Bảng Điểm *** </strong>
        </td>
        <td width="35%"><hr/></td> 
    </tr>
</table>

<asp:DataList ID="StudentData" runat="server" DataKeyField="StuId" DataSourceID="StudentSource"
    Width="100%">
    <ItemTemplate>
        <table width="100%">
            <tr>
                <td width = "20%">
                    <b>MSSV:</b>
                </td>
                <td>
                    <%# Server.HtmlDecode(Eval("StuId") as string) %>
                </td>
                <td width = "20%">
                    <b>Họ tên:</b>
                </td>
                <td>
                    <%# Server.HtmlDecode(Helper.GetValueName(Eval("StuNm")))%>
                </td>
            </tr>
            <tr>
                <td >
                    <b>Số tín chỉ tích lũy:</b>
                </td>
                <td>
                    <%# Server.HtmlDecode(Helper.GetValueName(Eval("Amark0"), "{0}", "Chưa cập nhật"))%>
                </td>
                <td>
                    <b>Điểm trung bình:</b>
                </td>
                <td>
                    <%# Server.HtmlDecode(Helper.GetValueName(Eval("Amark1"), "{0:0.00}", "Chưa cập nhật"))%>
                </td>
            </tr>
            <tr>
                <td colspan="4" align="center">
                    <small>(Sinh viên chỉ có thể tích lũy những tín chỉ có điểm tổng kết môn từ 5.0 trở
                        lên.)</small>
                </td>
            </tr>
        </table>
    </ItemTemplate>
</asp:DataList>
</ContentTemplate>
</asp:UpdatePanel>

<br/>
<asp:UpdatePanel ID="MarkUpdate" runat="server">
    <ContentTemplate>
        <table width="100%">
            <tr>
                <td >
                    Năm học:
                    <asp:SqlDataSource ID="AYearsSource" runat="server" ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>"
                        SelectCommand="SELECT DISTINCT [AYear] FROM [Mark] WHERE ([StuId] = @StuId) ORDER BY [AYear] DESC">
                        <SelectParameters>
                            <asp:Parameter Name="StuId" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:DropDownList ID="cbxAYears" runat="server" AutoPostBack="True" DataSourceID="AYearsSource"
                        DataTextField="AYear" DataValueField="AYear" OnDataBound="cbxAYears_DataBound" Width="10%">
                    </asp:DropDownList>
                    Học kì:
                    <asp:SqlDataSource ID="TermsSource" runat="server" ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>"
                        SelectCommand="SELECT DISTINCT [Term] FROM [Mark] WHERE (([StuId] = @StuId) AND ([AYear] LIKE @AYear)) ORDER BY [Term] DESC">
                        <SelectParameters>
                            <asp:Parameter Name="StuId" Type="String" />
                            <asp:ControlParameter ControlID="cbxAYears" Name="AYear" PropertyName="SelectedValue"
                                Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:DropDownList ID="cbxTerms" runat="server" AutoPostBack="True" DataSourceID="TermsSource"
                        DataTextField="Term" DataValueField="Term" OnDataBound="cbxTerms_DataBound" OnSelectedIndexChanged="cbxTerms_SelectedIndexChanged"
                        Width="10%">
                    </asp:DropDownList>
                </td>
                <td width="16">
                    <asp:UpdateProgress ID="MarkUpdateProgress" runat="server" AssociatedUpdatePanelID="MarkUpdate">
                        <ProgressTemplate>
                            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/dnnanim.gif" />
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </td>
            </tr>
        </table>
        <asp:SqlDataSource ID="MarksSource" runat="server" ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>"
            SelectCommand="SELECT Mark.Term, Mark.AYear, Mark.Mark, Subject.SubNm, Subject.Credits, Subject.SubId FROM Mark INNER JOIN Subject ON Mark.SubId = Subject.SubId WHERE (Mark.StuId = @StuId) AND (Mark.AYear LIKE @AYear) AND (Mark.Term >= @TermMin) AND (Mark.Term <= @TermMax) ORDER BY Mark.AYear, Mark.Term"
            OnSelecting="MarksSource_Selecting">
            <SelectParameters>
                <asp:Parameter Name="StuId" Type="String" />
                <asp:ControlParameter ControlID="cbxAYears" Name="AYear" PropertyName="SelectedValue"
                    Type="String" />
                <asp:Parameter Name="TermMin" Type="Byte" />
                <asp:Parameter Name="TermMax" Type="Byte" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="MarkData" runat="server" AutoGenerateColumns="False" DataSourceID="MarksSource"
            EnableModelValidation="True" AllowSorting="True" ShowFooter="True" OnRowDataBound="MarkGridView_OnRowDataBound"
            Width="100%">
            <Columns>
                <asp:TemplateField HeaderText="Năm học" SortExpression="AYear">
                    <ItemTemplate>
                        <%# Helper.GetAYear(Eval("AYear") as string) %>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="Term" HeaderText="Học kì" SortExpression="Term">
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle HorizontalAlign = "Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Mã môn" SortExpression="SubID">
                    <ItemTemplate>
                        &nbsp;&nbsp;<%# Eval("SubID")%>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Mã môn" SortExpression="SubNm">
                    <ItemTemplate>
                        &nbsp;&nbsp;<%# Eval("SubNm")%>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="Credits" HeaderText="Số tín chỉ" SortExpression="Credits">
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Điểm" SortExpression="Mark">
                    <ItemTemplate>
                        <%# string.Format("{0:0.0}", (byte)Eval("Mark") / (double)10) %>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Nhân hệ số">
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle HorizontalAlign = "Center" />
                    <ItemTemplate>
                        <%# string.Format("{0:0.0}", (byte)Eval("Credits") * (byte)Eval("Mark") / (double)10)%>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
                Chưa có dữ liệu điểm.
            </EmptyDataTemplate>
            <FooterStyle Font-Bold="True" HorizontalAlign="Center" />
        </asp:GridView>
    </ContentTemplate>
</asp:UpdatePanel>


