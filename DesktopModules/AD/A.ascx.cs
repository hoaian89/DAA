using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Security.Roles;
using DotNetNuke.Security.Membership;
using DotNetNuke.Entities.Users;
using DotNetNuke.Entities.Host;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Data.SqlClient;
using System.Linq;
using DAA;

public partial class DesktopModules_A_A : PortalModuleBase
{
    public string sH = "";
    private string dataDir = "Data\\Bangdiem";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {

            if (DotNetNuke.Framework.AJAX.IsInstalled())
            {
                DotNetNuke.Framework.AJAX.RegisterScriptManager();
            }
            loadDirs();
            LoadFiles();
        }

    }

    string loadSubName(string ClassID)
    {           
        try
        {
            using (SqlConnection scon = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SiteSqlServer"].ToString()))
            {
                scon.Open();
                using (SqlCommand scom = new SqlCommand("Select Top 1 SubNm from Subject where SubID = @SubID", scon))
                {
                    scom.Parameters.Add("@SubID", ClassID);
                    return " - " + (string)scom.ExecuteScalar();
                }
            }
        }
        catch (Exception ex) { return string.Empty; }
        return "";
    }

    //  get list of dirs in main directory
    void loadDirs()
    {
        try
        {
            string dirPath = Server.MapPath(dataDir);
            DirectoryInfo mainDir = new DirectoryInfo(dirPath);
            foreach (DirectoryInfo dir in mainDir.GetDirectories())
            {
                DropDownList2.Items.Add(new ListItem(dir.Name.Replace("He","Hè").Replace("nam","năm").Replace("Diem","Điểm"), dir.Name));
            }

            DropDownList2.SelectedIndex = 0;

        }
        catch (Exception ex) { }
    }

    //  get all files in dir
    void LoadFiles()
    {
        try
        {
            string dir = Server.MapPath(dataDir + "\\" + DropDownList2.SelectedValue);
            DirectoryInfo dr = new DirectoryInfo(dir);
            FileInfo[] listFiles = dr.GetFiles();

            var sortedList =
                from d in listFiles
                orderby d.Name
                select d;
            var listArray = sortedList.ToArray();

            string subIDM = string.Empty;
            string subNm = string.Empty;
            string spaces = string.Empty;

            foreach (FileInfo f in listArray)
            {
                if (f.Extension.Equals(".xls") || f.Extension.Equals(".xlsx"))
                {
                    string fileName = f.Name.ToUpper().StartsWith("VM-") ? f.Name.ToUpper().Replace("VM-", "") : f.Name.ToUpper();
                    string className = fileName.Replace("-",".").Substring(0, fileName.LastIndexOf("."));
                    string subID = className.Contains(".") ? className.Substring(0, className.LastIndexOf(".")) : className;

                    if (subID != subIDM)
                    {
                        subNm = (!subID.Equals(className) ? loadSubName(subID) : "");
                        spaces = string.Empty;
                        for (int i = 0; i < (subNm.Length - 3 )/ 2 + 5 ; i++)
                            spaces += "&nbsp;";
                        subIDM = subID;
                        DropDownList1.Items.Add(new ListItem(className + subNm, f.Name));

                    }
                    else
                    {
                        DropDownList1.Items.Add(new ListItem(Server.HtmlDecode(className + spaces + "\""), f.Name));
                    }
                }

            }

            //  load decription
            string fileReadme = dir + "\\Readme.txt";
            FileInfo readmeFile = new FileInfo(fileReadme);
            Label2.Text = string.Empty;
            if (readmeFile.Exists)
            {
                StreamReader reader = new StreamReader(fileReadme);
                while (!reader.EndOfStream)
                    Label2.Text += reader.ReadLine() + "<br/>";
            }
        }
        catch (Exception ex) { }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        LoadClassMark();
    }

    void LoadClassMark()
    {
        try
        {
            string s = Server.MapPath(dataDir + "\\" + DropDownList2.SelectedValue + "\\" + DropDownList1.SelectedValue);
            OleDbConnection oleDbConnection = new OleDbConnection();
            oleDbConnection.ConnectionString =
            "Provider=Microsoft.Jet.OLEDB.4.0;" +
            @"Data Source=" +
            @"" + s + ";" +
            @"Extended Properties=""Excel 8.0;" +
            @"HDR=Yes;IMEX=1"";";
            oleDbConnection.Open();
            DataTable dtSheets = oleDbConnection.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
            OleDbCommand ocom = new OleDbCommand();
            ocom.Connection = oleDbConnection;
            OleDbDataAdapter od = new OleDbDataAdapter("select * from [" +
                dtSheets.Rows[0]["TABLE_NAME"].ToString().Replace("#", ".") + "]", oleDbConnection);
            DataSet ds = new DataSet();
            od.Fill(ds);

            int i = 0;
            bool isIn = false;
            foreach (DataRow row in ds.Tables[0].Rows)
            {
                try
                {
                    int.Parse(row[0].ToString());  // check
                    sH +=
                    "<tr height='21' align='center'>" +
                    "<td>" + row[0] + "&nbsp;</td>" +
                    "<td>" + row[1] + "&nbsp;</td>" +
                    "<td>" + row[2] + "&nbsp;</td>" +
                    "<td>" + row[3] + "&nbsp;</td>" +
                    "<td>" + row[4] + "&nbsp;</td>" +
                    "<td>" + row[5] + "&nbsp;</td>" +
                    "<td>" + row[6] + "&nbsp;</td>" +
                    "<td>" + row[7] + "&nbsp;</td>" +
                    "<td>" + row[8] + "&nbsp;</td>" +
                  "</tr>";
                    i++;
                    if(!isIn) isIn = true;
                }
                catch (Exception ex1) { if(isIn) break ; }
            }
            if (i <= 22)
            {
                string header = "<div style='vertical-align: top; height:" + 21 * i + "px; width:700px; overflow:auto;'>";
                sH = TemplateClassMarkCol + header + tableTem + sH;
            }
            else
            {
                string header = "<div style='vertical-align: top; height:570px; width:700px; overflow:auto;'>";
                sH = TemplateClassMarkExpand + header + tableTem + sH;
            }

            sH += "</table></div>";

            ds.Dispose();
            oleDbConnection.Close();
            oleDbConnection.Dispose();
            Label1.Text = Server.HtmlDecode(sH);
        }
        catch (Exception ex)
        {
            Label1.Text = ex.Message;
        }
    }

    #region TemplateTable

    string TemplateClassMarkExpand = "<div style='vertical-align: top; height:80px; width:700px; overflow:auto;'>" +
              "<table cellspacing='0' cellpadding='0' border='1' align='center' width='96%'>" +
              "<col width ='35'/>" +
              "<col width='15%' />" +
              "<col width='35%' />" +
              "<col width='7%'/>" +
              "<col width='7%' />" +
              "<col width='7%' />" +
              "<col width='6%' />" +
              "<col width='8%' />" +
              "<col width='9%' />" +
              "<tr height='80' align='center' bgcolor='#E7FDCE'>" +
                "<td height='68'>TT</td>" +
                "<td >M&atilde; s&#7889; SV</td>" +
                "<td >H&#7885; v&agrave; t&ecirc;n sinh    vi&ecirc;n</td>" +
                "<td >&#272;i&#7875;m TB <br/>b&agrave;i <br/>t&#7853;p<br/>(20%)</td>" +
                "<td >&#272;i&#7875;m <br />" +
                 " thi gi&#7919;a k&#7923;<br/>(30%)</td>" +
                "<td >&#272;i&#7875;m<br />" +
                 " thi cu&#7889;i <br/>k&#7923;<br/>(50%)</td>" +
                "<td >&#272;i&#7875;m <br />" +
                "  h&#7885;c ph&#7847;n</td>" +
                "<td >&#272;i&#7875;m ch&#7919;</td>" +
                "<td >Ghi ch&uacute;</td>" +
              "</tr></table></div>";

    string TemplateClassMarkCol = "<div style='vertical-align: top; height:100px; width:700px; overflow:auto;'>" +
              "<table cellspacing='0' cellpadding='0' border='1' align='center' width='96%'>" +
              "<col width ='35'/>" +
              "<col width='15%' />" +
              "<col width='35%' />" +
              "<col width='7%'/>" +
              "<col width='7%' />" +
              "<col width='7%' />" +
              "<col width='6%' />" +
              "<col width='8%' />" +
              "<col width='9%' />" +
              "<tr height='80' align='center' bgcolor='#E7FDCE'>" +
                "<td height='68'>TT</td>" +
                "<td >M&atilde; s&#7889; SV</td>" +
                "<td >H&#7885; v&agrave; t&ecirc;n sinh    vi&ecirc;n</td>" +
                "<td >&#272;i&#7875;m TB <br/>b&agrave;i <br/>t&#7853;p<br/>(20%)</td>" +
                "<td >&#272;i&#7875;m <br />" +
                 " thi gi&#7919;a k&#7923;<br/>(30%)</td>" +
                "<td >&#272;i&#7875;m<br />" +
                 " thi cu&#7889;i <br/>k&#7923;<br/>(50%)</td>" +
                "<td >&#272;i&#7875;m <br />" +
                "  h&#7885;c ph&#7847;n</td>" +
                "<td >&#272;i&#7875;m ch&#7919;</td>" +
                "<td >Ghi ch&uacute;</td>" +
              "</tr></table></div>";
    string tableTem =
            "<table cellspacing='0' cellpadding='0' border='1' align='center' width='96%'>" +
              "<col width ='35'/>" +
              "<col width='15%' />" +
              "<col width='35%' />" +
              "<col width='7%'/>" +
              "<col width='7%' />" +
              "<col width='7%' />" +
              "<col width='6%' />" +
              "<col width='8%' />" +
              "<col width='9%' />";
    #endregion
    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList1.Items.Clear();
        LoadFiles();
    }
}
