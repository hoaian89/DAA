using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using DotNetNuke.Entities.Modules;

public partial class DesktopModules_A_CLass_Manage_A_Class_Manage : PortalModuleBase
{
    SqlDataSource source;
    protected void Page_Load(object sender, EventArgs e)
    {
        ShowInfo.Text = "";
    }

    protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
    protected void GridView2_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView2.EditIndex = -1;
        GridView2.DataBind();

    }
    protected void GridView2_Load(object sender, EventArgs e)
    {

    }
    protected void SqlDataSource1_Load(object sender, EventArgs e)
    {
        source = (SqlDataSource)sender;
    }

    protected void GridView2_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        source.UpdateParameters["StuID"].DefaultValue = ((Label)GridView2.Rows[GridView2.EditIndex].FindControl("StuID")).Text;
        source.UpdateParameters["Date"].DefaultValue = ((TextBox)GridView2.Rows[GridView2.EditIndex].FindControl("DateEdit")).Text;

        try { source.Update(); }
        catch (Exception ex) { ShowInfo.Text = ex.Message; }
        GridView2.EditIndex = -1;
        GridView2.DataBind();
    }

    protected void GridView2_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView2.EditIndex = e.NewEditIndex;
        GridView2.DataBind();

    }

    protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        source.DeleteParameters["StuID"].DefaultValue = ((Label)GridView2.Rows[e.RowIndex].FindControl("StuID")).Text;
        
        try { source.Delete(); }
        catch (Exception ex) { ShowInfo.Text = ex.Message; }
        GridView2.DataBind();
    }

    protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "InsertNew")
        {
            string ClassID = DropDownList1.SelectedValue;
            source.InsertParameters["StuID"].DefaultValue = ((TextBox)GridView2.FooterRow.FindControl("StuidFooter")).Text; ;
            source.InsertParameters["ClassID"].DefaultValue = ClassID;
            source.InsertParameters["SubID"].DefaultValue = ClassID.Substring(0, ClassID.LastIndexOf("."));

            using (SqlConnection scon = new SqlConnection(source.ConnectionString))
            {
                scon.Open();
                int i = 0;
                using (SqlCommand scom = new SqlCommand("select Credits from Mark as M , Subject as S where S.SubID = M.SubID and M.SubID = @SubID and StuID = @StuID and Mark >= 50 ", scon))
                {
                    scom.Parameters.Add("@StuID", source.InsertParameters["StuID"].DefaultValue);
                    scom.Parameters.Add("@SubID", source.InsertParameters["SubID"].DefaultValue);

                    try
                    {
                        object o = scom.ExecuteScalar();
                        if (o != null)
                            i = int.Parse(o.ToString());
                    }
                    catch (Exception ex) { }
                }
                source.InsertParameters["Rereg"].DefaultValue = i.ToString();
            }

            try { source.Insert(); }
            catch (Exception ex) { ShowInfo.Text = ex.Message; }

            GridView2.DataBind();
        }
    }

    public string getDate()
    {
        return DateTime.Now.ToString();
    }

    int i = 1;
    public string Count()
    {
        return (i++).ToString();
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        source.SelectCommand = "SELECT R.StuID,StuNm,Date From [RegisterInfo] as R , Student as S where ClassID = @ClassID and S.StuID = R.StuID order by Date DESC";
        GridView2.DataBind();
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        bool isFound = false;
        string Find = FindItem.Text.Trim();
        foreach (GridViewRow row in GridView2.Rows)
        {
            if (((Label)row.FindControl("StuID")).Text.Equals(Find))
            {
                row.BackColor = System.Drawing.Color.Yellow;
                isFound = true;
            }
            else row.BackColor = System.Drawing.Color.Transparent;
        }
        ShowInfo0.Text = !isFound ? "--> Không tìm th?y sinh viên này!" : "--> Tìm th?y";
    }
    
    //  Delete from registerclick
    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        string[] StuIDs = Out.Text.Split('\n');
        string FromClassID = DropDownList3.SelectedValue;
        
        int i = 0;
        using (SqlConnection scon = new SqlConnection(EditMarkSource.ConnectionString))
        {
            scon.Open();
            using (SqlCommand scom = new SqlCommand("Delete From RegisterInfo where StuID = @StuID and ClassID = @FromClassID", scon))
            {
                scom.Parameters.Add("@StuID", "");
                scom.Parameters.Add("@FromClassID", FromClassID);

                foreach (string stuid in StuIDs)
                {
                    scom.Parameters["@StuID"].Value = stuid.Trim().Replace("\r", "");
                    try { i += scom.ExecuteNonQuery(); }
                    catch (Exception ex) { }
                }
            }
        }
    }

	protected void LinkButton9_Click(object sender, EventArgs e)
    {
        string[] StuIDs = InID.Text.Split('\n');
        string FromClassID = AddTo.SelectedValue;
        
        int i = 0;
        using (SqlConnection scon = new SqlConnection(EditMarkSource.ConnectionString))
        {
            scon.Open();
            string error = string.Empty;

            using (SqlCommand scom = new SqlCommand("Insert into RegisterInfo(StuID,ClassID,SubID,Date) values(@StuID,@ClassID,@SubID,getDate())", scon))
            {
                scom.Parameters.Add("@StuID", "");
                scom.Parameters.Add("@ClassID",FromClassID);
                scom.Parameters.Add("@SubID", FromClassID.Substring(0,FromClassID.LastIndexOf(".")));

                foreach (string line in StuIDs)
                {
                    try 
					{ 
	                    scom.Parameters["@StuID"].Value = line.Trim().Replace("\r","");

						i += scom.ExecuteNonQuery(); 
					}
                    catch (Exception ex) { error += "<br/> - " + line; }  
                }
            }

            ShowInf.Text = i.ToString() + error;
        }
    }

    //  Change class button click
    protected void LinkButton3_Click(object sender, EventArgs e)
    {
        string[] StuIDs = In.Text.Split('\n');
        string FromClassID = From.SelectedValue;
        string ToClassID = To.SelectedValue;

        int i = 0;
        using (SqlConnection scon = new SqlConnection(EditMarkSource.ConnectionString))
        {
            scon.Open();
            using (SqlCommand scom = new SqlCommand("Update RegisterInfo Set ClassID = @ToClassID where StuID = @StuID and ClassID = @FromClassID", scon))
            {
                scom.Parameters.Add("@StuID", "");
                scom.Parameters.Add("@FromClassID", FromClassID);
                scom.Parameters.Add("@ToClassID", ToClassID);

                foreach (string stuid in StuIDs)
                {
                    scom.Parameters["@StuID"].Value = stuid.Trim().Replace("\r","");
                    try { i += scom.ExecuteNonQuery(); }
                    catch (Exception ex) { }
                }
            }
        }
    }

    //  Delete button click
    protected void LinkButton4_Click(object sender, EventArgs e)
    {
        string[] Lines = TextBox2.Text.Split('\n');

        int i = 0;
        using (SqlConnection scon = new SqlConnection(EditMarkSource.ConnectionString))
        {
            scon.Open();
            string error = string.Empty;
            using (SqlCommand scom = new SqlCommand("Delete From RegisterInfo where StuID = @StuID and SubID = @SubID", scon))
            {
                scom.Parameters.Add("@StuID", "");
                scom.Parameters.Add("@SubID","");

                foreach (string line in Lines)
                {
                    
                    try 
					{ 
						string[] contents = line.Replace("\r", "").Split(';');
	                    scom.Parameters["@StuID"].Value = contents[0].Trim().Replace("\r", "");
    	                scom.Parameters["@SubID"].Value = contents[1].Trim().Replace("\r", "");

						i += scom.ExecuteNonQuery(); 
					}
                    catch (Exception ex) { error += "<br/> - " + line + " " + ex.Message; }
                }
                ShowInf.Text = i.ToString() + error;
            }   
        }
    }

    // Insert button click
    protected void LinkButton5_Click(object sender, EventArgs e)
    {
        string[] Lines = TextBox1.Text.Split('\n');

        int i = 0;
        using (SqlConnection scon = new SqlConnection(EditMarkSource.ConnectionString))
        {
            scon.Open();
            string error = string.Empty;

            using (SqlCommand scom = new SqlCommand("Insert into RegisterInfo(StuID,ClassID,SubID,Date) values(@StuID,@ClassID,@SubID,getDate())", scon))
            {
                scom.Parameters.Add("@StuID", "");
                scom.Parameters.Add("@ClassID", "");
  

                foreach (string line in Lines)
                {
                   
                    try 
		    { 
		        string[] contents = line.Replace("\r", "").Split(';');
	                scom.Parameters["@StuID"].Value = contents[0].Trim().Replace("\r", "");
    	                string ClassID =  contents[1].Trim().Replace("\r", "");
                        scom.Parameters["@ClassID"].Value = ClassID;
                        scom.Parameters["@SubID"].Value = ClassID.Substring(0, ClassID.Length - 4);

			i += scom.ExecuteNonQuery(); 
		    }
                    catch (Exception ex) { if(ex.Message.Contains("INSERT")) error += "<br/> - " + line; }  
                }
            }

            ShowInf.Text = i.ToString() + error;
        }
    }
}