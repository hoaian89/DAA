using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities;
using DotNetNuke.Entities.Modules;
using System.Data.SqlClient;
using System.Configuration;
using System.Globalization;
using System.Threading;

public partial class DesktopModules_C_LichThi_QuanLy_C_LichThi_QuanLy : PortalModuleBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["SiteSqlServer"].ConnectionString))
        {
            con.Open();
            SqlCommand com = new SqlCommand();
            com.Connection = con;
            string sql = "Select PropertyValue from ExamScheduleInfo where PropertyName = ";
            if (!Page.IsPostBack)
            {
                com.CommandText = sql + "'Semester'";
                txtSemester.Text = com.ExecuteScalar().ToString();
                com.CommandText = sql + "'Year'";
                txtYear.Text = com.ExecuteScalar().ToString();
            }
            com.CommandText = sql + "'LastUpdatedTime'";
            lblUpdatedTime.Text = com.ExecuteScalar().ToString();
            con.Close();
        }
    }
    
    protected void GridExamSchedule_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        SqlDataSourceExam.DeleteParameters["ClassID"].DefaultValue = ((Label)GridExamSchedule.Rows[e.RowIndex].FindControl("lblClassID")).Text;
        SqlDataSourceExam.Delete();

        SqlDataSourceExamInfo.UpdateParameters["PropertyName"].DefaultValue = "LastUpdatedTime";
        SqlDataSourceExamInfo.UpdateParameters["PropertyValue"].DefaultValue = DateTime.Now.ToString("dd-MM-yyyy, hh:mm");
        SqlDataSourceExamInfo.Update();
    }
    protected void GridExamSchedule_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridExamSchedule.EditIndex = e.NewEditIndex;
        GridExamSchedule.DataBind();
    }
    protected void GridExamSchedule_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        SqlDataSourceExam.UpdateParameters["ClassID"].DefaultValue = ((Label)GridExamSchedule.Rows[GridExamSchedule.EditIndex].FindControl("lblClassID")).Text;
        SqlDataSourceExam.UpdateParameters["Date"].DefaultValue = ((TextBox)GridExamSchedule.Rows[GridExamSchedule.EditIndex].FindControl("DateEdit")).Text;
        SqlDataSourceExam.UpdateParameters["Period"].DefaultValue = ((TextBox)GridExamSchedule.Rows[GridExamSchedule.EditIndex].FindControl("PeriodEdit")).Text;
        SqlDataSourceExam.UpdateParameters["Room"].DefaultValue = ((TextBox)GridExamSchedule.Rows[GridExamSchedule.EditIndex].FindControl("RoomEdit")).Text;

        SqlDataSourceExam.Update();

        SqlDataSourceExamInfo.UpdateParameters["PropertyName"].DefaultValue = "LastUpdatedTime";
        SqlDataSourceExamInfo.UpdateParameters["PropertyValue"].DefaultValue = DateTime.Now.ToString("dd-MM-yyyy, hh:mm");
        SqlDataSourceExamInfo.Update();

        GridExamSchedule.EditIndex = -1;
        GridExamSchedule.DataBind();
    }
    protected void GridExamSchedule_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridExamSchedule.EditIndex = -1;
        GridExamSchedule.DataBind();
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        SqlDataSourceExam.InsertParameters["ClassID"].DefaultValue = txtClassID.Text;
        SqlDataSourceExam.InsertParameters["Date"].DefaultValue = calDate.SelectedDate.ToShortDateString();
        SqlDataSourceExam.InsertParameters["Period"].DefaultValue = txtPeriod.Text;
        SqlDataSourceExam.InsertParameters["Room"].DefaultValue = txtRoom.Text;
        SqlDataSourceExam.Insert();

        SqlDataSourceExamInfo.UpdateParameters["PropertyName"].DefaultValue = "LastUpdatedTime";
        SqlDataSourceExamInfo.UpdateParameters["PropertyValue"].DefaultValue = DateTime.Now.ToString("dd-MM-yyyy, hh:mm");
        SqlDataSourceExamInfo.Update();

        GridExamSchedule.DataBind();
    }
    protected void btnChangeYear_Click(object sender, EventArgs e)
    {
        if (txtYear.Text.Trim().Length != 0)
        {
            SqlDataSourceExamInfo.UpdateParameters["PropertyValue"].DefaultValue = txtYear.Text;
            SqlDataSourceExamInfo.UpdateParameters["PropertyName"].DefaultValue = "Year";
            SqlDataSourceExamInfo.Update();
        }
    }
    protected void btnChangeSemester_Click(object sender, EventArgs e)
    {
        if (txtSemester.Text.Trim().Length != 0)
        {
            SqlDataSourceExamInfo.UpdateParameters["PropertyValue"].DefaultValue = txtSemester.Text;
            SqlDataSourceExamInfo.UpdateParameters["PropertyName"].DefaultValue = "Semester";
            SqlDataSourceExamInfo.Update();
        }
    }
    protected void btnDeleteAll_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["SiteSqlServer"].ConnectionString))
        {
            con.Open();
            SqlCommand com = new SqlCommand();
            com.Connection = con;
            com.CommandText = "DELETE FROM [ExamSchedule]";
            com.ExecuteNonQuery();
            con.Close();
        }
        SqlDataSourceExamInfo.UpdateParameters["PropertyName"].DefaultValue = "LastUpdatedTime";
        SqlDataSourceExamInfo.UpdateParameters["PropertyValue"].DefaultValue = DateTime.Now.ToString("dd-MM-yyyy, hh:mm");
        SqlDataSourceExamInfo.Update();

        GridExamSchedule.DataBind();
    }
}