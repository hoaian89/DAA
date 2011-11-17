using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using System.Data;
using System.Data.SqlClient;

public partial class DesktopModules_SM_SG : PortalModuleBase
{
    private SqlConnection conn = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        CheckData();
        SqlDataSource1.SelectParameters["StuId"].DefaultValue = HttpContext.Current.User.Identity.Name;
    }
    public void CheckData()
    {
        try
        {
            SqlCommand cmd = null;
            try
            {
                conn = new SqlConnection(SqlDataSource1.ConnectionString);
                conn.Open();
                cmd = new SqlCommand("Select * from SuggestMark", conn);
                cmd.ExecuteNonQuery();
            }
            catch
            {
                cmd.CommandText = @"CREATE TABLE SuggestMark ( " +
                        @"StuId      nvarchar(10) NOT NULL PRIMARY KEY," +
                        @"TA2Web     float NULL," +
                        @"TA2Info    float NULL, " +
                        @"TTWeb      float NULL, " +
                        @"TTInfo     float NULL, " +
                        @"Memo       ntext NULL, " +
                        @"SDay       smalldatetime, " +
                        @") ";
                cmd.ExecuteNonQuery();
            }

            SqlParameter p = new SqlParameter();
            p.SourceColumn = "StuId";
            p.ParameterName = "@StuId";
            p.Value = HttpContext.Current.User.Identity.Name;
            cmd.Parameters.Add(p);
            cmd.CommandText = "INSERT INTO SuggestMark(StuId,TA2Web,TA2Info,TTWeb,TTInfo,Memo,SDay) VALUES(@StuId,NULL,NULL,NULL,NULL,NULL," + DateTime.Today.ToShortDateString() + ")";
            cmd.ExecuteNonQuery();
        }
        catch
        {

        }
        finally
        {
            conn.Close();
        }
    }
}