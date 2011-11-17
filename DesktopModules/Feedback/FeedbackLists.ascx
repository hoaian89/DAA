<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" Codebehind="FeedbackLists.ascx.vb" Inherits="DotNetNuke.Modules.Feedback.FeedbackLists" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.UI.WebControls" Assembly="DotNetNuke" %>

<table cellspacing="0" cellpadding="4" border="0" width="100%" summary="Feedback Lists Table">
   <tr>
       <td class="SubHead" style="white-space:nowrap;" align="center" colspan="2">
		    <dnn:label id="plListType" runat="server" controlname="rbListType"/>
		    <asp:RadioButtonList ID="rbListType" runat="server" RepeatDirection="Horizontal" cssclass="NormalTextBox" AutoPostBack="true">
		        <asp:ListItem  Value="1" Selected="true" resourceKey="Categories"/>
		        <asp:ListItem  Value="2" resourceKey="Subjects"/>
		    </asp:RadioButtonList>
	    </td>
   </tr>
   <tr>
        <td valign="top">
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td valign="top">
                        <asp:DataGrid ID="dgItems" runat="server"
                        AutoGenerateColumns="false" width="100%" 
                        CellPadding="2" GridLines="None" cssclass="DataGrid_Container" >
                        <headerstyle cssclass="NormalBold" verticalalign="Top" horizontalalign="Center"/>
                        <itemstyle cssclass="Normal" horizontalalign="center" />
                        <alternatingitemstyle cssclass="Normal" />
                        <edititemstyle cssclass="NormalTextBox" />
                        <selecteditemstyle cssclass="NormalRed" />
                        <footerstyle cssclass="DataGrid_Footer" />
                        <pagerstyle cssclass="DataGrid_Pager" />
                        <Columns>
                       <dnn:imagecommandcolumn CommandName="MoveUp" ImageUrl="~/images/up.gif" EditMode="URL" KeyField="ListID" />
		               <dnn:imagecommandcolumn CommandName="MoveDown" ImageUrl="~/images/dn.gif" EditMode="URL" KeyField="ListID" />
		               <dnn:imagecommandcolumn CommandName="Edit" ImageUrl="~/images/edit.gif" EditMode="URL" KeyField="ListID" />
		                <dnn:imagecommandcolumn Commandname="Delete" imageurl="~/images/delete.gif" keyfield="ListID" />
	                    <dnn:textcolumn  datafield="Name" HeaderText="Name" />
		                <dnn:textcolumn datafield="ListValue" HeaderText="ListValue" />
		               
		                    <asp:TemplateColumn HeaderText="IsActive">
						        <HeaderStyle HorizontalAlign="center" CssClass="NormalBold"></HeaderStyle>
						        <ItemStyle HorizontalAlign="center" CssClass="Normal"></ItemStyle>
						        <ItemTemplate>
							        <asp:Image runat="server" ImageUrl='<%# IIf(DataBinder.Eval(Container.DataItem, "IsActive") = 1, "~/images/checked.gif", "~/images/unchecked.gif") %>' ID="Image2"/>
						        </ItemTemplate>
						    </asp:TemplateColumn>
		              </Columns>
		                  </asp:DataGrid>
                    </td>
                </tr>
            </table>
        </td>
        <td style="width:60%;">
            <table border="0" cellspacing="0" cellpadding="0" width="100%" style="text-align:left;">
               
                <tr>
                    <td class="SubHead" >
                         <dnn:label id="plListName" runat="server" controlname="txtBoxListName"/>
                    </td>
                    <td class="SubHead">
                     <asp:HiddenField ID="txtListID" runat="server" />
                    <asp:TextBox width="150px" ID="txtBoxListName" runat="server" TextMode="SingleLine" MaxLength="50" cssclass="NormalTextBox" />
                    <asp:requiredfieldvalidator id="valtxtBoxListName" runat="server" cssclass="NormalRed" display="Dynamic"
				            controltovalidate="txtBoxListName" resourcekey="valtxtBoxListName" ValidationGroup="FeedbackList" />
		
                    </td>
                </tr>
                 <tr>
                    <td class="SubHead" >
                         <dnn:label id="plListValue" runat="server" controlname="txtBoxListValue"/>
                    </td>
                    <td class="SubHead">
                        <asp:TextBox ID="txtBoxListValue" width="150px" runat="server" TextMode="SingleLine" MaxLength="100" cssclass="NormalTextBox" />
                         	<asp:requiredfieldvalidator id="valtxtBoxListValue" runat="server" cssclass="NormalRed" display="Dynamic"
				            controltovalidate="txtBoxListValue" resourcekey="valtxtBoxListValue" ValidationGroup="FeedbackList" />
		    
                    </td>
                </tr>
                <tr>
                    <td class="SubHead" >
                         <dnn:label id="plIsActive" runat="server" controlname="checkBoxIsActive"/>
                    </td>
                    <td class="SubHead"><asp:CheckBox ID="checkBoxIsActive" runat="server" ></asp:Checkbox></td>
                </tr>
                <tr runat="server" id="trErrorRow" visible="false">
                    <td colspan="2">
                         <asp:label id="plErrorMsg" runat="server" resourcekey="plErrorMsg" cssclass="NormalRed"></asp:label>
                        
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="left">
                        <asp:linkbutton id="cmdSaveEntry" ValidationGroup="FeedbackList" resourcekey="cmdSave" runat="server" cssclass="CommandButton" causesvalidation="True" />&nbsp;
			            <asp:linkbutton id="cmdReturn" ValidationGroup="FeedbackList" resourcekey="cmdReturn" runat="server" cssclass="CommandButton" causesvalidation="False" />
			   
			        </td>
                </tr>
            </table>
        </td>
   </tr>
</table>