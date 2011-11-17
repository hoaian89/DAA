<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Post Announcement.ascx.cs" Inherits="DesktopModules_Post_Announcement_Post_Announcement" %>
<%@ Register TagPrefix="dnn" TagName="URL" Src="~/controls/URLControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<style type="text/css">
    .style1
    {
        width: 672px;
    }
    .style2
    {
        color: #0033CC;
    }
    .style3
    {
        width: 100%;
    }
</style>
<asp:UpdatePanel runat="server" ID = "Panel">
<ContentTemplate>
<table width="100%">
    <tr>
        <td width="30%">
<asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" 
    RepeatDirection="Horizontal" 
    onselectedindexchanged="RadioButtonList1_SelectedIndexChanged">
    <asp:ListItem Value="1" Selected="True">Post bài mới</asp:ListItem>
    <asp:ListItem Value="2">Sửa bài cũ</asp:ListItem>
</asp:RadioButtonList>
        </td>
        <td class="style1" valign="bottom">
<asp:DropDownList ID="DropDownList1" runat="server" 
    DataSourceID="AnnounmentList" DataTextField="Title" DataValueField="ItemID" 
    Visible="False" AutoPostBack="True" 
                onselectedindexchanged="DropDownList1_SelectedIndexChanged" Width="280px">
</asp:DropDownList>
            &nbsp;&nbsp;
            <asp:LinkButton ID="DelButton" runat="server" onclick="LinkButton3_Click" 
                 OnClientClick ="javascript : return confirm('Bạn có chắc muốn xóa bài viết này không ?')" Visible="False">Xóa</asp:LinkButton>
            </td>
        <td align="right" class="style1" valign="bottom">
            <asp:Label ID="Suslabel" runat="server" style="color: #CC3300"></asp:Label>
            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/save.gif" 
                onclick="LinkButton1_Click" />
            <span class="style2">
            <asp:LinkButton ID="LinkButton2" runat="server" onclick="LinkButton2_Click">Lưu</asp:LinkButton>
            &nbsp;</span></td>
    </tr>
</table>
<asp:UpdateProgress ID="RegCrepdateProgress0" runat="server" AssociatedUpdatePanelID="Panel">
<ProgressTemplate>
    <asp:Image ID="Image1" runat="server" ImageUrl="~/images/dnnanim.gif" />
</ProgressTemplate>
</asp:UpdateProgress>
<asp:SqlDataSource ID="AnnounmentList" runat="server" 
    ConnectionString="<%$ ConnectionStrings:SiteSqlServer %>" 
    SelectCommand="SELECT distinct [Title], [ItemID] FROM [Announcements] WHERE [ModuleID] = @ModuleID">
    <SelectParameters>
        <asp:Parameter Name="ModuleID" Type="Int32"/>
    </SelectParameters>
</asp:SqlDataSource>
<hr />
    <br />
<strong>Tựa đề :</strong>
<asp:TextBox ID="Title" runat="server" Width="90%" Font-Bold="True"></asp:TextBox>
<br />
<br />
<dnn:TextEditor ID="teContent" runat="server" Width="100%" Height="500" 
        ChooseMode="True"></dnn:TextEditor>
    <br />
    <hr />
    Mô tả : <asp:TextBox ID="description" runat="server" Width="100%" Height="120px" TextMode="MultiLine"></asp:TextBox>
    <br />
    <hr />
    <table class="style3">
        <tr>
            <td>
                ** Ngày bắt đầu :&nbsp;&nbsp;</td>
            <td>
                <asp:TextBox ID="StartDate" runat="server" Font-Bold="True"></asp:TextBox>
                
                
            </td>
            <td align="right">
                ** Ngày kết thúc :</td>
            <td align="right">
                <asp:TextBox ID="EnDate" runat="server" Font-Bold="True"></asp:TextBox>
                
            </td>
        </tr>
    </table>
</ContentTemplate>
</asp:UpdatePanel>
