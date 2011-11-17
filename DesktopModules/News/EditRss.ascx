<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EditRss.ascx.vb" Inherits="DotNetNuke.Modules.News.EditRss" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<asp:DataList runat="server" ID="dlFeeds" DataKeyField="FeedId" ItemStyle-CssClass="Normal">
 <ItemTemplate>
  		<asp:imagebutton runat="server" causesvalidation="false" commandname="Edit" imageurl="~/images/edit.gif" alternatetext="Edit" resourcekey="Edit" id="cmdEditFeed" Enabled='<%# IIF(InEditFeedId=0, "True", "False") %>' />
		  <asp:imagebutton id="cmdDeleteFeed" runat="server" causesvalidation="false" commandname="Delete"	imageurl="~/images/delete.gif" alternatetext="Delete" resourcekey="Delete" Enabled='<%# IIF(InEditFeedId=0, "True", "False") %>' />
    <%#DataBinder.Eval(Container.DataItem, "FeedUrl")%>
 </ItemTemplate>
 <EditItemTemplate>
  <table cellspacing="0" cellpadding="2" border="0">
   <tr>
    <td class="SubHead">
     <dnn:label id="plFeedUrl" runat="server" controlname="txtFeedUrl" suffix=":" />
    </td>
    <td>
     <asp:TextBox id="txtFeedUrl" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FeedUrl")  %>' Width="500" />
    </td>
   </tr>
   <tr>
    <td class="SubHead">
     <dnn:label id="plCacheTime" runat="server" controlname="txtCacheTime" suffix=":" />
    </td>
    <td>
     <asp:TextBox id="txtCacheTime" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "CacheTime") %>' />
	    <asp:comparevalidator id="valcompCacheTime" runat="server" controltovalidate="txtCacheTime" display="Dynamic" errormessage="Not a valid (whole) number!" type="Integer" operator="DataTypeCheck" resourcekey="valWholeNumber.Error" />
     <asp:requiredfieldvalidator ID="reqCacheTime" runat="server" errormessage="Required!" ResourceKey="Required.Error" controltovalidate="txtCacheTime" display="Dynamic" />
    </td>
   </tr>
   <tr>
    <td class="SubHead">
     <dnn:label id="plUser" runat="server" controlname="txtUser" suffix=":" />
    </td>
    <td>
     <asp:TextBox id="txtUser" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "User") %>' />
    </td>
   </tr>
   <tr>
    <td class="SubHead">
     <dnn:label id="plPassword" runat="server" controlname="txtPassword" suffix=":" />
    </td>
    <td>
     <asp:TextBox id="txtPassword" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Password") %>' />
    </td>
   </tr>
  </table>
  <br>
  <asp:LinkButton id="cmdUpdateFeed" runat="server" Text="Update" ResourceKey="cmdUpdate" CommandName="update" />
  <asp:LinkButton id="cmdCancelFeed" runat="server" Text="Cancel" ResourceKey="cmdCancel" CommandName="cancel" />
 </EditItemTemplate>
 <FooterTemplate>
  <div style="width:100%;text-align:right;">
   <asp:LinkButton ID="cmdAdd" runat="server" Text="Add" ResourceKey="cmdAdd" CssClass="SubHead" CommandName="Add" />
  </div>
 </FooterTemplate>
</asp:DataList>

<p>
	<asp:linkbutton class="CommandButton" id="cmdUpdate" runat="server" resourcekey="cmdUpdate" text="Update"	borderstyle="none" />&nbsp;
	<asp:linkbutton class="CommandButton" id="cmdCancel" runat="server" resourcekey="cmdCancel" text="Cancel"	borderstyle="none" causesvalidation="False" />
</p>

