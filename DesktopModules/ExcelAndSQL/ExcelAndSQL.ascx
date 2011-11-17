<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ExcelAndSQL.ascx.cs" Inherits="DesktopModules_ExcelAndSQL_ExcelAndSQL" %>
<div>       
Upload         
    <asp:Button ID="btnImport" runat="server" Text="Import" onclick="btnImport_Click" />
    <asp:FileUpload id="fileupload" runat="server"/>
    <br/>
    <hr/>
Download
    <asp:ListBox ID="lsbTable" runat="server" SelectionMode="Multiple" 
        Width="192px"></asp:ListBox>
    <asp:Button ID="btnExport" runat="server" onclick="btnExport_Click" 
        Text="Export and Download" />
</div>