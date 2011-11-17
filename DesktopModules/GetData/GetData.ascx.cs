using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using System.Data.SqlClient;
using System.IO;

public partial class DesktopModules_GetData_GetData :PortalModuleBase
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        StreamWriter f = new StreamWriter(Server.MapPath("~\\data\\data.bin"));
        string s = "";
        using (SqlConnection scon =
        new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SiteSqlServer"].ToString()))
        {
            scon.Open();
            using (SqlCommand scom = new SqlCommand("Select * from RegisterInfo",scon))
            {
                SqlDataReader sreader =  scom.ExecuteReader();
                while(sreader.Read())
                {

                    string m 
                        = "Insert into RegisterInfo values("
                        + "N'"+sreader.GetValue(0)+"'"
                        + ",N'" + sreader.GetValue(1) + "'"
                        + ",N'" + sreader.GetValue(2) + "'"
                        + ",'"  + sreader.GetValue(3) + "'"
                        +"," + sreader.GetValue(4) + ")";
                    f.WriteLine(m);
                }
                sreader.Close();
            }

            f.WriteLine("");

            using (SqlCommand scom = new SqlCommand("Select * from SuggestionInfo", scon))
            {
                SqlDataReader sreader = scom.ExecuteReader();
                while (sreader.Read())
                {

                    string m
                        = "Insert into SuggestionInfo values("
                        + "N'" + sreader.GetValue(0) + "'"
                        + ",N'" + sreader.GetValue(1) + "')";
                    f.WriteLine(m);
                }
            }
        }
        f.Close();
        Response.ClearContent();
        Response.ClearHeaders();
        Response.ContentType = "application/txt";
        Response.AddHeader
        ("Content-Disposition", "attachment; filename = data.bin");
        Response.TransmitFile(Server.MapPath("~\\data\\data.bin"));
        Response.End();
        Response.Flush();
        Response.Clear();

        
    }
}