using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using System.Data.SqlClient;
using System.IO;
using System.Drawing;

public partial class DesktopModules_PramePro_PramePro : PortalModuleBase
{
    //  Variables 
    string IconImage = "<img src = '/Portals/0/Pictures/grant.gif'/>";
    string Dept;

    protected void Page_Load(object sender, EventArgs e)
    {
        IconImage = Server.HtmlDecode(IconImage);
        if (!IsPostBack)
        {
            if (DotNetNuke.Framework.AJAX.IsInstalled())
            {
                DotNetNuke.Framework.AJAX.RegisterScriptManager();
            }
            PromeProDatabase.SelectParameters["StuID"].DefaultValue = HttpContext.Current.User.Identity.Name;;
            SqlDataSource1.SelectParameters["StuID"].DefaultValue = HttpContext.Current.User.Identity.Name;
            Check();
        }        
    }

    bool HightlightRow(string SubID,ref int sumCre,string Mark) 
    {
        foreach (GridViewRow row in GridView1.Rows)
        {
            //  Not checked
            if (row.Cells[10].Text == "" )
            {
                string s = row.Cells[4].Text;
                if (s == "MEDU1")
                {
                    row.BackColor = System.Drawing.Color.FromArgb(172, 238, 214);
                    row.ForeColor = System.Drawing.Color.White;
                    row.Cells[10].Text = IconImage;
                }
                else 
                if (s == SubID || ((s[s.Length - 1] == '*') && (SubID.StartsWith(s.Substring(0, s.Length - 2)))))
                {
                    if ((int.Parse(Mark) >= 50))
                    {
                        //  Hightlight row that pass
                        row.BackColor = System.Drawing.Color.FromArgb(172,238,214);
                        row.ForeColor = System.Drawing.Color.White;
                        row.Cells[9].Text = Mark;
                        row.Cells[10].Text = IconImage;
                        //  Check sum credits
                        try { sumCre += int.Parse(row.Cells[6].Text); }
                        catch (Exception ex) { }
                        return true;
                    }
                    else row.Cells[10].Text = "K";
               }
            }
        }
        return false;
    }

    void Check()
    {
        try
        {
            SqlConnection scon =
                new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SiteSqlServer"].ToString());
            scon.Open();
            string SelectCommand = "select SubID,Mark from [Mark] as M where " +
            "StuId = '" + HttpContext.Current.User.Identity.Name + "'";
            SqlCommand scom = new SqlCommand(SelectCommand, scon);
            SqlDataReader sreader = scom.ExecuteReader();
            int sum = 0;
            int numberofSub = 1;  // Contain "Giao duc quoc phong"
            while (sreader.Read())
            {
                if (HightlightRow(sreader.GetValue(0).ToString(), ref sum, string.Format("{0:0.0}",(byte)sreader.GetValue(1) /(double)10)))
                    numberofSub++;
            }
            Label1.Text = numberofSub.ToString();
            Label2.Text = sum.ToString();
            scon.Close();
            scon.Dispose();    
        }
        catch(Exception Ex){}
        Recheck();
    }
    
    void Recheck()
    {
        int sum = 0;
        foreach (GridViewRow row in GridView1.Rows)
        {
            string text = row.Cells[4].Text;
            if (text.StartsWith("ENG0") && row.Cells[10].Text =="")
            {row.Visible = false;}
            try
            {
                sum += row.Cells[6].Text != "&nbsp;"?int.Parse(row.Cells[6].Text) :0;
            }
            catch(Exception){}
        }
        if (Dept != "Cử nhân tài năng" && Dept != "Chương trình tiên tiến HTTT") sum -= 10;
        Label3.Text = sum.ToString();
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        switch (DropDownList1.SelectedValue)
        {
            case "Term":
                GridView1.Columns[1].Visible = false;
                GridView1.Columns[3].Visible = true;
                GridView1.Columns[0].Visible = true;
                GridView1.Columns[2].Visible = false;
                PromeProDatabase.SelectCommand = "SELECT [SubID], [Ord],[OrdTerm], [SubNm], [Regedits], [Thoer], [Prac], [Term], [Typ] FROM [FramePro] as F,[Student] as S WHERE (F.Ace = S.Dept) and (S.StuID = @StuID) ORDER BY [OrdTerm]";
                GridView1.DataBind();
                break;
            case "Type":
                GridView1.Columns[0].Visible = false;
                GridView1.Columns[3].Visible = false;
                GridView1.Columns[2].Visible = true;
                GridView1.Columns[1].Visible = true;
                PromeProDatabase.SelectCommand = "SELECT [SubID], [Ord],[OrdTerm], [SubNm], [Regedits], [Thoer], [Prac], [Term], [Typ] FROM [FramePro] as F,[Student] as S WHERE (F.Ace = S.Dept) and (S.StuID = @StuID) ORDER BY [Ord]";
                GridView1.DataBind();
                break;
        }
        Check();       
    }

    public string GetDept(string _Dept)
    {
        Dept = _Dept;
        switch (_Dept)
        {
            case "CS": return "Khoa học máy tính";
            case "IS": return "Hệ thống thông tin";
            case "NT": return "Mạng máy tính & truyền thông";
            case "CE": return "Kỹ thuật máy tính";
            case "SE": return "Kỹ thuật phần mềm ";
            case "TE": return "Cử nhân tài năng";
            case "AE": return "Chương trình tiên tiến HTTT";
            default: return "Chưa xác định";
        }
    }

}