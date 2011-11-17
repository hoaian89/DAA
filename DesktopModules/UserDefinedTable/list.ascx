<%@ Control Language="vb" Inherits="DotNetNuke.Modules.UserDefinedTable.List" AutoEventWireup="false"
    Explicit="True" CodeBehind="List.ascx.vb" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.UI.WebControls" Assembly="DotNetNuke" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<asp:Panel ID="panSearch" Width="100%" CssClass="Normal" runat="server" Visible="false" DefaultButton="cmdSearch">
    <asp:PlaceHolder ID="phSearchSentence" runat="server"/>&nbsp;&nbsp;
    <asp:LinkButton ID="cmdSearch" CssClass="CommandButton" runat="server" resourcekey="cmdSearch"/>&nbsp;&nbsp;
    <asp:LinkButton ID="cmdResetSearch" CssClass="CommandButton" runat="server" resourcekey="cmdResetSearch"/>&nbsp;&nbsp;
    <dnn:Label ID="plSearch" runat="server" Text="" />
    <br />
    <asp:Label ID="lblNoRecordsFound" CssClass="Normal" runat="server" Visible="False" resourcekey="lblNoRecordsFound" />
</asp:Panel>
<asp:GridView ID="grdData" runat="server" Visible="False" EnableViewState="False"
    PagerSettings-Visible="false" GridLines="None" CellPadding="4" AutoGenerateColumns="False"
    AllowSorting="True">
    <AlternatingRowStyle CssClass="Normal UDT_Table_AlternateItem" />
    <RowStyle CssClass="Normal UDT_Table_Item" />
    <HeaderStyle CssClass="NormalBold UDT_Table_Head" />
    <Columns>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.EditLink", "<a href=""{0}""><img src="""+ DotNetNuke.Common.Globals.ResolveUrl ("~/images/edit.gif") +""" alt=""edit"" border=""0""/></a>") %>'>
                </asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
<dnn:PagingControl ID="ctlPagingControl" runat="server" totalrecord="0" PageSize="1" CurrentPage="1" Visible="False" Mode="PostBack" />
<asp:PlaceHolder ID="XslOutput" runat="server" Visible="False" />
