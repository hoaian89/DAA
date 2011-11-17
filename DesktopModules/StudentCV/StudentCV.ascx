<%@ Control Language="C#" AutoEventWireup="true" CodeFile="StudentCV.ascx.cs" Inherits="daa.StudentCV" %>
<%@ Import Namespace="daa" %>
<asp:UpdatePanel ID="StuCVUpdate" runat="server">
    <ContentTemplate>
        <asp:SqlDataSource ID="StudentDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>"
            OnLoad="StudentDataSource_Load" SelectCommand="SELECT * FROM [Student] WHERE ([StuId] = @StuId)"
            UpdateCommand="UPDATE Student SET Address = @Address, Phone = @Phone, Email = @Email, Account = @Account WHERE ([StuId] = @StuId)">
            <SelectParameters>
                <asp:Parameter Name="StuId" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="StuID" Type="String" />
                <asp:Parameter Name="Address" Type="String" />
                <asp:Parameter Name="Phone" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter Name="Account" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:DataList ID="StudentData" runat="server" DataKeyField="StuId" DataSourceID="StudentDataSource"
            OnEditCommand="StudentData_EditCommand" OnCancelCommand="StudentData_CancelCommand"
            OnUpdateCommand="StudentData_UpdateCommand" Width="100%">
            <ItemTemplate>
                <table width="100%">
                    <tr>
                        <td width="16">
                            <asp:UpdateProgress ID="StuCVUpdateProgress" runat="server" AssociatedUpdatePanelID="StuCVUpdate">
                                <ProgressTemplate>
                                    <asp:Image ID="Image1" runat="server" ImageUrl="~/images/dnnanim.gif" />
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                        <td>
                            Mã số:
                            <%# Server.HtmlDecode(Eval("StuId") as string) %>
                        </td>
                        <td align="right">
                            <asp:LinkButton ID="EditButton" Text="Chỉnh sửa" CommandName="Edit" runat="server" />
                        </td>
                    </tr>
                </table>
                <hr />
                <table width="100%">
                    <tr>
                        <td width="15%">
                            Họ tên:
                        </td>
                        <td width="35%">
                            <%# Server.HtmlDecode(Helper.GetValueName(Eval("StuNm")))%>
                        </td>
                        <td width="15%">
                            Giới tính:
                        </td>
                        <td width="35%">
                            <%# Server.HtmlDecode(Helper.GetGenderName(Eval("Gender") as bool?)) %>
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
                            Quê quán:
                        </td>
                        <td>
                            <%# Server.HtmlDecode(Helper.GetValueName(Eval("Native")))%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Nhập học:
                        </td>
                        <td>
                            <%# Server.HtmlDecode(Helper.GetValueName(Eval("Eyear", "{0:MM/yyyy}")))%>
                        </td>
                        <td>
                            Vào lớp:
                        </td>
                        <td>
                            <%# Server.HtmlDecode(Helper.GetValueName(Eval("Eclass")))%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Khoa:
                        </td>
                        <td>
                            <%# Server.HtmlDecode(Helper.GetDeptName(Eval("Dept") as string)) %>
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Bậc học:
                        </td>
                        <td>
                            <%# Server.HtmlDecode(Helper.GetDegreeName(Eval("Degree") as string)) %>
                        </td>
                        <td>
                            Hệ:
                        </td>
                        <td>
                            <%# Server.HtmlDecode(Helper.GetStatusName(Eval("Status") as string)) %>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            &nbsp;
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
                            Số CMND:
                        </td>
                        <td>
                            <%# Server.HtmlDecode(Helper.GetValueName(Eval("Idnum")))%>
                        </td>
                        <td>
                            Tài khoản ngân hàng:
                        </td>
                        <td>
                            <%# Server.HtmlDecode(Helper.GetValueName(Eval("Account")))%>
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
            <EditItemTemplate>
                <table width="100%">
                    <tr>
                        <td width="16">
                            <asp:UpdateProgress ID="StuCVUpdateProgress" runat="server" AssociatedUpdatePanelID="StuCVUpdate">
                                <ProgressTemplate>
                                    <asp:Image ID="Image1" runat="server" ImageUrl="~/images/dnnanim.gif" />
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>
                        <td>
                            Mã số:
                            <%# Server.HtmlDecode(Eval("StuId") as string) %>
                        </td>
                        <td align="right">
                            <asp:LinkButton ID="UpdateButton" Text="Cập nhật" CommandName="Update" runat="server"
                                ValidationGroup="StudentCV" />
                            |
                            <asp:LinkButton ID="CancelButton" Text="Hủy bỏ" CommandName="Cancel" runat="server" />
                        </td>
                    </tr>
                </table>
                <hr />
                <p>
                    Mọi sự thay đổi trên những thông tin được in đậm đều sẽ được gửi về phòng đào tạo
                    để xem xét. Sinh viên có thể tự do thay đổi những thông tin còn lại.</p>
                <table width="100%">
                    <tr>
                        <td width="15%">
                            <b>Họ tên:</b>
                        </td>
                        <td width="35%">
                            <asp:TextBox ID="txtStuNm" Text='<%# Eval("StuNm") %>' runat="server" />
                            <asp:RequiredFieldValidator ID="RequiredStuNm" runat="server" Text="*" ToolTip="Họ tên chưa được nhập."
                                ValidationGroup="StudentCV" ControlToValidate="txtStuNm" />
                            <asp:HiddenField ID="hdStuNm" Value='<%# Eval("StuNm") %>' runat="server" />
                        </td>
                        <td width="15%">
                            <b>Giới tính:</b>
                        </td>
                        <td width="35%">
                            <asp:RadioButtonList ID="optGender" runat="server" SelectedValue='<%# Eval("Gender") %>'
                                RepeatDirection="Horizontal">
                                <asp:ListItem Value="False" Text="Nam" />
                                <asp:ListItem Value="True" Text="Nữ" />
                                <asp:ListItem Value="" Text="Chưa cập nhật" Enabled="false" />
                            </asp:RadioButtonList>
                            <asp:RequiredFieldValidator ID="RequiredGender" runat="server" Text="*" ToolTip="Giới tính chưa được nhập."
                                ValidationGroup="StudentCV" ControlToValidate="optGender" />
                            <asp:HiddenField ID="hdGender" Value='<%# Eval("Gender") %>' runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>Ngày sinh:</b>
                        </td>
                        <td>
                            <asp:TextBox ID="txtBDay" runat="server" Text='<%# Eval("BDay", "{0:dd/MM/yyyy}") %>' />
                            <asp:RequiredFieldValidator ID="RequiredBDay" runat="server" Text="*" ToolTip="Ngày sinh chưa được nhập."
                                ValidationGroup="StudentCV" ControlToValidate="txtBDay" />
                            <asp:CompareValidator ID="BDayTypeValidator" runat="server" ControlToValidate="txtBDay"
                                Text="*" ToolTip="Ngày tháng năm sinh không hợp lệ." Operator="DataTypeCheck"
                                Type="Date" ValidationGroup="StudentCV" ForeColor="Red" />
                            <asp:HiddenField ID="hdBDay" Value='<%# Eval("BDay", "{0:dd/MM/yyyy}") %>' runat="server" />
                        </td>
                        <td>
                            <b>Quê quán:</b>
                        </td>
                        <td>
                            <asp:TextBox ID="txtNative" Text='<%# Eval("Native") %>' runat="server" />
                            <asp:RequiredFieldValidator ID="RequiredNative" runat="server" Text="*" ToolTip="Quê quán chưa được nhập."
                                ValidationGroup="StudentCV" ControlToValidate="txtNative" />
                            <asp:HiddenField ID="hdNative" Value='<%# Eval("Native") %>' runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>Nhập học:</b>
                        </td>
                        <td>
                            <asp:TextBox ID="txtEyear" runat="server" Text='<%# Eval("Eyear", "{0:MM/yyyy}") %>' />
                            <asp:RequiredFieldValidator ID="RequiredEyear" runat="server" Text="*" ToolTip="Tháng năm vào học chưa được nhập."
                                ValidationGroup="StudentCV" ControlToValidate="txtEyear" />
                            <asp:RegularExpressionValidator ID="EyearTypeValidator" runat="server" ControlToValidate="txtEyear"
                                Text="*" ToolTip="Tháng năm nhập học không hợp lệ." ValidationExpression="(0[1-9]|1[012])[- /.](19|20)\d\d"
                                ValidationGroup="StudentCV" ForeColor="Red" />
                            <asp:HiddenField ID="hdEyear" Value='<%# Eval("Eyear", "{0:MM/yyyy}") %>' runat="server" />
                        </td>
                        <td>
                            <b>Vào lớp:</b>
                        </td>
                        <td>
                            <asp:TextBox ID="txtEclass" Text='<%# Eval("Eclass") %>' runat="server" />
                            <asp:RequiredFieldValidator ID="RequiredEClass" runat="server" Text="*" ToolTip="Lớp vào học chưa được nhập."
                                ValidationGroup="StudentCV" ControlToValidate="txtEclass" />
                            <asp:HiddenField ID="hdEclass" Value='<%# Eval("Eclass") %>' runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>Khoa:</b>
                        </td>
                        <td>
                            <asp:DropDownList ID="lstDept" runat="server" SelectedValue='<%# Eval("Dept") %>'>
                                <asp:ListItem Value="" Text="Chưa cập nhật" Enabled="false" />
                                <asp:ListItem Text="Khoa học máy tính" Value="CS" />
                                <asp:ListItem Text="Cử nhân tài năng" Value="TB" />
                                <asp:ListItem Text="Kỹ thuật máy tính" Value="CE" />
                                <asp:ListItem Text="Công nghệ phần mềm" Value="SE" />
                                <asp:ListItem Text="Hệ thống thông tin" Value="IS" />
                                <asp:ListItem Text="Mạng máy tính & Truyền thông" Value="NT" />
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredDept" runat="server" Text="*" ToolTip="Khoa chưa được nhập."
                                ValidationGroup="StudentCV" ControlToValidate="lstDept" />
                            <asp:HiddenField ID="hdDept" Value='<%# Eval("Dept") %>' runat="server" />
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>Bậc học:</b>
                        </td>
                        <td>
                            <asp:DropDownList ID="lstDegree" runat="server" SelectedValue='<%# Eval("Degree") %>'>
                                <asp:ListItem Value="" Text="Chưa cập nhật" Enabled="false" />
                                <asp:ListItem Text="Đại học" Value="ĐH" />
                                <asp:ListItem Text="Cao học" Value="CH" />
                                <asp:ListItem Text="Tiến sỹ" Value="TS" />
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredDegree" runat="server" Text="*" ToolTip="Bậc học chưa được nhập."
                                ValidationGroup="StudentCV" ControlToValidate="lstDegree" />
                            <asp:HiddenField ID="hdDegree" Value='<%# Eval("Degree") %>' runat="server" />
                        </td>
                        <td>
                            <b>Hệ:</b>
                        </td>
                        <td>
                            <asp:DropDownList ID="lstStatus" runat="server" SelectedValue='<%# Eval("Status") %>'>
                                <asp:ListItem Value="" Text="Chưa rõ" Enabled="false" />
                                <asp:ListItem Text="Chính quy" Value="CQ" />
                                <asp:ListItem Text="Từ xa" Value="TX" />
                                <asp:ListItem Text="Tại chức" Value="TC" />
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredStatus" runat="server" Text="*" ToolTip="Hệ chưa được nhập."
                                ValidationGroup="StudentCV" ControlToValidate="lstStatus" />
                            <asp:HiddenField ID="hdStatus" Value='<%# Eval("Status") %>' runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Địa chỉ:
                        </td>
                        <td colspan="3">
                            <asp:TextBox ID="txtAddress" Text='<%# Eval("Address") %>' Width="400" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Điện thoại:
                        </td>
                        <td>
                            <asp:TextBox ID="txtPhone" Text='<%# Eval("Phone") %>' runat="server" />
                        </td>
                        <td>
                            Email:
                        </td>
                        <td>
                            <asp:TextBox ID="txtEmail" Text='<%# Eval("Email") %>' runat="server" />
                            <asp:RegularExpressionValidator ID="EmailRegexValidator" runat="server" ToolTip="Địa chỉ email không hợp lệ."
                                Text="*" ValidationGroup="StudentCV" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                ForeColor="Red" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>Số CMND:</b>
                        </td>
                        <td>
                            <asp:TextBox ID="txtIdnum" Text='<%# Eval("Idnum") %>' runat="server" />
                            <asp:RequiredFieldValidator ID="RequiredIdnum" runat="server" Text="*" ToolTip="Số CMND chưa được nhập."
                                ValidationGroup="StudentCV" ControlToValidate="txtIdnum" />
                            <asp:HiddenField ID="hdIdnum" Value='<%# Eval("Idnum") %>' runat="server" />
                        </td>
                        <td>
                            Tài khoản ngân hàng:
                        </td>
                        <td>
                            <asp:TextBox ID="txtAccount" Text='<%# Eval("Account") %>' runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" align="center">
                            <asp:Label ID="StudentFailureText" runat="server" EnableViewState="False" ForeColor="Red" />
                        </td>
                    </tr>
                </table>
            </EditItemTemplate>
        </asp:DataList>
    </ContentTemplate>
</asp:UpdatePanel>
