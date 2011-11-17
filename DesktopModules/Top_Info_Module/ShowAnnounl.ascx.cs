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
    }

    int order = 1;
    String group = string.Empty;
 
    public String getOrder(String _group)
    {
        string item = _group.Substring(0, 3);
        if (!item.Equals(group))
        {
            order = 1;
            group = item;
        }
        return (order++).ToString();
    }

    public String getOrder()
    {
        return (order++).ToString();
    }

    protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}