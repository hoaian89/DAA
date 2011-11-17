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
        string subID = ClassID.Text.Substring(0,ClassID.Text.Length - 4);

        using (SqlConnection scon = new SqlConnection(System.Configuration.ConfigurationManager.
        ConnectionStrings["SiteSqlServer"].ToString() + ";MultipleActiveResultSets = True;"))
        {
            scon.Open();
            using(SqlCommand scom = new SqlCommand("select Top " + Max.Text + " StuID from SuggestionInfo where subID = @SubID",scon))
            {
                scom.Parameters.Add("@SubID", subID);   // Get SubID to run script scom
                try 
                {
                    SqlDataReader sreader =  scom.ExecuteReader();  // Run Script
                    using (SqlCommand scom1 = new SqlCommand("Select Credits from Mark as M , Subject as S where S.SubID = M.SubID and M.SubID = @SubID and StuID = @StuID and Mark >= 50 ",scon))
                    {
                        scom1.Parameters.Add("@StuID","");
                        scom1.Parameters.Add("@SubID",subID);

                        using (SqlCommand scom2 = new SqlCommand("Insert into RegisterInfo values(@StuID,@ClassID,@SubID,getdate(),@Rereg)", scon))
                        {
                            scom2.Parameters.Add("@StuID","");
                            scom2.Parameters.Add("@ClassID",ClassID.Text);
                            scom2.Parameters.Add("@SubID",subID);
                            scom2.Parameters.Add("@Rereg","");

                            while (sreader.Read())
                            {
                                try
                                {
                                    scom1.Parameters["@StuID"].Value = scom2.Parameters["@StuID"].Value = sreader.GetValue(0);     //Get StuID
                                    int i = 0;
                                    try
                                    {
                                        object o = scom1.ExecuteScalar();
                                        if (o != null)
                                            i = int.Parse(o.ToString());
                                    }
                                    catch (Exception ex) { }

                                    scom2.Parameters["@Rereg"].Value = i;
                                    scom2.ExecuteNonQuery();
                                }catch(Exception ex){}
                            }
                        }
                    }
                }
                catch(Exception ex){ShowInfo.Text = ex.Message;}
            }
        }
        ShowInfo.Text = "Thành công ! ";
    }
}