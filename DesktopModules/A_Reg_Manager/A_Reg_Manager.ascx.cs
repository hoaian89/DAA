using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using DotNetNuke.Entities.Modules;
using System.IO;
//using ICSharpCode.SharpZipLib.Checksums;
//using ICSharpCode.SharpZipLib.Zip;
//using ExcelCOM = Microsoft.Office.Interop.Excel;

public partial class DesktopModules_A_Reg_Manager_A_Reg_Manager : PortalModuleBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    DataList datalist;
    protected void DataList1_Load(object sender, EventArgs e)
    {
        datalist = (DataList)sender;
    }

    //  Save data
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
       string Status = ((CheckBox)DataList1.Items[0].FindControl("Status")).Checked.ToString();
       string Term = ((TextBox)DataList1.Items[0].FindControl("Term")).Text.Trim();
       string Year = ((TextBox)DataList1.Items[0].FindControl("Year")).Text.Trim();
       string MinCre = ((TextBox)DataList1.Items[0].FindControl("MinCre")).Text.Trim();
       string MaxCre = ((TextBox)DataList1.Items[0].FindControl("MaxCre")).Text.Trim();
       string User = ((DropDownList)DataList1.Items[0].FindControl("User")).SelectedIndex.ToString();
       string Notice = ((TextBox)DataList1.Items[0].FindControl("Notice")).Text;
       string Times = ((DropDownList)DataList1.Items[0].FindControl("Times")).SelectedValue;

       if( !Term.Equals("1") && !Term.Equals("2") && !Term.ToLower().Equals("hè")
       ||(Year.Length != 4)) return;
       else 
       {
            source.UpdateParameters["Status"].DefaultValue = Status;
            source.UpdateParameters["Term"].DefaultValue = Term;
            source.UpdateParameters["Year"].DefaultValue = Year;
            source.UpdateParameters["MinCre"].DefaultValue = MinCre;
            source.UpdateParameters["MaxCre"].DefaultValue = MaxCre;
            source.UpdateParameters["User"].DefaultValue = User;
            source.UpdateParameters["Notice"].DefaultValue = Notice;
            source.UpdateParameters["Times"].DefaultValue = Times;

            try 
            {
                source.Update(); datalist.DataBind(); 
                ((Label)DataList1.Items[0].FindControl("ShowInfo")).Text = "Thành công !"; 
            }
            catch (Exception ex) 
            {
                ((Label)DataList1.Items[0].FindControl("ShowInfo")).Text = ex.Message; 
            }
       }
    }

    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        //GetData();
    }

    //  Delete all data
    protected void LinkButton4_Click(object sender, EventArgs e)
    {
        if (((CheckBox)DataList1.Items[0].FindControl("Del_Confirm")).Checked)
        {
            try { source.Delete(); ((Label)DataList1.Items[0].FindControl("ShowInfo")).Text = "Thành công!"; }
            catch (Exception ex) { ((Label)DataList1.Items[0].FindControl("ShowInfo")).Text = ex.Message; }
        }
    }

    //  Backupdata
    protected void LinkButton7_Click(object sender, EventArgs e)
    {
        Backup();
    }

    //  Start application
    protected void LinkButton6_Click(object sender, EventArgs e)
    {
        if (((CheckBox)DataList1.Items[0].FindControl("Start_Confirm")).Checked)
        {
            //  Backup database
            Backup();

            //  Delete old data
            try { source.Delete(); }
            catch (Exception ex) { ((Label)DataList1.Items[0].FindControl("ShowInfo")).Text = ex.Message; return; }

            //  Set to start module
            string Status = "1";
            string Term = ((TextBox)DataList1.Items[0].FindControl("Term")).Text.Trim();
            string Year = ((TextBox)DataList1.Items[0].FindControl("Year")).Text.Trim();
            string MinCre = ((TextBox)DataList1.Items[0].FindControl("MinCre")).Text.Trim();
            string MaxCre = ((TextBox)DataList1.Items[0].FindControl("MaxCre")).Text.Trim();
            string User = ((DropDownList)DataList1.Items[0].FindControl("User")).SelectedIndex.ToString();
            string Notice = ((TextBox)DataList1.Items[0].FindControl("Notice")).Text;
            string Times = ((DropDownList)DataList1.Items[0].FindControl("Times")).SelectedIndex.ToString();

            if (!Term.Equals("1") && !Term.Equals("2") && !Term.ToLower().Equals("hè")
            || (Year.Length != 4)) return;
            else
            {
                source.UpdateParameters["Status"].DefaultValue = Status;
                source.UpdateParameters["Term"].DefaultValue = Term;
                source.UpdateParameters["Year"].DefaultValue = Year;
                source.UpdateParameters["MinCre"].DefaultValue = MinCre;
                source.UpdateParameters["MaxCre"].DefaultValue = MaxCre;
                source.UpdateParameters["User"].DefaultValue = User;
                source.UpdateParameters["Notice"].DefaultValue = Notice;
                source.UpdateParameters["Times"].DefaultValue = Times;

                try { source.Update(); datalist.DataBind(); ((Label)DataList1.Items[0].FindControl("ShowInfo")).Text = "Thành công !"; }
                catch (Exception ex) { ((Label)DataList1.Items[0].FindControl("ShowInfo")).Text = ex.Message; }
            }
        }

    }

    //  Backup database
    public void Backup()
    {
        using (SqlConnection scon = new SqlConnection(source.ConnectionString))
        {
            scon.Open();
            string BackupID = "Register_Backup";
            using (SqlCommand scom = new SqlCommand("Select * into Register_Backup_0 from RegisterInfo", scon))
            {
                scom.Parameters.Add("@BackupID", "");
                int i;
                for (i = 0; i < 5; i++)
                {
                    try
                    {
                        scom.ExecuteNonQuery();
                        try
                        {
                            scom.Parameters["@BackupID"].Value = BackupID + "_" + i.ToString();
                            scom.CommandText = "Insert into BackupLog values (@BackupID,getDate())";
                            scom.ExecuteNonQuery();
                            break;
                        }
                        catch (Exception ex)
                        {
                            scom.CommandText = "Update BackupLog set log = getDate() where Backup = @BackupID";
                            scom.ExecuteNonQuery();
                        }
                    }
                    catch (Exception ex)
                    {
                        scom.CommandText = "Select * into " + BackupID + "_" + (i + 1).ToString() + " from RegisterInfo";
                    }
                }

                if (i >= 5)
                {
                    scom.CommandText = " Select * from [BackupLog] where Log = (select Min(Log) from BackupLog)";
                    SqlDataReader sreader = scom.ExecuteReader();
                    sreader.Read();
                    BackupID = sreader.GetValue(0).ToString();
                    
                    if (sreader.HasRows)
                    {
                        sreader.Close();
                        scom.CommandText = "Drop table " + BackupID;
                        scom.ExecuteNonQuery();
                        scom.CommandText = "Select * into " + BackupID + " from RegisterInfo";
                        scom.ExecuteNonQuery();
                        try
                        {
                            scom.Parameters["@BackupID"].Value = BackupID;
                            scom.CommandText = "Insert into BackupLog values (@BackupID,getDate())";
                            scom.ExecuteNonQuery();
                        }
                        catch (Exception ex)
                        {
                            scom.CommandText = "Update [BackupLog] set [log] = getDate() where [Backup] = @BackupID";
                            scom.ExecuteNonQuery();
                        }
                    }

                }

            }
        }
        ((DropDownList)DataList1.Items[0].FindControl("BackupDrop")).DataBind();
    }

    //  Restore Data
    public void Restore()
    {
        if (((CheckBox)DataList1.Items[0].FindControl("Restore_Confirm")).Checked)
        {
            using (SqlConnection scon = new SqlConnection(source.ConnectionString))
            {
                scon.Open();
                using (SqlCommand scom = new SqlCommand("Drop table RegisterInfo", scon))
                {

                    try { scom.ExecuteNonQuery(); }
                    catch (Exception ex) { }
                    try
                    {
                        scom.CommandText = "Select * into RegisterInfo from " +
                            ((DropDownList)DataList1.Items[0].FindControl("BackupDrop")).SelectedValue;
                        scom.ExecuteNonQuery();
                    }
                    catch (Exception ex) { }
                }
            }
        }
    }
        
    SqlDataSource source;
    protected void RegManageDB_Load(object sender, EventArgs e)
    {
        source = (SqlDataSource)sender;
    }

    protected void Restore_Click(object sender, EventArgs e)
    {
        //  Restore data from Dropdownlist
        Restore();
    }

    protected void Down_List_Each_Class(object sender, ImageClickEventArgs e)
    {
        string FileName = Server.MapPath("~\\Data\\Data_Count_List_Class.bin");
        if (File.Exists(FileName)) File.Delete(FileName);
        StreamWriter swriter = new StreamWriter(FileName);

        using(SqlConnection scon = new SqlConnection(source.ConnectionString))
        {
            scon.Open();
            using(SqlCommand scom = new SqlCommand("Select ClassID,count(*) from RegisterInfo group by ClassID",scon))
            {
                try
                {
                    SqlDataReader sreader = scom.ExecuteReader();
                    while (sreader.Read())
                    {
                        string ClassID = sreader.GetValue(0).ToString();
                        string count = sreader.GetValue(1).ToString();
                        swriter.WriteLine(ClassID + " " + count);
                    }
                    sreader.Close();
                }catch(Exception ex){}

                swriter.WriteLine("Suggest");

                scom.CommandText = "select SubID,count(*) from SuggestionInfo group by SubID";
                try
                {
                    SqlDataReader sreader = scom.ExecuteReader();
                    while (sreader.Read())
                    {
                        string SubID = sreader.GetValue(0).ToString();
                        string count = sreader.GetValue(1).ToString();
                        swriter.WriteLine(SubID + " " + count);
                    }
                    sreader.Close();
                }
                catch (Exception ex) { }
            }

        }

        swriter.Close();
        Response.ClearContent();
        Response.ClearHeaders();
        Response.ContentType = "application/bin";
        Response.AddHeader
        ("Content-Disposition", "attachment; filename = Data_Count_List_Class.bin");
        Response.TransmitFile(FileName);
        Response.End();
        Response.Flush();
        Response.Clear();
    }

    protected void Down_List_Class(object sender, ImageClickEventArgs e)
    {
        string FileName = Server.MapPath("~\\Data\\Data_Class_List_Final.bin");
        if (File.Exists(FileName)) File.Delete(FileName);
        StreamWriter swriter = new StreamWriter(FileName);

        using (SqlConnection scon = new SqlConnection(source.ConnectionString +
        ";MultipleActiveResultSets = True;"))
        {
            //  Get classID from ScheduleM 
            scon.Open();
            using (SqlCommand scom = new SqlCommand("Select distinct classID from RegisterInfo", scon))
            {
                try
                {
                    //  Each ClassID
                    SqlDataReader sreader = scom.ExecuteReader();
                    bool isFirst = true;
                    while (sreader.Read())
                    {
						try
						{
                        string ClassId = sreader.GetValue(0).ToString();
                        string SubID = " ";
						try 
						{
                            SubID = ClassId.Substring(0, ClassId.LastIndexOf("."));
						}
						catch(Exception ex){}
                        string SubNm = " ";

                        if(isFirst) isFirst = false;
                        else  swriter.WriteLine(";");
						
                        swriter.WriteLine(ClassId);  //   Write ClassID
                        using (SqlCommand scom2 = new SqlCommand("select SubNm from Subject where SubID = @SubID", scon))
                        {
                            scom2.Parameters.Add("@SubID", SubID);
                            try{SubNm = scom2.ExecuteScalar().ToString();} catch(Exception ex){}
                        }
                        swriter.WriteLine(SubNm);  //   Write ClassID

                        using (SqlCommand scom1 = new SqlCommand("Select R.StuID,StuNm from RegisterInfo as R ,Student as S " +
                        "where  R.StuId = S.StuId  and ClassID = @ClassID order by Date ASC", scon))
                        {
                            scom1.Parameters.Add("@ClassID", ClassId);
                            try
							{
								SqlDataReader sreader1 = scom1.ExecuteReader();
	                            while(sreader1.Read())
    	                        {
        	                        swriter.WriteLine(sreader1.GetValue(0).ToString() + ";" + sreader1.GetValue(1).ToString());   
            	                }
							}catch(Exception ex){}
                        }
						}catch(Exception ex){}
                        
                    }
                }catch(Exception ex){}
            }
        }

        swriter.Close();
        Response.ClearContent();
        Response.ClearHeaders();
        Response.ContentType = "application/bin";
        Response.AddHeader
        ("Content-Disposition", "attachment; filename = Data_Class_List_Final.bin");
        Response.TransmitFile(FileName);
        Response.End();
        Response.Flush();
        Response.Clear();
       
    }

    protected void Down_List_Fee(object sender, ImageClickEventArgs e)
    {
        string FileName = Server.MapPath("~\\Data\\Data_Fee_List.bin");
        if (File.Exists(FileName)) File.Delete(FileName);
        StreamWriter swriter = new StreamWriter(FileName);

        using (SqlConnection scon = new SqlConnection(source.ConnectionString + ";MultipleActiveResultSets = True;"))
        {
            scon.Open();
            using (SqlCommand scom = new SqlCommand("Select R.StuID , StuNm , Sum(Credits) from RegisterInfo as R ,Student as S, Subject as Su "+
            " where S.StuID = R.StuID and R.SubID = Su.SubID group by R.StuID , StuNm", scon))
            {
                try
                {
                    SqlDataReader sreader = scom.ExecuteReader();
                    while (sreader.Read()) 
                    {
                        string StuID = sreader.GetValue(0).ToString();
                        string StuNM = sreader.GetValue(1).ToString();
                        string NumCredits = sreader.GetValue(2).ToString();
                        string Subjects = string.Empty;

                        using(SqlCommand scom1 = new SqlCommand("Select R.SubID,Credits from RegisterInfo as R, Subject as S  where R.SubID = S.SubID and StuID = @StuID",scon))
                        {
                            scom1.Parameters.Add("@StuID",StuID);
                            try
                            {
                                SqlDataReader sreader1 = scom1.ExecuteReader();

                                sreader1.Read();
                                Subjects += sreader1.GetValue(0).ToString() + "(" + sreader1.GetValue(1).ToString() + ")";

                                while (sreader1.Read())
                                {
                                    Subjects += "," + sreader1.GetValue(0).ToString() + "(" + sreader1.GetValue(1).ToString() + ")";
                                }
                            }
                            catch (Exception ex) { }
                        }
                        swriter.WriteLine(StuID + ";" + StuNM + ";" + Subjects + ";" + NumCredits);
                    }
                    sreader.Close();
                }
                catch (Exception ex) { }

            }

        }

        swriter.Close();
        Response.ClearContent();
        Response.ClearHeaders();
        Response.ContentType = "application/bin";
        Response.AddHeader
        ("Content-Disposition", "attachment; filename = Data_Fee_List.bin");
        Response.TransmitFile(FileName);
        Response.End();
        Response.Flush();
        Response.Clear();
    }
}