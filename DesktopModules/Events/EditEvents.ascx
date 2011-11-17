<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EditEvents.ascx.vb" Inherits="DotNetNuke.Modules.Events.EditEvents" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<%@ Register TagPrefix="dnn" TagName="URL" Src="~/controls/URLControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<asp:Panel ID="pnlEventsModuleEdit" runat="server">
<style type="text/css">
    .CalIcon {cursor:pointer;}
</style>
<table id="tblMain" cellpadding="2" cellspacing="2" width="85%" border="0">
    <tr>
        <td class="SubHead" valign="top">
            <dnn:SectionHead ID="dshEventSettings" ResourceKey="EventSettings" IncludeRule="True" Section="tblEvent" Text="Event Settings"
                CssClass="Head" runat="server">
            </dnn:SectionHead>
            <table id="tblEvent" width="100%" cellpadding="2" cellspacing="2" runat="server">
                <tr>
                    <td class="SubHead"  style="width: 150px;">
                        <dnn:Label ID="lblTitle" runat="server">
                        </dnn:Label>
                    </td>
                    <td class="SubHead">
                        <asp:TextBox ID="txtTitle" CssClass="NormalTextBox" runat="server" MaxLength="100" Columns="30" Width="250px" Font-Size="8pt"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="valRequiredTitle" runat="server" CssClass="Normal" resourcekey="valRequiredTitle" ControlToValidate="txtTitle"></asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="valConflict" runat="server" CssClass="Normal"  
                                ControlToValidate="txtP1Every" Visible="False" EnableViewState="false"></asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="valLocationConflict" runat="server" CssClass="Normal" 
                                ControlToValidate="txtP1Every" Visible="False" EnableViewState="false"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="SubHead" valign="top">
                        <dnn:Label ID="lblAllDayEvent" runat="server"></dnn:Label>
                    </td>
                    <td class="SubHead" valign="top" style="white-space:nowrap;">
                        <asp:CheckBox ID="chkAllDayEvent" runat="server" CssClass="SubHead" ></asp:CheckBox>
                    </td>
                </tr>
                <tr>
                    <td class="SubHead">
                        <dnn:Label ID="lblStartDateTime" runat="server">
                        </dnn:Label>
                    </td>
                    <td class="SubHead">
                        <asp:TextBox ID="txtStartDate" runat="server" Font-Size="8pt" CssClass="NormalTextBox" Width="74px"></asp:TextBox>
                        <asp:Image ID="imgStartDate" runat="server" cssclass="CalIcon" EnableViewState="False" ImageUrl="~/DesktopModules/Events/Images/SmallCalendar.gif"></asp:Image>
                        <asp:DropDownList ID="cmbStartTime" runat="server" Font-Size="8pt" CssClass="NormalTextBox" Width="80px"></asp:DropDownList>
                        <asp:RequiredFieldValidator ID="valRequiredStartDate" runat="server" Display="Dynamic" CssClass="Normal" resourcekey="valRequiredStartDate" ControlToValidate="txtStartDate" EnableViewState="false" ValidationGroup="startdate" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:CompareValidator id="valValidStartDate" Operator="GreaterThanEqual" Display="Dynamic" ControlToValidate="txtStartDate"  
                            type="Date" resourcekey="valValidStartDate" runat="server" ValidationGroup="startdate" SetFocusOnError="True"></asp:CompareValidator>
                        <asp:RequiredFieldValidator ID="valValidRecurStartDate" runat="server" CssClass="Normal" resourcekey="valValidRecurStartDate" 
                                ControlToValidate="txtStartDate" Visible="False" EnableViewState="false"></asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="valValidRecurStartDate2" runat="server" CssClass="Normal" resourcekey="valValidRecurStartDate2" 
                                ControlToValidate="txtStartDate" Visible="False" EnableViewState="false"></asp:RequiredFieldValidator>
                        <asp:LinkButton ID="btnCopyStartdate" resourcekey="btnCopyStartdate" runat="server"  text="Copy to enddate." CssClass="CommandButton" BorderStyle="none" CausesValidation="False"/>
                    </td>
                </tr>
                <tr>
                    <td class="SubHead">
                        <dnn:Label ID="lblEndDateTime" runat="server">
                        </dnn:Label>
                    </td>
                    <td class="SubHead">
                        <asp:TextBox ID="txtEndDate" runat="server" Font-Size="8pt" CssClass="NormalTextBox" Width="74px"></asp:TextBox>
                        <asp:Image ID="imgEndDate" runat="server" EnableViewState="False" cssclass="CalIcon" ImageUrl="~/DesktopModules/Events/Images/SmallCalendar.gif"></asp:Image>
                        <asp:DropDownList ID="cmbEndTime" runat="server" Font-Size="8pt" CssClass="NormalTextBox" Width="80px"></asp:DropDownList>
                        <asp:RequiredFieldValidator ID="valRequiredEndDate" runat="server" Display="Dynamic" CssClass="Normal" resourcekey="valRequiredEndDate" ControlToValidate="txtEndDate" EnableViewState="false"></asp:RequiredFieldValidator>
                        <asp:CompareValidator id="valValidEndDate" Operator="GreaterThanEqual" Display="Dynamic" ControlToValidate="txtEndDate" ControlToCompare ="txtStartDate" 
                            type="Date" resourcekey="valValidEndDate" runat="server"></asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td class="SubHead" valign="top">
                        <dnn:Label ID="lblDisplayEndDate" runat="server"></dnn:Label>
                    </td>
                    <td class="SubHead" valign="top" style="white-space:nowrap;">
                        <asp:CheckBox ID="chkDisplayEndDate" runat="server" CssClass="SubHead" ></asp:CheckBox>
                    </td>
                </tr>
                <tr ID="trTimeZone" runat="server" visible="false">
                    <td class="SubHead" valign="top">
                        <dnn:Label ID="lblTimeZone" runat="server">
                        </dnn:Label>
                    </td>
                    <td class="SubHead">
                        <asp:Label ID="lblEventTimeZone" runat="server" CssClass="Normal"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="SubHead" valign="top">
                        <dnn:Label ID="lblImportance" runat="server">
                        </dnn:Label>
                    </td>
                    <td class="SubHead">
                        <asp:DropDownList ID="cmbImportance" runat="server" Font-Size="8pt" CssClass="NormalTextBox">
                            <asp:ListItem resourcekey="Low" Value="3">Low</asp:ListItem>
                            <asp:ListItem resourcekey="Normal" Value="2" Selected="True">Normal</asp:ListItem>
                            <asp:ListItem resourcekey="High" Value="1">High</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="SubHead" valign="top">
                        <dnn:Label ID="lblCategory" runat="server">
                        </dnn:Label>
                    </td>
                    <td class="SubHead">
                        <asp:DropDownList ID="cmbCategory" runat="server" Font-Size="8pt" CssClass="NormalTextBox" Width="184px">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="SubHead" valign="top">
                        <dnn:Label ID="lblLocation" runat="server">
                        </dnn:Label>
                    </td>
                    <td class="SubHead">
                        <asp:DropDownList ID="cmbLocation" runat="server" Font-Size="8pt" CssClass="NormalTextBox" Width="184px">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr id="trCustomField1" runat="server">
	                <td class="SubHead">
		                <dnn:label id="lblCustomField1" runat="server"></dnn:label></td>
	                <td class="SubHead">
		                <asp:textbox id="txtCustomField1" runat="server" cssclass="NormalTextBox" width="250px"
			                Columns="30" maxlength="100"></asp:textbox></td>
                </tr>
                <tr id="trCustomField2" runat="server">
	                <td class="SubHead">
		                <dnn:label id="lblCustomField2" runat="server"></dnn:label></td>
	                <td class="SubHead">
		                <asp:textbox id="txtCustomField2" runat="server" cssclass="NormalTextBox"  width="250px"
			                Columns="30" maxlength="100"></asp:textbox></td>
                </tr>
                <tr id="trOwner" runat="server">
                    <td class="SubHead" valign="top">
                        <dnn:Label ID="lblOwner" runat="server">
                        </dnn:Label>
                    </td>
                    <td class="SubHead">
                        <asp:DropDownList ID="cmbOwner" runat="server" Font-Size="8pt" CssClass="NormalTextBox" Width="184px">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td colspan=2 class="SubHead" valign="top">
                        <dnn:Label ID="lblNotes" runat="server">
                        </dnn:Label>
                    </td>
                </tr>
                <tr>
                    <td class="SubHead" valign="top" colspan="2">
                        <dnn:TextEditor ID="ftbDesktopText" runat="server" Width="600" Height="400">
                        </dnn:TextEditor>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="SubHead" valign="top">
            <asp:Panel ID="pnlDetailPage" runat="server" Width="100%">
                <hr />
                <table id="tblDetailPage" width="100%" cellpadding="0" cellspacing="0" border="0" runat="server">
                    <tr>
                        <td>
                            <table id="tblDetailPageChk" width="100%" cellpadding="2" cellspacing="2" border="0" runat="server">
                                <tr>
                                    <td class="SubHead" valign="top" style="width:160px;">
                                        <dnn:Label ID="lblDetailPage" runat="server"></dnn:Label>
                                    </td>
                                    <td class="SubHead" valign="top" style="white-space:nowrap;">
                                        <asp:CheckBox ID="chkDetailPage" runat="server" CssClass="SubHead" ></asp:CheckBox>
                                    </td>
                                </tr>
                            </table>
                            <table id="tblDetailPageDetail" width="100%" cellpadding="2" cellspacing="2" border="0" runat="server">
                                <tr>
                                    <td class="SubHead" valign="top"  style="width:160px;">
                                        <dnn:Label ID="lblDetailURL" runat="server"></dnn:Label>
                                    </td>
                                    <td class="SubHead" valign="top" style="white-space:nowrap;">
                                        <dnn:URL ID="URLDetail" runat="server" Width="300" ShowFiles="False" ShowUrls="True" ShowNewWindow="True" ShowTrack="False"
                                            ShowLog="False" UrlType="U" ShowTabs="True"></dnn:URL>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
    </tr>
    <tr>
        <td class="SubHead" valign="top">
            <asp:Panel ID="pnlReminder" runat="server" Width="100%">
                <hr />
                <table id="tblReminder" width="100%" cellpadding="0" cellspacing="0" border="0" runat="server">
                    <tr>
                        <td>
                            <table id="tblReminderChk" width="100%" cellpadding="2" cellspacing="2" border="0" runat="server">
                                <tr>
                                    <td class="SubHead" valign="top" style="width:160px;">
                                        <dnn:Label ID="lblSendReminder" runat="server"></dnn:Label>
                                    </td>
                                    <td class="SubHead" valign="top" style="white-space:nowrap;">
                                        <asp:CheckBox ID="chkReminder" runat="server" CssClass="SubHead"></asp:CheckBox>
                                    </td>
                                </tr>
                            </table>
                            <table id="tblReminderDetail" width="100%" cellpadding="2" cellspacing="2" border="0" runat="server">
                                <tr>
                                    <td class="SubHead" valign="top" style="width:160px;">
                                        <dnn:Label ID="lblTimeBefore" runat="server"></dnn:Label>
                                    </td>
                                    <td class="SubHead" style="white-space:nowrap;" valign="top">
                                        <asp:TextBox ID="txtReminderTime" CssClass="NormalTextBox" runat="server" MaxLength="3" Width="50" Font-Size="8pt">8</asp:TextBox><asp:DropDownList
                                                ID="ddlReminderTimeMeasurement" runat="server" Font-Size="8pt" CssClass="NormalTextBox">
                                                <asp:ListItem Value="m" resourcekey="Minutes">Minutes</asp:ListItem>
                                                <asp:ListItem Value="h" resourcekey="Hours" Selected="True">Hours</asp:ListItem>
                                                <asp:ListItem Value="d" resourcekey="Days">Days</asp:ListItem>
                                            </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="valBadReminderTime" runat="server" CssClass="Normal" ErrorMessage="Invalid Reminder Time (1-30 days, 15-60 minutes, 1-24 hours)" resourcekey="valBadReminderTime" 
                                            ControlToValidate="txtReminderTime" Visible="False" EnableViewState="false"></asp:RequiredFieldValidator>                        </td>
                                </tr>
                                <tr>
                                    <td class="SubHead" valign="top">
                                        <dnn:Label ID="lblEmailFrom" runat="server"></dnn:Label>
                                    </td>
                                    <td class="SubHead" valign="top" style="white-space:nowrap;">
                                        <asp:TextBox ID="txtReminderFrom" runat="server" Font-Size="8pt" CssClass="NormalTextBox" Width="157px" MaxLength="100" Wrap="False"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="valEmail" runat="server" ControlToValidate="txtReminderFrom" ErrorMessage="Valid Email Address required" resourcekey="valEmail" 
                                            ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="SubHead" valign="top" style="width:160px;">
                                        <dnn:Label ID="lblNotifyEmailSubject" runat="server"></dnn:Label>
                                    </td>
                                    <td class="SubHead" valign="top" style="white-space:nowrap;">
                                        <asp:TextBox ID="txtSubject" runat="server" Font-Size="8pt" CssClass="NormalTextBox" Width="100%" TextMode="MultiLine" MaxLength="300"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="SubHead" valign="top"  style="width:160px;>
                                        <dnn:Label ID="lblNotifyEmailMessage" runat="server"></dnn:Label>
                                    </td>
                                    <td class="SubHead" valign="top" style="white-space:nowrap;">
                                        <asp:TextBox ID="txtReminder" CssClass="NormalTextBox" runat="server" Font-Size="8pt" Width="100%" Height="80px" TextMode="MultiLine" MaxLength="2048"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
    </tr>
    <tr>
        <td class="SubHead" valign="top">
            <asp:Panel ID="pnlImage" runat="server" Width="100%">
                <hr />
                <table id="tblImage" width="100%" cellpadding="0" cellspacing="0" border="0" runat="server">
                    <tr>
                        <td>
                            <table id="tblImageChk" width="100%" cellpadding="2" cellspacing="2" border="0" runat="server">
                                <tr>
                                    <td class="SubHead" valign="top" style="width:160px;">
                                        <dnn:Label ID="lblDisplayImage" runat="server"></dnn:Label>
                                    </td>
                                    <td class="SubHead" valign="top" style="white-space:nowrap;">
                                        <asp:CheckBox ID="chkDisplayImage" runat="server" CssClass="SubHead"></asp:CheckBox>
                                    </td>
                                </tr>
                            </table>
                            <table id="tblImageURL" width="100%" cellpadding="2" cellspacing="2" border="0" runat="server">
                                <tr>
                                    <td class="SubHead" valign="top"  style="width:160px;">
                                        <dnn:Label ID="lblImageURL" runat="server"></dnn:Label>
                                    </td>
                                    <td class="SubHead" valign="top" style="white-space:nowrap;">
                                        <dnn:URL ID="ctlURL" runat="server" Width="300" ShowFiles="True" ShowUrls="True" ShowNewWindow="False" ShowTrack="False"
                                            ShowLog="False" UrlType="F" ShowTabs="False"></dnn:URL>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="SubHead" valign="top">
                                        <dnn:Label ID="lblWidth" runat="server"></dnn:Label>
                                    </td>
                                    <td class="SubHead" valign="top" style="white-space:nowrap;">
                                        <asp:TextBox ID="txtWidth" runat="server" CssClass="NormalTextBox" Columns="50" Width="37px"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="valWidth" runat="server" ControlToValidate="txtWidth" ErrorMessage="Width must be a valid Integer or Blank" resourcekey="valWidth" 
                                            ValidationExpression="^[1-9]+[0-9]*$"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="SubHead" valign="top">
                                        <dnn:Label ID="lblHeight" runat="server"></dnn:Label>
                                    </td>
                                    <td class="SubHead" valign="top" style="white-space:nowrap;">
                                        <asp:TextBox ID="txtHeight" runat="server" CssClass="NormalTextBox" Columns="50" Width="37px"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="valHeight" runat="server" ControlToValidate="txtHeight" ErrorMessage="Height must be a valid Integer or Blank" resourcekey="valHeight" 
                                            ValidationExpression="^[1-9]+[0-9]*$"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>       
            </asp:Panel>
        </td>
    </tr>
    <tr>
        <td class="SubHead" valign="top">
            <asp:Panel ID="pnlRecurring" runat="server" Width="100%">
                <hr />
                <table id="tblRecurring" width="100%" border="0" cellpadding="0" cellspacing="0" runat="server">
                    <tr>
                        <td>
                            <table id="tblRecurringChk" width="100%" border="0" cellpadding="2" cellspacing="2" runat="server">
                                <tr>
                                    <td class="SubHead" style="width:160px;">
                                        <dnn:Label ID="lblRecEvent" runat="server"></dnn:Label>
                                    </td>
                                    <td class="SubHead">
                                        <asp:CheckBox ID="chkReccuring" runat="server" CssClass="SubHead" ></asp:CheckBox>    <br />                            
                                        <input id="rblRepeatTypeN" type="radio" checked style="display:none;" value="N" name="rblRepeatType" runat="server" />
                                    </td>
                                </tr>
                             </table>
                             <table id="tblRecurringDetails" style="width:100%;" cellpadding="4" cellspacing="2" runat="server">
                                <tr>
                                    <td class="SubHead" colspan="2" style="white-space:nowrap;width:160px;">
                                        <dnn:Label ID="lblEndDate" runat="server"></dnn:Label>
                                    </td>
                                    <td class="SubHead" colspan="3">
                                        <asp:TextBox ID="txtRecurEndDate" runat="server" CssClass="NormalTextBox"></asp:TextBox>
                                        <asp:Image ID="imgRecurEndDate" runat="server" cssclass="CalIcon" EnableViewState="False" ImageUrl="~/DesktopModules/Events/Images/SmallCalendar.gif">
                                        </asp:Image>
                                        <asp:RequiredFieldValidator ID="valRequiredRecurEndDate" runat="server" ControlToValidate="txtRecurEndDate" resourcekey="valRequiredRecurEndDate" 
                                            CssClass="Normal" EnableViewState="false" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:CompareValidator ID="valValidRecurEndDate" runat="server" ControlToValidate="txtRecurEndDate" ControlToCompare="txtStartDate" resourcekey="valValidRecurEndDate" 
                                            CssClass="Normal" EnableViewState="false" EnableClientScript="False" Display="Dynamic" Operator="GreaterThanEqual" Type="Date"></asp:CompareValidator>
                                        <asp:RequiredFieldValidator ID="valValidRecurEndDate2" runat="server" CssClass="Normal" resourcekey="valValidRecurEndDate2" 
                                                ControlToValidate="txtRecurEndDate" Visible="False" EnableViewState="false"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="5" style="height:10px;"><hr /></td>
                                </tr>
                                <tr>
                                    <td class="SubHead" style="width:10px;">
                                        &nbsp;</td>
                                    <td class="SubHead">
                                        <dnn:Label ID="lblPeriodicEvent" runat="server"></dnn:Label>
                                    </td>
                                    <td class="SubHead">
                                        <input id="rblRepeatTypeP1" type="radio" value="P1" name="rblRepeatType" runat="server">
                                    </td>
                                    <td class="SubHead">
                                        &nbsp;</td>
                                    <td class="SubHead">
                                        <table ID="tblDetailP1" runat="server" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td class="SubHead" style="text-align: left">
                                                    <asp:Label ID="lblEvery" runat="server" CssClass="SubHead" 
                                                        resourcekey="lblEvery">Repeated every:</asp:Label>
                                                    <asp:TextBox ID="txtP1Every" runat="server" Columns="3" 
                                                        CssClass="NormalTextBox" MaxLength="3" Width="31px">1</asp:TextBox>
                                                    <asp:DropDownList ID="cmbP1Period" runat="server" CssClass="NormalTextBox">
                                                        <asp:ListItem resourcekey="Days" Selected="True" Value="D">Day(s)</asp:ListItem>
                                                        <asp:ListItem resourcekey="Weeks" Value="W">Week(s)</asp:ListItem>
                                                        <asp:ListItem resourcekey="Months" Value="M">Month(s)</asp:ListItem>
                                                        <asp:ListItem resourcekey="Years" Value="Y">Year(s)</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:RangeValidator ID="valP1Every" runat="server" 
                                                        ControlToValidate="txtP1Every" MinimumValue="1" Display="Dynamic" MaximumValue="999" Type="Integer" CssClass="Normal" EnableViewState="false" 
                                                       resourcekey="valP1Every" EnableClientScript="False"></asp:RangeValidator>
                                                    <asp:RequiredFieldValidator ID="valP1Every2" runat="server" ControlToValidate="txtP1Every" resourcekey="valP1Every" 
                                                        CssClass="Normal" EnableViewState="false" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td class="SubHead">
                                        &nbsp;</td>
                                    <td class="SubHead" valign="middle">
                                        <dnn:Label ID="lblWeeklyEvent" runat="server"></dnn:Label>
                                    </td>
                                    <td class="SubHead">
                                        <input id="rblRepeatTypeW1" type="radio" value="W1" name="rblRepeatType" runat="server">
                                    </td>
                                    <td class="SubHead">
                                        &nbsp;</td>
                                    <td class="SubHead">
                                        <table ID="tblDetailW1" runat="server" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td class="SubHead" style="text-align: left">
                                                    <asp:Label ID="lblRepetitionWeek" runat="server" CssClass="SubHead" 
                                                        resourcekey="lblRepetitionWeek">Repetition frequency (weeks):</asp:Label>
                                                    <asp:TextBox ID="txtW1Every" runat="server" Columns="3" 
                                                        CssClass="NormalTextBox" MaxLength="2" Width="31px">1</asp:TextBox>
                                                    
                                                    <asp:RangeValidator ID="valW1Day" runat="server" Display="Dynamic" 
                                                        ControlToValidate="txtW1Every" MinimumValue="1" MaximumValue="99" Type="Integer" CssClass="Normal" EnableViewState="false" 
                                                        resourcekey="valW1Day" EnableClientScript="False"></asp:RangeValidator>
                                                    <asp:RequiredFieldValidator ID="valW1Day2" runat="server" ControlToValidate="txtW1Every" resourcekey="valW1Day" 
                                                        CssClass="Normal" EnableViewState="false" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>
                                                       
                                                    <br/>
                                                    <asp:Label ID="lblWeekDays" runat="server" resourcekey="lblWeekDays">On:</asp:Label><asp:CheckBox ID="chkW1Sun" runat="server" CssClass="SubHead" Text="Sun" />
                                                    &nbsp;
                                                    <asp:CheckBox ID="chkW1Mon" runat="server" CssClass="SubHead" Text="Mon" />
                                                    &nbsp;
                                                    <asp:CheckBox ID="chkW1Tue" runat="server" CssClass="SubHead" Text="Tue" />
                                                    &nbsp;
                                                    <asp:CheckBox ID="chkW1Wed" runat="server" CssClass="SubHead" Text="Wed" />
                                                    &nbsp;
                                                    <asp:CheckBox ID="chkW1Thu" runat="server" CssClass="SubHead" Text="Thu" />
                                                    &nbsp;
                                                    <asp:CheckBox ID="chkW1Fri" runat="server" CssClass="SubHead" Text="Fri" />
                                                    &nbsp;
                                                    <asp:CheckBox ID="chkW1Sat" runat="server" CssClass="SubHead" Text="Sat" />
                                                    <br />                                                    
                                                    <asp:RequiredFieldValidator ID="valW1Day3" runat="server" CssClass="Normal"  
                                                        ControlToValidate="txtW1Every" Visible="False" EnableViewState="false"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                     </td>
                                    </tr>
                                    <tr>
                                        <td class="SubHead">
                                            &nbsp;</td>
                                        <td class="SubHead" valign="middle">
                                            <dnn:Label ID="lblMonthlyEvent" runat="server"></dnn:Label>
                                        </td>
                                        <td class="SubHead">
                                            <input id="rblRepeatTypeM" type="radio" value="M" name="rblRepeatType" runat="server">
                                        </td>
                                    
                                        <td class="SubHead">
                                            &nbsp;</td>
                                        <td class="SubHead">

                                        <table ID="tblDetailM1" runat="server" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td class="SubHead" style="width:20px;">
                                                    <input ID="rblRepeatTypeM1" runat="server" name="rblRepeatTypeMM" type="radio" 
                                                        value="M1"> </input></td>
                                                <td class="SubHead" style="text-align: left">
                                                    <asp:Label ID="lblRepeatedOn1" runat="server" CssClass="SubHead" 
                                                        resourcekey="lblRepeatedOn1">Repeated on:</asp:Label>
                                                    <asp:DropDownList ID="cmbM1Every" runat="server" Width="79px">
                                                        <asp:ListItem resourcekey="First" Selected="True" Value="1">First</asp:ListItem>
                                                        <asp:ListItem resourcekey="Second" Value="2">Second</asp:ListItem>
                                                        <asp:ListItem resourcekey="Third" Value="3">Third</asp:ListItem>
                                                        <asp:ListItem resourcekey="Fourth" Value="4">Fourth</asp:ListItem>
                                                        <asp:ListItem resourcekey="Last" Value="5">Last</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:DropDownList ID="cmbM1Period" runat="server" Width="86px">
                                                        <asp:ListItem Value="0">Sunday</asp:ListItem>
                                                        <asp:ListItem Value="1">Monday</asp:ListItem>
                                                        <asp:ListItem Value="2">Tuesday</asp:ListItem>
                                                        <asp:ListItem Value="3">Wednesday</asp:ListItem>
                                                        <asp:ListItem Value="4">Thursday</asp:ListItem>
                                                        <asp:ListItem Value="5">Friday</asp:ListItem>
                                                        <asp:ListItem Value="6">Saturday</asp:ListItem>
                                                    </asp:DropDownList>
                                                 </td>
                                            </tr>
                                            <tr>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td class="SubHead" style="width:20px;">
                                                    <input ID="rblRepeatTypeM2" runat="server" name="rblRepeatTypeMM" type="radio" 
                                                        value="M2"> </input></td>
                                                <td class="SubHead" style="text-align: left">
                                                    <asp:Label ID="lblRepeatedOn2" runat="server" CssClass="SubHead" 
                                                        resourcekey="lblRepeatedOn2">Repeated on day:</asp:Label>
                                                    <asp:DropDownList ID="cmbM2Period" runat="server" Width="58px">
                                                        <asp:ListItem resourcekey="01" Selected="True" Value="1">1st</asp:ListItem>
                                                        <asp:ListItem resourcekey="02" Value="2">2nd</asp:ListItem>
                                                        <asp:ListItem resourcekey="03" Value="3">3rd</asp:ListItem>
                                                        <asp:ListItem resourcekey="04" Value="4">4th</asp:ListItem>
                                                        <asp:ListItem resourcekey="05" Value="5">5th</asp:ListItem>
                                                        <asp:ListItem resourcekey="06" Value="6">6th</asp:ListItem>
                                                        <asp:ListItem resourcekey="07" Value="7">7th</asp:ListItem>
                                                        <asp:ListItem resourcekey="08" Value="8">8th</asp:ListItem>
                                                        <asp:ListItem resourcekey="09" Value="9">9th</asp:ListItem>
                                                        <asp:ListItem resourcekey="10" Value="10">10th</asp:ListItem>
                                                        <asp:ListItem resourcekey="11" Value="11">11th</asp:ListItem>
                                                        <asp:ListItem resourcekey="12" Value="12">12th</asp:ListItem>
                                                        <asp:ListItem resourcekey="13" Value="13">13th</asp:ListItem>
                                                        <asp:ListItem resourcekey="14" Value="14">14th</asp:ListItem>
                                                        <asp:ListItem resourcekey="15" Value="15">15th</asp:ListItem>
                                                        <asp:ListItem resourcekey="16" Value="16">16th</asp:ListItem>
                                                        <asp:ListItem resourcekey="17" Value="17">17th</asp:ListItem>
                                                        <asp:ListItem resourcekey="18" Value="18">18th</asp:ListItem>
                                                        <asp:ListItem resourcekey="19" Value="19">19th</asp:ListItem>
                                                        <asp:ListItem resourcekey="20" Value="20">20th</asp:ListItem>
                                                        <asp:ListItem resourcekey="21" Value="21">21st</asp:ListItem>
                                                        <asp:ListItem resourcekey="22" Value="22">22nd</asp:ListItem>
                                                        <asp:ListItem resourcekey="23" Value="23">23rd</asp:ListItem>
                                                        <asp:ListItem resourcekey="24" Value="24">24th</asp:ListItem>
                                                        <asp:ListItem resourcekey="25" Value="25">25th</asp:ListItem>
                                                        <asp:ListItem resourcekey="26" Value="26">26th</asp:ListItem>
                                                        <asp:ListItem resourcekey="27" Value="27">27th</asp:ListItem>
                                                        <asp:ListItem resourcekey="28" Value="28">28th</asp:ListItem>
                                                        <asp:ListItem resourcekey="29" Value="29">29th</asp:ListItem>
                                                        <asp:ListItem resourcekey="30" Value="30">30th</asp:ListItem>
                                                        <asp:ListItem resourcekey="31" Value="31">31st</asp:ListItem>
                                                    </asp:DropDownList><br/>
                                                    <asp:Label ID="lblRepetitionMonth" runat="server" CssClass="SubHead" 
                                                        resourcekey="lblRepetitionMonth">Repetition frequency (months)</asp:Label>
                                                    <asp:TextBox ID="txtM2Every" runat="server" Columns="3" 
                                                        CssClass="NormalTextBox" Font-Size="8pt" MaxLength="2" Width="31px">1</asp:TextBox>
                                                    <asp:RangeValidator ID="valM2Every" runat="server" Display="Dynamic"
                                                        ControlToValidate="txtM2Every" MinimumValue="1" MaximumValue="99" Type="Integer" CssClass="Normal" EnableViewState="false" 
                                                        resourcekey="valM2Every" EnableClientScript="false"></asp:RangeValidator>
                                                    <asp:RequiredFieldValidator ID="valM2Every2" runat="server" ControlToValidate="txtM2Every" resourcekey="valM2Every" 
                                                        CssClass="Normal" EnableViewState="false" EnableClientScript="False" Display="Dynamic"></asp:RequiredFieldValidator>

                                                </td>
                                            </tr>
                                        </table>
                                     </td>
                                   </tr>
                                   <tr>
                                       <td class="SubHead">
                                            &nbsp;</td>
                                       <td class="SubHead" valign="top">
                                            <dnn:Label ID="lblYearlyEvent" runat="server"></dnn:Label>
                                        </td>
                                        <td class="SubHead">
                                            <input id="rblRepeatTypeY1" type="radio" value="Y1" name="rblRepeatType" runat="server">
                                        </td>
                                        <td class="SubHead">
                                        &nbsp;</td>
                                        <td class="SubHead">
                                        <table ID="tblDetailY1" runat="server" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td class="SubHead" style="text-align: left">
                                                    <asp:Label ID="lblRepeatOnDate" runat="server" CssClass="SubHead" 
                                                        resourcekey="lblRepeatOnDate">Repeated on this date:</asp:Label>
                                                    <asp:TextBox ID="txtY1Period" runat="server" CssClass="NormalTextBox" 
                                                        Width="74px"></asp:TextBox>
                                                    <asp:Image ID="imgY1Period" runat="server" cssclass="CalIcon" EnableViewState="False" 
                                                        ImageUrl="~/DesktopModules/Events/Images/SmallCalendar.gif" />
                                                    <asp:RequiredFieldValidator ID="valRequiredYearEventDate" runat="server" 
                                                        ControlToValidate="txtY1Period" CssClass="Normal" EnableViewState="false" 
                                                        ErrorMessage="Invalid Annual Repeat Date" Display="Dynamic" EnableClientScript="False" resourcekey="valRequiredYearEventDate">
                                                      </asp:RequiredFieldValidator>
                                                    <asp:CompareValidator ID="valValidYearEventDate" runat="server" ControlToValidate="txtY1Period" ControlToCompare="txtStartDate" resourcekey="valValidYearEventDate" 
                                                        CssClass="Normal" EnableClientScript="False" EnableViewState="false" Display="Dynamic" Visible="false" Operator="GreaterThanEqual" Type="Date"></asp:CompareValidator>
                                                        
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>                  
            </asp:Panel>
        </td>   
    </tr>
    <tr>
        <td class="SubHead" valign="top">
            <asp:Panel ID="pnlEnroll" runat="server" Width="100%">
                <hr />
                <table id="tblEnrollment" width="100%" border="0" cellpadding="2" cellspacing="2" runat="server">
                    <tr>
                        <td class="SubHead" valign="top" style="width:160px;">
                            <dnn:Label ID="lblAllowErollment" runat="server"></dnn:Label>
                        </td>
                        <td class="SubHead" valign="top">
                            <asp:CheckBox ID="chkSignups" runat="server" CssClass="SubHead" Visible="False"></asp:CheckBox>
                        </td>
                    </tr>
                 </table>
                 <table id="tblEnrollmentDetails" width="100%" border="0" cellpadding="2" cellspacing="2" runat="server">
                    <tr>
                        <td class="SubHead" valign="top" style="width:160px;">
                            <dnn:Label ID="lblTypeOfEnrollment" runat="server"></dnn:Label>
                        </td>
                        <td class="SubHead" valign="top">
                            <input id="rblFree" type="radio" checked value="FREE" name="rblEnrollType" runat="server"/>&nbsp;
                            <asp:Label ID="lblFree" resourcekey="lblFree" runat="server" CssClass="SubHead">Free</asp:Label><asp:Label ID="lblModerated"
                                resourcekey="lblModerated.Text" runat="server" CssClass="SubHead">(Moderated)</asp:Label>
                            <br/>
                            <input id="rblPaid" type="radio" value="PAID" name="rblEnrollType" runat="server"/>&nbsp;
                            <asp:Label ID="lblPaidFee" resourcekey="lblPaidFee" runat="server" CssClass="SubHead">Paid   Fee:</asp:Label>&nbsp;<asp:TextBox
                                ID="txtEnrollFee" runat="server" Font-Size="8pt" CssClass="NormalTextBox" 
                                Width="56px" MaxLength="8" Wrap="False" style="text-align: right"></asp:TextBox>
                            <asp:Label ID="lblTotalCurrency" runat="server" CssClass="NormalBold"></asp:Label>
                            <br/>
                            <asp:RequiredFieldValidator ID="valBadFee" runat="server" CssClass="Normal" ErrorMessage="Numeric fee > 0.00 required for Paid Enrollment" resourcekey="valBadFee" 
                                ControlToValidate="txtEnrollFee" Visible="False" EnableViewState="false"></asp:RequiredFieldValidator>
                            <asp:RequiredFieldValidator ID="valPayPalAccount" runat="server" CssClass="Normal" ErrorMessage="PayPal Account required for Paid Enrollment" resourcekey="valPayPalAccount" ControlToValidate="txtPayPalAccount"
                                    Visible="False" EnableViewState="false"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="SubHead" valign="top" style="width:160px;">
                            <dnn:Label ID="lblPayPalAccount" runat="server"></dnn:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPayPalAccount" runat="server" Font-Size="8pt" CssClass="NormalTextBox" Width="147px" MaxLength="100" Wrap="False"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="SubHead" valign="top" style="width:160px;">
                            <dnn:Label ID="lblMaxEnrollment" runat="server"></dnn:Label>
                        </td>
                        <td class="SubHead" valign="top">
                            <asp:TextBox ID="txtMaxEnrollment" runat="server" CssClass="NormalTextBox" Width="32px" MaxLength="3">0</asp:TextBox>&nbsp;
                            <asp:Label ID="lblCurrentEnrolled" resourcekey="lblCurrentEnrolled" runat="server" CssClass="SubHead">Currently Enrolled:</asp:Label>
                            &nbsp;<asp:TextBox ID="txtEnrolled" runat="server" Font-Size="8pt" CssClass="SubHead" Width="32px" MaxLength="3" ReadOnly="True" BorderStyle="None">0</asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="SubHead" valign="top" style="width:160px;">
                            <dnn:Label ID="lblEnrollListView" Text="Enroll List on Detail View:" runat="server" ControlName="chkEnrollListView"></dnn:Label>
                        </td>
                        <td class="SubHead" valign="top">
                            <asp:CheckBox ID="chkEnrollListView" runat="server" Checked="False"></asp:CheckBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="SubHead" valign="top" style="width:160px;">
                            <dnn:Label ID="lblEnrollmentRole" runat="server"></dnn:Label>
                        </td>
                        <td class="SubHead" valign="top">
                            <asp:DropDownList ID="ddEnrollRoles" AutoPostBack="True" runat="server" Font-Size="8pt" Width="214px">
                            </asp:DropDownList>
                            <br/>
                            <asp:Label ID="lblEnrollRoleNote" resourcekey="lblEnrollRoleNote" runat="server" CssClass="SubHead">(select "None" for All Registered)</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="SubHead" valign="top">
                            <dnn:Label ID="lblRegUser" runat="server"></dnn:Label>
                        </td>
                        <td class="SubHead">
                            <asp:DropDownList ID="cmbRegUser" runat="server" Font-Size="8pt" CssClass="NormalTextBox" Width="184px">
                            </asp:DropDownList>&nbsp;&nbsp;
                            <asp:LinkButton ID="lnkAddRegUser" resourcekey="lnkAddRegUser" runat="server" CssClass="CommandButton" Text="Add User"
                                BorderStyle="none">Add User</asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td class="SubHead" valign="top" colspan="2">
                            <asp:Label ID="lblEnrolledUsers" resourcekey="lblEnrolledUsers" runat="server">Enrolled Users</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="SubHead" valign="top" colspan="2">
                            <div>
                                <asp:DataGrid ID="grdEnrollment" runat="server" AutoGenerateColumns="False" BorderStyle="Outset" BorderWidth="2px" CssClass="Normal"
                                    DataKeyField="SignupID" GridLines="Horizontal" Visible="False" Width="100%">
                                    <EditItemStyle VerticalAlign="Bottom"></EditItemStyle>
                                    <AlternatingItemStyle BackColor="WhiteSmoke"></AlternatingItemStyle>
                                    <ItemStyle VerticalAlign="Top"></ItemStyle>
                                    <HeaderStyle Font-Bold="True" BackColor="Silver"></HeaderStyle>
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelect" runat="server"></asp:CheckBox>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:BoundColumn DataField="UserName" HeaderText="Enrollee"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="Telephone" HeaderText="Phone"></asp:BoundColumn>
                                        <asp:BoundColumn DataField="Approved" HeaderText="Approved"></asp:BoundColumn>
                                        <asp:TemplateColumn HeaderText="Event Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEventBegin" runat="server" Text='<%# Format(DataBinder.Eval(Container.DataItem,"EventTimeBegin","{0:d}")) %>'>
                                                </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                    </Columns>
                                </asp:DataGrid>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="SubHead" colspan="2">
                            <table id="tblEnrollEmail" cellpadding="2" cellspacing="2" width="100%" border="0" runat="server">
                                <tr>
                                    <td class="SubHead">
                                        <asp:Label ID="lblEmailEnrolledUsers" resourcekey="lblEmailEnrolledUsers" runat="server" CssClass="SubHead">Email Enrolled Users</asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="SubHead">
                                        <asp:LinkButton ID="lnkSelectedEmail" resourcekey="lnkSelectedEmail" runat="server" CssClass="CommandButton" Text="Update"
                                            BorderStyle="none">Email Selected Enrolled Users</asp:LinkButton>&nbsp;&nbsp;
                                        <asp:LinkButton ID="lnkSelectedDelete" resourcekey="lnkSelectedDelete" runat="server" CssClass="CommandButton" Text="Update"
                                            BorderStyle="none">Delete Selected Enrolled Users</asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
    </tr>
    <tr>
        <td class="SubHead" valign="top">
            <hr />
            <asp:LinkButton ID="updateButton" runat="server" CssClass="CommandButton" Text="Update" BorderStyle="none">Update</asp:LinkButton>&nbsp;
            <asp:LinkButton ID="cancelButton" resourcekey="cancelButton" runat="server" CssClass="CommandButton" Text="Cancel" BorderStyle="none"
                CausesValidation="False"></asp:LinkButton>&nbsp;
            <asp:LinkButton ID="deleteButton" runat="server" CssClass="CommandButton" Text="Delete"
                BorderStyle="none" CausesValidation="False">Delete</asp:LinkButton>&nbsp;
            <asp:LinkButton ID="copyButton" runat="server" CssClass="CommandButton" Text="Copy" BorderStyle="none">Copy</asp:LinkButton><br/>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" Width="100%"></asp:ValidationSummary>
        </td>
    </tr>
    <tr>
        <td class="SubHead" valign="top">
            <asp:Panel ID="pnlAudit" Visible="false" HorizontalAlign="Left" runat="server" Width="100%">
                <hr />
                <span class="Normal">
                    <asp:Label ID="lblCreatedBy" runat="server" resourcekey="lblCreatedBy" CssClass="SubHead" Visible="False">Created by:</asp:Label>&nbsp;
                    <asp:Label ID="CreatedBy" runat="server" CssClass="SubHead"></asp:Label>&nbsp;
                    <asp:Label ID="lblOn" runat="server" resourcekey="lblOn" CssClass="SubHead">on</asp:Label>&nbsp;
                    <asp:Label ID="CreatedDate" runat="server" CssClass="SubHead"></asp:Label></span>
            </asp:Panel>
            <asp:DropDownList ID="cboTimeZone" CssClass="NormalTextBox" runat="server" Font-Size="8pt" Visible="False">
            </asp:DropDownList>
        </td>
    </tr>
</table>
</asp:Panel>
