using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;

/// <summary>
/// Summary description for MyObjects
/// </summary>
public class MyObjects : List<MyObject>
{
    public static List<String> fileNames = new List<string>();
    public static void addRow(string file){
        fileNames.Add(file);
    }

    public static void clearAll(){
        fileNames.Clear();
    }

    public MyObjects() 
    {
        this.InitializeMyObjects();
    }

    private void InitializeMyObjects()
    {
        foreach(string file in fileNames)
        {
            MyObject myEmployee = new MyObject();
            myEmployee.Name = file;
            this.Add(myEmployee);
        }
    }

    public List<MyObject> GetMyObjects()
    {
        return this;
    }
}
