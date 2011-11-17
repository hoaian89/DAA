<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="Portal" TagName="URL" Src="~/controls/URLControl.ascx" %>
<%@ Control Language="vb" AutoEventWireup="false" Inherits="DotNetNuke.Modules.Help.Settings"
    Codebehind="Settings.ascx.vb" %>
<p>
    <table id="Table1" cellspacing="0" cellpadding="0" border="0">
        <tr>
            <td class="SubHead">
                <dnn:Label ID="plModuleID" runat="server" Suffix=":"></dnn:Label>
            </td>
            <td class="Normal">
                <asp:DropDownList ID="cboModuleID" runat="server">
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td class="SubHead">
                <dnn:Label ID="plImagesRootPath" runat="server" Suffix=":"></dnn:Label>
            </td>
            <td class="Normal">
                <asp:TextBox ID="txtImagesRootPath" runat="server" size="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="SubHead">
                <dnn:Label ID="plUploadXML" runat="server" Suffix=":"></dnn:Label>
            </td>
            <td class="Normal">
                <Portal:URL ID="ctlXML" runat="server" FileFilter="jpg,jpeg,jpe,gif,bmp,png,swf,xml,zip"
                    Required="False" Width="250px" ShowDatabase="false" ShowLog="false" ShowNewWindow="false"
                    ShowSecure="false" ShowTabs="false" ShowTrack="false" ShowUrls="false" ShowUsers="false">
                </Portal:URL>
            </td>
        </tr>
        <tr>
            <td class="SubHead">
                <dnn:Label ID="plUploadImages" runat="server" Suffix=":"></dnn:Label>
            </td>
            <td class="Normal">
                <Portal:URL ID="ctlImages" runat="server" FileFilter="jpg,jpeg,jpe,gif,bmp,png,swf,xml,zip"
                    Required="False" Width="250px" ShowDatabase="false" ShowLog="false" ShowNewWindow="false"
                    ShowSecure="false" ShowTabs="false" ShowTrack="false" ShowUrls="false" ShowUsers="false">
                </Portal:URL>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Label ID="lblMessage" runat="server" CssClass="NormalRed"></asp:Label></td>
        </tr>
    </table>
</p>
