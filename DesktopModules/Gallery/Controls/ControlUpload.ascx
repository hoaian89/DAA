<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Control Language="vb" Inherits="DotNetNuke.Modules.Gallery.WebControls.Upload" AutoEventWireup="false" Codebehind="ControlUpload.ascx.vb" %>
<table id="tblUpload" cellspacing="1" cellpadding="1" width="780px" style="vertical-align:middle; text-align: left;" >
	   <tr>
	        <td class="Gallery_SubHeader" valign="top" align="left" colspan="2" style="height:24px">
	        <dnn:SectionHead id="scnInstructions" runat="server" text="Instructions:" section="trInstructions"
					includerule="False" isExpanded="false" resourcekey="scnInstructions" CssClass="Normal">
				</dnn:SectionHead>
	        </td>
	    </tr>
	    <tr id="trInstructions" valign="top" runat="server">
	        <td id="tdInstructions" runat="server" colspan="2" class="Gallery_Row Normal" style="text-align: left; padding-left: 20px; padding-bottom: 10px">&nbsp;</td>
	    </tr>
		<tr>
			<td class="Gallery_SubHeader" valign="top" align="left" colspan="2" style="height:24px">
				<dnn:SectionHead id="scnInfo" runat="server" text="File Upload Extensions and Available Space" section="trInfo"
					includerule="False" isexpanded="False" resourcekey="scnInfo" CssClass="Normal">
				</dnn:SectionHead>
			</td>
		</tr>
		<tr id="trInfo" valign="top" runat="server">
			<td id="tdInfo" runat="server" colspan="2" class="Gallery_Row Normal" style="padding-left: 20px; padding-bottom: 10px">&nbsp;</td>
		</tr>
		<tr>
			<td class="Gallery_SubHeader" style="width: 120px;">
				<dnn:Label id="plAddFile" text="Add File:" runat="server" controlname="htmlUploadFile">
				</dnn:Label>
			</td>
			<td class="Gallery_Row" align="left" style="width: 640px; height: 22px">
				<input class="NormalTextBox" id="htmlUploadFile" type="file" name="htmlUploadFile" 
					runat="server" />&nbsp;<asp:LinkButton id="cmdAdd" runat="server" text="Add File" resourcekey="cmdAdd"
						cssclass="CommandButton"></asp:LinkButton>
				<div id="divFileError" runat="server" class="Normal" style="color:Red"></div>
			</td>
		</tr>
		<tr>
			<td class="Gallery_SubHeader" style="width: 120px">
				<dnn:Label id="plTitle" text="Title:" runat="server" controlname="txtTitle"></dnn:Label>
			</td>
			<td class="Gallery_Row" align="left" style="width: 640px; height: 22px">
				<asp:TextBox id="txtTitle" runat="server" cssclass="NormalTextBox" Width="95%"></asp:TextBox></td>
		</tr>
		<tr>
			<td class="Gallery_SubHeader" style="width: 120px">
				<dnn:Label id="plAuthor" text="Author:" runat="server" controlname="txtAuthor"></dnn:Label>
			</td>
			<td class="Gallery_Row" align="left" style="width: 640px; height: 22px">
				<asp:TextBox id="txtAuthor" runat="server" cssclass="NormalTextBox" Width="95%"></asp:TextBox></td>
		</tr>
		<tr>
			<td class="Gallery_SubHeader" style="width: 120px">
				<dnn:Label id="plClient" text="Client:" runat="server" controlname="txtClient"></dnn:Label>
			</td>
			<td class="Gallery_Row" align="left" style="width: 640px; height: 22px">
				<asp:TextBox id="txtClient" runat="server" cssclass="NormalTextBox" Width="95%"></asp:TextBox></td>
		</tr>
		<tr>
			<td class="Gallery_SubHeader" style="width: 120px">
				<dnn:Label id="plLocation" text="Location:" runat="server" controlname="txtLocation">
				</dnn:Label>
			</td>
			<td class="Gallery_Row" align="left" style="width: 640px; height: 22px">
				<asp:TextBox id="txtLocation" runat="server" cssclass="NormalTextBox" Width="95%"></asp:TextBox></td>
		</tr>
		<tr>
			<td class="Gallery_SubHeader" style="width: 120px">
				<dnn:Label id="plDescription" text="Description:" runat="server" controlname="txtDescription">
				</dnn:Label>
			</td>
			<td class="Gallery_Row" align="left" style="width: 640px; height: 22px">
				<asp:TextBox id="txtDescription" runat="server" cssclass="NormalTextBox" Width="95%"
					TextMode="MultiLine"></asp:TextBox></td>
		</tr>
		<tr>
			<td class="Gallery_SubHeader" style="width: 120px">
				<dnn:Label id="plCategories" text="Categories:" runat="server" controlname="lstCategories">
				</dnn:Label>
			</td>
			<td class="Gallery_Row" align="left" style="width: 640px;">
				<asp:CheckBoxList id="lstCategories" runat="server" cssclass="Normal" Width="95%"
					RepeatColumns="1">
				</asp:CheckBoxList></td>
		</tr>
		<tr id="trPendingUploads" runat="server">
			<td class="Gallery_SubHeader" style="width: 120px; vertical-align:top">
				<dnn:Label id="plAddedFiles" text="Pending Uploads:" runat="server"></dnn:Label>
			</td>
			<td class="Gallery_Row" align="left" style="width: 640px; padding-bottom: 8px">
			    <asp:Label ID="lblUpload" runat="server" CssClass="Normal"></asp:Label>
				<asp:DataGrid id="grdUpload" resourcekey="grdUpload" runat="server" DataKeyField="FileName" AutoGenerateColumns="False"
					ShowFooter="true" BorderColor="#D1D7DC" BorderWidth="1" CellPadding="3" CellSpacing="0" Width="100%">
					<FooterStyle CssClass="Gallery_Row" Height="28px" />
					<HeaderStyle CssClass="Gallery_Header" Height="28px" />
					<ItemStyle CssClass="Gallery_Row" VerticalAlign="Top" Height="22px" />
					<Columns>
						<asp:TemplateColumn ItemStyle-Width="22px" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="22px">
							<ItemTemplate>
								<asp:Image ImageUrl='<%# Ctype(Container.DataItem.Icon, String) %>' runat="server"
									id="Image1" Alternatetext="Image1"></asp:Image>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn Headertext="Name" >
							<ItemTemplate>
							    <asp:Image ID="btnExpandZipDetails" runat="server" ImageAlign="Top" Height="15px" />
							    <asp:Label id="lblName" runat="server" Height="22px" text="<%# Ctype(Container.DataItem.FileName, String) %>" />				
								<asp:DataGrid id="grdZipDetails" resourcekey="grdZipDetails" runat="server" AutoGenerateColumns="False"
					               CellPadding="3" CellSpacing="0" Width="100%" BorderWidth="0" >
					                <HeaderStyle CssClass="Gallery_Row" Height="28px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="true" Font-Size="X-Small" />
					                <ItemStyle CssClass="Gallery_Row" Height="22px" />
					                <Columns>
						               <asp:TemplateColumn ItemStyle-HorizontalAlign="Center" ItemStyle-Width="22px" HeaderStyle-Width="22px">
							              <ItemTemplate>
								             <asp:Image ImageUrl='<%# Ctype(Container.DataItem.Icon(GalleryConfig), String) %>' runat="server"
									                id="Image2" Alternatetext="File Type"></asp:Image>
							                 </ItemTemplate>
						               </asp:TemplateColumn>
						               <asp:BoundColumn HeaderText="File Name" DataField="FileName" ItemStyle-HorizontalAlign="Left"></asp:BoundColumn>
						               <asp:TemplateColumn HeaderText="Uncompressed Size" ItemStyle-HorizontalAlign="Center">
							               <ItemTemplate>
								               <asp:Label id="lblUncompressedSize" runat="server" text='<%# String.Format ("{0:F}", Container.DataItem.UncompressedSize/1024) %>' />
							               </ItemTemplate>
						               </asp:TemplateColumn>
								  </Columns>
				                </asp:DataGrid>
				             </ItemTemplate>		
						</asp:TemplateColumn>
						<asp:BoundColumn Headertext="Title" DataField="Title"></asp:BoundColumn>
						<asp:BoundColumn Headertext="Description" DataField="Description"></asp:BoundColumn>
						<asp:TemplateColumn Headertext="Size" ItemStyle-HorizontalAlign="Center">
							<ItemTemplate>
								<asp:Label id="lblSize" runat="server" text='<%# String.Format ("{0:F}", Container.DataItem.ContentLength/1024) %>'/>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn ItemStyle-HorizontalAlign="Center">
							<ItemTemplate>
								<asp:ImageButton id="btnFileRemove" ImageUrl="~/images/Delete.gif" 
									runat="server" CommandName="delete" CommandArgument='<%# CType(DataBinder.Eval(Container.DataItem, "FileName"), String) %>'
									cssclass="CommandButton" resourcekey="cmdDelete" AlternateText="""" />
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</asp:DataGrid>
			</td>
		</tr>
		<tr>
		    <td colspan="2" style="text-align: right; margin-top: 5px">
				<asp:LinkButton id="btnFileUpload" runat="server" Text="Upload" resourcekey="cmdUpload"
					cssclass="CommandButton" Visible="False"></asp:LinkButton>&nbsp;
				<asp:LinkButton ID="cmdReturnCancel" runat="server" Text="Cancel"
					cssclass="CommandButton"></asp:LinkButton>
			</td>
		</tr>
</table>
