<%@ Control Language="vb" AutoEventWireup="false" Codebehind="EventIcons.ascx.vb" Inherits="DotNetNuke.Modules.Events.EventIcons" %>
<table cellspacing="0" cellpadding="0" border="0">
    <tr>
        <td valign="middle" style="white-space:nowrap;" align="center">
            <asp:Label ID="lblSubscribe" runat="server" CssClass="SubHead" >Subscribe</asp:Label>&nbsp;
            <asp:ImageButton ID="btnSubscribe" runat="server" AlternateText="Subscribe" 
                ImageUrl="~/DesktopModules/Events/Images/false.gif" visible="false" />&nbsp;&nbsp;
            <asp:Image ID="imgBar"  runat="server"
                ImageUrl="~/DesktopModules/Events/Images/cal-bar.gif" visible="true" />&nbsp;&nbsp;
            <asp:ImageButton ID="btnModerate" runat="server" AlternateText="Moderate Events" 
                ImageUrl="~/DesktopModules/Events/Images/moderate.gif" visible="false" />
            <asp:ImageButton ID="btnAdd" runat="server" AlternateText="Add Events" 
                ImageUrl="~/DesktopModules/Events/Images/cal-add.gif" visible="false" />
            <asp:ImageButton ID="btnMonth" runat="server" AlternateText="Month View" 
                ImageUrl="~/DesktopModules/Events/Images/cal-month.gif" visible="false" />
            <asp:ImageButton ID="btnWeek" runat="server" AlternateText="Week View" 
                ImageUrl="~/DesktopModules/Events/Images/cal-week.gif" visible="false" />
            <asp:ImageButton ID="btnList" runat="server" AlternateText="List View" 
                ImageUrl="~/DesktopModules/Events/Images/cal-list.gif" visible="false" />
            <asp:ImageButton ID="btnEnroll" runat="server" AlternateText="My Enrollments" 
                ImageUrl="~/DesktopModules/Events/Images/cal-enroll.gif" visible="false" />
            <asp:ImageButton ID="btnRSS" runat="server" AlternateText="Events RSS" 
                ImageUrl="~/DesktopModules/Events/Images/rss.gif" visible="false" />
        </td>
	</tr>
</table>
