using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using System.Data.SqlClient;
using System.IO;
using ICSharpCode.SharpZipLib.Checksums;
using ICSharpCode.SharpZipLib.Zip;
using ExcelCOM = Microsoft.Office.Interop.Excel;

public partial class DesktopModules_A_GetData_RegCre_GetDataFromRegCre : PortalModuleBase
{
    SqlDataSource source;
    protected void Page_Load(object sender, EventArgs e)
    {
        ShowInfo.Text = "";
        //ScriptManager.RegisterStartupScript(this.GridView1,this.GetType(), "refresh", "window.setTimeout('window.location.reload(true);',5000);", true);
    }

    protected void Page_UnLoad(object sender, EventArgs e)
    {
        Timer1.Enabled = false;
        Timer1.Dispose();
    }

    protected void Timer1_Tick(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }

    protected void GridView_Bound(object sender, EventArgs e)
    {
        foreach (GridViewRow grow in GridView1.Rows)
        {
            
            if (int.Parse(grow.Cells[8].Text) <= int.Parse(grow.Cells[9].Text))
            {
                grow.BackColor = System.Drawing.Color.Snow;
            }

		    if (grow.Cells[1].Text.EndsWith("B"))
                grow.BackColor = System.Drawing.Color.PaleGoldenrod;

            if (((HiddenField)grow.FindControl("isClosed")).Value == "True")
                grow.BackColor = System.Drawing.Color.Red;


            ((Label)grow.FindControl("Percen")).Text = 
                String.Format("{0:0}",int.Parse(grow.Cells[9].Text) * 100.0 / int.Parse(grow.Cells[8].Text) ) + "%"; 
        }
    }

    int order = 1;
    public int getOrder()
    {
        return order++;
    }

    public string getCenterWithSpace(string s)
    {
        if (s != null) return s.Replace(",", "<br/>&nbsp;&nbsp;");
        else return "";
    }

    public string getCenter(string s)
    {
        if (s != null) return s.Replace(",", "<br/>");
        else return "";
    }
    /*
    protected void GetDataBT_Click(object sender, EventArgs e)
    {
        GetData();
    }

    private void GetData()
    {
        List<string> f = new List<string>();
        ExcelCOM.Application exApp;
        ExcelCOM.Workbook exBook;
        string workbookPath = Server.MapPath("~\\Bangdiem\\DKHP\\Template.xls");
        try
        {
            exApp = new ExcelCOM.Application();
            exBook = exApp.Workbooks.Open(workbookPath, 0, false, 5, "", "", false, ExcelCOM.XlPlatform.xlWindows, "",
            true, false, 0, true, false, false);
        }
        catch (Exception ex) { throw new ArgumentException(ex.Message); }

        using (SqlConnection scon = new SqlConnection(
        System.Configuration.ConfigurationManager.ConnectionStrings["SiteSqlServer"].ToString() +
        ";MultipleActiveResultSets = True;"))
        {
            //  Get classID from ScheduleM 
            scon.Open();
            using (SqlCommand scom = new SqlCommand("Select classID from ScheduleM", scon))
            {
                try
                {
                    SqlDataReader sreader = scom.ExecuteReader();
                    while (sreader.Read())
                    {
                        using (SqlCommand scom1 = new SqlCommand("Select R.StuID,StuNm from RegisterInfo as R ,Student as S " +
                        "where  R.StuId = S.StuId  and ClassID = @ClassID", scon))
                        {
                            scom1.Parameters.Add("@ClassID", sreader.GetValue(0).ToString());
                            SqlDataReader sreader1 = scom1.ExecuteReader();

                            exBook = exApp.Workbooks.Open(workbookPath,
                            0, false, 5, "", "", false, ExcelCOM.XlPlatform.xlWindows, "",
                            true, false, 0, true, false, false);

                            int i = 0;
                            string ClassId = sreader.GetValue(0).ToString();
                            string SubID = ClassId.Substring(0, ClassId.Length - 4);

                            ExcelCOM.Worksheet exSheet = (ExcelCOM.Worksheet)exBook.Worksheets[1];
                            try
                            {
                                using (SqlCommand scom2 = new SqlCommand("select SubNm from Subject where SubID = @SubID", scon))
                                {
                                    scom2.Parameters.Add("@SubID", SubID);
                                    exSheet.Cells[2, 3] = scom2.ExecuteScalar().ToString();
                                }
                                exSheet.Name = ClassId;
                                exSheet.Cells[2, 5] = ClassId;
                            }
                            catch (Exception ex) { }

                            //  Get all student register with class
                            while (sreader1.Read())
                            {
                                string im = (i + 9).ToString();

                                ExcelCOM.Range r = (ExcelCOM.Range)exSheet.get_Range("A" + im, "B" + im).EntireRow;
                                r.Insert(-4121, i + 9);

                                exSheet.Cells[i + 8, 1] = (i + 1).ToString();
                                exSheet.Cells[i + 8, 2] = sreader1.GetValue(0).ToString();
                                exSheet.Cells[i + 8, 3] = sreader1.GetValue(1).ToString();
                                i++;
                            }
                            string path = Server.MapPath("~\\Bangdiem\\Lop\\VM-" + SubID
                                + "-" + ClassId.Substring(ClassId.Length - 3, 3) + ".xls");
                            if (File.Exists(path)) File.Delete(path);
                            f.Add(path);
                            exApp.Visible = false;
                            exBook.SaveAs(path, ExcelCOM.XlFileFormat.xlWorkbookNormal, null, null, false, false,
                            ExcelCOM.XlSaveAsAccessMode.xlExclusive, false, false, false, false, false);
                            exBook.Close(false, false, false);
                        }
                    }
                }
                catch (Exception ex) { }
            }
        }

        //  Close appli
        exApp.Quit();
        System.Runtime.InteropServices.Marshal.ReleaseComObject(exBook);
        System.Runtime.InteropServices.Marshal.ReleaseComObject(exApp);

        string filename = string.Format("~\\Bangdiem\\Lop\\DKHP_Data_{0}.{1}.{2}.rar",
            DateTime.Now.Day, DateTime.Now.Month, DateTime.Now.Year);
        WriteZipFile(f, Server.MapPath(filename), 0);

        Response.Redirect(filename);
    }

    private static void WriteZipFile(List<string> filesToZip, string path, int compression)
    {
        if (compression < 0 || compression > 9)
            throw new ArgumentException("Invalid compression rate.");

        if (!Directory.Exists(new FileInfo(path).Directory.ToString()))
            throw new ArgumentException("The Path does not exist.");

        foreach (string c in filesToZip)
            if (!File.Exists(c))
                throw new ArgumentException(string.Format("The File{0}does not exist!", c));


        Crc32 crc32 = new Crc32();
        ZipOutputStream stream = new ZipOutputStream(File.Create(path));
        stream.SetLevel(compression);

        for (int i = 0; i < filesToZip.Count; i++)
        {
            ZipEntry entry = new ZipEntry(Path.GetFileName(filesToZip[i]));
            entry.DateTime = DateTime.Now;

            using (FileStream fs = File.OpenRead(filesToZip[i]))
            {
                byte[] buffer = new byte[fs.Length];
                fs.Read(buffer, 0, buffer.Length);
                entry.Size = fs.Length;
                fs.Close();
                crc32.Reset();
                crc32.Update(buffer);
                entry.Crc = crc32.Value;
                stream.PutNextEntry(entry);
                stream.Write(buffer, 0, buffer.Length);
            }
        }
        stream.Finish();
        stream.Close();
    }
    */

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        
    }
    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
       
    }
    protected void GridView1_Load(object sender, EventArgs e)
    {
        
    }
    protected void SqlDataSource1_Load(object sender, EventArgs e)
    {
        source = (SqlDataSource)sender;
    }
    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
       
    }


    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        bool isFound = false;
        foreach (GridViewRow row in GridView1.Rows)
        {
            if (row.Cells[0].Text.Equals(FindItem.Text))
            {
                row.BackColor = System.Drawing.Color.Yellow;
                isFound = true;
            }
            else row.BackColor = System.Drawing.Color.Transparent;
        }
        ShowInfo.Text = !isFound ? "--> Không tìm th?y mã l?p này!" : "";
    }

    protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
    {
    }
}