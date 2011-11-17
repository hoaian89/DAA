<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EventDetails.ascx.vb" Inherits="DotNetNuke.Modules.Events.EventDetails" %>
<asp:Panel ID="pnlEventsModuleDetails" runat="server">
    <div id="divEventDetails1" runat="server" style="width:90%;text-align:left;" />
    <div id="tabReminder" Runat="server" width="90%">
    <table cellspacing="2" cellpadding="3" border="0" width="90%" style="text-align:left;">
        <tbody>
           <!-- Begin controls -->
            <tr valign="top">
                <td class="SubHead" style="width:35%"><div id="rem1" runat="server" visible="false">
                <asp:Image ID="imgNotify" runat="server" ImageUrl="Images/bell.gif" />&nbsp;
                    <asp:LinkButton ID="cmdNotify" CssClass="CommandButton" runat="server" BorderStyle="none" 
                        resourcekey="cmdNotify">Notify Me for this Event @</asp:LinkButton><br />
		<asp:CheckBox ID="chkReminderRec" resourcekey="chkReminderRec" Visible="false" runat="server" CssClass="SubHead" Text=""></asp:CheckBox></div> 
                </td>
                <td class="SubHead"><div id="rem2" runat="server" visible="false">
                    <asp:TextBox ID="txtUserEmail" CssClass="NormalTextBox" runat="server" Width="199px"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="valEmail" ValidationGroup="EventEmail" runat="server" resourcekey="valEmail" 
                          ControlToValidate="txtUserEmail" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator  ID="valEmail2" ValidationGroup="EventEmail" runat="server" resourcekey="valEmail" 
                          ControlToValidate="txtUserEmail" Display="Dynamic"></asp:RequiredFieldValidator><br />
	            <asp:TextBox ID="txtReminderTime" CssClass="NormalTextBox" runat="server" MaxLength="3" Width="30" Font-Size="8pt">8</asp:TextBox>
                    <asp:DropDownList
                        ID="ddlReminderTimeMeasurement" runat="server" Width="90" Font-Size="8pt" CssClass="NormalTextBox">
                    </asp:DropDownList> <asp:Label ID="lblTimeBefore" resourcekey="lblTimeBefore" runat="server"></asp:Label></div>
		    <div id="rem3" runat="server" visible="false"> <asp:Image ID="imgConfirmation" runat="server" ImageUrl="Images/bell.gif" />
                    <asp:Label ID="lblConfirmation" runat="server"></asp:Label></div>
                </td>
            </tr> 
        </tbody>
    </table>
    </div>
    <div id="divEventDetails2" runat="server" style="width:100%;text-align:left;" />
    <div id="tabEnrollment" Runat="server" width="90%">
    <table cellspacing="2" cellpadding="3" border="0" width="90%" style="text-align:left;">
        <tbody>
            <tr>
                <td class="SubHead" style="width:35%"><div id="enroll1" runat="server" visible="false">
                <asp:Image ID="imgEnroll" runat="server" ImageUrl="Images/enroll.gif" />&nbsp;
                <asp:LinkButton ID="cmdSignup" CssClass="CommandButton" runat="server" BorderStyle="none" 
                        CausesValidation="False">Enroll for this Event?</asp:LinkButton></div>
                </td>
                <td class="SubHead"><div id="enroll2" runat="server" visible="false">
                    <asp:Image ID="imgSignup" runat="server" ImageUrl="Images/enroll.gif" />&nbsp;
                    <asp:Label ID="lblSignup" runat="server">You are not enrolled for this event!</asp:Label></div>
                </td>
            </tr>
        </tbody>
    </table>
    </div>
    <div id="divEventDetails3" runat="server" style="width:100%;text-align:left;" />
    <div id="tabEnrollList" Runat="server" width="90%">
    <table cellspacing="2" cellpadding="3" border="0" width="90%" style="text-align:left;">
        <tbody>
            <tr>
                <td class="SubHead" valign="top" >
                    <asp:Label ID="lblEnrolledUsers" resourcekey="lblEnrolledUsers" runat="server">Enrolled Users</asp:Label>
                </td>
            </tr>
            <tr>
                <td class="SubHead" valign="top" align="center">
                    <div>
                        <asp:DataGrid ID="grdEnrollment" runat="server" AutoGenerateColumns="False" BorderStyle="Outset" BorderWidth="2px" CssClass="Normal"
                            DataKeyField="SignupID" GridLines="Horizontal" Visible="True" Width="100%">
                            <EditItemStyle VerticalAlign="Bottom"></EditItemStyle>
                            <AlternatingItemStyle BackColor="WhiteSmoke"></AlternatingItemStyle>
                            <ItemStyle VerticalAlign="Top"></ItemStyle>
                            <HeaderStyle Font-Bold="True" BackColor="Silver"></HeaderStyle>
                            <Columns>
                                <asp:BoundColumn DataField="EnrollUserName" HeaderText="EnrollUserName"></asp:BoundColumn>
                                <asp:BoundColumn DataField="EnrollDisplayName" HeaderText="EnrollDisplayName"></asp:BoundColumn>
                                <asp:BoundColumn DataField="EnrollEmail" HeaderText="EnrollEmail"></asp:BoundColumn>
                                <asp:BoundColumn DataField="EnrollPhone" HeaderText="EnrollPhone"></asp:BoundColumn>
                                <asp:TemplateColumn headerText="EnrollApproved">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkEnrollApproved" runat="server" Enabled="false" Checked='<%# DataBinder.Eval(Container.DataItem,"EnrollApproved") %>'/>
                                </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns>
                        </asp:DataGrid>
                    </div>
                </td>
                        </tr>
        </tbody>
    </table>
    </div>
    <div id="divEventDetails4" runat="server" style="width:100%;text-align:left;" />
    <table cellspacing="2" cellpadding="3" border="0" width="100%" style="text-align:left">
        <tbody>
            <tr valign="top">
                <td align="right" class="Normal">
                    <br />
                    <asp:Label ID="lblvEventExport" runat="server" resourcekey="plvEventExport">Export to Desktop Event:</asp:Label>&nbsp;
                    <asp:LinkButton ID="cmdvEvent" CssClass="CommandButton" runat="server" BorderStyle="none" Text="Event" resourcekey="cmdvEvent" CausesValidation="False">Single</asp:LinkButton>&nbsp;&nbsp;
                    <asp:LinkButton ID="cmdvEventSeries" CssClass="CommandButton" runat="server" BorderStyle="none" Text="Event series" resourcekey="cmdvEventSeries" CausesValidation="False">Series</asp:LinkButton>
                </td>
            </tr>
            <tr valign="top">
                <td>
                    <br />
                    <asp:LinkButton ID="returnButton" CssClass="CommandButton" runat="server" BorderStyle="none" Text="Delete this item" resourcekey="returnButton" CausesValidation="False">Return</asp:LinkButton>
                    &nbsp;
                    <asp:LinkButton ID="editButton" CssClass="CommandButton" runat="server" BorderStyle="none" Text="Edit this item" resourcekey="editButton" CausesValidation="False">Edit</asp:LinkButton>
                    &nbsp;
                    <asp:LinkButton ID="editSeriesButton" CssClass="CommandButton" runat="server" BorderStyle="none" Text="Edit this series" resourcekey="editSeriesButton" CausesValidation="False" Visible="False">Edit Series</asp:LinkButton>
                    &nbsp;
                    <asp:LinkButton ID="deleteButton" CssClass="CommandButton" runat="server" BorderStyle="none" Text="Delete this item" resourcekey="deleteButton" CausesValidation="False">Delete</asp:LinkButton>
                    &nbsp;
                    <asp:LinkButton ID="deleteSeriesButton" CssClass="CommandButton" runat="server" BorderStyle="none" Text="Delete this series" resourcekey="deleteSeriesButton" CausesValidation="False" Visible="False">Delete Series</asp:LinkButton>
                    &nbsp;
                    <asp:DropDownList ID="cboTimeZone" runat="server" Visible="False" CssClass="NormalTextBox" Font-Size="8pt"/>
                </td>
            </tr>
        </tbody>
    </table>
</asp:Panel>
