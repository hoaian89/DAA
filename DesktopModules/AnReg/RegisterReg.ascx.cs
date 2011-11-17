using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Collections;
using System.Data.SqlClient;
using DotNetNuke.Entities.Modules;
using System.Xml;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using System.IO;
using System.Collections;
using System.Net;

//  State
//  0 : if registered then show Register Info
//  1 : if not then show Schedule 
//  2 : if edit button pressed then edit Info
//  1,2 --> 3 : Confirm --> 4 : Successful --> 0

public partial class DesktopModules_RegisterReg_RegisterReg : PortalModuleBase
{
    #region//  Variable's infomations
    protected string ConnectionString;
    private SqlDataSource studentsource;
    private int subRegifReReg, SchoYear, MaxCre, MinCre,Times;
    protected SqlDataSource scheduleSource;
    protected GridView schedule;
    public string HeightofDIV = "490px";
    protected List<GridViewRow> listSubID;
    public bool isOpen, UpdateSate = false;
    protected List<String> Reregsubject;
    public String userName, Term, Notice;

    #endregion

    protected void StudentDataSource_Load(object sender, EventArgs e)
    {
        studentsource = (SqlDataSource)sender;
        if (!Page.IsPostBack)
            studentsource.SelectParameters["StuId"].DefaultValue = userName;
    }

    protected void Suggest_Load(object sender, EventArgs e)
    {
        // loadInfo();
    }

    void loadInfo() 
    {
        string currentSubID = "";
        bool isFull = true;
      
  		DropDownList2.Items.Clear();
        DropDownList3.Items.Clear();

        using (SqlConnection scon = new SqlConnection(ConnectionString))
        {
            scon.Open();
            using (SqlCommand scom = new SqlCommand("Select ClassID,SubID,StuMx,CurNm from ScheduleM order by ClassID", scon))
            {
                try
                {
                    SqlDataReader sreader = scom.ExecuteReader();
                    while (sreader.Read())
                    {
                        if (currentSubID != sreader.GetValue(1).ToString())
                        {
                            if (isFull && currentSubID != "")
                            {
                                DropDownList2.Items.Add(currentSubID);
                            }
                            currentSubID = sreader.GetValue(1).ToString();
                            isFull = true;
                        }

                        if (int.Parse(sreader.GetValue(2).ToString()) > int.Parse(sreader.GetValue(3).ToString()))
                        {
                            isFull = false;
                        }
                    }

                    if (isFull && currentSubID != "")
                    {
                        DropDownList2.Items.Add(currentSubID);
                    }
                
                } catch(Exception ex){}
            }
        }
        LoadDay();
    
    }

    void LoadDay()
    {
        DropDownList3.Items.Clear();
        using (SqlConnection scon = new SqlConnection(ConnectionString))
        {
            scon.Open();
            using (SqlCommand scom = new SqlCommand("Select distinct Day , Period from ScheduleM where SubID = @SubID", scon))
            {
                try
                {
                    scom.Parameters.Add("@SubID", DropDownList2.SelectedItem.Text);

                    SqlDataReader sreader = scom.ExecuteReader();
                    while (sreader.Read())
                    {
                        System.Web.UI.WebControls.ListItem item = new System.Web.UI.WebControls.ListItem();
                        item.Text = "Ca:" + sreader.GetValue(1).ToString() + " - Ngày :" + sreader.GetValue(0).ToString();
                        item.Value = sreader.GetValue(1).ToString() + "$" + sreader.GetValue(0).ToString();

                        DropDownList3.Items.Add(item);
                    }
                }catch(Exception ex){}
            }

        }

    }

    protected void DropDownList2_Change(object sender, EventArgs e)
    {
        LoadDay();
    }

    int getInt(object o)
    {
        if (o is int) return (int)o;
        else return 0;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SiteSqlServer"].ToString() +
        ";MultipleActiveResultSets = True;";
        Reregsubject = new List<String>();
        userName = HttpContext.Current.User.Identity.Name;
        getVari();
        SetButton();

        if (!IsPostBack)
        {
            if (Session["State"] == null) Session.Add("State", 0);
            else Session["State"] = 0;
            CheckStateInfo();

            using (SqlConnection scon = new SqlConnection(ConnectionString))
            {
                scon.Open();
                using (SqlCommand scom = new SqlCommand("Select sum(Credits) from Subject as S , Mark as M " +
                "where (S.SubID = M.SubID) and (M.StuID = @StuID)", scon))
                {
                    scom.Parameters.Add("@StuID", userName);
                    try { Dahoc.Text = (getInt(scom.ExecuteScalar())).ToString(); }
                    catch (Exception ex) { }
                    scom.CommandText = "select sum(Credits) from Subject as S , Mark as M " +
                    "where (S.SubID = M.SubID) and ( M.StuID = @StuID ) and ( Mark >= 50 )";
                    try { DaTL.Text = (getInt(scom.ExecuteScalar())).ToString(); }
                    catch (Exception ex) { }
                }
            }
            SetDisplayForm();
			loadInfo();
        }
    }

    void getVari()
    {
        using (SqlConnection scon = new SqlConnection(ConnectionString))
        {
            scon.Open();
            //using(SqlCommand scom = new SqlCommand("Insert into RegManage values(0,N'Hè',2010)",scon))
            using (SqlCommand scom = new SqlCommand("Select Top 1 * from RegManage", scon))
            {
                try
                {
                    SqlDataReader sreader = scom.ExecuteReader();
                    sreader.Read();
                    isOpen = (bool)sreader.GetValue(0);
                    Term = (string)sreader.GetValue(1);
                    SchoYear = (int)sreader.GetValue(2);
                    MaxCre = int.Parse(sreader.GetValue(3).ToString());
                    MinCre = int.Parse(sreader.GetValue(4).ToString());
                    Notice = sreader.GetValue(6) == DBNull.Value ? "" : (string)sreader.GetValue(6);
                    Times = int.Parse(sreader.GetValue(7).ToString());
                }
                catch (Exception ex)
                {
                    isOpen = false;
                    Term = "1";
                    SchoYear = DateTime.Now.Year;
                    MaxCre = 30;
                    MinCre = 0;
                    Notice = "";
                    Times = 1;
                }
                CanTL.Text = MinCre.ToString();
                NoticeLabel.Text = Server.HtmlDecode(Notice.Replace("\n", "<br/>"));
            }
        }
    }

    void SetButton()
    {
        if (!isOpen)
        {
            if (Times == 1)
            {
                EditButton1.Visible = false;
                PrintButton1.Visible = false;
                Seperate.Visible = false;
                Seperate1.Visible = false;
                Download.Visible = false;
                EditButton2.Enabled = false;
            }
            else {
                EditButton1.Visible = false;
                PrintButton1.Visible = false;
                Seperate.Visible = false;
                Seperate1.Visible = false;
                EditButton2.Enabled = false;

                Download.Visible = true;
                
            }
        }
        else
        {
            if (Times == 1)
            {
                Seperate1.Visible = true;
                Download.Visible = true;
            }
            else
            {
                PrintButton1.Visible = false;
                Seperate.Visible = false;
                Seperate1.Visible = false;
                Download.Visible = false;
                EditButton2.Enabled = false;

                using (SqlConnection scon = new SqlConnection(ConnectionString))
                {
                    scon.Open();
                    using (SqlCommand scom = new SqlCommand("select count(*) from RegisterInfo as R, SCheduleM as S where R.ClassID = S.ClassID and StuID = @StuID and S.isClosed = 1", scon))
                    {
                        scom.Parameters.Add("@StuID", userName);
                        if ((int)scom.ExecuteScalar() == 0)
                            EditButton1.Enabled = false;
                        else EditButton1.Enabled = true;
                    }
                }
            }
        }
    }

    //  Set dislay base on state info 
    void SetDisplayForm()
    {
        if (GetState() == 0)
        {
            EditButton1.Text = "Sửa đổi";
            PrintButton1.Text = "Hủy tất cả";
            GridView1.Columns[GridView1.Columns.Count - 1].Visible = false;
            DropDownList1.Visible = false;
            ShowInfo.Text = "";
            Label3.Text = "Bạn đã đăng kí học phần gồm các môn sau : ";
            PrintButton1.OnClientClick = "return confirm('Bạn có chắc muốn hủy các môn đã đăng kí không ?')";
        }
        else
        {
            PrintButton1.OnClientClick = "";
            if (GetState() == 1 || GetState() == 5)
            {
                EditButton1.Text = "Đăng kí";
                PrintButton1.Text = "Hủy";
                GridView1.Columns[GridView1.Columns.Count - 1].Visible = true;
                DropDownList1.Visible = true;
                Label3.Text = "Chọn loại môn : ";
                ShowInfo.Text = "";

            }
            else { DropDownList1.Visible = false; }
        }
    }

    //  Check state info
    int CheckStateInfo()
    {
        DropDownList2.DataBind();
        using (SqlConnection scon = new SqlConnection(ConnectionString))
        {
            scon.Open();
            using (SqlCommand scom = new SqlCommand("Select count(*) from RegisterInfo where (StuID = @StuID)", scon))
            {
                scom.Parameters.Add("@StuID", userName);
                try
                {
                    if (getInt(scom.ExecuteScalar()) > 0)
                    {
                        scom.CommandText = "Select Sum(ReReg) from RegisterInfo where (StuID = @StuID)";
                        subRegifReReg = getInt(scom.ExecuteScalar());
                    }
                    else
                    {
                        Session["State"] = 1;
                    }
                }
                catch (Exception ex) { }
            }
        }
        return GetState();
    }

    void Clear()
    {
        using (SqlConnection scon = new SqlConnection(ConnectionString))
        {
            scon.Open();
            using (SqlCommand scom = new SqlCommand("Delete from RegisterInfo where (StuID = @StuID )", scon))
            {
                scom.Parameters.Add("@StuID", userName);
                try
                {
                    scom.ExecuteNonQuery();
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "Hoàn tất",
                        "alert('Đã xóa tất cả các môn đăng kí !')", true);
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "Thông báo lỗi",
                        "alert('Có một số lỗi xảy ra !')", true);
                }

                //  Update CurNm
                scom.CommandText = "Update ScheduleM set CurNm = (select count(*) from RegisterInfo " +
                    "where ScheduleM.ClassID = RegisterInfo.ClassID)";
                try { scom.ExecuteNonQuery(); }
                catch (Exception ex) { }
            }
        }
    }

    protected void PrintButton_Click(object sender, EventArgs e)
    {
        if (File.Exists(Server.MapPath("~\\Bangdiem\\DKHP\\DKHP_HK_" + userName + ".pdf")))
            return;

        if (GetState() == 0) { Clear(); Session["State"] = 1; }
        else Session["State"] = 0;
        DropDownList1.Enabled = true;
        CheckStateInfo();
        SetDisplayForm();
        SetDataSourceInfo();
    }

    protected void GridView1_Load(object sender, EventArgs e)
    {
        schedule = (GridView)sender;
    }

    protected void SqlDataSource1_Load(object sender, EventArgs e)
    {
        scheduleSource = (SqlDataSource)sender;
        if (!IsPostBack) SetDataSourceInfo();
    }

    void SetDataSourceInfo()
    {
        if (GetState() == 0)
        {
            scheduleSource.SelectCommand = "SELECT [Typ],S.SubID,[SubNm],R.ClassID,[Credits],[StuMx],[LecNm],[Day],[Period],[Room],[CurNm],[isClosed] FROM RegisterInfo as R,ScheduleM as S,Subject as S1" +
             " where (R.ClassID = S.ClassID) and (S1.SubID = R.SubID) and (R.StuID = '" + userName + "') ORDER BY [SubNm],[ClassID],[Day],[Period],[Room]";
        }
        else
            scheduleSource.SelectCommand = "SELECT [Typ],S.SubID,[SubNm],[ClassID],[Credits],[StuMx],[LecNm],[Day],[Period],[Room],[CurNm],[isClosed] FROM [ScheduleM] as S,Subject as S1 " +
            " where S.SubID = S1.SubID ORDER BY [SubNm],[ClassID],[Day],[Period],[Room] ";

        GridView1.DataBind();
    }

    bool Contains(List<GridViewRow> list, string SubID)
    {
        foreach (GridViewRow grow in list)
        {
            if (((HiddenField)grow.FindControl("SubID")).Value.Equals(SubID))
            {
                grow.BackColor = System.Drawing.Color.Yellow;
                return true;
            }
        }
        return false;
    }

    GridViewRow FindRow(string s, int i)
    {
        if (i == 1)
        {
            foreach (GridViewRow grow in ListOfRow)
                if (s.Equals(((HiddenField)grow.FindControl("SubID")).Value))
                    return grow;
        }
        else
        {
            foreach (GridViewRow grow in ListOfRow)
            {
                string[] dates = ((Label)grow.FindControl("Day")).Text.Replace("<br/>", ",").Split(',');
                string[] periods = ((Label)grow.FindControl("Period")).Text.Replace("<br/>", ",").Split(',');

                for (int j = 0; j < dates.Length; j++)
                {
                    if ((dates[j] + periods[j]).Equals(s))
                        return grow;
                }
            }
        }
        return null;
    }

    //  Display error color info
    bool displayErrorInfo(string error, string s, int i)
    {
        //  hightlight error row 
        FindRow(s, i).BackColor = System.Drawing.Color.Yellow;
        return displayErrorInfo(error);
    }

    bool displayErrorInfo(string error, GridViewRow row)
    {
        //  hightlight error row 
        row.BackColor = System.Drawing.Color.Yellow;
        return displayErrorInfo(error);
    }

    //  Display error text info
    bool displayErrorInfo(string s)
    {
        if (ShowInfo.Text.Contains("***  ")) ShowInfo.Text += s + "<br/>";
        else ShowInfo.Text = "***  " + s + "<br/>";
        return false;
    }

    //  Check row gridview info 
    List<string> SubIDList = new List<string>();
    List<string> DateList = new List<string>();
    List<GridViewRow> ListOfRow = new List<GridViewRow>();

    bool CheckGrow(string Date, string Period, string SubID, GridViewRow row)
    {
        if (SubIDList.Contains(SubID))    // Error on same subID
        {
            row.BackColor = System.Drawing.Color.Yellow;
            return displayErrorInfo(string.Format("Môn học không được trùng nhau : {0}", SubID), SubID, 1);

        }
        else SubIDList.Add(SubID);

        string[] dates = Date.Replace("<br/>", ",").Split(',');
        string[] periods = Period.Replace("<br/>", ",").Split(',');

        bool isFirst = true;
        for (int i = 0; i < dates.Length; i++)
        {
            string dateandperiod = dates[i] + periods[i];
            if (DateList.Contains(dateandperiod))      // Error on samq datetime
            {
                row.BackColor = System.Drawing.Color.Yellow;
                if (isFirst) displayErrorInfo(string.Format("Trùng giờ học : Thứ {0} Ca {1}", dates[i], periods[i]), dateandperiod, 2);
                else displayErrorInfo(string.Format("Thứ {0} Ca {1}", dates[i], periods[i]), dateandperiod, 2);

                isFirst = false;
            }
            else DateList.Add(dateandperiod);
        }

        ListOfRow.Add(row);
        return true;
    }

    //  Check condition about all preinfo to register item
    protected bool CheckCondition(List<GridViewRow> listSubID, ref int sum)
    {
        ShowInfo.Text = "";
        listSubID = new List<GridViewRow>();

        int inum = 0;
        using (SqlConnection scon = new SqlConnection(ConnectionString))
        {
            scon.Open();
            using (SqlCommand scom = new SqlCommand("Select SI.PreSubID,S.SubNm,SI.typ from SubInfo as SI, Subject " +
            "as S where ( SI.PreSubID = S.subID ) and ( SI.SubID = @SubID ) order by typ ", scon))
            {
                using (SqlCommand scom1 = new SqlCommand("SELECT count(*) FROM Mark " +
                "WHERE (StuId = @StuID) AND (SubId = @SubID) AND (Mark >= 50) ", scon))
                {
                    scom1.Parameters.Add("@StuID", userName);
                    scom.Parameters.Add("@SubID", "");
                    scom1.Parameters.Add("@SubID", "");
                    foreach (GridViewRow grow in GridView1.Rows)
                    {
                        //  If row is checked then break in 
                        grow.BackColor = System.Drawing.Color.Transparent;
                        if (((CheckBox)grow.FindControl("chkSelect")).Checked)
                        {
                            //  Check about same subID and date
                            string SubID = ((HiddenField)grow.FindControl("SubID")).Value;
                            string Date = ((Label)grow.FindControl("Day")).Text;
                            string Period = ((Label)grow.FindControl("Period")).Text;

                            if (!CheckGrow(Date, Period, SubID, grow)) return false;
                            else grow.BackColor = System.Drawing.Color.AliceBlue;

                            /*
                            scom.Parameters["@SubID"].Value = SubID;
                            try
                            {
                                //scom.Prepare();
                                SqlDataReader sReader = scom.ExecuteReader();
                                string S = ""; int type = 1;
                                while (sReader.Read())
                                {
                                    if (int.Parse(sReader.GetValue(2).ToString()) != type)
                                    {
                                        type++;
                                        if (S.Equals("")) break;
                                        else S = "";
                                    }
                                    scom1.Parameters["@SubID"].Value = sReader.GetValue(0) as string;
                                    if (getInt(scom1.ExecuteScalar()) == 0)  // Will true if drop remain data
                                    {
                                        S += sReader.GetValue(1) + " ( " + sReader.GetValue(0) + " ),";
                                        break;
                                    }
                                }
                                if (!S.Equals(""))
                                    displayErrorInfo("Bạn chưa học môn " + S.Remove(S.Length - 1) +
                                    " là môn tiên quyết của môn " + ((LinkButton)grow.FindControl("SubNm")).Text, grow);
                                sReader.Close();
                            }
                            catch(Exception ex){}
                            */

                            sum += int.Parse(grow.Cells[3].Text);
                            inum++;

                        }
                    }
                }
            }
        }

        //  Check condition about Qui che : MaxReg
        //  Num of credits must larger than 0

        //  Check conditonn about  MinReg
        //  Check condition about Qui che : maxReg of TB and Yeu
        if (sum > MaxCre)
            return displayErrorInfo("*** Lỗi : Số TC phải bé hơn " + MaxCre.ToString());
        else if (sum < MinCre)
            return displayErrorInfo("*** Lỗi : Số TC phải lớn hơn " + MinCre.ToString());

        if (inum == 0)
            return displayErrorInfo("*** Lỗi : Tổng số môn đăng kí phải lớn hơn 0!");
        return true;
    }

    int GetState()
    {
        if (Session["State"] == null)
            Session.Add("State", 0);
        return (int)Session["State"];
    }

    int UpdateDatabaseSchedule(ref List<GridViewRow> listMain, bool updateState)
    {
        List<GridViewRow> list = new List<GridViewRow>();
        int sum = 0;
        using (SqlConnection scon = new SqlConnection(ConnectionString))
        {
            scon.Open();
            using (SqlCommand scom = new SqlCommand("Select ClassID from RegisterInfo where (StuID = @StuID )", scon))
            {
                scom.Parameters.Add("@StuID", userName);
                if (GetState() == 6)
                {
                    //  Delete all ClassID unchecked
                    using (SqlDataReader sreader = scom.ExecuteReader())
                    {
                        using (SqlCommand scom1 = new SqlCommand("Delete from RegisterInfo where StuID = @StuID and ClassID = @ClassID", scon))
                        {
                            scom1.Parameters.Add("@StuID", userName);
                            scom1.Parameters.Add("@ClassID", "0");
                            while (sreader.Read())
                            {
                                foreach (GridViewRow row in GridView1.Rows)
                                {
                                    if (((HiddenField)row.FindControl("ClassID")).Value.Equals(sreader.GetValue(0).ToString()))  // Exist
                                    {
                                        if (!((CheckBox)row.FindControl("chkselect")).Checked)
                                        {
                                            scom1.Parameters["@ClassID"].Value = sreader.GetValue(0).ToString();
                                            try { scom1.ExecuteNonQuery(); }
                                            catch (Exception ex) { }
                                        }
                                        break;
                                    }

                                }
                            }
                        }
                    }
                }

                scom.CommandText = "Insert into RegisterInfo(StuId,ClassID,SubID,Date,ReReg) values" +
                "(@StuID,@ClassID,@SubID,getDate(),@Value)";
                scom.Parameters.Add("@ClassID", "");
                scom.Parameters.Add("@SubID", "");
                scom.Parameters.Add("@Value", 0);

                foreach (GridViewRow grow in GridView1.Rows)
                {
                    if (((CheckBox)grow.FindControl("chkselect")).Checked)
                    {
                        grow.BackColor = System.Drawing.Color.Transparent;
                        scom.Parameters["@SubID"].Value = ((HiddenField)grow.FindControl("SubID")).Value;
                        scom.Parameters["@ClassID"].Value = ((HiddenField)grow.FindControl("ClassID")).Value;
                        if (getRereg().Contains(scom.Parameters["@SubID"].Value.ToString()))
                            scom.Parameters["@Value"].Value = grow.Cells[3].Text;
                        else scom.Parameters["@Value"].Value = 0;
                        try
                        {
                            sum += int.Parse(grow.Cells[3].Text);
                            using (SqlCommand scomA = new SqlCommand("Update ScheduleM set CurNm = CurNm + 1 where ClassID = @ClassID", scon))
                            {
                                scomA.Parameters.Add("@ClassID", scom.Parameters["@ClassID"].Value);
                                try { scomA.ExecuteNonQuery(); scom.ExecuteNonQuery(); }
                                catch (Exception ex) { ShowInfo.Text += scom.Parameters["@ClassID"].Value; }
                            }
                        }
                        catch (Exception e) { ShowInfo.Text = "Có lỗi xảy ra"; }
                    }
                }

                //  Update Curnm 
                scom.CommandText = "Update ScheduleM set CurNm = (select count(*) from RegisterInfo " +
                "where ScheduleM.ClassID = RegisterInfo.ClassID)";
                try { scom.ExecuteNonQuery(); }
                catch (Exception ex) { }
            }
        }
        Session["State"] = 0;
        SetDataSourceInfo();
        SetDisplayForm();
        GridView1.DataBind();

        return sum;
    }

    List<String> getRereg()
    {
        if (Session["ReReg"] == null) Session.Add("ReReg", Reregsubject);
        return (List<String>)Session["Rereg"];
    }

    void SetReregSession()
    {
        if (Session["ReReg"] == null) Session.Add("ReReg", Reregsubject);
        else Session["Rereg"] = Reregsubject;
    }

    //  Confirm user and give some info to user
    int ConfirmtoReg()
    {
        int i = 0;
        int sum = 0;
        string Comment = "";
        using (SqlConnection scon = new SqlConnection(ConnectionString))
        {
            scon.Open();
            using (SqlCommand scom = new SqlCommand("Select count(*) from Mark where (StuID = @StuID) and (SubID = @SubID) and (Mark >= 50)", scon))
            {
                scom.Parameters.Add("@StuID", userName);
                scom.Parameters.Add("@SubId", "");
                foreach (GridViewRow grow in GridView1.Rows)
                {
                    grow.BackColor = System.Drawing.Color.Transparent;
                    if (!((CheckBox)grow.FindControl("chkSelect")).Checked) grow.Visible = false;
                    else
                    {
                        i++;
                        scom.Parameters["@SubID"].Value = ((HiddenField)grow.FindControl("SubID")).Value;
                        string SubNm = ((LinkButton)grow.FindControl("SubNm")).Text;
                        try
                        {
                            if (getInt(scom.ExecuteScalar()) > 0)
                            {
                                Comment += SubNm + " ( " + scom.Parameters["@SubID"].Value + " ) ,";
                                grow.BackColor = System.Drawing.Color.AntiqueWhite;
                                sum += int.Parse(grow.Cells[3].Text);
                                Reregsubject.Add(scom.Parameters["@SubID"].Value.ToString());
                            }
                        }
                        catch (Exception ex) { }
                    }
                }
            }
        }
        if (Comment != "") ShowInfo.Text += "&nbsp;** Chú ý : Bạn đã học môn " + Comment.Remove(Comment.Length - 1) +
        ". Bạn có muốn đăng kí học lại không ?<br/>";
        else ShowInfo.Text += "&nbsp;** Bạn có đồng ý đăng kí những môn học trên không ?<br/>";
        EditButton1.Text = "Đồng ý ";
        return sum;
    }

    protected void EditButton1_Click(object sender, EventArgs e)
    {
        if (File.Exists(Server.MapPath("~\\Bangdiem\\DKHP\\DKHP_HK_" + userName + ".pdf")))
            return;

        //  Edit command
        if ((int)GetState() == 0)
        {
            Session["State"] = 5;
            CheckStateInfo();
            SetDisplayForm();
            SetDataSourceInfo();
            GridView1.DataBind();
            DropDownList1.Enabled = true;
        }
        else
        {
            int sum = 0;
            int sub = 0;
            if ((int)GetState() == 1 || (int)GetState() == 5)    //  Edit command
            {
                listSubID = new List<GridViewRow>();
                if (!CheckCondition(listSubID, ref sum)) return;
                else
                {
                    Hide("*");
                    sub = ConfirmtoReg();
                    Session["State"] = (int)GetState() + 1;   //  Change to Confirm info           
                    SetReregSession();
                    DropDownList1.Enabled = false;
                }
                DK.Text = sum.ToString();
                Sum.Text = (sum + int.Parse(Dahoc.Text) - sub - subRegifReReg).ToString();
                SumTL.Text = (sum + int.Parse(DaTL.Text) - sub - subRegifReReg).ToString();
            }
            else if ((GetState() == 2) || (GetState() == 6))
            {
                sum = UpdateDatabaseSchedule(ref listSubID, UpdateSate);
                if (ShowInfo.Text.Equals("")) ShowInfo.Text = " *** Bạn đã đăng kí thành công !<br/><br/>";
            }
        }
    }

    //  Select row to display in gridview
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList dropdownlist = (DropDownList)sender;
        Hide(dropdownlist.SelectedValue);
    }

    void Hide(string type)
    {
        foreach (GridViewRow row in GridView1.Rows)
        {
            if (type != "*" && ((HiddenField)row.FindControl("Type")).Value != type)
                row.Visible = false;
            else { row.Visible = true; }
        }
    }

    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        //  Check count of rows
        int sum = 0;
        if (GetState() == 1 || GetState() == 5)
        {
            using (SqlConnection scon = new SqlConnection(ConnectionString))
            {
                scon.Open();
                using (SqlCommand scom = new SqlCommand("Select [ClassID] from RegisterInfo where (StuID = @StuID)", scon))
                {
                    scom.Parameters.Add("@StuID", userName);
                    try
                    {
                        SqlDataReader sreader = scom.ExecuteReader();
                        while (sreader.Read())
                        {
                            foreach (GridViewRow grow in GridView1.Rows)
                            {
                                if (!((CheckBox)grow.FindControl("chkSelect")).Checked)
                                {
                                    string ClassID = ((HiddenField)grow.FindControl("ClassID")).Value;
                                    if (ClassID == sreader.GetValue(0).ToString())
                                    {
                                        grow.BackColor = System.Drawing.Color.AliceBlue;
                                        ((CheckBox)grow.FindControl("chkSelect")).Checked = true;

                                        if(EditButton1.Enabled && Times == 2 && 
                                            ((HiddenField)grow.FindControl("isClosed")).Value != "True")
                                            ((CheckBox)grow.FindControl("chkSelect")).Enabled = false;
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    catch (Exception ex) { }
                }
            }

            // hide if full
            foreach (GridViewRow grow in GridView1.Rows)
            {
                if (int.Parse(grow.Cells[8].Text) <= int.Parse(grow.Cells[9].Text))
                {
                    if (((CheckBox)grow.FindControl("chkSelect")).Checked == false)
                    {
                        ((CheckBox)grow.FindControl("chkSelect")).Enabled = false;
                        grow.BackColor = System.Drawing.Color.Snow;
                    }
                }

                if (((HiddenField)grow.FindControl("ClassID")).Value.EndsWith("B"))
                    grow.BackColor = System.Drawing.Color.PaleGoldenrod;

                if (((HiddenField)grow.FindControl("isClosed")).Value == "True")
                    grow.BackColor = System.Drawing.Color.Red;
            }
        }
        else
        {
            foreach (GridViewRow grow in GridView1.Rows)
            {
                try
                {
                    if (GetState() == 0) sum += int.Parse(grow.Cells[3].Text);
                    else if (((CheckBox)grow.FindControl("chkselect")).Checked)
                    {
                        sum += int.Parse(grow.Cells[3].Text);
                    }
                }
                catch (Exception ex) { }

                if (((HiddenField)grow.FindControl("ClassID")).Value.EndsWith("B"))
                    grow.BackColor = System.Drawing.Color.PaleGoldenrod;

                if (((HiddenField)grow.FindControl("isClosed")).Value == "True")
                    grow.BackColor = System.Drawing.Color.BlanchedAlmond;
            }
            if (Sum.Text.Equals("0"))
            {
                DK.Text = sum.ToString();
                Sum.Text = (sum + int.Parse(Dahoc.Text) - subRegifReReg).ToString();
                SumTL.Text = (sum + int.Parse(DaTL.Text) - subRegifReReg).ToString();
            }
        }
    }

    protected void LinkButton3_Click(object sender, EventArgs e)
    {
        ShowInfoAboutSug.Text = "";
        using (SqlConnection scon = new SqlConnection(ConnectionString))
        {
            scon.Open();
            try
            {
                bool isValid = true;
                using (SqlCommand scom0 = new SqlCommand("Select stumx,curNm from ScheduleM where SubID = @SubID",scon))
                {
                    scom0.Parameters.Add("@SubID", DropDownList2.SelectedItem.Text);
                    SqlDataReader sreader = scom0.ExecuteReader();
                    while (sreader.Read())
                    {
                        if (int.Parse(sreader.GetValue(0).ToString()) > int.Parse(sreader.GetValue(1).ToString()))
                        {
                            isValid = false;
                            break;
                        }

                    }   
                }

                if (!isValid)
                {
                    ShowInfoAboutSug.Text = "Lớp mới đã được đề nghị !";
                    SetDataSourceInfo();
                    loadInfo();
                    
                    return ;
                }

                using (SqlCommand scom = new SqlCommand("Select Top 1 StuMx from ScheduleM where SUBID = @SUBID", scon))
                {
                    scom.Parameters.Add("@SUBID", DropDownList2.SelectedItem.Text);
                    SqlDataReader sreader = scom.ExecuteReader();

                    sreader.Read();
                    using (SqlCommand scom1 = new SqlCommand("", scon))
                    {
                        scom1.CommandText = "INSERT INTO ScheduleM(CLassID,SubID,LecNm,Period,Day,Room,StuMx,CurNm,Suggest)" +
                        "VALUES(@ClassID,@SubID,N'*',@Period,@Day,N'*',@StuMx,0,1)";
                        using (SqlCommand scom3 = new SqlCommand("Select count (*) from ScheduleM where SubID = @SubID and Suggest = 1",scon))
                        {
                            try
                            { 
                                scom3.Parameters.Add("@SubID", DropDownList2.SelectedItem.Text);

                                scom1.Parameters.Add("@ClassID", DropDownList2.SelectedItem.Text + ".B"+ ((int)scom3.ExecuteScalar()).ToString() +"B");
                                scom1.Parameters.Add("@SubID", DropDownList2.SelectedItem.Text);
                                scom1.Parameters.Add("@Period", DropDownList3.SelectedValue.Split('$')[0]);
                                scom1.Parameters.Add("@Day", DropDownList3.SelectedValue.Split('$')[1]);
                                scom1.Parameters.Add("@StuMx", sreader.GetValue(0));

                                scom1.ExecuteNonQuery(); ShowInfoAboutSug.Text = string.Format("--> Thành công : đã thêm {0}", scom1.Parameters["@ClassID"].Value);

                               
                                SetDataSourceInfo();
                                loadInfo();
                            }
                            catch (Exception ex) { ShowInfoAboutSug.Text = "Đã thêm lớp này !"; }
                        }
                    }

                }
            }
            catch (Exception ex) { ShowInfoAboutSug.Text = "Lỗi!"; }
        }
    }

    public string getHiV()
    {
        int i = 1;
        foreach (GridViewRow row in GridView1.Rows)
        {
            if (row.Visible)
                if (((HiddenField)row.FindControl("SubID")).Value.StartsWith("ENG0")) i += 4;
                else i+=2;

            if (i > 20) return HeightofDIV;
        }
        return (i * 19 + 25).ToString() + "px";

    }

    public string GetDept(string _Dept)
    {
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

    public string getCenterWithSpace(string s)
    {
        if (s != null) return s.Replace(",", "<br/>&nbsp;&nbsp;");
        else return "";
    }

    public string getCenter(string s)
    {
        if (s != null) return s.Replace(",", "<br/>");
        else return "";
    }

    public string getTerm()
    {
        return Term;
    }

    public string getYear()
    {
        if (SchoYear.ToString().Length != 4)
            return SchoYear.ToString();
        return SchoYear.ToString() + "-" + (SchoYear + 1).ToString();
    }

    public string getYear2()
    {
        if (SchoYear.ToString().Length != 4)
            return SchoYear.ToString();
        return SchoYear.ToString().Substring(2, 2) + "-" + (SchoYear + 1).ToString().Substring(2, 2);
    }

    public string getTermYear()
    {
        if (Term.Contains("1"))
            return "HK 2 " +
                (SchoYear - 1).ToString().Substring(2, 2) + "-" + SchoYear.ToString().Substring(2, 2);
        else if (Term.Contains("2"))
            return "HK 1 Năm " + getYear2();
        else
            return "HK 2 Năm " + getYear2();
        return "";
    }

    int order = 1;
    public int getOrder()
    {
        return order++;
    }

    public bool check(string max, string cur)
    {
        if (cur == null || max == null) return true;

        if (int.Parse(max) <= int.Parse(cur))
            return false;
        else return true;
    }


    #region Template to print pdf
    protected void Download_Click(object sender, EventArgs e)
    {
        //  Check condition
        if (!GridView1.Columns[GridView1.Columns.Count - 1].Visible)
        {
            // Create PDF Document
            String Path = Server.MapPath("~\\Bangdiem\\DKHP\\DKHP_HK_" + userName + ".pdf");
            Document myDocument = new Document(PageSize.A4, 5, 5, 30, 10);

            if (!File.Exists(Path))
            {

                PdfWriter.GetInstance(myDocument, new FileStream(Path, FileMode.CreateNew));

                //  Open document
                myDocument.Open();

                BaseFont bf = BaseFont.CreateFont(Server.MapPath(@"~\Font\TIMES.TTF"), BaseFont.IDENTITY_H, true);
                iTextSharp.text.Font font = new iTextSharp.text.Font(bf, 12);

                iTextSharp.text.Image image = iTextSharp.text.Image.GetInstance(Server.MapPath("~/images/UIT.png"));
                image.Alignment = iTextSharp.text.Image.UNDERLYING;
                image.ScaleToFit(30f, 30f);

                Chunk c1 = new Chunk("TRƯỜNG ĐẠI HỌC CÔNG NGHỆ THÔNG TIN", font);
                c1.SetUnderline(0.5f, -4f);
                Paragraph Header = new Paragraph(15);
                Header.IndentationLeft = 15;
                Header.Alignment = 3;
                Header.Font = font;
                Header.Add(image);
                Header.SpacingBefore = 5f;
                Header.Add("             ĐẠI HỌC QUỐC GIA THÀNH PHỐ HỒ CHÍ MINH \n               ");
                Header.Add(c1);

                Header.Add("\n\n\n");

                myDocument.Add(Header);

                // Add gridview to
                iTextSharp.text.Table table = new iTextSharp.text.Table(5);

                // set table style properties
                table.BorderWidth = 1;
                table.BorderColor = Color.DARK_GRAY;
                table.Padding = 4;
                table.Alignment = 1;
                table.Width = 90;

                // set *column* widths
                float[] widths = { 0.05f, 0.23f, 0.17f, 0.45f, 0.1f };
                table.Widths = widths;

                string[] col = { "TT", "Mã Lớp", "Mã Môn", "Tên Môn Học", "Số TC" };
                font = new iTextSharp.text.Font(bf, 13, 1);

                // create the *table* header row
                for (int i = 0; i < col.Length; ++i)
                {
                    Cell cell = new Cell(new Phrase(col[i], font));
                    cell.Header = true;
                    cell.HorizontalAlignment = 1;
                    table.AddCell(cell);
                }
                table.EndHeaders();

                int sum = 0;
                font = new iTextSharp.text.Font(bf, 12);
                int order = 0;
                foreach (GridViewRow row in GridView1.Rows)
                {
                    Cell c = new Cell(new Phrase((++order).ToString(), font));
                    c.HorizontalAlignment = 1;
                    table.AddCell(c);

                    c = new Cell(new Phrase(row.Cells[1].Text, font));
                    c.HorizontalAlignment = 1;
                    table.AddCell(c);

                    c = new Cell(new Phrase(((HiddenField)row.FindControl("SubID")).Value, font));
                    c.HorizontalAlignment = 1;
                    table.AddCell(c);

                    c = new Cell(new Phrase("   " + ((LinkButton)row.FindControl("SubNm")).Text, font));
                    table.AddCell(c);

                    c = new Cell(new Phrase(row.Cells[3].Text, font));
                    c.HorizontalAlignment = 1;
                    try { sum += Int16.Parse(row.Cells[3].Text); }
                    catch (Exception ex) { }
                    table.AddCell(c);
                }

                font = new iTextSharp.text.Font(bf, 14);
                Paragraph p = new Paragraph("ĐĂNG KÍ HỌC PHẦN HK " + getTerm() + " " + getYear() + " \n", font);
                p.Alignment = 1;
                p.Add("MSSV : " + userName);
                myDocument.Add(p);

                font = new iTextSharp.text.Font(bf, 12);
                c1 = new Chunk("\n\nHọ Tên : ", font);
                font = new iTextSharp.text.Font(bf, 12, 2);
                Chunk c2 = new Chunk(((Label)StudentData.Items[0].FindControl("StuNmLB")).Text, font);
                font = new iTextSharp.text.Font(bf, 12);
                Chunk c3 = new Chunk("     Khoa : ", font);
                font = new iTextSharp.text.Font(bf, 12, 2);
                Chunk c4 = new Chunk(((Label)StudentData.Items[0].FindControl("DeptLB")).Text, font);

                Paragraph p2 = new Paragraph();
                p2.IndentationLeft = 30f;
                p2.Alignment = 3;
                p2.Add(c1);
                p2.Add(c2);
                p2.Add(c3);
                p2.Add(c4);
                myDocument.Add(p2);

                //  Add Gridview
                myDocument.Add(table);

                font = new iTextSharp.text.Font(bf, 12);
                p = new Paragraph(String.Format("Tổng số TC :        {0}                 ", sum.ToString()), font);
                p.Alignment = 2;
                myDocument.Add(p);

                //  Add sign
                font = new iTextSharp.text.Font(bf, 13);
                p = new Paragraph("\n\n\n                                                                                              Chữ ký SV", font);
                p.Add("                                  Chữ ký PĐT\n\n");
                p.Add("                                                                                           .......................");
                p.Add("                              ........................\n");
                myDocument.Add(p);

                //  Check 
                List<string> DateL = new List<string>();
                List<string> Derror = new List<string>();
                String error = "";
                bool first = true;
                foreach (GridViewRow grow in GridView1.Rows)
                {
                    string Date = ((Label)grow.FindControl("Day")).Text;
                    string Period = ((Label)grow.FindControl("Period")).Text;

                    string[] dates = Date.Replace("<br/>", ",").Split(',');
                    string[] periods = Period.Replace("<br/>", ",").Split(',');

                    for (int i = 0; i < dates.Length; i++)
                    {
                        string dateandperiod = dates[i] + periods[i];
                        if (DateL.Contains(dateandperiod))      // Error on samq datetime
                        {
                            if (!Derror.Contains(dateandperiod))
                            {
                                if (first)
                                {
                                    error += "Thứ " + dates[i] + " ca " + periods[i];
                                    first = false;
                                }
                                else error += ", Thứ " + dates[i] + " ca " + periods[i];

                                Derror.Add(dateandperiod);
                            }
                        }
                        else DateL.Add(dateandperiod);
                    }
                }

                if (error != "")
                {
                    font = new iTextSharp.text.Font(bf, 12);
                    p = new Paragraph("\n\n        Ghi chú : trùng giờ học ", font);
                    p.Add("\n        (" + error + ")");
                    myDocument.Add(p);
                }


                font = new iTextSharp.text.Font(bf, 11);
                p = new Paragraph("\n        In vào :" + DateTime.UtcNow.ToShortTimeString() +
                    " " + DateTime.UtcNow.ToShortDateString(), font);
                p.Add("\n        Chú ý : Sinh viên \n        không được tự ý thay đổi nội dung file này.");
                myDocument.Add(p);

                //  Close document 
                myDocument.Close();

                //  Check connection and trangfer file
                using (SqlConnection scon = new SqlConnection(ConnectionString))
                {
                    scon.Open();
                    using (SqlCommand scom = new SqlCommand("Insert into DownloadLog values(@StuID,getdate())", scon))
                    {
                        scom.Parameters.Add("@StuID", userName);
                        try
                        {
                            scom.ExecuteNonQuery();
                        }
                        catch (Exception ex)
                        {
                            using (SqlCommand scom1 = new SqlCommand("Update Downloadlog set log = getdate() where StuID = @StuID", scon))
                            {
                                try
                                {
                                    scom1.Parameters.Add("@StuID", userName);
                                    scom1.ExecuteNonQuery();

                                }
                                catch (Exception ex1) { }
                            }
                        }
                    }
                }
            }
            Response.ClearContent();
            Response.ClearHeaders();
            Response.ContentType = "application/pdf";
            Response.AddHeader
            ("Content-Disposition", "attachment; filename = DKHP_" + userName + ".pdf");
            Response.TransmitFile(Path);
            Response.End();
            Response.Flush();
            Response.Clear();
        }
    }
    #endregion

}