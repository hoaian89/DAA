using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for MyObject
/// </summary>
public class MyObject
{
    private string _name;

    public MyObject()
    {
        
    }

    public string Name
    {
        get { return this._name ?? string.Empty; }
        set { this._name = value; }
    }
}
