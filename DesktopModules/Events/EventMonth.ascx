<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EventMonth.ascx.vb" Inherits="DotNetNuke.Modules.Events.EventMonth" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Events.WebControls" Assembly="DotNetNuke.Events.WebControls" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="evt" TagName="Category" Src="~/DesktopModules/Events/SelectCategory.ascx" %>
<%@ Register TagPrefix="evt" TagName="Icons" Src="~/DesktopModules/Events/EventIcons.ascx" %>
<div>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td style="white-space:nowrap;width:33%" align="center" rowspan="2">
                &nbsp;
            </td>
            <td style="white-space:nowrap;width:33%;" align="center">
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
                <evt:Category ID="SelectCategory" runat="server">
                </evt:Category>
            </td>
        </tr>
        <tr>
            <td style="white-space:nowrap;" align="center" colspan="3">
                <dnn:DNNCalendar ID="EventCalendar" runat="server" CssClass="Event" CellPadding="0" NextPrevFormat="FullMonth" DayStyle-VerticalAlign="Top"
                    PrevMonthText=" " NextMonthText=" " ShowGridLines="True" SelectMonthText=" " SelectWeekText=" " >
                    <TodayDayStyle HorizontalAlign="Center" CssClass="EventTodayDay" VerticalAlign="Top"></TodayDayStyle>
                    <SelectorStyle HorizontalAlign="Center" CssClass="EventSelector" VerticalAlign="Top"></SelectorStyle>
                    <DayStyle HorizontalAlign="Center" CssClass="EventDay" VerticalAlign="Top"></DayStyle>
                    <NextPrevStyle HorizontalAlign="Center" CssClass="EventNextPrev" VerticalAlign="Top"></NextPrevStyle>
                    <DayHeaderStyle HorizontalAlign="Center" CssClass="EventDayHeader" VerticalAlign="Top"></DayHeaderStyle>
                    <SelectedDayStyle HorizontalAlign="Center" CssClass="EventSelectedDay" VerticalAlign="Top"></SelectedDayStyle>
                    <TitleStyle HorizontalAlign="Center" CssClass="EventTitle" VerticalAlign="Middle"></TitleStyle>
                    <WeekendDayStyle HorizontalAlign="Center" CssClass="EventWeekendDay" VerticalAlign="Top"></WeekendDayStyle>
                    <OtherMonthDayStyle HorizontalAlign="Center" CssClass="EventOtherMonthDay" VerticalAlign="Top"></OtherMonthDayStyle>
                </dnn:DNNCalendar>
            </td>
        </tr>
        <tr>
            <td style="white-space:nowrap;width:0px" align="center" colspan="3">
                <evt:Icons ID="EventIcons2" runat="server"></evt:Icons>
            </td>
        </tr>
    </table>
</div>
