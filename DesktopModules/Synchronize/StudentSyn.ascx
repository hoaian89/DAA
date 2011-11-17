<%@ Control Language="C#" AutoEventWireup="true" CodeFile="StudentSyn.ascx.cs" Inherits="daa.StudentSyn" %>
<asp:UpdatePanel ID="StudentUpdate" runat="server">
    <ContentTemplate>
        <fieldset>
            <legend>Sinh viên</legend>
            <table width="100%">
                <tr>
                    <td>
                        Tổng số:
                        <asp:Label ID="lblStuTotal" runat="server"></asp:Label>
                    </td>
                    <td>
                        Đã có tài khoản:
                        <asp:Label ID="lblNoRegStu" runat="server"></asp:Label>
                    </td>
                    <td>
                        Chưa có tài khoản:
                        <asp:Label ID="lblNoFreeStu" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:Button ID="btnSynStu" runat="server" Text="Đồng bộ" OnClick="btnSynStu_Click" />
                    </td>
                    <td width="16">
                        <asp:UpdateProgress ID="StudentUpdateProgress" runat="server" AssociatedUpdatePanelID="StudentUpdate">
                            <ProgressTemplate>
                                <asp:Image ID="Image1" runat="server" ImageUrl="~/images/dnnanim.gif" />
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
            </table>
            <p>
                Danh sách sinh viên chưa được cấp tài khoản (nếu có) được liệt kê bên dưới.</p>
            <asp:Label ID="lblFreeStus" runat="server"></asp:Label>
        </fieldset>
    </ContentTemplate>
</asp:UpdatePanel>
