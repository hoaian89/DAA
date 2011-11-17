<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExecuteQuery.aspx.cs" Inherits="ExecuteQuery" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <br />
        <asp:Label ID="Label1" runat="server" Text="SQL Query :  "></asp:Label>
&nbsp;
        <asp:TextBox ID="SAtxt" runat="server" Width="874px"></asp:TextBox>
        <br />
        <br />
    
    </div>
    &nbsp;&nbsp;
    <asp:Button ID="SAbtnExecute" runat="server" Text="Execute" Width="87px" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="SALB" runat="server" Text="Label"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Button ID="btnExport" runat="server" Text="Export" Width="97px" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="LBExport" runat="server" Text="Label"></asp:Label>
    <br />
    <br />
    <br />
    <asp:GridView ID="SAGrid" runat="server">
    </asp:GridView>
    <asp:Label ID="LBError" runat="server" Text="LBError"></asp:Label>
    </form>
</body>
</html>
