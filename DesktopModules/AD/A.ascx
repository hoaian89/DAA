<%@ Control Language="C#" AutoEventWireup="true" CodeFile="A.ascx.cs" Inherits="DesktopModules_A_A" %>
<asp:UpdatePanel ID="onlineMarkPanel" runat="server">
<ContentTemplate>
<style type="text/css">
.style1
{
    width: 100%;
}
</style>
<table class="style1">
    <tr>
        <td width="90">
            &nbsp;&nbsp;Học kì :</td>
        <td width="30%">
        <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="true" 
                onselectedindexchanged="DropDownList2_SelectedIndexChanged">
        </asp:DropDownList>
        </td>
        <td>
        <asp:UpdateProgress ID="RegCrepdateProgress0" runat="server" AssociatedUpdatePanelID="onlineMarkPanel">
		<ProgressTemplate>
			<asp:Image ID="Image1" runat="server" ImageUrl="~/images/dnnanim.gif" />
		</ProgressTemplate>
		</asp:UpdateProgress></td>
    </tr>
    <tr>
        <td>
            &nbsp;&nbsp;Lớp : </td>
        <td>
            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
                onselectedindexchanged="Button1_Click" />
            
        </td>
        <td>
            <asp:Label ID="Label3" runat="server" Text=""></asp:Label>
		</td>
    </tr>
    <tr>
        <td>
            </td>
        <td >
            </td>
        <td>
            &nbsp;</td>
    </tr>
</table>
<br />
    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
    <br />
    <em><span class="style2">Ghi chú về kỳ thi :</span></em>
    <br />
    <hr />
    <br />
    <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
</ContentTemplate>
</asp:UpdatePanel>