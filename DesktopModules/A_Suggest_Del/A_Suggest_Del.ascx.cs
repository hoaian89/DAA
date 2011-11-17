using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using DotNetNuke.Entities.Modules;

public partial class DesktopModules_A_Suggest_Del_A_Suggest_Del : PortalModuleBase
{
    SqlDataSource source;
    SqlDataSource source1;
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void SqlDataSource1_Load(object sender, EventArgs e)
    {
        source = (SqlDataSource)sender;
        source.SelectParameters["StuID"].DefaultValue = HttpContext.Current.User.Identity.Name;
    }

    protected void SqlDataSource2_Load(object sender, EventArgs e)
    {
        source1 = (SqlDataSource)sender;
        source1.SelectParameters["StuID"].DefaultValue = HttpContext.Current.User.Identity.Name;
    }

    protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        //  Check
        int number = 0;
        foreach (GridViewRow row in GridView2.Rows)
        {
            try { number += int.Parse(((Label)row.FindControl("Credits")).Text); }
            catch(Exception ex){}
        }

        if (number >= 12)
        {
            source.DeleteParameters["ClassID"].DefaultValue = ((Label)GridView2.Rows[e.RowIndex].FindControl("ClassID")).Text;
            source.DeleteParameters["StuID"].DefaultValue = HttpContext.Current.User.Identity.Name;

            try { source.Delete(); ShowInfo.Text = "Thành công : " + source.DeleteParameters["ClassID"].DefaultValue; GridView1.DataBind(); }
            catch (Exception ex) { ShowInfo.Text = "Lỗi : Bạn đã đê nghị hủy lớp này !!!";}
        }
        else ShowInfo.Text = "Lỗi : Số TC phải lớn hơn 12!";
    }

    int i = 1;
    public String getOrder() 
    {
        return (i++).ToString();
    }
}