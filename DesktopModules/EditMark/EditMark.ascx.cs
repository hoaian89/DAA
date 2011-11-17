using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using DotNetNuke.Entities.Modules;

public partial class DesktopModules_EditMark_EditMark : PortalModuleBase
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
        source.SelectParameters["StuId"].DefaultValue = FindItem.Text;
    }
    protected void GridView2_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        source.UpdateParameters["SubID"].DefaultValue = ((TextBox)GridView2.Rows[GridView2.EditIndex].FindControl("SubidEdit")).Text;
        source.UpdateParameters["Term"].DefaultValue = ((TextBox)GridView2.Rows[GridView2.EditIndex].FindControl("TermEdit")).Text;
        source.UpdateParameters["Ayear"].DefaultValue = ((TextBox)GridView2.Rows[GridView2.EditIndex].FindControl("AyearEdit")).Text;
        source.UpdateParameters["Mark"].DefaultValue = ((TextBox)GridView2.Rows[GridView2.EditIndex].FindControl("MarkEdit")).Text;
        
        source.Update();
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
        source.DeleteParameters["SubID"].DefaultValue = ((Label)GridView2.Rows[e.RowIndex].FindControl("lSubID")).Text;
        source.Delete();
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        GridView2.DataBind();
    }

    protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "InsertNew")
        {
            source.InsertParameters["StuID"].DefaultValue = FindItem.Text;
            source.InsertParameters["SubID"].DefaultValue = ((TextBox)GridView2.FooterRow.FindControl("SubidFooter")).Text;
            source.InsertParameters["Term"].DefaultValue = ((TextBox)GridView2.FooterRow.FindControl("TermFooter")).Text;
            source.InsertParameters["Ayear"].DefaultValue = ((TextBox)GridView2.FooterRow.FindControl("AyearFooter")).Text;
            source.InsertParameters["Mark"].DefaultValue = ((TextBox)GridView2.FooterRow.FindControl("MarkFooter")).Text;
            source.Insert();
            GridView2.DataBind();
        }
    }
}