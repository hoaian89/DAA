using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using System.IO;
using System.Web.UI.HtmlControls;

public partial class DesktopModules_C_LopHocPhi_HienThi : PortalModuleBase
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void ddlLop_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }
    
    protected void btnExport_Click(object sender, EventArgs e)
    {
        try
        {
            HtmlForm form = new HtmlForm();
            form.Controls.Add(gridDS);
            string attachment = "attachment; filename=" + ddlLop.SelectedValue + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            gridDS.RenderControl(htw);
            Response.Write(sw.ToString());
            Label1.Text = sw.ToString();
            Response.End();
            Label1.Text = "Finish";
        }
        catch (Exception ex)
        {
            Label1.Text = ex.Message;
        }
    }
    
}