using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using System.Data.SqlClient;
using System.Configuration;

public partial class DesktopModules_C_LichThi_Xem_C_LichThi_Xem : PortalModuleBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblStuID.Text = UserInfo.Username;
        SqlDataSourceExam.SelectParameters["StuID"].DefaultValue = UserInfo.Username;

        using (SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["SiteSqlServer"].ConnectionString))
        {
            con.Open();
            SqlCommand com = new SqlCommand();
            com.Connection = con;
            string sql = "Select PropertyValue from ExamScheduleInfo where PropertyName = ";
            com.CommandText = sql + "'Semester'";
            lblSemester.Text = com.ExecuteScalar().ToString();
            com.CommandText = sql + "'Year'";
            lblYear.Text = com.ExecuteScalar().ToString();
            com.CommandText = sql + "'LastUpdatedTime'";
            lblLastUpdatedTime.Text = com.ExecuteScalar().ToString();
            con.Close();
        }
    }
}