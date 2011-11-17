using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using DotNetNuke.Entities.Modules;

public partial class DesktopModules_GetAnnoun_GetAnoun : PortalModuleBase
{
    public string RequestPage = "Thôngbáomới.aspx?";
    public string IconNew = "<img src='/Portals/0/Pictures/icon_new.gif'/>";
    public string getContent(string s)
    {
        string temp = HtmlRemoval.StripTagsRegex(Server.HtmlDecode(s));
        int l = temp.Length < 100 ? temp.Length : 100;
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

public static class HtmlRemoval
{
    /// <summary>
    /// Remove HTML from string with Regex.
    /// </summary>
    public static string StripTagsRegex(string source)
    {
        return Regex.Replace(source, "<.*?>", string.Empty);
    }

    /// <summary>
    /// Compiled regular expression for performance.
    /// </summary>
    static Regex _htmlRegex = new Regex("<.*?>", RegexOptions.Compiled);

    /// <summary>
    /// Remove HTML from string with compiled Regex.
    /// </summary>
    public static string StripTagsRegexCompiled(string source)
    {
        return _htmlRegex.Replace(source, string.Empty);
    }

    /// <summary>
    /// Remove HTML tags from string using char array.
    /// </summary>
    public static string StripTagsCharArray(string source)
    {
        char[] array = new char[source.Length];
        int arrayIndex = 0;
        bool inside = false;

        for (int i = 0; i < source.Length; i++)
        {
            char let = source[i];
            if (let == '<')
            {
                inside = true;
                continue;
            }
            if (let == '>')
            {
                inside = false;
                continue;
            }
            if (!inside)
            {
                array[arrayIndex] = let;
                arrayIndex++;
            }
        }
        return new string(array, 0, arrayIndex);
    }
}
