using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;

public partial class DesktopModules_HelloWord_Hello : PortalModuleBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Write(PortalSettings.HomeDirectoryMapPath);
		Response.Write("<br/>" + TabId.ToString());
    }
}
