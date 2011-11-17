<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Moderation.ascx.vb" Inherits="DotNetNuke.Modules.Feedback.Moderation" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.UI.WebControls" Assembly="DotNetNuke" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<table cellspacing="0" cellpadding="4" border="0" width="100%" summary="Moderation Table">
   <tr>
    <td> <asp:linkbutton id="cmdReturn" resourcekey="cmdReturn" runat="server" cssclass="CommandButton" causesvalidation="False">Return</asp:linkbutton>
    </td>
   </tr>
   <tr>
        <td valign="top">
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="left" class="subhead">
                        <br /><br />
                         <dnn:label id="plPendingMessages" runat="server" />
		                <hr />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <dnn:PagingControl id="ctlPagingControl" runat="server"></dnn:PagingControl>
                    </td>
                </tr>
                <tr>
                    <td style="white-space:nowrap;" valign="top">
                        <asp:DataGrid ID="dgPendingFeedback" runat="server" 
                        AutoGenerateColumns="false" width="100%" 
                        CellPadding="6" GridLines="None" cssclass="DataGrid_Container" >
                        <headerstyle cssclass="NormalBold" verticalalign="Top" horizontalalign="left"/>
                        <itemstyle cssclass="Normal" horizontalalign="left" />
                        <alternatingitemstyle cssclass="Normal" />
                        <edititemstyle cssclass="NormalTextBox" />
                        <selecteditemstyle cssclass="NormalRed" />
                        <footerstyle cssclass="DataGrid_Footer" />
                        <pagerstyle cssclass="DataGrid_Pager" />
                        <Columns>
                        <dnn:imagecommandcolumn Text="Publish" ShowImage="false" CommandName="Publish"  EditMode="URL" KeyField="FeedbackID" />
		                <dnn:imagecommandcolumn Text="Set Private" ShowImage="false" CommandName="SetPrivate"  EditMode="URL" keyfield="FeedbackID" />
	                    <dnn:imagecommandcolumn Text="Archive" ShowImage="false" CommandName="Archive"  EditMode="URL" KeyField="FeedbackID" />
		                <dnn:imagecommandcolumn Text="Delete" ShowImage="false" CommandName="Delete" EditMode="Command" KeyField="FeedbackID" />
		               <dnn:textcolumn datafield="Subject" headertext="Subject"/>
		                <dnn:textcolumn datafield="Message" headertext="Message"/>
		                <dnn:textcolumn datafield="CreatedByEmail" headertext="From"/>
		                <dnn:textcolumn datafield="DateCreated" headertext="Create Date"/>
		                </Columns>
		                </asp:DataGrid>
                    </td>
                </tr>
                <tr>
                    <td align="left" class="subhead">
                        <br /><br />
                         <dnn:label id="plPrivateMessages" runat="server" />
		                <hr />
                    </td>
                </tr>
                 <tr>
                    <td align="right">
                        <dnn:PagingControl id="ctlPagingControl2" runat="server"></dnn:PagingControl>
                    </td>
                </tr>
                <tr>
                    <td style="white-space:nowrap;" valign="top">
                        <asp:DataGrid ID="dgPrivateFeedback" runat="server" 
                        AutoGenerateColumns="false" width="100%" 
                        CellPadding="6" GridLines="None" cssclass="DataGrid_Container" >
                        <headerstyle cssclass="NormalBold" verticalalign="Top" horizontalalign="left"/>
                        <itemstyle cssclass="Normal" horizontalalign="left" />
                        <alternatingitemstyle cssclass="Normal" />
                        <edititemstyle cssclass="NormalTextBox" />
                        <selecteditemstyle cssclass="NormalRed" />
                        <footerstyle cssclass="DataGrid_Footer" />
                        <pagerstyle cssclass="DataGrid_Pager" />
                        <Columns>
                        <dnn:imagecommandcolumn Text="Publish" ShowImage="false" CommandName="Publish"  EditMode="URL" KeyField="FeedbackID" />
		                <dnn:imagecommandcolumn Text="Archive" ShowImage="false" CommandName="Archive"  EditMode="URL" KeyField="FeedbackID" />
		                <dnn:imagecommandcolumn Text="Delete" ShowImage="false" CommandName="Delete"   KeyField="FeedbackID" />
		                <dnn:textcolumn datafield="Subject" headertext="Subject"/>
		                <dnn:textcolumn datafield="Message" headertext="Message"/>
		                <dnn:textcolumn datafield="CreatedByEmail" headertext="From"/>
		                <dnn:textcolumn datafield="DateCreated" headertext="Create Date"/>
		                </Columns>
		                </asp:DataGrid>
                    </td>
                </tr>
                 <tr>
                    <td align="left" class="subhead">
                        <br /><br />
                         <dnn:label id="plPublicMessages" runat="server" />
		                <hr />
                    </td>
                </tr>
                 <tr>
                    <td align="right">
                        <dnn:PagingControl id="ctlPagingControl3" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="white-space:nowrap;" valign="top">
                        <asp:DataGrid ID="dgPublicFeedback" runat="server" 
                        AutoGenerateColumns="false" width="100%" 
                        CellPadding="6" GridLines="None" cssclass="DataGrid_Container" >
                        <headerstyle cssclass="NormalBold" verticalalign="Top" horizontalalign="left"/>
                        <itemstyle cssclass="Normal" horizontalalign="left" />
                        <alternatingitemstyle cssclass="Normal" />
                        <edititemstyle cssclass="NormalTextBox" />
                        <selecteditemstyle cssclass="NormalRed" />
                        <footerstyle cssclass="DataGrid_Footer" />
                        <pagerstyle cssclass="DataGrid_Pager" />
                        <Columns>
                        <dnn:imagecommandcolumn Text="Set Private" ShowImage="false" CommandName="SetPrivate"  EditMode="URL" keyfield="FeedbackID" />
	                   <dnn:imagecommandcolumn Text="Archive" ShowImage="false" CommandName="Archive"  EditMode="URL" KeyField="FeedbackID" />
		                <dnn:imagecommandcolumn Text="Delete" ShowImage="false" CommandName="Delete"   KeyField="FeedbackID" />
		                 <dnn:textcolumn datafield="Subject" headertext="Subject"/>
		                <dnn:textcolumn datafield="Message" headertext="Message"/>
		                <dnn:textcolumn datafield="CreatedByEmail" headertext="From"/>
		                <dnn:textcolumn datafield="DateCreated" headertext="Create Date"/>
		                </Columns>
		                </asp:DataGrid>
                    </td>
                </tr>
                 <tr>
                    <td align="left" class="subhead">
                        <br /><br />
                         <dnn:label id="plArchiveMessages" runat="server" />
		                <hr />
                    </td>
                </tr>
                  <tr>
                    <td align="right">
                        <dnn:PagingControl id="ctlPagingControl4" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="white-space:nowrap;"  valign="top">
                        <asp:DataGrid ID="dgArchiveFeedback" runat="server" 
                        AutoGenerateColumns="false" width="100%" 
                        CellPadding="6" GridLines="None" cssclass="DataGrid_Container" >
                        <headerstyle cssclass="NormalBold" verticalalign="Top" horizontalalign="left"/>
                        <itemstyle cssclass="Normal" horizontalalign="left" />
                        <alternatingitemstyle cssclass="Normal" />
                        <edititemstyle cssclass="NormalTextBox" />
                        <selecteditemstyle cssclass="NormalRed" />
                        <footerstyle cssclass="DataGrid_Footer" />
                        <pagerstyle cssclass="DataGrid_Pager" />
                        <Columns>
                        <dnn:imagecommandcolumn Text="Publish" ShowImage="false" CommandName="Publish"  EditMode="URL" KeyField="FeedbackID" />
		                <dnn:imagecommandcolumn Text="Set Private" ShowImage="false" CommandName="SetPrivate"  EditMode="URL" keyfield="FeedbackID" />
	                    <dnn:imagecommandcolumn Text="Delete" ShowImage="false" CommandName="Delete"   KeyField="FeedbackID" />
		                <dnn:textcolumn datafield="Subject" headertext="Subject"/>
		                <dnn:textcolumn datafield="Message" headertext="Message"/>
		                <dnn:textcolumn datafield="CreatedByEmail" headertext="From"/>
		                <dnn:textcolumn datafield="DateCreated" headertext="Create Date"/>
		                </Columns>
		                </asp:DataGrid>
                    </td>
                </tr>
            </table>
        </td>
   </tr>
</table>
