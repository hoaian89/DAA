<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Settings.ascx.cs" Inherits="daa.StudentCVSettings" %>
<asp:RequiredFieldValidator ID="EmailRequired" runat="server" ToolTip="Chưa nhập địa chỉ email."
    ControlToValidate="txtEmail" ValidationGroup="StudentCV">*</asp:RequiredFieldValidator>
Email:
<asp:TextBox ID="txtEmail" runat="server" ValidationGroup="StudentCV"></asp:TextBox>
<asp:RegularExpressionValidator ID="EmailValidator" runat="server" ToolTip="Địa chỉ email không hợp lệ."
    ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
    ValidationGroup="StudentCV">*</asp:RegularExpressionValidator>