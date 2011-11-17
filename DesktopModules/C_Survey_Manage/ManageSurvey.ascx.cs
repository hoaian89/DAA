using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using System.Data.SqlClient;
using System.Configuration;
using DotNetNuke.Services.Exceptions;

public partial class DesktopModules_C_Survey_ManageSurvey_ : PortalModuleBase
{

    private int SurveyID = -1;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnAddClass_Click(object sender, EventArgs e)
    {
        string ClassName = txtClass.Text.Trim();
        if (ClassName.Length == 0)
            return;
        txtClass.Text = txtClass.Text.Trim();
        SqlDataSourceClass.Insert();

        lstClasses.DataBind();
        
    }
    protected void SqlDataSourceClass_Load(object sender, EventArgs e)
    {
    }
    protected void btnDeleteClass_Click(object sender, EventArgs e)
    {
        SqlDataSourceClass.Delete();
        lstClasses.DataBind();
    }
    protected void btnDeleteOption_Click(object sender, EventArgs e)
    {
        int sid = int.Parse(hidSurveyID.Value);
        if (sid != -1)
            SqlDataSourceSurveyOption.Delete();

        //Remove Item from listbox
        lstOptions.Items.Remove(lstOptions.SelectedItem);
    }
    protected void SqlDataSourceSurveyOption_Load(object sender, EventArgs e)
    {
    }
    protected void btnAddOption_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtOption.Text.Trim().Length == 0)
                return;
            int sid = Int32.Parse(hidSurveyID.Value);
            if (sid != -1)
            {
                SqlDataSourceSurveyOption.InsertParameters[0].DefaultValue = txtOption.Text.ToString();
                SqlDataSourceSurveyOption.InsertParameters[1].DefaultValue = Int32.Parse(hidSurveyID.Value).ToString();
                SqlDataSourceSurveyOption.Insert();
                lstOptions.DataBind();
            }
            else
            {
                //Add item to listbox
                lstOptions.Items.Add(txtOption.Text);
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message + ex.StackTrace);
        }
    }
    protected void btnEditQuestion_Click(object sender, EventArgs e)
    {
        if (lstQuestions.SelectedIndex == -1)
            return; //User has not selected an item
        else
            hidSurveyID.Value = lstQuestions.SelectedValue;

        lstOptions.DataBind();

        txtQuestion.Text = lstQuestions.SelectedItem.Text;
        pnlQuestionDetails.Visible = true;
    }
    protected void btnAddQuestion_Click(object sender, EventArgs e)
    {
        hidSurveyID.Value = "-1";
        pnlQuestionDetails.Visible = true;
    }
    protected void btnDeleteQuestion_Click(object sender, EventArgs e)
    {
        SqlDataSourceSurveys.Delete();
    }
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        if (txtQuestion.Text.Trim().Length == 0)
            return;
        try
        {
            int surveyID = int.Parse(hidSurveyID.Value);
            if (surveyID == -1)
            {
                SqlDataSourceSurveys.Insert();
                if (hidSurveyID.Value == "-1")
                    return;
                for (int i=0; i<lstOptions.Items.Count; i++)
                {
                    SqlDataSourceSurveyOption.InsertParameters[0].DefaultValue = lstOptions.Items[i].Text;
                    SqlDataSourceSurveyOption.InsertParameters[1].DefaultValue = hidSurveyID.Value;
                    SqlDataSourceSurveyOption.Insert();
                }
                lstOptions.DataBind();
                lstQuestions.DataBind();
                pnlQuestionDetails.Visible = false;
            }
            else
            {
                SqlDataSourceSurveys.Update();
                pnlQuestionDetails.Visible = false;
            }
        }
        catch (Exception ex)
        {
            Exceptions.ProcessModuleLoadException(this, ex);
        }
    }
    protected void SqlDataSourceSurveys_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Command.Parameters["@SurveyID"] != null)
            hidSurveyID.Value = e.Command.Parameters["@SurveyID"].Value.ToString();
        else
            hidSurveyID.Value = "-1";
        
    }
}