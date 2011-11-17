<%@ Control Language="VB" AutoEventWireup="false" Inherits="DotNetNuke.Modules.UserDefinedTable.TemplateList"
    CodeBehind="TemplateList.ascx.vb" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<asp:Label CssClass="Normal" ID="litTemplates" runat="server" />
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="TemplateDataSource"
    PagerSettings-Visible="false" BorderWidth="0px" GridLines="None" CellPadding="4">
    <AlternatingRowStyle CssClass="Normal UDT_Table_AlternateItem" />
    <RowStyle CssClass="Normal UDT_Table_Item" />
    <HeaderStyle CssClass="NormalBold UDT_Table_Head" />
    <Columns>
        <asp:TemplateField ShowHeader="False">
            <ItemTemplate>
                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Select"
                    resourcekey="Select.Text" CssClass="CommandButton"></asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
        <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
    </Columns>
    <PagerSettings Visible="False" />
</asp:GridView>
<asp:ObjectDataSource ID="TemplateDataSource" runat="server" SelectMethod="TemplateList"
    TypeName="DotNetNuke.Modules.UserDefinedTable.TemplateController" />
<div class="Normal" style="margin-top: 15px">
    <asp:Label ID="Description" runat="server" />
</div>
<div>
    <dnn:CollectionEditorControl runat="server" ID="TemplateCustomValuesEditor" EditorDataField="Editor"
        EnableClientValidation="False" GroupByMode="None" NameDataField="Caption" ValueDataField="Value"
        LengthDataField="Length" VisibleDataField="TrueColumn" AutoGenerate="true" HelpDisplayMode="Never"
        EditControlStyle-CssClass="NormalTextBox" ErrorStyle-CssClass="NormalRed" GroupHeaderStyle-CssClass="Head"
        EditControlStyle-Width="525px" GroupHeaderIncludeRule="True" HelpStyle-CssClass="Help"
        LabelStyle-CssClass="SubHead" VisibilityStyle-CssClass="Normal" Width="700px" >
    </dnn:CollectionEditorControl>
    <asp:LinkButton CssClass="CommandButton" runat="server" ID="cmdApply" resourcekey="Select"
        Visible="False" />
</div>
