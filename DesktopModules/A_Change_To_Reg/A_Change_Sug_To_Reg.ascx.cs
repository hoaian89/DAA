using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using DotNetNuke.Entities.Modules;

public partial class DesktopModules_A_Change_Form_Sug_To_Reg_A_Change_Sug_To_Reg : PortalModuleBase
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Change_Click(object sender, EventArgs e)
    {
        
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        string s = TextBox1.Text;
        string []sA = s.Split('\n');
        
        int i = 0;
        string Error="";

        using (SqlConnection scon = new SqlConnection(System.Configuration.ConfigurationManager.
        ConnectionStrings["SiteSqlServer"].ToString() + ";MultipleActiveResultSets = True;"))
        {
            scon.Open();
            using (SqlCommand scom2 = new SqlCommand("", scon))
            {
                foreach(string si in sA)
                {
                    scom2.CommandText = si.Replace("\r","");
                    try { i += scom2.ExecuteNonQuery();}
                    catch (Exception ex) {  Error += scom2.CommandText; }
                }
            }
        }
        ShowInfo.Text = i.ToString() + " dòng được tác động! <br/>" + Error;
    }
}