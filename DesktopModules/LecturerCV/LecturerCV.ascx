<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LecturerCV.ascx.cs" Inherits="daa.LecturerCV" %>
<%@ Import Namespace="daa" %>
<asp:UpdatePanel ID="LecturerUpdate" runat="server">
    <ContentTemplate>
        <table width="100%">
            <tr>
                <td>
                    <asp:SqlDataSource ID="DeptsSource" runat="server" ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>"
                        SelectCommand="SELECT DISTINCT [Dept] FROM [Lecturer]"></asp:SqlDataSource>
                    Khoa/Phòng:
                </td>
                <td>
                    <asp:DropDownList ID="cbxDepts" runat="server" DataSourceID="DeptsSource" DataTextField="Dept"
                        DataValueField="Dept" AutoPostBack="True" OnDataBound="cbxDepts_DataBound">
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:SqlDataSource ID="LectsSource" runat="server" ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>"
                        SelectCommand="SELECT * FROM [Lecturer] WHERE ([Dept] = @Dept) ORDER BY [LecNm]">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="cbxDepts" Name="Dept" PropertyName="SelectedValue"
                                Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    Tên:
                </td>
                <td>
                    <asp:DropDownList ID="cbxLects" runat="server" AutoPostBack="True" DataSourceID="LectsSource"
                        DataTextField="LecNm" DataValueField="LecId" OnDataBound="cbxLects_DataBound">
                    </asp:DropDownList>
                </td>
                <td width="16">
                    <asp:UpdateProgress ID="LecturerUpdateProgress" runat="server" AssociatedUpdatePanelID="LecturerUpdate">
                        <ProgressTemplate>
                            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/dnnanim.gif" />
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </td>
            </tr>
        </table>
        <hr />
        <asp:SqlDataSource ID="LecturerSource" runat="server" ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>"
            SelectCommand="SELECT * FROM [Lecturer] WHERE ([LecId] = @LecId)">
            <SelectParameters>
                <asp:ControlParameter ControlID="cbxLects" Name="LecId" PropertyName="SelectedValue"
                    Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:DataList ID="LecturerData" runat="server" DataKeyField="LecId" DataSourceID="LecturerSource"
            Width="100%">
            <ItemTemplate>
                <table width="100%">
                    <tr>
                        <td width="15%">
                            Mã giảng viên:
                        </td>
                        <td width="35%">
                            <%# Server.HtmlDecode(Eval("LecId") as string) %>
                        </td>
                        <td width="15%">
                            Họ tên:
                        </td>
                        <td width="35%">
                            <%# Server.HtmlDecode(Helper.GetValueName(Eval("LecNm")))%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Ngày sinh:
                        </td>
                        <td>
                            <%# Server.HtmlDecode(Helper.GetValueName(Eval("BDay", "{0:dd/MM/yyyy}")))%>
                        </td>
                        <td>
                            Giới tính:
                        </td>
                        <td>
                            <%# Server.HtmlDecode(Helper.GetGenderName(Eval("Gender") as bool?)) %>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Quê quán:
                        </td>
                        <td>
                            <%# Server.HtmlDecode(Helper.GetValueName(Eval("Native") as string))%>
                        </td>
                        <td>
                            Số CMND:
                        </td>
                        <td>
                            <%# Server.HtmlDecode(Helper.GetValueName(Eval("Idnum") as string))%>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Học vị:
                        </td>
                        <td>
                            <%# Server.HtmlDecode(Helper.GetSPostName(Eval("Spost") as string))%>
                        </td>
                        <td>
                            Học hàm:
                        </td>
                        <td>
                            <%# Server.HtmlDecode(Helper.GetAPostName(Eval("Apost") as string))%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Đơn vị:
                        </td>
                        <td>
                            <%# Server.HtmlDecode(Helper.GetValueName(Eval("Office") as string))%>
                        </td>
                        <td>
                            Khoa/Phòng:
                        </td>
                        <td>
                            <%# Server.HtmlDecode(Helper.GetDeptName(Eval("Dept") as string))%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Chức vụ:
                        </td>
                        <td>
                            <%# Server.HtmlDecode(Helper.GetOPostName(Eval("OPost") as string))%>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Điện thoại:
                        </td>
                        <td>
                            <%# Server.HtmlDecode(Helper.GetValueName(Eval("Phone")))%>
                        </td>
                        <td>
                            Email:
                        </td>
                        <td>
                            <%# Server.HtmlDecode(Helper.GetValueName(Eval("Email"), "<a href=\"mailto:{0}\">{0}</a>"))%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Địa chỉ:
                        </td>
                        <td colspan="3">
                            <%# Server.HtmlDecode(Helper.GetValueName(Eval("Address")))%>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Ghi chú:
                        </td>
                        <td colspan="3">
                            <%# Server.HtmlDecode(Helper.GetValueName(Eval("Memo"), "{0}", "Không có"))%>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>
    </ContentTemplate>
</asp:UpdatePanel>
