using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;

public partial class DesktopModules_GetAnnoun_GetAnoun : PortalModuleBase
{
    public string RequestPage = "Thôngbáomới.aspx?";
    public string IconNew = "<img src='/daa/Portals/0/Pictures/icon_new.gif'/>";
    public string getContent(string s)
    {
        string temp = s;
        int l = temp.Length < 250 ? temp.Length : 250;
        if (l > 0 )
        {
            temp = (temp.Substring(0, l));
            try
            {
                temp = Server.HtmlDecode(temp);
                if (temp.Contains(' '))
                    temp = (temp.Substring(0, temp.LastIndexOf(' ')));
                char m = temp[temp.Length - 1];
                if (m=='+'||m=='-'||m=='%'||m=='#'||
                    m=='&'||m=='$'||m=='('||m=='*'||m==')')
                    temp = temp.Remove(temp.Length - 1, 1);

                while (temp.Contains("<img"))
                {
                    for (int i = temp.IndexOf("<img"); i < temp.Length;i++ )
                        if (temp[i] == '>')
                        {
                            temp = temp.Remove(temp.IndexOf("<img"), i - temp.IndexOf("<img")+1);
                            break;
                        }
                }
            }
            catch (Exception ex) { }
        }
        return temp;
    }

    public string getIconNew(string date)
    {
        if (Math.Abs((DateTime.Parse(date) - DateTime.Now).TotalDays) <= 7)
            return IconNew;
        else return "";
    }
}