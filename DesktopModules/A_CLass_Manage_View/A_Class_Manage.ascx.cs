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
            source.InsertParameters["SubID"].DefaultValue = ClassID.Substring(0, ClassID.Length - 4);

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
        ShowInfo0.Text = !isFound ? "--> Không tìm thấy sinh viên này!" : "--> Tìm thấy";
    }
}