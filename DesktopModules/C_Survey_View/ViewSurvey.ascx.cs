using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class DesktopModules_C_Survey_ViewSurvey_ : PortalModuleBase
{
    public void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (HasVoted() == false)
            {
                pnlSurvey.Visible = true;
                pnlResult.Visible = false;
            }
            else
            {
                DisplayResult();
            }
        }
    }
    public bool HasVoted()
    {
        object val = DotNetNuke.Services.Personalization.Personalization.GetProfile(ModuleId.ToString(), "Voted");
        if (val != null)
            return (Boolean)val;
        else
            return false;
    }
    public void DisplayResult()
    {
        pnlResult.Visible = true;
        pnlSurvey.Visible = false;
        if (DotNetNuke.Security.PortalSecurity.IsInRoles(this.ModuleConfiguration.AuthorizedEditRoles))
            btnViewSurvey.Visible = true;
    }
    public void DisplaySurvey()
    {
        pnlResult.Visible = false;
        pnlSurvey.Visible = true;
        if (DotNetNuke.Security.PortalSecurity.IsInRoles(this.ModuleConfiguration.AuthorizedEditRoles))
            btnViewResult.Visible = true;
    }
    protected void lstResult_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        int surveyID = Int32.Parse(lstResult.DataKeys[e.Item.ItemIndex].ToString());
        int Votes = Convert.ToInt32(((DataRowView)e.Item.DataItem).Row.ItemArray[2].ToString());
        if (lstClasses.SelectedIndex == -1)
            lstClasses.SelectedIndex = 0;
        int ClassID = Int32.Parse(lstClasses.SelectedValue);
        using (SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["SiteSQLServer"].ConnectionString))
        {
            SqlCommand com = new SqlCommand();
            com.Connection = con;
            string count = "(select count(*) from C_SurveyResult where SurveyOptionID = so.SurveyOptionID AND ClassID = " + ClassID.ToString() + ") ";
            string sqlcom = "Select so.SurveyOptionID, so.OptionName, 'OptionVotes' = ";
            sqlcom += count;
            if (Votes != 0)
                sqlcom += ", 'Percent' = Round(Cast(" + count + " AS FLOAT)*100 /" + Votes.ToString() + ", 2)";
            else
                sqlcom += ", 'Percent' = 0 ";
            sqlcom += " from C_SurveyOption so " +
                      " where so.SurveyID = " + surveyID.ToString();

            com.CommandText = sqlcom;
            con.Open();
            SqlDataReader reader = com.ExecuteReader();
            Repeater repeater = e.Item.FindControl("repOptions") as Repeater;
            repeater.DataSource = reader;
            repeater.DataBind();

            con.Close();
        }
    }
   
    public void lstSurvey_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemIndex == -1)
            return;
        int surveyID = int.Parse(lstSurvey.DataKeys[e.Item.ItemIndex].ToString());
        using (SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["SiteSQLServer"].ConnectionString))
        {
            SqlCommand com = new SqlCommand();
            com.Connection = con;
            com.CommandText = "Select SurveyOptionID, OptionName " +
                "from C_SurveyOption where SurveyID = " + surveyID.ToString();
            con.Open();
            SqlDataReader reader = com.ExecuteReader();
            RadioButtonList rads = e.Item.FindControl("radOptions") as RadioButtonList;
            rads.DataSource = reader;
            rads.DataBind();

            con.Close();
        }
    }
    protected void btnVote_Click(object sender, EventArgs e)
    {
        bool Valid = true;
        int NumberOfQuestions = lstSurvey.Items.Count;
        for (int i = 0; i < NumberOfQuestions; i++)
        {
            RadioButtonList rads = lstSurvey.Items[i].FindControl("radOptions") as RadioButtonList;
            if (rads.SelectedIndex == -1)
                Valid = false;
        }
        int ClassID = int.Parse(ddlClasses.SelectedValue);
        if (Valid)
        {
            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["SiteSQLServer"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                for (int i = 0; i < NumberOfQuestions; i++)
                {
                    int surveyID = (int)lstSurvey.DataKeys[i];
                    RadioButtonList rads = lstSurvey.Items[i].FindControl("radOptions") as RadioButtonList;
                    int surveyOptionID = int.Parse(rads.SelectedValue);

                    cmd.CommandText = String.Format("Insert into C_SurveyResult values({0}, {1}, {2}, {3})",
                        UserId, ClassID, surveyID, surveyOptionID);

                    cmd.ExecuteNonQuery();
                }

                con.Close();

                //Keep info show that user has voted
                DotNetNuke.Services.Personalization.Personalization.SetProfile(ModuleId.ToString(), "Voted", true);

                //Hide Survey Section
                pnlSurvey.Visible = false;
                pnlResult.Visible = true;

                //Update data displaying
                lstResult.DataBind();
            }
        }
        else
        {
            //User didn't answer some questions
            lblInfo.Text = "Bạn chưa chọn một số câu hỏi";
        }
    }
    protected void btnViewSurvey_Click(object sender, EventArgs e)
    {
        DisplaySurvey();
    }
    protected void btnViewResult_Click(object sender, EventArgs e)
    {
        DisplayResult();
    }
}


