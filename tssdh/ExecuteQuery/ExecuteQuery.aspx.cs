using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.IO;
using System.Drawing;
using System.Xml;


public partial class ExecuteQuery : System.Web.UI.Page
{
    SqlConnection cnn;
    DataTable SAt;
    SqlDataAdapter SAda;
    //BindingSource SAbd;
    protected void Page_Load(object sender, EventArgs e)
    {
        SAbtnExecute.Click += new EventHandler(SAbtnExecute_Click);
        btnExport.Click += new EventHandler(btnExport_Click);
        if (ConnectData())
        {
            if (!Page.IsPostBack)
            {
                UpdateStatus(0, SALB);
                UpdateStatus(0, LBExport);
                SAtxt.Text = "";
                LBError.Visible = false;
                //  SAtxt.AutoPostBack = true;
            }
        }
        else
        {
            LBError.Visible = true;
            LBError.Text = "Không thể kết nối với Cơ sở dữ liệu";
        }

    }


    void btnExport_Click(object sender, EventArgs e)
    {
        //ExportToExcel();
        if (FillDB())
            ExportToXML();
    }
    DataSet ds;
    bool FillDB()
    {
        UpdateStatus(1, LBExport);
        try
        {
            ds = new DataSet("QLTSSDHv2");
            if (cnn.State == ConnectionState.Closed) cnn.Open();
            /*string t = HttpContext.Current.Server.MapPath("Default.aspx").Replace("Default.aspx", "Table");
            StreamReader sr = File.OpenText(t);
            ArrayList ar = new ArrayList();
            string text;
            do
            {
                text = sr.ReadLine();
                if (text != null)
                {
                    ar.Add(text);
                }
            }
            while (text != null);
            sr.Close();*/
            string[] ar = ConfigurationManager.AppSettings["Table"].Split(',');
            for (int i = 0; i < ar.Length; i++)
            {
                if (!FillTable(ar[i].ToString())) return false;
            }
            /*if (!FillTable("NguoiDung")) return false;
        if(!FillTable("GiamSat")) return false;
        if(!FillTable("TuyenSinh")) return false;
        if(!FillTable("MonThi")) return false;
        if(!FillTable("Nganh")) return false;
        if(!FillTable("CumThi")) return false;
        if(!FillTable("NgoaiNgu")) return false;
        if(!FillTable("GiayTo")) return false;
        if(!FillTable("UuTien")) return false;
        if(!FillTable("HoSo")) return false;
        if(!FillTable("SYLL")) return false;
        if(!FillTable("LLNN")) return false;
        if(!FillTable("DH_CH")) return false;
        if(!FillTable("BaiBao")) return false;
        if(!FillTable("CTNC")) return false;
        if(!FillTable("HTLV")) return false;
        if(!FillTable("HS_GT")) return false;
        if(!FillTable("PhongThi")) return false;
        if(!FillTable("DanhSachThi")) return false;
        if (!FillTable("PhucKhao")) return false;*/
            cnn.Close();
        }
        catch (Exception e)
        {
            LBError.Text = e.Message;
            UpdateStatus(2, LBExport);
            cnn.Close();
            return false;
        }
        return true;
    }
    bool FillTable(string tb)
    {
        try
        {
            string t = "select*from " + tb;
            SqlDataAdapter da = new SqlDataAdapter(t, cnn);
            da.Fill(ds, tb);
        }
        catch (Exception e)
        {
            LBError.Text = e.Message;
            UpdateStatus(2, LBExport);
            return false;
        }
        return true;
    }
    bool ExportToXML()
    {
        string t = HttpContext.Current.Server.MapPath("ExecuteQuery.aspx").Replace("ExecuteQuery.aspx", "DB.xml");
        /*   XmlTextWriter writer = new XmlTextWriter(t,null);
           writer.WriteStartDocument();
           for (int i = 0; i < ds.Tables.Count; i++)
           {
               if (ds.Tables[i].Rows.Count == 0)
               {
                   writer.WriteStartElement(ds.Tables[i].TableName);
                   writer.WriteEndElement();
               }
               else
               {
                   writer.WriteStartElement(ds.Tables[i].TableName);
                   writer.WriteStartElement("Value");
                   for(int j=0;j<ds.Tables[i].Rows.Count;j++)
                   for (int k = 0; k < ds.Tables[i].Columns.Count; k++)
                   {
                       writer.WriteStartElement(ds.Tables[i].Columns[k].ColumnName);
                       writer.WriteString(ds.Tables[i].Rows[j][k].ToString());
                       writer.WriteEndElement();
                   }
                   writer.WriteEndElement();
                   writer.WriteEndElement();
               }
           }
           writer.WriteEndDocument();
           writer.Close();*/

        //////////////
        try
        {
            StreamWriter s = new StreamWriter(t);
            ds.WriteXml(s);
            s.Close();
        }
        catch (Exception e)
        {
            LBError.Text = e.Message;
            UpdateStatus(2, LBExport);
            return false;
        }
        /////////////
        UpdateStatus(3, LBExport);
        return true;
    }
    void SAbtnExecute_Click(object sender, EventArgs e)
    {

        Execute(SAtxt.Text);
    }
    void Execute(string query)
    {
        UpdateStatus(1, SALB);
        try
        {
            cnn.Open();
            SAt = new DataTable();
            SAda = new SqlDataAdapter(query, cnn);
            SqlCommandBuilder cmd = new SqlCommandBuilder(SAda);
            SAda.Fill(SAt);
            //SAbd = new BindingSource();
            //SAbd.DataSource = SAt;
            SAGrid.Columns.Clear();
            SAGrid.DataSource = SAt;
            SAGrid.DataBind();
            try
            {
                SqlCommand sqlcmd = new SqlCommand(query, cnn);
                sqlcmd.ExecuteNonQuery();
            }
            catch
            {
            }
            cnn.Close();
            UpdateStatus(3, SALB);
        }
        catch (Exception e)
        {
            LBError.Text = e.Message;
            UpdateStatus(2, SALB);
        }
    }
    void UpdateStatus(int t, Label l)
    {
        switch (t)
        {
            case 0://Tình trạng ban đầu 
                LBError.Visible = false;
                l.ForeColor = Color.Black;
                l.Text = "Ready";
                break;
            case 1://Tình trạng đang thực thi
                LBError.Visible = false;
                l.ForeColor = Color.Blue;
                l.Text = "Executing...";
                break;
            case 2://Tình trạng lỗi
                LBError.Visible = true;
                l.ForeColor = Color.Red;
                l.Text = "Error!!!";
                break;
            case 3://Tình trạng hoàn tất
                LBError.Visible = false;
                l.ForeColor = Color.Green;
                l.Text = "Done";
                break;
        }
        //this.Refresh();
    }

    bool ConnectData()
    {
        try
        {
            /*string t = HttpContext.Current.Server.MapPath("ExecuteQuery.aspx").Replace("ExecuteQuery.aspx", "Connection");
            StreamReader sr = File.OpenText(t);

            //                FileStream f = new FileStream("D:\\Connection", FileMode.Open, FileAccess.Read);
            //BinaryReader r = new BinaryReader(f);
            //string c = r.ReadString();

            //r.Close();
            string c = "";
            try
            {
                c = sr.ReadLine();
                sr.Close();
            }
            catch
            {
                sr.Close();
                return false;
            }*/
            string c = ConfigurationManager.ConnectionStrings["SiteSqlServer"].ConnectionString;
            cnn = new SqlConnection(c);
            try
            {
                cnn.Open();
            }
            catch
            {
                //cnn.Close();
                return false;
            }
        }
        catch
        {

            //cnn.Close();
            return false;
        }
        cnn.Close();
        return true;
    }
}

