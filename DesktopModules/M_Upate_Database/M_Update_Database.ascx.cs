
using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using DotNetNuke.Entities.Modules;
//using DotNetNuke.ComponentModel.
public partial class DesktopModules_M_Upate_Database_M_Update_Database : PortalModuleBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (DotNetNuke.Framework.AJAX.IsInstalled())
            {
                DotNetNuke.Framework.AJAX.RegisterScriptManager();                
            }
        }
        
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SiteSqlServer"].ToString();
        SqlConnection connection = new SqlConnection(connectionString);
        connection.Open();
        SqlCommand insertCmd = new SqlCommand("Insert into Subject(SubId,SubNm,Credits) values(@NewSubId,@SubNm,@Credits)", connection);
        SqlDataAdapter adapter = new SqlDataAdapter("select * from Subject where SubID=\'" + txtSubId.Text + "\'", connection);
        DataSet ds=new DataSet();
        adapter.Fill(ds);
        insertCmd.Parameters.Add(new SqlParameter("@SubNm",ds.Tables[0].Rows[0]["SubNm"]));
        insertCmd.Parameters.Add(new SqlParameter("@Credits",txtTC.Text));
        insertCmd.Parameters.Add(new SqlParameter("@NewSubId", txtNewSubId.Text));
        try
        {
            lblError.Text = "";
            insertCmd.ExecuteNonQuery();
        }
        catch(SqlException err) {
            lblError.Text = err.Message;
            connection.Close();
            return;
        }

        SqlCommand cmd = new SqlCommand("Update Mark set SubId=@NewSubId where SubId=@SubId and StuId in (select stu.StuId from Student stu where stu.dept=@dept and LEFT(stu.StuId,2)=@makhoa)", connection);
        cmd.Parameters.Add(new SqlParameter("@dept",txtDept.Text));
        cmd.Parameters.Add(new SqlParameter("@makhoa",txtCourse.Text));
        cmd.Parameters.Add(new SqlParameter("@NewSubId",txtNewSubId.Text));
        cmd.Parameters.Add(new SqlParameter("@SubId", txtSubId.Text));
        cmd.ExecuteNonQuery();
        connection.Close();       
 
        txtCourse.Text = "";
        txtDept.Text = "";
        txtNewSubId.Text = "";
        txtSubId.Text = "";
        txtTC.Text = "";             
    }
}
