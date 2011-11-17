using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using System.Data;

namespace daa
{
    public partial class StudyResults : PortalModuleBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            SqlDataSource1.SelectParameters["name"].DefaultValue = string.Format("%{0}%",nameTxb.Text);
            ShowList.DataBind();
        }

        protected void cbxAYears_DataBound(object sender, EventArgs e)
        {
            // Format the ayear
            foreach (ListItem item in cbxAYears.Items)
                item.Text = Helper.GetAYear(item.Text);

            // Default selection
            cbxAYears.Items.Insert(0, new ListItem { Text = "Tất cả", Value = "%", Selected = false });
        }

        protected void cbxTerms_DataBound(object sender, EventArgs e)
        {
            cbxTerms.Items.Insert(0, new ListItem { Text = "Tất cả", Value = "0", Selected = false });
        }

        int total_credits = 0;
        double total_marks = 0;
        protected void MarkGridView_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var row = (DataRowView)e.Row.DataItem;
                total_credits += (byte)row["Credits"];
                total_marks += (byte)row["Credits"] * (byte)row["Mark"] / (double)10;
            }
            else if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.Cells[0].Text = "Tổng kết";
                e.Row.Cells[3].Text = string.Format("Trung bình: {0:0.00}", total_marks / total_credits, 2);
                e.Row.Cells[4].Text = total_credits.ToString();
                e.Row.Cells[6].Text = string.Format("{0:0.0}", total_marks);
            }
        }

        protected void MarksSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            if (cbxTerms.SelectedIndex == -1 || cbxTerms.SelectedValue == "0")
            {
                e.Command.Parameters["@TermMin"].Value = byte.MinValue;
                e.Command.Parameters["@TermMax"].Value = byte.MaxValue;
            }
            else e.Command.Parameters["@TermMin"].Value = e.Command.Parameters["@TermMax"].Value = 
                byte.Parse(cbxTerms.SelectedValue);

        }

        protected void cbxTerms_SelectedIndexChanged(object sender, EventArgs e)
        {
            MarkData.DataBind();
        }

        protected void GridView1Command(object sender, GridViewCommandEventArgs e)
        {
            GridViewRow row = (GridViewRow)((LinkButton)e.CommandSource).NamingContainer; ;
            string stuID = ((LinkButton)row.FindControl("StuID")).Text;
            
            if (e.CommandName == "SHOW")
            {
                StudentSource.SelectParameters["StuId"].DefaultValue
                = AYearsSource.SelectParameters["StuId"].DefaultValue
                = TermsSource.SelectParameters["StuId"].DefaultValue
                = MarksSource.SelectParameters["StuId"].DefaultValue
                = stuID ;

                MarkData.DataBind();
                StudentData.DataBind();

                if (ShowList.Rows.Count > 5)
                {
                    SqlDataSource1.SelectParameters["name"].DefaultValue = ((LinkButton)row.FindControl("StuNm")).Text; ;
                    ShowList.DataBind();
                }
            }
        }
        protected void  ShowList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
                
        }
    }
}