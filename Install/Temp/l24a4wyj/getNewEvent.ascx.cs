using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;

public partial class DesktopModules_getNewEvent : PortalModuleBase
{
    public string RequestPage = "daa.uit.edu.vn/daa/Tinmới.aspx?";
    public string IconNew = "<img src='/daa/Portals/0/Pictures/icon_new.gif'/>";
    public string getIconNew(string date)
    {
        if (Math.Abs((DateTime.Parse(date) - DateTime.Now).TotalDays) <= 7)
            return IconNew;
        else return "";
    }
}