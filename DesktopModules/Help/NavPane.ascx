<%@ Register TagPrefix="dnnLabel" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Control Language="vb" AutoEventWireup="false" Inherits="DotNetNuke.Modules.Help.NavPane" Codebehind="NavPane.ascx.vb" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.UI.WebControls" Assembly="DotNetNuke.WebControls" %>
<table height="10" cellSpacing="0" cellPadding="0" border="0">
	<tr vAlign="top">
		<td height="1" nowrap colspan="2"><DNN:DNNTREE id="DNNTree1" runat="server" cssclass="CommandButton"></DNN:DNNTREE>
		</td>
	</tr>
	<TR>
		<TD noWrap height="1">
			<asp:TextBox id="txtSearch" runat="server" Width="100px"></asp:TextBox>
			<asp:Button id="btnSearch" runat="server" Text="Go" resourcekey="btnSearch"></asp:Button>
		</TD>
		<TD noWrap height="1">
		</TD>
	</TR>
</table>

