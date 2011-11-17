<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.Modules.UserDefinedTable.EditForm"
    CodeBehind="Form.ascx.vb" %>
<div runat="server" id="divForm" class="UDT_Form">
    <asp:Table ID="tblEditForm" runat="server" summary="Edit User Defined Design Table"
        Visible="false">
    </asp:Table>
    <asp:PlaceHolder runat="server" ID="placeholderEditForm" Visible="false"></asp:PlaceHolder>
    <div class="UDT_Buttons" >
        <span style="padding-right: 100px; white-space: nowrap">
            <asp:Label resourcekey="RequiredFootnote" runat="server" CssClass="Normal" ID="lblRequiredFootnote">* required</asp:Label>
        </span>
        <asp:LinkButton ID="cmdUpdate" Text="Update" runat="server" resourcekey="cmdUpdate"
            cssclass="CommandButton UDT_Default" BorderStyle="none" />
        &nbsp;
        <asp:LinkButton ID="cmdCancel" Text="Cancel" CausesValidation="False" resourcekey="cmdCancel"
            runat="server" cssclass="CommandButton UDT_Cancel" BorderStyle="none" />
        &nbsp;
        <asp:LinkButton ID="cmdDelete" Text="Delete" CausesValidation="False" resourcekey="cmdDelete"
            runat="server" class="CommandButton UDT_Delete" BorderStyle="none" />
        <asp:Button ID="cmdUpdateButton" Text="Update" runat="server" resourcekey="cmdUpdate"
          CssClass="UDT_Default"   />
        &nbsp;
        <asp:Button ID="cmdCancelButton" Text="Cancel" CausesValidation="False" resourcekey="cmdCancel"
            runat="server" CssClass="UDT_Cancel"  />
        &nbsp;
        <asp:Button ID="cmdDeleteButton" Text="Delete" CausesValidation="False" resourcekey="cmdDelete"
            runat="server"  CssClass="UDT_Delete"/>
    </div>
</div>
