<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewComments.ascx.cs" Inherits="SuonLight.Modules.News.ViewComments" %>
<%@ Register TagPrefix="dnn" Src="~/controls/LabelControl.ascx" TagName="Label" %>
<asp:ListView ID="lvComments" DataKeyNames="Id" runat="server" 
    onitemdatabound="lvComments_ItemDataBound" 
    onitemcommand="lvComments_ItemCommand" >
<LayoutTemplate>
    <table cellpadding="0" cellspacing="0" border="0" width="100%">
        <tbody>
            <tr runat="server" id="itemPlaceholder"></tr>
        </tbody>
        <tfoot>        
            <tr>
               <td width="10%">&nbsp;</td> 
               <td><asp:TextBox runat="server" ID="txtContent" TextMode="MultiLine" Width="100%" Rows="5" ></asp:TextBox></td> 
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td><asp:Button ID="btnSubmit" runat="server" Text="Bình luận" CommandName="AddComment" CommandArgument='<%# Eval("Id") %>' /></td>
            </tr>
        </tfoot>
    </table>
</LayoutTemplate>
<EmptyDataTemplate>    
    <table cellpadding="0" cellspacing="0">
    <tr>
        <td>
            &nbsp;
        </td>
        <td>
            <span style="color:Red">Chưa có comment.</span>
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;
        </td>
        <td>
            <asp:TextBox ID="txtContent" runat="server" TextMode="MultiLine" Rows="5" Width="100%"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>
            <asp:Button ID="btnSubmit" runat="server" Text="Bình luận" CommandName="EmptyComment" />
        </td>
    </tr>
    </table>
</EmptyDataTemplate>
<ItemTemplate>
<tr>        
    <td>
        <asp:Image ID="imgAvatar" runat="server" ImageUrl="" Width="50px" Height="50px"/>
        <br />
        <asp:Label ID="lblDisplayName" runat="server"></asp:Label>        
    </td>
    <td>
        <asp:Label ID="lblContent" runat="server" ></asp:Label>   
        <hr />     
        <asp:Label ID="lblRelyContent" runat="server"></asp:Label>
        <asp:HyperLink ID="hplRely" runat="server" Text="Trả lời">                      
         </asp:HyperLink>
         <asp:LinkButton ID="lnkbtnDelete" runat="server" CommandName="DeleteComment" CommandArgument='<%# Eval("ID") %>' Text="Xóa" Visible='<%# IsEditable %>'></asp:LinkButton>
    </td>
</tr>
</ItemTemplate>
</asp:ListView>
