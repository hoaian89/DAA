using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using DotNetNuke.Entities.Modules;

public partial class DesktopModules_A_Edit_RegisterInfo_A_Edit_RegisterInfo : PortalModuleBase
{
    SqlDataSource source;
    protected void Page_Load(object sender, EventArgs e)
    {
        ShowInfo.Text = "";
    }

    protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        GridView2.DataBind();
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
        string ClassID = ((TextBox)GridView2.Rows[GridView2.EditIndex].FindControl("ClassidEdit")).Text;
        source.UpdateParameters["OldClassID"].DefaultValue = ((HiddenField)GridView2.Rows[GridView2.EditIndex].FindControl("ClassidHidden")).Value;
        source.UpdateParameters["NewClassID"].DefaultValue = ClassID;
        source.UpdateParameters["SubID"].DefaultValue = ClassID.Substring(0, ClassID.Length - 4);

        using (SqlConnection scon = new SqlConnection(source.ConnectionString))
        {
            scon.Open();
            int i = 0;
            using (SqlCommand scom = new SqlCommand("select Credits from Mark as M , Subject as S where S.SubID = M.SubID and M.SubID = @SubID and StuID = @StuID and Mark >= 50 ", scon))
            {
                scom.Parameters.Add("@StuID", FindItem.Text);
                scom.Parameters.Add("@SubID", source.UpdateParameters["SubID"].DefaultValue);

                try
                {
                    object o = scom.ExecuteScalar();
                    if (o != null)
                        i = int.Parse(o.ToString());
                }
                catch (Exception ex) { ShowInfo.Text = ex.Message; }
            }
            source.UpdateParameters["Rereg"].DefaultValue = i.ToString();
        }

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
        source.DeleteParameters["ClassID"].DefaultValue = ((Label)GridView2.Rows[e.RowIndex].FindControl("ClassID")).Text;
        source.DeleteParameters["StuID"].DefaultValue = HttpContext.Current.User.Identity.Name;

        try { source.Delete(); }
        catch (Exception ex) {}
    }

    
}