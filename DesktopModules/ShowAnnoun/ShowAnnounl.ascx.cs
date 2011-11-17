using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using System.Data.SqlClient;

public partial class DesktopModules_ShowAnnoun_ShowAnnounl : PortalModuleBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string id = Request.QueryString.ToString();
            try
            {
                id = id.Substring(id.LastIndexOf('&')+1, id.Length - id.LastIndexOf('&')-1);
                int.Parse(id);
                SqlDataSource1.SelectParameters["ItemID"].DefaultValue = id;
            }
            catch(Exception ex){}

        }
    }

    public string attack()
    {
        try
        {
            using (SqlConnection scon = new SqlConnection(SqlDataSource1.ConnectionString))
            {
                scon.Open();
                using (SqlCommand scom = new SqlCommand("Select fileName from AttachedFiles where ID = @ID",scon))
                {
                    scom.Parameters.Add("@ID", SqlDataSource1.SelectParameters["ItemID"].DefaultValue);
                    SqlDataReader sreader = scom.ExecuteReader();
                    if (sreader.HasRows)
                    {
                        string links = "<p style='color: #0099CC;font-style: italic;'> " +
                            "<img width = '15' height='15' src = 'http://daa.uit.edu.vn/images/itempage.gif' /> Files đính kèm : ";
                        while (sreader.Read())
                        {
                            string link = "<a href = 'http://daa.uit.edu.vn/Data/UploadedFiles/" + sreader.GetValue(0).ToString() + "'>"
                                + sreader.GetValue(0).ToString() + " <a/>  &nbsp;";
                            links += link;
                        }
                        links += "</p>";

                        return links;
                    }
                    else return string.Empty;
                }
            }
        }
        catch (Exception ex) { return string.Empty; }
    }
}