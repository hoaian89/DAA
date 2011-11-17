using System;
using System.Collections.Generic;
using DotNetNuke.Entities.Modules;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;

public partial class DesktopModules_C_Collect_Info_Eng_M_Collect_Info_Eng : PortalModuleBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (HttpContext.Current.User.Identity.Name.Substring(0, 2).CompareTo("06") != 0)
            {
                ShowInfo.Text = "Chú ý : Khảo sát chỉ áp dụng cho sinh viên khóa 1 !";
                return;
            }

            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SiteSQLServer"].ToString();
            SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();
            try
            {                
                //Label1.Text = Membership.GetUser().ProviderUserKey.ToString();
                SqlCommand cmd = new SqlCommand("SELECT * FROM KHAOSATAV WHERE StuId=@StuId", conn);
                string result = string.Empty;
                cmd.Parameters.AddWithValue("@StuId", HttpContext.Current.User.Identity.Name);
                //cmd.Parameters.AddWithValue("@Result", result);
                    //cmd.ExecuteNonQuery();
                SqlDataReader reader = cmd.ExecuteReader();
                reader.Read();
                result = reader.GetSqlValue(1).ToString();
                switch (result)
                {
                    case "A":
                        RadioButtonList1.SelectedIndex = 0;
                        break;
                    case "B":
                        RadioButtonList1.SelectedIndex = 1;
                        break;
                    case "C":
                        RadioButtonList1.SelectedIndex = 2;
                        break;
                    case "D":
                        RadioButtonList1.SelectedIndex = 3;
                        break;
                    case "E":
                        RadioButtonList1.SelectedIndex = 4;
                        break;
                    case "F":
                        RadioButtonList1.SelectedIndex = 5;
                        break;
                }
                ShowInfo.Text = "Bạn đã chọn : " + RadioButtonList1.SelectedValue;
            }
            catch (Exception err)
            {
                // cmd.CommandText = "Update KHAOSATAV SET Result=@Result WHERE StuId=@StuId";
                // cmd.ExecuteNonQuery();                
            }
            conn.Close();
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        //RadioButtonList1.SelectedIndex = 0;
        if (HttpContext.Current.User.Identity.Name.Substring(0,2).CompareTo("06")!=0)
        {
            ShowInfo.Text = "Chú ý : Khảo sát chỉ áp dụng cho sinh viên khóa 1 !";
            return;
        }

        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SiteSQLServer"].ToString();
        SqlConnection conn = new SqlConnection(connectionString);
        conn.Open();

        SqlCommand cmd = new SqlCommand("INSERT INTO KHAOSATAV(StuId,Result) VALUES(@StuId, @Result)", conn);
        string result = string.Empty;
        switch (RadioButtonList1.SelectedIndex)
        { 
            case 0:
                result = "A";
                break;
            case 1:
                result = "B";
                break;
            case 2:
                result = "C";
                break;
            case 3:
                result = "D";
                break;
            case 4:
                result = "E";
                break;
            case 5:
                result = "F";
                break;
        }
        cmd.Parameters.AddWithValue("@StuId", HttpContext.Current.User.Identity.Name);
        cmd.Parameters.AddWithValue("@Result", result);
        try
        {
            cmd.ExecuteNonQuery();
            ShowInfo.Text = "Bạn đã chọn : " + RadioButtonList1.SelectedValue;
        }
        catch (Exception err)
        {
            try
            {
                cmd.CommandText = "Update KHAOSATAV SET Result=@Result WHERE StuId=@StuId";
                cmd.ExecuteNonQuery();
                ShowInfo.Text = "Bạn đã chọn : " + RadioButtonList1.SelectedValue;
            }
            catch (Exception ex) { ShowInfo.Text = "Lỗi !"; }
        }       
        
        conn.Close();
    }

}