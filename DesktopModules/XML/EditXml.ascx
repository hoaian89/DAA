<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="URL" Src="~/controls/URLControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="ParameterEditor" Src="~/DesktopModules/xml/Parameters/ParameterEditor.ascx" %>
<%@ Control Language="VB" CodeFile="EditXml.ascx.vb" AutoEventWireup="false" Explicit="True"
    Inherits="DotNetNuke.Modules.XML.EditXml" %>
<br/>
<table class="Settings" cellspacing="2" cellpadding="2" width="560" summary="Edit XML Design Table"
	border="0">
	<tr>
		<td>
			<dnn:sectionhead id="dshXmlSource" runat="server" isexpanded="true" includerule="true" resourcekey="dshXmlSource"
				section="secXmlSource" cssclass="Head"></dnn:sectionhead>
		</td>
	</tr>
	<tr id="secXmlSource" runat="server">
		<td>
			<asp:label id="lblXmlSource" resourcekey="lblXmlSource" runat="server" cssclass="normal">In this section, you can define the source of your Xml data. It can be provided 
				as local file or be queried via http using dynamic querystrings.</asp:label>
			<dnn:url id="ctlURLxml" runat="server" required="True" showtrack="False" shownewwindow="False"
				showlog="False" showfiles="True" showurls="True" showtabs="False" width="300"></dnn:url>
			<div id="divUrlSettings" runat="server" style="MARGIN-TOP:-20px; MARGIN-BOTTOM:10px">
				<dnn:sectionhead id="dshUrlParams" runat="server" isexpanded="false" includerule="false" resourcekey="dshUrlParams"
					section="sectXmlParam" cssclass="SubHead"></dnn:sectionhead>
				<div id="sectXmlParam" runat="server"><dnn:parametereditor id="pedSource" runat="server" purpose="URL" requiredvaluesneeded="true" SupportsFallbackValues="true" /></div>
				<dnn:sectionhead id="dshQueryStringEncoding" runat="server" isexpanded="false" includerule="false"
					resourcekey="dshQueryStringEncoding" section="sectQueryStringEncoding" cssclass="SubHead"></dnn:sectionhead>
				<div id="sectQueryStringEncoding" runat="server" class="normalBold">
					<dnn:label id="plQueryStringEncoding" runat="server" controlname="rblQueryStringEncoding" suffix=":"></dnn:label>
					<asp:radiobuttonlist id="rblQueryStringEncoding" runat="server" cssclass="normalBold">
						<asp:listitem value="ASCII">ASCII</asp:listitem>
						<asp:listitem value="Default">Windows Default</asp:listitem>
						<asp:listitem value="UTF8" selected="True">UTF 8</asp:listitem>
					</asp:radiobuttonlist>
				</div>
				<dnn:sectionhead id="dshSecurity" cssclass="SubHead" runat="server" text="Security Options (optional)"
					section="tblSecurity" resourcekey="lblSecurityTitle" includerule="False" isexpanded="false"></dnn:sectionhead>
				<table cellspacing="0" cellpadding="2" border="0" summary="Security Options (optional)"
					id="tblSecurity" runat="server">
					<tr>
						<td class="NormalBold"><dnn:label id="lblDomain" runat="server" controlname="txtAccount" suffix=":"></dnn:label></td>
						<td>
							<asp:textbox id="txtAccount" runat="server"></asp:textbox></td>
					</tr>
					<tr>
						<td class="NormalBold"><dnn:label id="lblPassword" runat="server" controlname="txtPassword" suffix=":"></dnn:label></td>
						<td>
							<asp:textbox id="txtPassword" runat="server" textmode="Password"></asp:textbox></td>
					</tr>
				</table>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<br/>
			<dnn:sectionhead id="dshXslTrans" runat="server" isexpanded="true" includerule="true" resourcekey="dshXslTrans"
				section="secXslTrans" cssclass="Head"></dnn:sectionhead>
		</td>
	</tr>
	<tr id="secXslTrans" runat="server">
		<td><asp:label id="lblXslDefinition" resourcekey="lblXslDefinition" runat="server" cssclass="normal">In this section, you can define the source of your XSl Stylesheet. You can define additional arguments to provide your script with context information.</asp:label>
			<dnn:url id="ctlURLxsl" runat="server" required="True" showtrack="False" shownewwindow="False"
				showlog="False" urltype="F" showfiles="True" showurls="True" showtabs="False" width="300"></dnn:url>
			<div id="divXslSettings" runat="server" style="MARGIN-TOP:-20px; MARGIN-BOTTOM:10px">
				<dnn:sectionhead id="dshXslParams" runat="server" isexpanded="false" resourcekey="dshXslParams" section="sectXslParams"
					cssclass="SubHead"></dnn:sectionhead>
				<div id="sectXslParams" runat="server"><dnn:parametereditor id="pedXsl" runat="server" purpose="XSL"></dnn:parametereditor></div>
			</div>
		</td>
	</tr>
	<tr>
		<td><br/>
			<dnn:sectionhead id="dshAdvanced" runat="server" isexpanded="false" includerule="true" resourcekey="dshAdvancedTitle"
				section="secAdvanced" cssclass="Head"></dnn:sectionhead></td>
	</tr>
	<tr id="secAdvanced" runat="server">
		<td>
			<table id="tblAdvanced" runat="server">
				<tr>
					<td valign="top" colspan="2">
						<asp:label id="lblOutput" runat="server" resourcekey="lblOutput" text="The Xml Module will usually render its output as html inside the module. However it is possible to create downloads too."
							cssclass="normal" />
						<br/>
					</td>
				</tr>
				<tr>
					<td class="SubHead" valign="top"><dnn:label id="plOutput" suffix=":" controlname="rblOutput" runat="server" text="Return result:" /></td>
					<td>
						<asp:radiobuttonlist id="rblOutput" runat="server" cssclass="normalBold">
							<asp:listitem value="Inline" selected="True" resourcekey="OutputInline">inside module</asp:listitem>
							<asp:listitem value="Link" resourcekey="OutputLink">as link to a file stream</asp:listitem>
							<asp:listitem value="Response" resourcekey="OutputResponse">as  file stream</asp:listitem>
						</asp:radiobuttonlist>
					</td>
				</tr>
				<tr>
					<td class="SubHead" valign="top"><dnn:label id="plContentType" suffix=":" controlname="rblContentType" runat="server" text="Content type:" />
					</td>
					<td>
						<asp:radiobuttonlist id="rblContentType" runat="server" cssclass="normalBold">
							<asp:listitem value="xml|text/xml" selected="True">*.xml (text/xml)</asp:listitem>
							<asp:listitem value="txt|text/html">*.htm (text/html)</asp:listitem>
							<asp:listitem value="csv|text/comma-separated-values">*.csv (text/comma-separated-values)</asp:listitem>
							<asp:listitem value="txt|text/plain">*.txt (text/plain)</asp:listitem>
						</asp:radiobuttonlist></td>
				</tr>
				<tr>
					<td colspan="2">
						<hr/>
						<asp:label id="lblSearch" runat="server" resourcekey="lblSearch" cssclass="normal">The Output of the Xml Module is not searchable in DotNetNuke Search by default. However, if you want to and your setup doesn't depend on dynamic parameters you can switch own indexing.</asp:label>
						<br/>
					</td>
				</tr>
				<tr>
					<td valign="top" class="SubHead"><dnn:label id="plIndexRun" suffix=":" controlname="rblIndexRun" runat="server" text="Allow index run:" /></td>
					<td><span class="normalBold">
							<asp:radiobuttonlist id="rblIndexRun" runat="server" cssclass="normalBold">
								<asp:listitem value="Never" selected="True" resourcekey="IndexRunNever">never (search is disabled)</asp:listitem>
								<asp:listitem value="NextRun" resourcekey="IndexRunNextRun">only on next run</asp:listitem>
								<asp:listitem value="Always" resourcekey="IndexRunAlways">always</asp:listitem>
								<asp:listitem value="OncePerHour" resourcekey="IndexRunOncePerHour">once per hour</asp:listitem>
								<asp:listitem value="OncePerDay" resourcekey="IndexRunOncePerDay">once per day</asp:listitem>
							</asp:radiobuttonlist>
							<asp:label id="lblDynamicParameter" runat="server" visible="False" resourcekey="lblDynamicParameter">Index run is disabled as there are dynamic parameters for either query string or xsl args.</asp:label>
							<br/>
							<br/>
							<asp:linkbutton cssclass="CommandButton" id="cmdClearSearchIndex" runat="server" resourcekey="cmdClearSearchIndex"
								borderstyle="none" causesvalidation="False">Clear Search Index</asp:linkbutton>
						</span>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<hr/>
						<asp:label id="lblEnableByQuerystring" runat="server" resourcekey="lblEnableByQuerystring"
							cssclass="normal">For some use cases it is necessary that the module only runs if the request contains a defined querystring parameter/ value pair.</asp:label>
						<br/>
					</td>
				</tr>
				<tr>
					<td valign="top" class="NormalBold"><dnn:label id="plEnableParam" suffix=":" controlname="txtEnableParam" runat="server" text="Querystring param:" /></td>
					<td>
						<asp:textbox id="txtEnableParam" runat="server"></asp:textbox>
					</td>
				</tr>
				<tr>
					<td valign="top" class="NormalBold"><dnn:label id="plEnableValue" suffix=":" controlname="txtEnableValue" runat="server" text="Querystring value:" /></td>
					<td>
						<asp:textbox id="txtEnableValue" runat="server"></asp:textbox>
					</td>
				</tr>
				<tr>
					<td class="SubHead" valign="top"></td>
					<td>
						<asp:linkbutton class="CommandButton" id="cmdClearEnableByParam" runat="server" resourcekey="cmdClearEnableByParam"
							borderstyle="none" causesvalidation="False">Clear/ Disable</asp:linkbutton></td>
				</tr>
			</table>
			<p>
				<hr/>
			<p></p>
		</td>
	</tr>
</table>
<asp:linkbutton class="CommandButton" id="cmdUpdate" runat="server" text="Update" borderstyle="none"
	resourcekey="cmdUpdate"></asp:linkbutton>&nbsp;
<asp:linkbutton class="CommandButton" id="cmdCancel" runat="server" text="Cancel" borderstyle="none"
	resourcekey="cmdCancel" causesvalidation="False"></asp:linkbutton>
