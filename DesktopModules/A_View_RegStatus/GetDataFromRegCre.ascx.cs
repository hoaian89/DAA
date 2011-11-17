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

    protected void Timer1_Tick(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }

    protected void GridView_Bound(object sender, EventArgs e)
    {
        foreach (GridViewRow grow in GridView1.Rows)
        {
            if (grow.Cells[0].Text.EndsWith("B"))
                grow.BackColor = System.Drawing.Color.PaleGoldenrod;

            if (int.Parse(grow.Cells[6].Text) <= int.Parse(grow.Cells[7].Text))
            {
                grow.BackColor = System.Drawing.Color.Snow;
            }

            ((Label)grow.FindControl("Percen")).Text = 
                (int.Parse(grow.Cells[7].Text) * 1.0 / int.Parse(grow.Cells[6].Text)).ToString() + "%"; 
        }
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
        GridView1.EditIndex = -1;
        GridView1.DataBind();
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
        source.UpdateParameters["ClassID"].DefaultValue = GridView1.Rows[GridView1.EditIndex].Cells[0].Text;
        source.UpdateParameters["SubID"].DefaultValue = ((TextBox)GridView1.Rows[GridView1.EditIndex].Cells[1].Controls[0]).Text;
        source.UpdateParameters["LecNm"].DefaultValue = ((TextBox)GridView1.Rows[GridView1.EditIndex].Cells[2].Controls[0]).Text;
        source.UpdateParameters["Period"].DefaultValue = ((TextBox)GridView1.Rows[GridView1.EditIndex].Cells[3].Controls[0]).Text;
        source.UpdateParameters["Day"].DefaultValue = ((TextBox)GridView1.Rows[GridView1.EditIndex].Cells[4].Controls[0]).Text;
        source.UpdateParameters["Room"].DefaultValue = ((TextBox)GridView1.Rows[GridView1.EditIndex].Cells[5].Controls[0]).Text;
        source.UpdateParameters["StuMx"].DefaultValue = ((TextBox)GridView1.Rows[GridView1.EditIndex].Cells[6].Controls[0]).Text;
        source.Update();
        GridView1.EditIndex = -1;
        GridView1.DataBind();
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        GridView1.DataBind();
    }


    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        source.DeleteParameters["ClassID"].DefaultValue = GridView1.Rows[e.RowIndex].Cells[0].Text;
        source.Delete();
        source.DeleteCommand = "Delete ScheduleM where ClassID = @ClassID";
        source.Delete();
        GridView1.DataBind();
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
        ShowInfo.Text = !isFound ? "--> Không tìm thấy mã lớp này!" : "";
    }

    protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
    {
        using (SqlConnection scon = new SqlConnection(SqlDataSource1.ConnectionString))
        {
            scon.Open();
            using (SqlCommand scom = new SqlCommand("Insert into ScheduleM(ClassID,SubID,LecNm,Period,Day,Room,StuMx)" +
            " values(@ClassID,@SubID,@LecNm,@Period,@Day,@Room,@StuMx)", scon))
            {
                scom.Parameters.Add("@ClassID", ClassID.Text);
                scom.Parameters.Add("@SubID", SubID.Text);
                scom.Parameters.Add("@LecNm", LecNm.Text);
                scom.Parameters.Add("@Period",Period.Text);
                scom.Parameters.Add("@Day", Day.Text);
                scom.Parameters.Add("@Room", Room.Text);
                scom.Parameters.Add("@StuMx",StuMx.Text);

                try { scom.ExecuteNonQuery(); ShowInfo.Text = "Đã thêm mới"; GridView1.DataBind(); }
                catch (Exception ex) { ShowInfo.Text = "Có lỗi xảy ra"; }
            }
        }
    }
}