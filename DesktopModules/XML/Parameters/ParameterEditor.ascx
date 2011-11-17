<%@ Control Language="vb" AutoEventWireup="false" CodeFile="ParameterEditor.ascx.vb" Inherits="DotNetNuke.Modules.XML.ParameterEditor"  %>
<%@ Import Namespace="DotNetNuke.Modules.XML" %>
<asp:datagrid id="grdParams" summary="List of Parameters" datakeyfield="ID" gridlines="None" borderwidth="0px"
	autogeneratecolumns="False" cellpadding="2" cssclass="Normal" runat="server">
	<columns>
		<asp:templatecolumn>
			<itemstyle wrap="False" verticalalign="Top"></itemstyle>
			<itemtemplate>
				<asp:imagebutton runat="server" causesvalidation="false" commandname="Edit" imageurl="~/images/edit.gif"
					alternatetext="Edit" resourcekey="Edit" id="Imagebutton1" />
				<asp:imagebutton id="cmdDeleteParam" runat="server" causesvalidation="false" commandname="Delete"
					imageurl="~/images/delete.gif" alternatetext="Delete" resourcekey="Delete" />
			</itemtemplate>
			<edititemtemplate>
				<asp:imagebutton runat="server" causesvalidation="false" commandname="Update" imageurl="~/images/save.gif"
					alternatetext="Save" resourcekey="Save" id="Imagebutton2" />
				<asp:imagebutton runat="server" causesvalidation="false" commandname="Cancel" imageurl="~/images/cancel.gif"
					alternatetext="Cancel" resourcekey="Cancel" id="Imagebutton3" />
			</edititemtemplate>
		</asp:templatecolumn>
		<asp:templatecolumn headertext="Name">
			<headerstyle cssclass="NormalBold"></headerstyle>
			<itemstyle cssclass="Normal" verticalalign="Top"></itemstyle>
			<itemtemplate>
				<%#CType(Container.DataItem, ParameterInfo).Name%>
			</itemtemplate>
			<edititemtemplate>
				<asp:label id="lblParamName" runat="server" />
				<asp:TextBox ID="txtParamName" runat="server" MaxLength="50" Text='<%# CType(Container.DataItem, ParameterInfo).Name %>' />
			</edititemtemplate>
		</asp:templatecolumn>
		<asp:templatecolumn headertext="Required">
			<headerstyle horizontalalign="Center" cssclass="NormalBold"></headerstyle>
			<itemstyle horizontalalign="Center" cssclass="Normal"></itemstyle>
			<itemtemplate>
				<asp:image runat="server" imageurl='<%# IIf(DataBinder.Eval(Container.DataItem, "IsValueRequired") = True, "~/images/checked.gif", "~/images/unchecked.gif")%>' visible='<%#RequiredValuesNeeded()%>' id="Image2"/>
			</itemtemplate>
			<edititemtemplate>
				<asp:label id="lblRequired" runat="server" visible='<%#RequiredValuesNeeded()%>'/>
				<asp:checkbox runat="server" id="chkRequired" checked='<%# IIf(DataBinder.Eval(Container.DataItem, "IsValueRequired") = True, "True", "False") %>' visible='<%#RequiredValuesNeeded()%>'/>
			</edititemtemplate>
		</asp:templatecolumn>
		<asp:templatecolumn headertext="Value">
			<headerstyle cssclass="NormalBold"></headerstyle>
			<itemstyle wrap="False" cssclass="Normal" verticalalign="Top"></itemstyle>
			<itemtemplate>
				<asp:label runat="server" resourcekey='<%# CType(Container.DataItem, ParameterInfo).Type %>'>
					<%#CType(Container.DataItem, ParameterInfo).Type%>
				</asp:label>
				<%#IIf(CType(Container.DataItem, ParameterInfo).IsArgumentRequired(), "(" + Convert.ToString(CType(Container.DataItem, ParameterInfo).TypeArgument) + ")", "")%>
				<%#IIf(SupportsFallbackValues andalso CType(Container.DataItem, ParameterInfo).SupportsFallbackValue() andalso cstrn(CType(Container.DataItem, ParameterInfo).TypeArgument).Length>0, "("+ Localization.GetString(LocaleKeys.ParameterFallback, LocalResourceFile) + ": " + Convert.ToString(CType(Container.DataItem, ParameterInfo).TypeArgument) + ")", "")%>
			</itemtemplate>
			<edititemtemplate>
				<asp:label id="lblParamType" runat="server" />
				<asp:DropDownList ID="cboParamType" runat="server" selectedValue='<%# CType(Container.DataItem, ParameterInfo).Type %>'>
					<asp:listitem value="StaticValue" resourcekey="StaticValue">Static Value</asp:listitem>
					<asp:listitem value="PassThrough" resourcekey="PassThrough">QueryString Pass-Through Parameter</asp:listitem>
					<asp:listitem value="FormPassThrough" resourcekey="FormPassThrough">Form Pass-Through Parameter</asp:listitem>
					<asp:listitem value="UserCustomProperty" resourcekey="UserCustomProperty">Custom User Property</asp:listitem>
					<asp:listitem value="PortalID" resourcekey="PortalID">Portal ID</asp:listitem>
					<asp:listitem value="PortalName" resourcekey="PortalName">Portal Name</asp:listitem>
					<asp:listitem value="HomeDirectory" resourcekey="HomeDirectory">HomeDirectory</asp:listitem>
					<asp:listitem value="CurrentCulture" resourcekey="CurrentCulture">CurrentCulture</asp:listitem>
					<asp:listitem value="TabID" resourcekey="TabID">Tab ID</asp:listitem>
					<asp:listitem value="UserID" resourcekey="UserID">User ID</asp:listitem>
					<asp:listitem value="UserUsername" resourcekey="UserUsername">User's Username</asp:listitem>
					<asp:listitem value="UserFirstName" resourcekey="UserFirstName">User's First Name</asp:listitem>
					<asp:listitem value="UserLastName" resourcekey="UserLastName">User's Last Name</asp:listitem>
					<asp:listitem value="UserFullName" resourcekey="UserFullName">User's Full Name</asp:listitem>
					<asp:listitem value="UserEmail" resourcekey="UserEmail">User's Email</asp:listitem>
					<asp:listitem value="UserWebsite" resourcekey="UserWebsite">User's Website</asp:listitem>
					<asp:listitem value="UserIM" resourcekey="UserIM">User's IM</asp:listitem>
					<asp:listitem value="UserStreet" resourcekey="UserStreet">User's Street</asp:listitem>
					<asp:listitem value="UserUnit" resourcekey="UserUnit">User's Unit</asp:listitem>
					<asp:listitem value="UserCity" resourcekey="UserCity">User's City</asp:listitem>
					<asp:listitem value="UserCountry" resourcekey="UserCountry">User's Country</asp:listitem>
					<asp:listitem value="UserRegion" resourcekey="UserRegion">User's Region</asp:listitem>
					<asp:listitem value="UserPostalCode" resourcekey="UserPostalCode">User's Postal Code</asp:listitem>
					<asp:listitem value="UserPhone" resourcekey="UserPhone">User's Phone</asp:listitem>
					<asp:listitem value="UserCell" resourcekey="UserCell">User's Cell</asp:listitem>
					<asp:listitem value="UserFax" resourcekey="UserFax">User's Fax</asp:listitem>
					<asp:listitem value="UserLocale" resourcekey="UserLocale">User's Locale</asp:listitem>
					<asp:listitem value="UserTimeZone" resourcekey="UserTimeZone">User's TimeZone</asp:listitem>
					<asp:listitem value="UserIsAuthorized" resourcekey="UserIsAuthorized">User's Authorized Flag</asp:listitem>
					<asp:listitem value="UserIsLockedOut" resourcekey="UserIsLockedOut">User's Lock Out Flag</asp:listitem>
					<asp:listitem value="UserIsSuperUser" resourcekey="UserIsSuperUser">User's SuperUser Flag</asp:listitem>
					
				</asp:dropdownlist>
				<asp:TextBox ID="txtParamArgument" runat="server" MaxLength="2000" Text='<%# CType(Container.DataItem, ParameterInfo).TypeArgument %>' />
				<asp:label id="lblParamScript" runat="server" />
			</edititemtemplate>
		</asp:templatecolumn>
	</columns>
</asp:datagrid>
<asp:placeholder id="ErrorMessagePlaceHolder" runat="server" />
<p><asp:linkbutton id="cmdAddParam" cssclass="CommandButton" runat="server" resourcekey="cmdAddParam"
		text="Add New Column" causesvalidation="False"></asp:linkbutton>&nbsp;
</p>

