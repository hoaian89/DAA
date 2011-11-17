<%@ Control Language="C#" Inherits="M2Land.Modules.FlashImageRotator.EditFlashImageRotator"
    AutoEventWireup="true" Codebehind="EditFlashImageRotator.ascx.cs" %>
<%@ Register Assembly="Toolkit.ColorPicker" Namespace="DnnSun.WebControls.Toolkit"
    TagPrefix="cc2" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="Portal" TagName="URL" Src="~/controls/URLControl.ascx" %>
<table id="tblSettingContainer" cellspacing="2" cellpadding="2" width="560" summary="Flash ImageRotator Setting Table"
    border="0">
    <tr align="left">
        <td>
            <dnn:SectionHead ID="dshBasics" runat="server" Text="The Basics:" CssClass="Head"
                Section="tblBasics" />
            <table id="tblBasics" cellspacing="2" cellpadding="2" width="475" summary="Flash ImageRotator Basic Setting Table"
                border="0" runat="server">
                <tr>
                    <td class="SubHead" width="30%">
                        <dnn:Label ID="plWidth" runat="server" ControlName="txtWidth" Text="Width:" />
                    </td>
                    <td>
                        <asp:TextBox Width="150" ID="txtWidth" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:RangeValidator ID="valgWidth" runat="server" ControlToValidate="txtWidth" ErrorMessage="Must be a Integer between 0 - 2000"
                            Type="Integer" MaximumValue="2000" MinimumValue="0" CssClass="Normal"></asp:RangeValidator></td>
                </tr>
                <tr>
                    <td class="SubHead" width="30%">
                        <dnn:Label ID="plHeight" runat="server" ControlName="txtHeight" Text="Height:" />
                    </td>
                    <td>
                        <asp:TextBox Width="150" ID="txtHeight" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:RangeValidator ID="valgHeight" runat="server" ControlToValidate="txtHeight"
                            ErrorMessage="Must be a Integer between 0 - 2000" Type="Integer" MaximumValue="2000"
                            MinimumValue="0" CssClass="Normal"></asp:RangeValidator></td>
                </tr>
                <tr>
                    <td class="SubHead" width="30%">
                        <dnn:Label ID="plImageListXMLFile" runat="server" ControlName="txtImageListXML" Text="Image List File:" />
                    </td>
                    <td>
                        <asp:TextBox Width="150" ID="txtImageListXMLFile" runat="server" Enabled="false"></asp:TextBox></td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td class="SubHead" width="30%" style="height: 45px">
                        <dnn:Label ID="plTranstion" runat="server" ControlName="txtTranstion" Text="Transtion:" />
                    </td>
                    <td style="height: 45px">
                        <asp:DropDownList ID="droplistTranstion" runat="server" Width="150">
                            <asp:ListItem Selected="True" Value="random">random(default)</asp:ListItem>
                            <asp:ListItem>fade</asp:ListItem>
                            <asp:ListItem>bgfade</asp:ListItem>
                            <asp:ListItem>blocks</asp:ListItem>
                            <asp:ListItem>bubbles</asp:ListItem>
                            <asp:ListItem>circles</asp:ListItem>
                            <asp:ListItem>flash</asp:ListItem>
                            <asp:ListItem>fluids</asp:ListItem>
                            <asp:ListItem>lines</asp:ListItem>
                            <asp:ListItem>slowfade</asp:ListItem>
                            <asp:ListItem></asp:ListItem>
                        </asp:DropDownList><br />
                    </td>
                    <td style="height: 45px">
                    </td>
                </tr>
            </table>
            <dnn:SectionHead ID="dshImageList" runat="server" Text="Edit Image XML List " CssClass="Head"
                Section="tblImageList" IsExpanded="true" ResourceKey="ImageList" />
            <asp:GridView ID="GridView1" runat="server">
            </asp:GridView>
            <table id="tblImageList" cellspacing="2" cellpadding="2" width="475" summary="EditStylesheet"
                border="0" runat="server">
                <tr>
                    <td class="SubHead">
                        <asp:TextBox ID="txtImageListXML" CssClass="NormalTextBox" runat="server" Rows="20"
                            TextMode="MultiLine" Wrap="False" Columns="100"></asp:TextBox></td>
                </tr>
            </table>
            <dnn:SectionHead ID="dshColors" runat="server" Text="The Colors:" CssClass="Head"
                Section="tblColors" IsExpanded="false" />
            <table id="tblColors" cellspacing="2" cellpadding="2" width="475" summary="The Colors"
                border="0" runat="server">
                <tr>
                    <td class="SubHead" width="30%">
                        <dnn:Label ID="plBackColor" runat="server" ControlName="txtBackColor" Text="BackColor:" />
                    </td>
                    <td>
                        &nbsp;
                        <cc2:ColorPicker ID="cpicBackColor" runat="server" />
                        
                    </td>
                </tr>
                <tr>
                    <td class="SubHead" width="30%">
                        <dnn:Label ID="plFrontColor" runat="server" ControlName="txtFrontColor" Text="FrontColor:" />
                    </td>
                    <td>
                        <cc2:ColorPicker ID="cpicFrontColor" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="SubHead" width="30%">
                        <dnn:Label ID="plLightColor" runat="server" ControlName="txtLightColor" Text="LightColor:" />
                    </td>
                    <td>
                        <cc2:ColorPicker ID="cpicLightColor" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="SubHead" width="30%">
                        <dnn:Label ID="plScreenColor" runat="server" ControlName="txtScreenColor" Text="ScreenColor:" />
                    </td>
                    <td>
                        
                        <cc2:ColorPicker ID="cpicScreenColor" runat="server" />
                        
                    </td>
                </tr>
            </table>
            <dnn:SectionHead ID="dshDisplayAppearance" runat="server" Text="Display Appearance:"
                CssClass="Head" Section="tblDisplayAppearance" IsExpanded="false" />
            <table id="tblDisplayAppearance" cellspacing="2" cellpadding="2" width="475" summary="Display Appearance"
                border="0" runat="server">
                <tr>
                    <td class="SubHead" width="30%">
                        <dnn:Label ID="plLogo" runat="server" ControlName="txtLogo" Text="Logo:" />
                    </td>
                    <td>
                        <Portal:URL ID="urlctlLogo" runat="server" Width="300" Required="False" UrlType="F"
                            ShowTabs="False" ShowFiles="True" ShowUrls="True" ShowLog="False" ShowNewWindow="False"
                            ShowTrack="False" />
                    </td>
                </tr>
                <tr>
                    <td class="SubHead" width="30%">
                        <dnn:Label ID="plOverStretch" runat="server" ControlName="txtOverStretch" Text="Over Stretch:" />
                    </td>
                    <td>
                        <asp:DropDownList ID="droplistOverStretch" runat="server" Width="150">
                            <asp:ListItem Selected="True" Value="false">false(default)</asp:ListItem>
                            <asp:ListItem>true</asp:ListItem>
                            <asp:ListItem>fit</asp:ListItem>
                            <asp:ListItem>none</asp:ListItem>
                        </asp:DropDownList><br />
                    </td>
                </tr>
                <tr>
                    <td class="SubHead" width="30%">
                        <dnn:Label ID="plShowIcon" runat="server" ControlName="droplistShowIcon" Text="Show Icon:" />
                    </td>
                    <td>
                        <asp:DropDownList ID="droplistShowIcon" runat="server" Width="150">
                            <asp:ListItem Selected="True" Value="true">true(default)</asp:ListItem>
                            <asp:ListItem>false</asp:ListItem>
                        </asp:DropDownList><br />
                    </td>
                </tr>
                <tr>
                    <td class="SubHead" width="30%">
                        <dnn:Label ID="plShowEq" runat="server" ControlName="droplistShowEq" Text="Show Eq:" />
                    </td>
                    <td>
                        <asp:DropDownList ID="droplistShowEq" runat="server" Width="150">
                            <asp:ListItem Selected="True" Value="false">false(default)</asp:ListItem>
                            <asp:ListItem>true</asp:ListItem>
                        </asp:DropDownList><br />
                    </td>
                </tr>
            </table>
            <dnn:SectionHead ID="dshControlbarAppearance" runat="server" Text="Controlbar Appearance:"
                CssClass="Head" Section="tblControlbarAppearance" IsExpanded="false" ResourceKey="ControlbarAppearance" />
            <table id="tblControlbarAppearance" cellspacing="2" cellpadding="2" width="475" summary="Controllbar Appearance"
                border="0" runat="server">
                <tr>
                    <td class="SubHead" width="30%">
                        <dnn:Label ID="plShowNavigation" runat="server" ControlName="droplistShowNavigation"
                            Text="Show Navigation:" ResourceKey="ShowNavigation" />
                    </td>
                    <td>
                        <asp:DropDownList ID="droplistShowNavigation" runat="server" Width="150">
                            <asp:ListItem Selected="True" Value="true">true(default)</asp:ListItem>
                            <asp:ListItem>false</asp:ListItem>
                        </asp:DropDownList></td>
                </tr>
            </table>
            <dnn:SectionHead ID="dshPlaybackBehaviour" runat="server" Text="Playback Behaviour:"
                CssClass="Head" Section="tblPlaybackBehaviour" IsExpanded="false" ResourceKey="PlaybackBehaviour" />
            <table id="tblPlaybackBehaviour" cellspacing="2" cellpadding="2" width="475" summary="Playback Behaviour"
                border="0" runat="server">
                <tr>
                    <td class="SubHead" width="30%">
                        <dnn:Label ID="plAudio" runat="server" ControlName="txtAudio" Text="Audio:" ResourceKey="Audio" />
                    </td>
                    <td colspan="2">
                        <Portal:URL ID="urlctlAudio" runat="server" Width="300" Required="False" UrlType="F"
                            ShowTabs="False" ShowFiles="True" ShowUrls="True" ShowLog="False" ShowNewWindow="False"
                            ShowTrack="False" />
                    </td>
                </tr>
                <tr>
                    <td class="SubHead" width="30%">
                        <dnn:Label ID="plAutoStart" runat="server" ControlName="droplistAutoStart" Text="Auto Start:"
                            ResourceKey="AutoStart" />
                    </td>
                    <td>
                        <asp:DropDownList ID="droplistAutoStart" runat="server" Width="150">
                            <asp:ListItem Selected="True" Value="true">true(default)</asp:ListItem>
                            <asp:ListItem>false</asp:ListItem>
                        </asp:DropDownList><br />
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td class="SubHead" width="30%">
                        <dnn:Label ID="plRepeat" runat="server" ControlName="droplistRepeat" Text="Repeat:"
                            ResourceKey="Repeat" />
                    </td>
                    <td>
                        <asp:DropDownList ID="droplistRepeat" runat="server" Width="150">
                            <asp:ListItem Selected="True" Value="false">false(default)</asp:ListItem>
                            <asp:ListItem>list</asp:ListItem>
                            <asp:ListItem>true</asp:ListItem>
                        </asp:DropDownList><br />
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td class="SubHead" width="30%">
                        <dnn:Label ID="plRotateTime" runat="server" ControlName="txtRotateTime" Text="Rotate Time:"
                            ResourceKey="RotateTime" />
                    </td>
                    <td>
                        <asp:TextBox Width="150" ID="txtRotateTime" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:RangeValidator ID="valgRotateTime" runat="server" ControlToValidate="txtRotateTime"
                            CssClass="Normal" ErrorMessage="Must be a Integer between 0 - 2000" MaximumValue="2000"
                            MinimumValue="0" Type="Integer"></asp:RangeValidator></td>
                </tr>
                <tr>
                    <td class="SubHead" width="30%">
                        <dnn:Label ID="plShuffle" runat="server" ControlName="droplistShuffle" Text="Shuffle:"
                            ResourceKey="Shuffle" />
                    </td>
                    <td>
                        <asp:DropDownList ID="droplistShuffle" runat="server" Width="150">
                            <asp:ListItem Selected="True" Value="false">false(default)</asp:ListItem>
                            <asp:ListItem>true</asp:ListItem>
                        </asp:DropDownList><br />
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td class="SubHead" width="30%">
                        <dnn:Label ID="plVolume" runat="server" ControlName="txtVolume" Text="Volume:" ResourceKey="Volume" />
                    </td>
                    <td>
                        <asp:TextBox Width="150" ID="txtVolume" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:RangeValidator ID="valgVolume" runat="server" ControlToValidate="txtVolume"
                            CssClass="Normal" ErrorMessage="Must be a Integer between 0 - 2000" MaximumValue="2000"
                            MinimumValue="0" Type="Integer"></asp:RangeValidator></td>
                </tr>
            </table>
            <dnn:SectionHead ID="dshExternalCommnunication" runat="server" Text="External Commnunication:"
                CssClass="Head" Section="tblExternalCommnunication" IsExpanded="false" ResourceKey="ExternalCommnunication" />
            <table id="tblExternalCommnunication" cellspacing="2" cellpadding="2" width="475"
                summary="ExternalCommnunication" border="0" runat="server">
                <tr>
                    <td class="SubHead" width="30%">
                        <dnn:Label ID="plEnableJs" runat="server" ControlName="droplistEnableJs" Text="Enable JS:"
                            ResourceKey="EnableJs" />
                    </td>
                    <td>
                        <asp:DropDownList ID="droplistEnableJs" runat="server" Width="150">
                            <asp:ListItem Selected="True" Value="false">false(default)</asp:ListItem>
                            <asp:ListItem>true</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="SubHead" width="30%">
                        <dnn:Label ID="plJavascriptID" runat="server" ControlName="txtJavascriptID" Text="Javascript ID:"
                            ResourceKey="JavascriptID" />
                    </td>
                    <td>
                        <asp:TextBox Width="150" ID="txtJavascriptID" runat="server"></asp:TextBox><br />
                    </td>
                </tr>
                <tr>
                    <td class="SubHead" width="30%">
                        <dnn:Label ID="plLinkFromDisplay" runat="server" ControlName="droplistLinkFromDisplay"
                            Text="Link From Display:" ResourceKey="LinkFromDisplay" />
                    </td>
                    <td>
                        <asp:DropDownList ID="droplistLinkFromDisplay" runat="server" Width="150">
                            <asp:ListItem Selected="True" Value="false">false(default)</asp:ListItem>
                            <asp:ListItem>true</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="SubHead" width="30%">
                        <dnn:Label ID="plLinkTarget" runat="server" ControlName="txtLinkTarget" Text="Link Target:"
                            ResourceKey="LinkTarget" />
                    </td>
                    <td>
                        <asp:TextBox Width="150" ID="txtLinkTarget" runat="server"></asp:TextBox><br />
                    </td>
                </tr>
            </table>
            
        </td>
    </tr>
</table>
<p>
    <asp:LinkButton CssClass="CommandButton" ID="cmdUpdate" OnClick="cmdUpdate_Click"
        resourcekey="cmdUpdate" runat="server" BorderStyle="none" Text="Update"></asp:LinkButton>&nbsp;
    <asp:LinkButton CssClass="CommandButton" ID="cmdCancel" OnClick="cmdCancel_Click"
        resourcekey="cmdCancel" runat="server" BorderStyle="none" Text="Cancel" CausesValidation="False"></asp:LinkButton>&nbsp;
</p>
<p>
    &nbsp;&nbsp;</p>
<p>
    &nbsp;</p>
