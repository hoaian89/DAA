<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Archive.ascx.vb" Inherits="DotNetNuke.Modules.Blog.Archive" %>

<table>
  <tr>
    <td><asp:label id="lblArchive" runat="server" cssclass="SubHead" ResourceKey="lblArchive">Archive</asp:label>
    </td>
  </tr>
  <tr>
    <td><asp:calendar 
    	id="calMonth" 
        runat="server" 
        cssclass="Normal"
        DayHeaderStyle-CssClass="Blog_Archive_DayHeader"
        DayStyle-CssClass="Blog_Archive_Day"
        NextPrevStyle-CssClass="Blog_Archive_NextPrev"
        OtherMonthDayStyle-CssClass="Blog_Archive_OtherMonth"
        SelectedDayStyle-CssClass="Blog_Archive_SelectedDay"
        SelectorStyle-CssClass="Blog_Archive_Selector"
        TitleStyle-CssClass="Blog_Archive_Title"
        TodayDayStyle-CssClass="Blog_Archive_TodayDay"
        WeekendDayStyle-CssClass="Blog_Archive_WeekendDay">
<TodayDayStyle CssClass="Blog_Archive_TodayDay">
</TodayDayStyle>

<SelectorStyle CssClass="Blog_Archive_Selector">
</SelectorStyle>

<DayStyle CssClass="Blog_Archive_Day">
</DayStyle>

<NextPrevStyle CssClass="Blog_Archive_NextPrev">
</NextPrevStyle>

<DayHeaderStyle CssClass="Blog_Archive_DayHeader">
</DayHeaderStyle>

<SelectedDayStyle CssClass="Blog_Archive_SelectedDay">
</SelectedDayStyle>

<TitleStyle CssClass="Blog_Archive_Title">
</TitleStyle>

<WeekendDayStyle CssClass="Blog_Archive_WeekendDay">
</WeekendDayStyle>

<OtherMonthDayStyle CssClass="Blog_Archive_OtherMonth">
</OtherMonthDayStyle></asp:calendar>
    </td>
  </tr>
  <tr>
    <td><asp:label id="lblMonthly" runat="server" cssclass="SubHead" ResourceKey="lblMonthly">Monthly</asp:label>
    </td>
  </tr>
  <tr>
    <td><asp:datalist id="lstArchiveMonths" runat="server" Width="100%" CssClass="CommandButton" CellPadding="0" CellSpacing="0" BorderWidth="0">
        <itemtemplate>
          <table width="100%" cellpadding="0" cellspacing="0" border="0" align="left">
            <tr>
              <td align="left">
<asp:hyperlink runat="server" id="lnkMonthYear" cssclass="CommandButton" navigateurl="default.aspx"></asp:hyperlink>
              </td>
              <td align="right">
<asp:HyperLink ImageUrl="~/desktopmodules/Blog/Images/feed-icon-12x12.gif" cssclass="CommandButton" Runat="server" ID="lnkBlogRSS" Visible="False" target="_blank"></asp:HyperLink>
              </td>
            </tr>
          </table>
        </itemtemplate>
      </asp:datalist>
    </td>
  </tr>
</table>
