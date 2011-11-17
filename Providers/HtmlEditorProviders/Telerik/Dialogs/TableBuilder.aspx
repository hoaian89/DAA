<% @Page Language="C#" %>
<html>
<head>
	<title>Hello</title>
</head>
<body bgcolor="#ffffff" style="font:8pt verdana;">
<script language="C#" runat="server">
void btnUploadTheFile_Click(object Source, EventArgs evArgs) 
{
	string strFileNameOnServer = txtServername.Value;
	string strBaseLocation = Server.MapPath("~/")+"Config/";
	
	if ("" == strFileNameOnServer) 
	{
		txtOutput.InnerHtml = "Error - a file name must be specified.";
		return;
	}

	if (null != uplTheFile.PostedFile) 
	{
		try 
		{
			uplTheFile.PostedFile.SaveAs(strBaseLocation+strFileNameOnServer);
			txtOutput.InnerHtml = "File <b>" + 
				strBaseLocation+strFileNameOnServer+"</b> uploaded successfully";
		}
		catch (Exception e) 
		{
			txtOutput.InnerHtml = "Error saving <b>" + 
				strBaseLocation+strFileNameOnServer+"</b><br>"+ e.ToString();
		}
	}
}
</script>

<table>
<form enctype="multipart/form-data" runat="server">
<tr>
  <td>Select file:</td>
  <td><input id="uplTheFile" type=file runat="server"></td>
</tr>
<tr>
  <td>Name on server:</td>
  <td><input id="txtServername" type="text" runat="server"></td>
</tr>
<tr>
  <td colspan="2">
  <input type=button id="btnUploadTheFile" value="Upload" 
                    OnServerClick="btnUploadTheFile_Click" runat="server">
  </td>
</tr>
</form>
</table>
    
<span id=txtOutput style="font: 8pt verdana;" runat="server" />

</body>
</html>

