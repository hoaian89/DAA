<%@ Control Language="vb" AutoEventWireup="false" Inherits="DotNetNuke.Modules.Help.CategoryEdit" Codebehind="CategoryEdit.ascx.vb" %>
<%@ Register TagPrefix="Portal" TagName="URL" Src="~/controls/URLControl.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.UI.WebControls" Assembly="DotNetNuke.WebControls" %>
<%@ Register TagPrefix="dnnLabel" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<table cellSpacing="0" cellPadding="5" width="80%" border="0">
	<tr>
		<td vAlign="top" noWrap align="left"><DNN:DNNTREE id="DNNTree1" cssclass="CommandButton" runat="server"></DNN:DNNTREE></td>
		<td vAlign="top" align="right"><asp:panel id="pnlDetails" runat="server">
				<TABLE>
					<TR>
						<TD class="SubHead" vAlign="top">
							<dnnLabel:label id="plName" runat="server" text="Name:" controlname="txtName"></dnnLabel:label></TD>
						<TD vAlign="top">
							<asp:TextBox id="txtName" cssclass="NormalTextBox" runat="server" Width="250px"></asp:TextBox>
							<asp:RequiredFieldValidator id="valCategoryNameRequired" runat="server" Text="<BR>Category Name Required." ControlToValidate="txtName"
								Display="Dynamic" ErrorMessage="<BR>Category Name Required." resourcekey="valCategoryNameRequired" CssClass="NormalRed"></asp:RequiredFieldValidator></TD>
					</TR>
					<TR>
						<TD class="SubHead" vAlign="top">
							<dnnLabel:label id="plDescription" runat="server" text="Description:" controlname="txtDescription"></dnnLabel:label></TD>
						<TD vAlign="top">
							<asp:TextBox id="txtDescription" cssclass="NormalTextBox" runat="server" Width="250px" TextMode="MultiLine"
								MaxLength="500" Rows="12"></asp:TextBox></TD>
					</TR>
					<TR id="imagerow" runat="server" visible="false">
						<TD class="SubHead" vAlign="top">
							<dnnLabel:Label id="plImage" runat="server" text="Image:" controlname="ctlURL"></dnnLabel:Label></TD>
						<TD vAlign="top" noWrap>
							<portal:url id="ctlURL" runat="server" FileFilter="jpg,jpeg,jpe,gif,bmp,png,swf" Required="False"
								width="250px"></portal:url></TD>
					</TR>
					<TR>
						<TD class="SubHead" vAlign="top">
							<dnnLabel:Label id="plKeywords" runat="server" text="Keywords:" controlname="txtKeywords"></dnnLabel:Label></TD>
						<TD vAlign="top">
							<asp:TextBox id="txtKeywords" cssclass="NormalTextBox" runat="server" Width="250px" TextMode="MultiLine"></asp:TextBox></TD>
					</TR>
					<TR>
						<TD class="SubHead" vAlign="top" colSpan="2" height="2">
							<HR>
						</TD>
					</TR>
					<TR>
						<TD class="SubHead" vAlign="top">
							<dnnLabel:Label id="plVisible" runat="server" text="Visible:" controlname="chkVisible"></dnnLabel:Label></TD>
						<TD vAlign="top">
							<asp:CheckBox id="chkVisible" runat="server"></asp:CheckBox></TD>
					</TR>
					<TR>
						<TD class="SubHead" vAlign="top">
							<dnnLabel:Label id="plParent" runat="server" text="Parent:" controlname="cboParent"></dnnLabel:Label></TD>
						<TD vAlign="top">
							<asp:DropDownList id="cboParent" cssclass="NormalTextBox" runat="server" Width="250px"></asp:DropDownList></TD>
					</TR>
					<TR>
						<TD class="SubHead" vAlign="top">
							<dnnLabel:Label id="plViewOrder" runat="server" text="View Order:" controlname="cmdUp"></dnnLabel:Label></TD>
						<TD vAlign="top">
							<asp:imagebutton id="cmdUp" runat="server" alternatetext="Move Tab Up In Current Level" commandname="up"
								imageurl="~/images/up.gif"></asp:imagebutton>
							<asp:imagebutton id="cmdDown" runat="server" alternatetext="" commandname="down" imageurl="~/images/dn.gif"></asp:imagebutton>
							<asp:imagebutton id="cmdRefresh" runat="server" alternatetext="Refresh View Order" commandname="refresh"
								imageurl="~/DesktopModules/Help/refresh.gif"></asp:imagebutton></TD>
					</TR>
					<TR id="MessageRow" runat="server" Visible="False">
						<TD align="left" colSpan="2" height="36">
							<asp:Label id="lblMessage" runat="server" CssClass="NormalRed"></asp:Label></TD>
					</TR>
					<TR>
						<TD align="right" colSpan="2" height="36">
							<asp:LinkButton id="cmdUpdate" runat="server" Text="Update" resourcekey="cmdUpdate" CssClass="CommandButton"></asp:LinkButton>&nbsp;
							<asp:LinkButton id="lnkDelete" runat="server" Text="Delete" resourcekey="cmdDelete" CssClass="CommandButton">Delete</asp:LinkButton>&nbsp;
							<asp:LinkButton id="cmdAddNew" runat="server" Text="Add New" resourcekey="cmdAddNew" CssClass="CommandButton"
								Visible="False"></asp:LinkButton>&nbsp;
							<asp:LinkButton id="cmdAddSibling" runat="server" Text="Add Sibling" resourcekey="cmdAddSibling"
								CssClass="CommandButton"></asp:LinkButton>&nbsp;
							<asp:LinkButton id="cmdAddChild" runat="server" Text="Add Child" resourcekey="cmdAddChild" CssClass="CommandButton"></asp:LinkButton></TD>
					</TR>
					<TR>
						<TD align="right" colSpan="2"></TD>
					</TR>
				</TABLE>
			</asp:panel></td>
	</tr>
	<TR>
		<TD vAlign="top" noWrap align="center" colSpan="2"><asp:linkbutton id="lnkBackToStore" runat="server" Text="Back" resourcekey="lnkBackToStore" CssClass="CommandButton"
				CausesValidation="False"></asp:linkbutton></TD>
	</TR>
</table>

