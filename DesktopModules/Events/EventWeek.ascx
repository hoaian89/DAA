<%@ Register TagPrefix="cc1" Namespace="DotNetNuke.Events.ScheduleControl" Assembly="DotNetNuke.Events.ScheduleControl" %>
<%@ Register TagPrefix="evt" TagName="Category" Src="~/DesktopModules/Events/SelectCategory.ascx" %>
<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EventWeek.ascx.vb" Inherits="DotNetNuke.Modules.Events.EventWeek" %>
<%@ Register TagPrefix="evt" TagName="Icons" Src="~/DesktopModules/Events/EventIcons.ascx" %>
<table cellspacing="0" cellpadding="0" width="100%" border="0">
    <tr>
        <td colspan="3">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td style="white-space:nowrap;width:33%" align="center" rowspan="2">
                        &nbsp;
                    </td>
                    <td style="white-space:nowrap;width:33%" align="center">
                        <asp:panel id="pnlDateControls" Runat="server" Visible="True">
                            <asp:LinkButton ID="lnkToday" runat="server" CssClass="CommandButton"> Today</asp:LinkButton>&nbsp;
                            <asp:HyperLink ID="CmdGoToDate" CssClass="CommandButton" runat="server" resourcekey="CmdGoToDate">View Date:</asp:HyperLink>&nbsp;
                            <asp:TextBox ID="txtGoToDate" runat="server" CssClass="NormalTextBox" Width="75px" Font-Size="8pt"></asp:TextBox><asp:Button
                                ID="cmdSelectDate" runat="server" CssClass="CommandButton" resourcekey="cmdSelectDate" Text="Go"></asp:Button>&nbsp;<asp:RequiredFieldValidator
                                    ID="valBadDate" runat="server" CssClass="Normal" Visible="False" EnableViewState="false" ErrorMessage="Invalid Date"
                                    ControlToValidate="txtGoToDate"></asp:RequiredFieldValidator>
                        </asp:panel>
                    </td>
                    <td style="white-space:nowrap;width:33%" align="right" rowspan="2" valign="top">
                        <evt:Icons ID="EventIcons" runat="server"></evt:Icons>
                    </td>
                </tr>
                <tr>
                    <td style="white-space:nowrap;" align="center">
                        <evt:Category id="SelectCategory" runat="server"></evt:Category>
        </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr class="WeekHeader">
        <td style="white-space:nowrap;" align="center">
            <asp:LinkButton ID="lnkPrev" CssClass="WeekNextPrev" runat="server">&lt;&lt;</asp:LinkButton>
        </td>
        <td style="white-space:nowrap;width:66%" align="center">
            <asp:Label ID="lblWeekOf" CssClass="WeekOfTitle" runat="server"></asp:Label>
        </td>
        <td style="white-space:nowrap;" align="center">
            <asp:LinkButton ID="lnkNext" CssClass="WeekNextPrev" runat="server">&gt;&gt;</asp:LinkButton>
        </td>
    </tr>
</table>

<cc1:ScheduleCalendar ID="schWeek" runat="server" Weeks="1" 
    StartDate="2007-01-14" 
    TimeScaleInterval="30" StartTimeField="StartTime" EndTimeField="EndTime" 
    Layout="Vertical" GridLines="None" StartDay="Sunday"
    TimeFieldsContainDate="True" 
    CssClass="WeekTable">
    <ItemTemplate>
        <%#Eval("Icons")%>
        <asp:HyperLink ID="lnkEvent" runat="Server" Text='<%# DataBinder.Eval(Container.DataItem,"Task") %>' 
            NavigateUrl='<%# DataBinder.Eval(Container.DataItem,"URL") %>' Target='<%# DataBinder.Eval(Container.DataItem,"Target") %>'>
        </asp:HyperLink>
    </ItemTemplate>
    <DateStyle CssClass="WeekTitle"></DateStyle>
    <ItemStyle CssClass="WeekItem"></ItemStyle>
    <BackgroundStyle CssClass="WeekBackground"></BackgroundStyle>
    <TimeTemplate>
        <%# Container.DataItem.ToShortTimeString() %>
    </TimeTemplate>
    <TimeStyle CssClass="WeekRangeheader" Wrap="False"></TimeStyle>
</cc1:ScheduleCalendar>
<table width="100%">
    <tr>
        <td style="white-space:nowrap;width:0px" align="center">
            <evt:Icons ID="EventIcons2" runat="server"></evt:Icons>
        </td>
    </tr>
</table>
