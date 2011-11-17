using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using DotNetNuke.Entities.Modules;

public partial class DesktopModules_A_Edit_Subject_A_Edit_Subject : PortalModuleBase
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
        source.UpdateParameters["SubID"].DefaultValue = ((TextBox)GridView2.Rows[GridView2.EditIndex].FindControl("SubidEdit")).Text;
        source.UpdateParameters["SubNm"].DefaultValue = ((TextBox)GridView2.Rows[GridView2.EditIndex].FindControl("SubnmEdit")).Text;
        source.UpdateParameters["Credits"].DefaultValue = ((TextBox)GridView2.Rows[GridView2.EditIndex].FindControl("CreditsEdit")).Text;
        source.UpdateParameters["Typ"].DefaultValue = ((TextBox)GridView2.Rows[GridView2.EditIndex].FindControl("TypEdit")).Text;

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

    protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "InsertNew")
        {
            source.InsertParameters["SubID"].DefaultValue = ((TextBox)GridView2.FooterRow.FindControl("SubidFooter")).Text;
            source.InsertParameters["SubNm"].DefaultValue = ((TextBox)GridView2.FooterRow.FindControl("SubnmFooter")).Text;
            source.InsertParameters["Credits"].DefaultValue = ((TextBox)GridView2.FooterRow.FindControl("CreditsFooter")).Text;
            source.InsertParameters["Typ"].DefaultValue = ((TextBox)GridView2.FooterRow.FindControl("TypFooter")).Text;
            source.Insert();
            GridView2.DataBind();
        }
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        int CurrentPage = GridView2.PageIndex;
        bool isFound = false;

        for (int i = 0; i < GridView2.PageCount; i++)
        {
            GridView2.PageIndex = i;
            GridView2.DataBind();
            foreach (GridViewRow row in GridView2.Rows)
            {
                if ((((Label)row.FindControl("lSubID")).Text.ToLower().Equals(FindItem.Text.ToLower())))
                {
                    row.BackColor = System.Drawing.Color.Yellow;
                    isFound = true;
                }
                else row.BackColor = System.Drawing.Color.Transparent;
            }
            if (isFound) break;
        }
        if (!isFound) GridView2.PageIndex = CurrentPage;
        ShowInfo.Text = !isFound ? "--> Không tìm thấy mã lớp này!" : "";
    }
}