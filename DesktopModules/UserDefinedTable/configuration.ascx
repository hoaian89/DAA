<%@ Import Namespace="DotNetNuke.Modules.UserDefinedTable" %>
<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.Modules.UserDefinedTable.Configuration"
    TargetSchema="http://schemas.microsoft.com/intellisense/ie5" CodeBehind="Configuration.ascx.vb" %>
<%@ Register TagPrefix="Portal" TagName="URL" Src="~/controls/URLControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Modules.UserDefinedTable.Security"
    Assembly="DotNetNuke.Modules.UserDefinedTable" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>

<script language="javascript" type="text/javascript">
    function OpenHelpWindow(url) {
        window.open(url, '', 'width=800, height=800, location=no, menubar=no, resizable=yes, scrollbars=yes, status=no, toolbar=no');
        window.event.returnValue = false;
    }
</script>

<table width="100%">
    <tbody>
        <tr>
            <td colspan="3">
                <dnn:SectionHead ID="dshUDT" CssClass="Head" runat="server" ResourceKey="FnlSchema"
                    IncludeRule="True" Section="udtSection" IsExpanded="True" />
            </td>
        </tr>
        <tr>
            <td width="25">
            </td>
            <td>
                <dnn:SectionHead ID="SectionHead1" CssClass="Head" runat="server" ResourceKey="UdtSettings"
                    IncludeRule="False" Section="udtSection" IsExpanded="True" />
                <div runat="server" id="udtSection" style="margin-top: 10px">
                    <p>
                        <asp:Label runat="server" resourcekey="UdtTeaser" /></p>
                    <asp:DataGrid ID="grdFields" DataKeyField="UserDefinedFieldId" BorderWidth="0px"
                        CellPadding="2" AutoGenerateColumns="False" GridLines="None" CssClass="Normal"
                        runat="server" Width="100%">
                        <Columns>
                            <asp:TemplateColumn>
                                <ItemStyle Wrap="False"></ItemStyle>
                                <ItemTemplate>
                                    <asp:ImageButton ID="cmdEditUserDefinedField" runat="server" CausesValidation="false"
                                        CommandName="Edit" ImageUrl="~/images/edit.gif" AlternateText="Edit" resourcekey="cmdEdit">
                                    </asp:ImageButton>
                                    <asp:ImageButton ID="cmdDeleteUserDefinedField" runat="server" CausesValidation="false"
                                        CommandName="Delete" ImageUrl="~/images/delete.gif" AlternateText="Delete" resourcekey="cmdDelete"
                                        Visible='<%# DataTypeByName(Eval(FieldsTableColumn.Type)).IsUserDefinedField%>' />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:ImageButton ID="cmdSaveUserDefinedField" runat="server" CausesValidation="false"
                                        CommandName="Update" ImageUrl="~/images/save.gif" AlternateText="Save" resourcekey="Save">
                                    </asp:ImageButton>
                                    <asp:ImageButton ID="cmdCancelUserDefinedField" runat="server" CausesValidation="false"
                                        CommandName="Cancel" ImageUrl="~/images/cancel.gif" AlternateText="Cancel" resourcekey="cmdCancel">
                                    </asp:ImageButton>
                                </EditItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Title">
                                <HeaderStyle CssClass="NormalBold" />
                                <ItemStyle CssClass="Normal" Width="35%" />
                                <ItemTemplate>
                                    <asp:Label runat="server" Text='<%# Eval(FieldsTableColumn.Title) %>'
                                        ID="Label1" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label ID="lblFieldTitle" runat="server" />
                                    <input type="hidden" id="hiddenOldFieldTitle" runat="server" value='<%# Eval(FieldsTableColumn.Title) %>' />
                                    <asp:TextBox runat="server" ID="txtFieldTitle" Columns="30" MaxLength="50" Text='<%# Eval(FieldsTableColumn.Title) %>' />
                                </EditItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Type">
                                <HeaderStyle CssClass="NormalBold" />
                                <ItemStyle CssClass="Normal" />
                                <ItemTemplate>
                                    <asp:Label runat="server" Text='<%# GetTypeName(Eval(FieldsTableColumn.Type)) %>' />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label runat="server" Text='<%#DataTypeByName(Eval(FieldsTableColumn.Type)).GetLocalization %>'
                                        Visible='<%# not( DataTypeByName(Eval(FieldsTableColumn.Type)).IsUserDefinedField)%>' />
                                    <input type="hidden" id="hiddenOldFieldType" runat="server" value='<%# Eval(FieldsTableColumn.Type) %>' />
                                    <asp:Label ID="lblFieldType" runat="server" Visible='<%# DataTypeByName(Eval(FieldsTableColumn.Type)).IsUserDefinedField()%>' />
                                    <asp:DropDownList ID="cboFieldType" runat="server" CssClass="NormalTextBox" DataSource='<%#  CType(IIf(DataTypeByName(Eval("FieldType")).IsUserDefinedField, ContentDataTypes, SystemDataTypes), Generic.IDictionary(Of String, String))  %>'
                                        Visible='<%# DataTypeByName(Eval("FieldType")).IsUserDefinedField%>'
                                        SelectedValue='<%# DataTypeByName(Eval(FieldsTableColumn.Type)).Name %>'
                                        DataTextField="Key" DataValueField="Value" />
                                    <asp:LinkButton ID="cmdChangeFieldType" runat="server" Text="" CommandName="FieldTypeChanged" />
                                </EditItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Required">
                                <HeaderStyle HorizontalAlign="Center" CssClass="NormalBold"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Center" CssClass="Normal"></ItemStyle>
                                <ItemTemplate>
                                    <asp:Image runat="server" ImageUrl='<%# IIf(Eval("Required") = True, "~/images/checked.gif", "~/images/unchecked.gif") %>'
                                        AlternateText='<%# IIf(Eval(FieldsTableColumn.Visible) = True, "1", "0") %>'
                                        ID="Image2" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Image runat="server" ImageUrl='<%# IIf(Eval("Required") = True, "~/images/checked.gif", "~/images/unchecked.gif") %>'
                                        ID="Image1" Visible='<%# not(DataTypeByName(Eval(FieldsTableColumn.Type)).IsUserDefinedField())%>' />
                                    <asp:Label ID="lblRequired" runat="server" Visible='<%# DataTypeByName(Eval(FieldsTableColumn.Type)).IsUserDefinedField()%>' />
                                    <asp:CheckBox runat="server" ID="chkRequired" Checked='<%# IIf(Eval("Required") = True, "True", "False") %>'
                                        Visible='<%# DataTypeByName(Eval(FieldsTableColumn.Type)).IsUserDefinedField()%>' />
                                </EditItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Visible">
                                <HeaderStyle HorizontalAlign="Center" CssClass="NormalBold" />
                                <ItemStyle HorizontalAlign="Center" CssClass="Normal" />
                                <ItemTemplate>
                                    <asp:Image runat="server" AlternateText='<%# IIf(Eval(FieldsTableColumn.Visible) = True, "1", "0") %>'
                                        ImageUrl='<%# IIf(Eval(FieldsTableColumn.Visible) = True, "~/images/checked.gif", "~/images/unchecked.gif") %>'
                                        ID="Image3" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label ID="lblVisible" runat="server" />
                                    <asp:CheckBox runat="server" ID="chkVisible" Checked='<%# IIf(Eval(FieldsTableColumn.Visible) = True, "True", "False") %>' />
                                </EditItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Private">
                                <HeaderStyle HorizontalAlign="Center" CssClass="NormalBold" />
                                <ItemStyle HorizontalAlign="Center" CssClass="Normal" />
                                <ItemTemplate>
                                    <asp:Image runat="server" AlternateText='<%# IIf(Eval(FieldsTableColumn.IsPrivate) = True, "1", "0") %>'
                                        ImageUrl='<%# IIf(Eval(FieldsTableColumn.IsPrivate) = True, "~/images/checked.gif", "~/images/unchecked.gif") %>' />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label ID="lblIsPrivate" runat="server" />
                                    <asp:CheckBox runat="server" ID="chkIsPrivate" Checked='<%# IIf(Eval(FieldsTableColumn.IsPrivate) = True, "True", "False") %>' />
                                </EditItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn HeaderText="Searchable">
                                <HeaderStyle HorizontalAlign="Center" CssClass="NormalBold" />
                                <ItemStyle HorizontalAlign="Center" CssClass="Normal" />
                                <ItemTemplate>
                                    <asp:Image runat="server" AlternateText='<%# IIf(Eval(FieldsTableColumn.Visible) = True, "1", "0") %>'
                                        ImageUrl='<%# IIf(Eval("Searchable") = True, "~/images/checked.gif", "~/images/unchecked.gif") %>'
                                        Visible="<%# DataTypeByName(Eval(FieldsTableColumn.Type)).SupportsSearch()%>"
                                        ID="Image4" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label ID="lblSearchable" runat="server" />
                                    <asp:CheckBox runat="server" ID="chkSearchable" Checked='<%# IIf(Eval("Searchable") = True, "True", "False") %>'
                                        Visible="<%# DataTypeByName(Eval(FieldsTableColumn.Type)).SupportsSearch()%>" />
                                </EditItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn>
                                <ItemTemplate>
                                    <input type="hidden" id="hiddenFieldOrder" runat="server" value='<%# Eval(FieldsTableColumn.Order) %>' />
                                    <asp:ImageButton ID="cmdMoveUserDefinedFieldUp" runat="server" CausesValidation="false"
                                        CommandName="Item" CommandArgument="Up" ImageUrl="~/images/up.gif" AlternateText="Move Field Up"
                                        resourcekey="MoveUp" Visible="<%#Container.ItemIndex>0%>" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn>
                                <ItemTemplate>
                                    <asp:ImageButton ID="cmdMoveUserDefinedFieldDown" runat="server" CausesValidation="false"
                                        CommandName="Item" CommandArgument="Down" ImageUrl="~/images/dn.gif" AlternateText="Move Field Down"
                                        resourcekey="MoveDown" Visible="<%#Container.ItemIndex<RowCount-1%>" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                        </Columns>
                    </asp:DataGrid>
                    <div>
                        <asp:Panel ID="panFieldSettings" runat="server" Visible="False" Width="100%">
                            <br />
                            <fieldset>
                                <legend class="NormalBold">
                                    <asp:Label ID="lblAdvancedFieldSettings" runat="server" resourcekey="AdvancedFieldSettings"></asp:Label>-
                                    <asp:Label ID="lblField" runat="server"></asp:Label></legend>
                                <table width="100%">
                                    <tr id="panInputSettings" runat="server">
                                        <td class="SubHead" valign="top">
                                            <dnn:Label ID="lblInputSettings" runat="server" Suffix=":" ResourceKey="InputSettings">
                                            </dnn:Label>
                                        </td>
                                        <td valign="top">
                                            <asp:TextBox ID="txtInputSettings" runat="server" CssClass="NormalTextBox" Width="400px"
                                                MaxLength="2000"></asp:TextBox>
                                            <asp:DropDownList ID="cboInputSettings" runat="server" CssClass="NormalTextBox" Width="400px"
                                                Visible="False" DataTextField="Key" DataValueField="Value">
                                            </asp:DropDownList>
                                            <asp:RadioButtonList ID="rblListType" runat="server" RepeatDirection="Horizontal"
                                                CssClass="Normal">
                                                <asp:ListItem Selected="True" Value="DropDown" resourcekey="DropDown"></asp:ListItem>
                                                <asp:ListItem Value="RadioButtons" resourcekey="RadioButtons"></asp:ListItem>
                                                <asp:ListItem Value="RadioButtonsHorizontal" resourcekey="RadioButtonsHorizontal"></asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr id="panOutputSettings" runat="server">
                                        <td class="SubHead" valign="top">
                                            <dnn:Label ID="lblOutputSettings" runat="server" Suffix=":" ResourceKey="OutputSettings">
                                            </dnn:Label>
                                        </td>
                                        <td valign="top">
                                            <asp:TextBox ID="txtOutputSettings" runat="server" CssClass="NormalTextBox" Width="400px"
                                                MaxLength="2000"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr id="panNormalizeFlag" runat="server">
                                        <td class="SubHead" valign="top">
                                            <dnn:Label ID="lblNormalizeFlag" runat="server" Suffix=":" ResourceKey="NormalizeFlag">
                                            </dnn:Label>
                                        </td>
                                        <td valign="top">
                                            <asp:CheckBox ID="chkNormalizeFlag" runat="server" Width="100%"></asp:CheckBox>
                                        </td>
                                    </tr>
                                    <tr id="panDefault" runat="server">
                                        <td class="SubHead" valign="top">
                                            <dnn:Label ID="lblDefault" runat="server" Suffix=":" ResourceKey="DefaultValue">
                                            </dnn:Label>
                                        </td>
                                        <td valign="top">
                                            <asp:TextBox ID="txtDefault" runat="server" CssClass="NormalTextBox" Width="400px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr id="panValidationRule" runat="server">
                                        <td class="SubHead" valign="top">
                                            <dnn:Label ID="lblValidationRule" runat="server" ResourceKey="ValidationRule" Suffix=":">
                                            </dnn:Label>
                                        </td>
                                        <td valign="top">
                                            <asp:TextBox ID="txtValidationRule" runat="server" CssClass="NormalTextBox" Width="400px"
                                                MaxLength="512"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr id="panValidationMessage" runat="server">
                                        <td class="SubHead" valign="top">
                                            <dnn:Label ID="lblValidationMessage" runat="server" ResourceKey="ValidationMessage"
                                                Suffix=":"></dnn:Label>
                                        </td>
                                        <td valign="top">
                                            <asp:TextBox ID="txtValidationMessage" runat="server" CssClass="NormalTextBox" Width="400px"
                                                MaxLength="512"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr id="panEditStyle" runat="server">
                                        <td class="SubHead" valign="top">
                                            <dnn:Label ID="lblEditStyle" runat="server" ResourceKey="EditStyle" Suffix=":"></dnn:Label>
                                        </td>
                                        <td valign="top">
                                            <asp:TextBox ID="txtEditStyle" runat="server" CssClass="NormalTextBox" Width="400px"
                                                MaxLength="512"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr id="panHelpText" runat="server">
                                        <td class="SubHead" valign="top">
                                            <dnn:Label ID="lblHelpText" runat="server" ResourceKey="ControlHelpText" Suffix=":">
                                            </dnn:Label>
                                        </td>
                                        <td valign="top">
                                            <asp:TextBox ID="txtHelpText" runat="server" CssClass="NormalTextBox" Width="400px"
                                                MaxLength="512" Height="100px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr id="panShowOnEdit" runat="server">
                                        <td class="SubHead" valign="top">
                                            <dnn:Label ID="lblShowOnEdit" runat="server" ResourceKey="ShowOnEdit" Suffix=":">
                                            </dnn:Label>
                                        </td>
                                        <td valign="top">
                                            <asp:CheckBox ID="chkShowOnEdit" runat="server" Width="400px"></asp:CheckBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </asp:Panel>
                    </div>
                    <p>
                        <dnn:CommandButton ID="cmdAddField" runat="server" CssClass="CommandButton" ResourceKey="cmdAddField"
                            ImageUrl="~/images/add.gif" />
                        &nbsp;
                        <asp:HyperLink ID="hlpToken" CssClass="CommandButton" runat="server" resourcekey="cmdTokensHelp"
                            Visible="False" NavigateUrl="#" />&nbsp;
                        <asp:HyperLink ID="hlpColumns" CssClass="CommandButton" runat="server" resourcekey="cmdColumnsHelp"
                            Visible="False" NavigateUrl="#" />
                    </p>
                    <table cellspacing="2" cellpadding="4" runat="server" width="100%">
                        <colgroup>
                            <col width="30%" />
                            <col width="70%" />
                        </colgroup>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plPrivacy" runat="server" Suffix="" ControlName="chkExcludeFromSearch" />
                            </td>
                            <td valign="top">
                                <asp:CheckBox ID="chkExcludeFromSearch" resourcekey="chkExcludeFromSearch" runat="server"
                                    AutoPostBack="false" />
                            </td>
                        </tr>
                    </table>
                </div>
                <dnn:SectionHead ID="dshSettings" CssClass="Head" runat="server" ResourceKey="Settings"
                    IncludeRule="False" Section="tableSettings" IsExpanded="False" />
                <div style="margin-left: 25px" runat="server" id="tableSettings">
                    <table id="tblSettings" cellspacing="2" cellpadding="4" runat="server" width="100%">
                        <colgroup>
                            <col width="30%" />
                            <col width="70%" />
                        </colgroup>
                        <tr>
                            <td class="Normal" colspan="2">
                                <br />
                                <asp:Label CssClass="SubHead" runat="server" resourcekey="URLSettings" ID="lblURLSettings" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plURLNewWindow" runat="server" Suffix="" ControlName="chkURLNewWindow" />
                            </td>
                            <td valign="top">
                                <asp:CheckBox ID="chkURLNewWindow" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plForceDownload" runat="server" Suffix="" ControlName="chkForceDownload" />
                            </td>
                            <td valign="top">
                                <asp:CheckBox ID="chkForceDownload" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plUrlOptimization" runat="server" Suffix="" ControlName="chkEnableUrlTracking" />
                            </td>
                            <td valign="top">
                                <asp:RadioButtonList ID="rblUrlOptimization" CssClass="NormalTextBox" runat="server"
                                    RepeatDirection="Horizontal">
                                    <asp:ListItem resourcekey="URL_Downloadnumbers" Value="True" Selected="True" />
                                    <asp:ListItem resourcekey="URL_SEO" Value="False" />
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td class="Normal" colspan="3">
                                <br />
                                <asp:Label CssClass="SubHead" runat="server" resourcekey="UserLinkSettings" ID="lblUserLinkSettings" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plUserLinkNewWindow" runat="server" Suffix="" ControlName="chkUserLinkNewWindow" />
                            </td>
                            <td valign="top" colspan="2">
                                <asp:CheckBox ID="chkUserLinkNewWindow" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plUserLinkCaption" runat="server" Suffix="" ControlName="rblUserLinkCaption" />
                            </td>
                            <td valign="top" colspan="2">
                                <asp:RadioButtonList ID="rblUserLinkCaption" CssClass="NormalTextBox" runat="server"
                                    RepeatDirection="Horizontal">
                                    <asp:ListItem resourcekey="DisplayName" Value="DisplayName" Selected="True" />
                                    <asp:ListItem resourcekey="UserName" Value="UserName" />
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plCnCLink" runat="server" Suffix="" ControlName="chkCnCLink" />
                            </td>
                            <td valign="top" colspan="2">
                                <asp:CheckBox ID="chkCnCLink" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="Normal" colspan="2">
                                <br />
                                <asp:Label ID="lblImageViewSettings" CssClass="SubHead" resourcekey="ImageViewSettings"
                                    runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plImageWidth" runat="server" Suffix=":" ControlName="txtImagewidth" />
                            </td>
                            <td class="Normal" valign="top">
                                <asp:TextBox ID="txtImageWidth" CssClass="NormalTextBox" runat="server" Width="50px"
                                    Style="text-align: right" />&nbsp;px
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plImageHeight" runat="server" Suffix=":" ControlName="txtImageheight" />
                            </td>
                            <td class="Normal" valign="top">
                                <asp:TextBox ID="txtImageHeight" CssClass="NormalTextBox" runat="server" Width="50px"
                                    Style="text-align: right" />&nbsp;px
                            </td>
                        </tr>
                          <tr>
                            <td class="Normal" colspan="2">
                                <br />
                                <asp:Label CssClass="SubHead" runat="server" resourcekey="CalculatedColumnSettings" ID="Label2" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plCalculatedColumnInForm" runat="server" Suffix="" ControlName="chkCalculatedColumnInForm" />
                            </td>
                            <td valign="top">
                                <asp:CheckBox ID="chkCalculatedColumnInForm" runat="server" />
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            <td width="25">
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <br />
                <dnn:SectionHead ID="dshListForms" CssClass="Head" runat="server" ResourceKey="BehaviorSettings"
                    IncludeRule="True" Section="tblListForms" IsExpanded="True" />
            </td>
        </tr>
        <tr>
            <td width="25">
            </td>
            <td>
                <div>
                    <table id="tblListForms" cellspacing="2" cellpadding="4" runat="server" width="100%">
                        <colgroup>
                            <col width="30%" />
                            <col width="70%" />
                        </colgroup>
                        <tr>
                            <td class="SubHead" valign="top" style="white-space: nowrap">
                                <dnn:Label ID="lblList" runat="server" Suffix="" ResourceKey="plUsage" ControlName="rblList" />
                            </td>
                            <td valign="top">
                                <p>
                                    <asp:RadioButtonList ID="rblUsageListForm" runat="server" CssClass="Normal" AutoPostBack="true"
                                        RepeatDirection="Horizontal" RepeatLayout="Flow">
                                        <asp:ListItem Value="List" resourcekey="ListMode"></asp:ListItem>
                                        <asp:ListItem Value="Form" resourcekey="FormMode"></asp:ListItem>
                                        <asp:ListItem Value="FormAndList" resourcekey="FormAndListMode"></asp:ListItem>
                                        <asp:ListItem Value="ListAndForm" resourcekey="ListAndFormMode"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </p>
                                <ul>
                                    <li class="NormalRed" runat="server" id="liRememberSettings">
                                        <asp:Label ID="lblRememberSettings" resourcekey="RememberSettings" runat="server" />
                                    </li>
                                   
                                </ul>
                            </td>
                        </tr>
                        <tr runat="server" id="rowListViewPermission" visible="false">
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plListViewPermission" runat="server" Suffix="" ControlName="chkListViewPermission" />
                            </td>
                            <td valign="top">
                                <asp:CheckBox ID="chkListViewPermission" resourcekey="chkListViewPermission" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plEnableEmail" runat="server" Suffix="" ControlName="chktracking" />
                            </td>
                            <td valign="top">
                                <asp:CheckBox ID="chkTracking" resourcekey="chkEnableEmail" runat="server" AutoPostBack="true" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plEnableCssLayout" runat="server" Suffix="" ResourceKey="plTableFreeForm"
                                    ControlName="rblTableFreeForm" />
                            </td>
                            <td valign="top">
                                <asp:RadioButtonList runat="server" ID="rblTableFreeForm" AutoPostBack="true" RepeatDirection="Horizontal"
                                    RepeatLayout="Flow">
                                    <asp:ListItem Value="False" resourcekey="lblFormTable"></asp:ListItem>
                                    <asp:ListItem Value="True" resourcekey="lblFormDiv"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="lblUseButtons" runat="server" ResourceKey="lblUseButtons" ControlName="rblFormLinksOrButtons"
                                    runat="server" />
                            </td>
                            <td>
                                <asp:RadioButtonList runat="server" ID="rblFormLinksOrButtons" AutoPostBack="true"
                                    RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Value="False" resourcekey="lblFormLinks"></asp:ListItem>
                                    <asp:ListItem Value="True" resourcekey="lblFormButtons"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plControlWidth" runat="server" Suffix="" ControlName="rblControlWidth"
                                    ResourceKey="ControlWidth" />
                            </td>
                            <td valign="top" colspan="2">
                                <asp:RadioButtonList ID="rblControlWidth" CssClass="NormalTextBox" runat="server"
                                    RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem resourcekey="ClassicWidth" Value="ClassicWidth" />
                                    <asp:ListItem resourcekey="FullWidth" Value="FullWidth" />
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                    </table>
                </div>
                <dnn:SectionHead ID="dshFormsSettings" CssClass="Head" runat="server" ResourceKey="FormsSettings"
                    IncludeRule="false" Section="tblForms" IsExpanded="False" />
                <div style="margin-left: 25px">
                    <table id="tblForms" cellspacing="2" cellpadding="4" runat="server" width="100%"
                        style="margin-top: 10px">
                        <colgroup>
                            <col width="30%" />
                            <col width="70%" />
                        </colgroup>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="lblOnSubmission" runat="server" Suffix="" ResourceKey="rblOnSubmission"
                                    ControlName="rblOnSubmission" />
                            </td>
                            <td>
                                <asp:RadioButtonList ID="rblOnSubmission" runat="server" CssClass="normal" RepeatDirection="Vertical"
                                    AutoPostBack="true">
                                    <asp:ListItem Value="Form" resourcekey="OnSubmissionForm" />
                                    <asp:ListItem Value="Text" resourcekey="OnSubmissionText" />
                                    <asp:ListItem Value="Redirect" resourcekey="OnSubmissionRedirect" />
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr id="rowOnSubmissionRedirect" runat="server">
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="lblOnSubmissionRedirect" runat="server" Suffix="" ResourceKey="lblOnSubmissionRedirect"
                                    ControlName="urlOnSubmissionRedirect" />
                            </td>
                            <td>
                                <Portal:URL ID="urlOnSubmissionRedirect" runat="server" ShowTrack="False" ShowNewWindow="False"
                                    ShowLog="False" ShowFiles="false" ShowUrls="true" ShowTabs="true" Width="200" />
                            </td>
                        </tr>
                        <tr id="rowSubmissionText" runat="server">
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="lblSub" runat="server" Suffix="" ResourceKey="plSubmissionText" ControlName="teSubmissionSuccess" />
                            </td>
                            <td>
                                <dnn:TextEditor ID="teSubmissionSuccess" runat="server" Height="250" Width="400">
                                </dnn:TextEditor>
                            </td>
                        </tr>
                    </table>
                </div>
                <dnn:SectionHead ID="dshRendering" CssClass="Head" runat="server" ResourceKey="ListSettings"
                    IncludeRule="false" Section="tblRendering" IsExpanded="true" />
                <div style="margin-left: 25px">
                    <table id="tblRendering" cellspacing="2" cellpadding="4" runat="server" style="margin-top: 10px"
                        width="100%">
                        <colgroup>
                            <col width="30%" />
                            <col width="70%" />
                        </colgroup>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plRenderMethod" runat="server" Suffix=":" ControlName="renderMethodRadioButtonList" />
                            </td>
                            <td valign="top">
                                <asp:RadioButtonList ID="renderMethodRadioButtonList" CssClass="NormalTextBox" runat="server"
                                    AutoPostBack="True">
                                    <asp:ListItem resourcekey="DataGrid" Value="DataGrid" Selected="True" />
                                    <asp:ListItem resourcekey="XslGeneratedStyleSheet" Value="XslUserDefinedStyleSheet" />
                                    <asp:ListItem resourcekey="XslPreDefinedStyleSheet" Value="XslPreDefinedStyleSheet" />
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr id="rowDataGrid" runat="server">
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plDnnCssClasses" runat="server" Suffix=":" ControlName="cboDnnCssClasses" />
                            </td>
                            <td class="Normal" valign="top">
                                <asp:DropDownList ID="cboDnnCssClasses" runat="server" CssClass="Normal" Width="300px">
                                    <asp:ListItem Value="UDT">&quot;Normal UDT_Table*&quot;</asp:ListItem>
                                    <asp:ListItem Value="DNN">&quot;DataGrid_*&quot;</asp:ListItem>
                                    <asp:ListItem Value="YUI" Selected="True">YUI DataTable Styled</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="rowPreDefined" runat="server">
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plPreDefinedStyleSheet" runat="server" Suffix=":" ControlName="XslPreDefinedDropDownList" />
                            </td>
                            <td valign="top">
                                <asp:DropDownList ID="XslPreDefinedDropDownList" runat="server" AutoPostBack="true" />
                                &nbsp;
                                <br />
                                <asp:HyperLink ID="HyperLinkStyleSheet" CssClass="CommandButton" runat="server" resourcekey="cmdDownLoadStyleSheet"
                                    Target="_blank" />
                            </td>
                        </tr>
                        <tr id="rowUserDefined" runat="server">
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plUserDefinedStyleSheet" runat="server" Suffix=":" ControlName="XslUserDefinedUrlControl" />
                            </td>
                            <td valign="top">
                                <Portal:URL ID="XslUserDefinedUrlControl" runat="server" FileFilter="xsl,xslt" Required="True"
                                    ShowTrack="False" ShowNewWindow="False" ShowLog="False" ShowFiles="True" ShowUrls="False"
                                    ShowTabs="False" Width="200" />
                                <div class="BelowUrlControl">
                                    <asp:LinkButton ID="cmdEditXSL" runat="server" CssClass="CommandButton" resourcekey="cmdEditXSL" />
                                    &nbsp;&nbsp;
                                    <img runat="server" src="~/images/icon_wizard_16px.gif" />
                                    <asp:LinkButton CssClass="CommandButton bold" resourcekey="cmdShowXSLGenerator" ID="cmdGenerateXSL"
                                        runat="server" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top" colspan="2">
                                <asp:Label ID="lblSorting" CssClass="SubHead" resourcekey="Sorting" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plSort" runat="server" Suffix=":" ControlName="cboSortField" />
                            </td>
                            <td valign="top">
                                <asp:DropDownList ID="cboSortField" CssClass="NormalTextBox" runat="server" Width="180px"
                                    DataValueField="UserDefinedFieldId" DataTextField="FieldTitle" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plOrder" runat="server" Suffix=":" ControlName="cboSortOrder" />
                            </td>
                            <td valign="top">
                                <asp:DropDownList ID="cboSortOrder" CssClass="NormalTextBox" runat="server" Width="180px">
                                    <asp:ListItem resourcekey="Ascending" Value="ASC" />
                                    <asp:ListItem resourcekey="Descending" Value="DESC" />
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plPaging" runat="server" Suffix=":" ControlName="cboPaging" />
                            </td>
                            <td valign="top">
                                <asp:DropDownList ID="cboPaging" runat="server" Width="180px" CssClass="NormalTextBox">
                                    <asp:ListItem resourcekey="NoPaging" Value="" />
                                    <asp:ListItem Value="1">1</asp:ListItem>
                                    <asp:ListItem Value="5">5</asp:ListItem>
                                    <asp:ListItem Value="10">10</asp:ListItem>
                                    <asp:ListItem Value="15">15</asp:ListItem>
                                    <asp:ListItem Value="20">20</asp:ListItem>
                                    <asp:ListItem Value="25">25</asp:ListItem>
                                    <asp:ListItem Value="30">30</asp:ListItem>
                                    <asp:ListItem Value="40">40</asp:ListItem>
                                    <asp:ListItem Value="50">50</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top" colspan="2">
                                <asp:Label ID="lblSearchAndFilter" CssClass="SubHead" resourcekey="SearchAndFilter"
                                    runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plFilter" runat="server" ControlName="txtFilter" Suffix=":" />
                            </td>
                            <td class="Normal" valign="top">
                                <asp:TextBox ID="txtFilter" runat="server" Width="400px" /><br />
                                <asp:HyperLink CssClass="CommandButton" ID="hlpToken2" runat="server" resourcekey="cmdTokensHelp"
                                    NavigateUrl="#" />&nbsp;
                                <asp:HyperLink CssClass="CommandButton" ID="hlpColumns2" runat="server" resourcekey="cmdColumnsHelp"
                                    NavigateUrl="#" />
                            </td>
                        </tr>
                        <tr id="rowSearchBox" runat="server">
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plShowSearchTextBox" runat="server" ControlName="chkShowSearchTextBox"
                                    Suffix=":" />
                            </td>
                            <td valign="top">
                                <asp:CheckBox ID="chkShowSearchTextBox" runat="server" AutoPostBack="true" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plSimpleSearch" runat="server" ControlName="chkSimpleSearch" Suffix=":" />
                            </td>
                            <td valign="top">
                                <asp:CheckBox ID="chkSimpleSearch" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plShowNoRecordsUntilSearch" runat="server" ControlName="chkShowNoRecordsUntilSearch"
                                    Suffix=":" />
                            </td>
                            <td valign="top">
                                <asp:CheckBox ID="chkShowNoRecordsUntilSearch" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plURLSearch" runat="server" ControlName="chkURLSearch" Suffix=":" />
                            </td>
                            <td valign="top">
                                <asp:CheckBox ID="chkURLSearch" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plTopCount" runat="server" ControlName="txtTopCount" Suffix=":" />
                            </td>
                            <td class="Normal" valign="top">
                                <asp:TextBox ID="txtTopCount" runat="server" Width="50px" Style="text-align: right" />
                                <asp:RangeValidator ID="errTopCount" runat="server" ControlToValidate="txtTopCount"
                                    Type="Integer" MinimumValue="1" MaximumValue="1000" Display="Static" resourcekey="ErrTopCount" />
                            </td>
                        </tr>
                    </table>
                </div>
                <dnn:SectionHead ID="dshChangeTracking" CssClass="Head" runat="server" ResourceKey="EmailSettings"
                    IncludeRule="false" Section="tblChangeTracking" IsExpanded="False" />
                <div style="margin-left: 25px">
                    <table id="tblChangeTracking" cellspacing="2" cellpadding="4" runat="server" width="100%"
                        style="margin-top: 10px">
                        <colgroup>
                            <col width="30%" />
                            <col width="70%" />
                        </colgroup>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plTrackingEmailAddresses" runat="server" Suffix=":" ControlName="txtTrackingEmailAddresses" />
                            </td>
                            <td class="Normal" valign="top">
                                <asp:TextBox ID="txtTrackingEmailAddresses" CssClass="NormalTextBox" runat="server"
                                    Width="400px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plTrackingEmail_CC" runat="server" Suffix=":" ControlName="txtTrackingEmail_CC" />
                            </td>
                            <td class="Normal" valign="top">
                                <asp:TextBox ID="txtTrackingEmail_CC" CssClass="NormalTextBox" runat="server" Width="400px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plTrackingEmail_BCC" runat="server" Suffix=":" ControlName="txtTrackingEmail_BCC" />
                            </td>
                            <td class="Normal" valign="top">
                                <asp:TextBox ID="txtTrackingEmail_BCC" CssClass="NormalTextBox" runat="server" Width="400px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plTrackingEmail_replyto" runat="server" Suffix=":" ControlName="txtTrackingEmail_replyto" />
                            </td>
                            <td class="Normal" valign="top">
                                <asp:TextBox ID="txtTrackingEmail_replyto" CssClass="NormalTextBox" runat="server"
                                    Width="400px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plTrackingEmail_from" runat="server" Suffix=":" ControlName="txtTrackingEmail_from" />
                            </td>
                            <td class="Normal" valign="top">
                                <asp:TextBox ID="txtTrackingEmail_from" CssClass="NormalTextBox" runat="server" Width="400px" />
                               
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plTrackingSubject" runat="server" Suffix=":" ControlName="txtTrackingSubject" />
                            </td>
                            <td class="Normal" valign="top">
                                <asp:TextBox ID="txtTrackingSubject" CssClass="NormalTextBox" runat="server" MaxLength="998"
                                    Width="400px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plTrackingMessage" runat="server" Suffix=":" ControlName="txtTrackingMessage" />
                            </td>
                            <td class="Normal" valign="top">
                                <dnn:TextEditor ID="teTrackingMessage" runat="server" Height="250" Width="400"></dnn:TextEditor>
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plTrackingOn" runat="server" Suffix=":" ControlName="txtTrackingTrigger" />
                            </td>
                            <td class="Normal" valign="top">
                                <asp:CheckBox ID="chkTrackingOnNew" runat="server" CssClass="Normal" resourcekey="TrackingOnNew" />
                                <asp:CheckBox ID="chkTrackingOnUpdate" runat="server" CssClass="Normal" resourcekey="TrackingOnUpdate" />
                                <asp:CheckBox ID="chkTrackingOnDelete" runat="server" CssClass="Normal" resourcekey="TrackingOnDelete" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plOnNew" runat="server" Suffix=":" ControlName="txtOnNew" ResourceKey="plOnNew" />
                            </td>
                            <td class="Normal" valign="top">
                                <asp:TextBox ID="txtOnNew" CssClass="NormalTextBox" runat="server" Width="400px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plOnUpdate" runat="server" Suffix=":" ControlName="txtOnUpdate" ResourceKey="plOnUpdate" />
                            </td>
                            <td class="Normal" valign="top">
                                <asp:TextBox ID="txtOnUpdate" CssClass="NormalTextBox" runat="server" Width="400px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plOnDelete" runat="server" Suffix=":" ControlName="txtOnDelete" ResourceKey="plOnDelete" />
                            </td>
                            <td class="Normal" valign="top">
                                <asp:TextBox ID="txtOnDelete" CssClass="NormalTextBox" runat="server" Width="400px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plBody" runat="server" Suffix=":" ControlName="rblBodyType" />
                            </td>
                            <td class="Normal" valign="top">
                                <asp:RadioButtonList ID="rblBodyType" runat="server" CssClass="Normal" RepeatDirection="Horizontal"
                                    AutoPostBack="True">
                                    <asp:ListItem Value="Auto" resourcekey="Bodytype_Auto"></asp:ListItem>
                                    <asp:ListItem Value="XslScript" resourcekey="Bodytype_Xsl"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr id="rowTrackingScript" runat="server">
                            <td class="SubHead" valign="top">
                                <dnn:Label ID="plTrackingScript" runat="server" Suffix=":" ControlName="XslUserDefinedUrlControl" />
                            </td>
                            <td valign="top">
                                <Portal:URL ID="XslTracking" runat="server" FileFilter="xsl,xslt" Required="True"
                                    ShowTrack="False" ShowNewWindow="False" ShowLog="False" ShowFiles="True" ShowUrls="False"
                                    ShowTabs="False" Width="200" />
                                <div class="BelowUrlControl">
                                    <asp:LinkButton ID="cmdEditEmail" runat="server" CssClass="CommandButton" resourcekey="cmdEditTrackingMessage" />
                                    &nbsp;&nbsp;
                                    <asp:LinkButton CssClass="CommandButton" resourcekey="cmdGenerateTrackingMessage"
                                        ID="cmdGenerateEmail" runat="server" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <p style="text-align: center">
                    <dnn:CommandButton ID="cmdUpdate" runat="server" CssClass="CommandButton" ResourceKey="cmdSaveAndBack"
                        ImageUrl="~/images/save.gif" />
                    &nbsp;
                    <dnn:CommandButton ID="cmdCancel" runat="server" CssClass="CommandButton" ResourceKey="cmdCancel"
                        ImageUrl="~/images/lt.gif" CausesValidation="False" />
                </p>
            </td>
            <td width="25">
            </td>
        </tr>
    </tbody>
</table>
