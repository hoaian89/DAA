using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using System.Data.SqlClient;

public partial class DesktopModules_A_Del_Suggest_A_Del_Suggest : PortalModuleBase
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void A(object sender, EventArgs e)
    {
        int i = 0;
        string ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SiteSqlServer"].ToString() +
            ";MultipleActiveResultSets = True;"; 

        using (SqlConnection scon = new SqlConnection(ConnectionString))
        {
            scon.Open();
            using (SqlCommand scom = new SqlCommand("Select * from SuggestDel",scon))
            {
                using (SqlCommand scom1 = new SqlCommand("Delete registerInfo where StuID = @StuID and ClassID = @ClassID",scon))
                {

                    scom1.Parameters.Add("@StuID","");
                    scom1.Parameters.Add("@ClassID","");
                    try
                    {
                        SqlDataReader sreader = scom.ExecuteReader();
                        while(sreader.Read())
                        {
                            scom1.Parameters["@StuID"].Value = sreader.GetValue(0).ToString();
                            scom1.Parameters["@ClassID"].Value = sreader.GetValue(1).ToString();
                            try { i += scom1.ExecuteNonQuery(); }
                            catch (Exception ex) { ShowInfo.Text = ex.Message; }
                        }
                        ShowInfo.Text = i.ToString(); 
                    }
                    catch(Exception ex){}
                }
            }
        }
    }

}