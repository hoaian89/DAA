<%@ Control Language="vb" Inherits="DotNetNuke.Modules.Announcements.Announcements"
    Codebehind="Announcements.ascx.vb" AutoEventWireup="false" Explicit="True" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<div class="DNN_ANN_viewtypeSelector" id="viewtypeSelector" runat="server">
    <div class="DNN_ANN_viewtypeSelectorLabel"><dnn:Label ID="plSelectView" runat="server" ControlName="ddlViewType" Suffix=":" CssClass="SubHead"></dnn:Label></div>
    <div class="DNN_ANN_viewtypeSelectorDDL"><asp:DropDownList ID="ddlViewType" CssClass="NormalTextBox" runat="server" AutoPostBack="True"></asp:DropDownList></div>
</div><asp:Literal ID="litAnnouncements" runat="server"></asp:Literal>
