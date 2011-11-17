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
    private int subRegifReReg;
    protected SqlDataSource scheduleSource;
    protected GridView schedule;
    public string HeightofDIV = "490px";
    protected List<GridViewRow> listSubID;
    protected bool UpdateSate = false;
    protected List<String> Reregsubject;
    protected String userName;
    #endregion

    protected void StudentDataSource_Load(object sender, EventArgs e)
    {
        studentsource = (SqlDataSource)sender;
        if (!Page.IsPostBack)
            studentsource.SelectParameters["StuId"].DefaultValue = userName;
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
        
        if (!IsPostBack)
        {
            if (GetState() == 0) CheckStateInfo();
            using (SqlConnection scon = new SqlConnection(ConnectionString))
            {
                scon.Open();
                using (SqlCommand scom = new SqlCommand("Select sum(Credits) from Subject as S , Mark as M "+
                "where (S.SubID = M.SubID) and (M.StuID = @StuID)", scon))
                {
                    scom.Parameters.Add("@StuID", userName);
                    try { Dahoc.Text = (getInt(scom.ExecuteScalar())).ToString();}
                    catch (Exception ex) { }
                    scom.CommandText = "select sum(Credits) from Subject as S , Mark as M " +
                    "where (S.SubID = M.SubID) and ( M.StuID = @StuID ) and ( Mark >= 50 )";
                    try { DaTL.Text = (getInt(scom.ExecuteScalar())).ToString(); }
                    catch (Exception ex) { }
                }
            }
            SetDisplayForm();
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

    int CheckStateInfo()
    {
        using (SqlConnection scon = new SqlConnection(ConnectionString))
        {
            scon.Open();
            using(SqlCommand scom = new SqlCommand("select count(*) from RegisterInfo where (StuID = @StuID) and ( Suggest = 0 ) or (Suggest is null )",scon))
            {
                scom.Parameters.Add("@StuID",userName);
                try
                {
                    if (getInt(scom.ExecuteScalar()) > 0)
                    {
                        scom.CommandText = "select sum(S.Credits) from RegisterInfo as R , Subject as S where" +
                        " (S.SubId = R.SubID) and (R.StuID = @StuID) and (R.ReReg = 1)";
                        subRegifReReg = getInt(scom.ExecuteScalar());
                    }
                    else
                    {
                        Session["State"] = 1;
                    }
                }catch(Exception ex){}
            }
        }
        return GetState();
    }

    void Clear() 
    {
        using (SqlConnection scon = new SqlConnection(ConnectionString))
        {
            scon.Open();
            using (SqlCommand scom = new SqlCommand("Delete from RegisterInfo where (StuID = @StuID ) "+
            "and (Suggest = 0)", scon))
            {
                scom.Parameters.Add("@StuID", userName);
                try 
                {
                    scom.ExecuteNonQuery(); 
                    ScriptManager.RegisterStartupScript(this.Page,Page.GetType(),"Hoàn tất",
                        "alert('Đã xóa tất cả các môn đăng kí !')",true);
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "Thông báo lỗi",
                        "alert('Có một số lỗi xảy ra !')", true);
                }
            }
        }
    }

    protected void PrintButton_Click(object sender, EventArgs e)
    {
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
            scheduleSource.SelectCommand = "SELECT [Typ],S.SubID,[SubNm],[Credits],S.LecID,[StuMx],[LecNm],[Day],[Period],[Room],[CurNm] FROM RegisterInfo as R,ScheduleM as S,Subject as S1 ,Lecturer as L" +
             " where (R.subID = S.SubID) and (R.LecID = S.LecID) and (L.LecID = R.LecID) and (S1.SubID = R.SubID) and (R.StuID = '" + userName + "') and (R.Suggest = 0) ORDER BY [Day], [Period]";
        }
        else 
            scheduleSource.SelectCommand = "SELECT [Typ],S.SubID,[SubNm],[Credits],S.LecID,[StuMx],[LecNm],[Day],[Period],[Room],[CurNm] FROM [ScheduleM] as S,Subject as S1 ,Lecturer as L " +
            " where S.SubID = S1.SubID and L.LecID = S.LecID ORDER BY [Day], [Period]";

        GridView1.DataBind();
    }

    bool Contains(List<GridViewRow> list, string SubID)
    {
        foreach (GridViewRow grow in list)
        {
            if (((HiddenField)grow.FindControl("Môn")).Value.Equals(SubID))
            {
                grow.BackColor = System.Drawing.Color.Yellow;
                return true;
            }
        }
        return false;
    }

    //  Display error color info
    bool displayErrorInfo(string s, GridViewRow row)
    {
        //  hightlight error row 
        row.BackColor = System.Drawing.Color.Yellow;
        return displayErrorInfo(s);
    }

    //  Display error text info
    bool displayErrorInfo(string s)
    {
        if (ShowInfo.Text.Contains("*** Lỗi : ")) ShowInfo.Text += s + "<br/>";
        else ShowInfo.Text = "*** Lỗi : " + s + "<br/>";
        return false;
    }

    //  Check row gridview info 
    bool CheckGrow(GridViewRow grow)
    {
        string SubIDM = ((HiddenField)grow.FindControl("Môn")).Value;
        string DateM = grow.Cells[3].Text + ((Label)grow.FindControl("Period1")).Text;
        foreach (GridViewRow row in listSubID)
        {
            string SubID = ((HiddenField)row.FindControl("Môn")).Value;
            string Date = row.Cells[3].Text + ((Label)row.FindControl("Period1")).Text;
            if (SubID == SubIDM)    // Error on same subID
            {
                row.BackColor = System.Drawing.Color.Yellow;
                return displayErrorInfo("Môn học không được trùng nhau : " +
                ((LinkButton)grow.FindControl("A")).Text + "( " + SubID + ")", grow);
            }
            if (DateM == Date)      // Error on samq datetime
            {
                row.BackColor = System.Drawing.Color.Yellow;
                return displayErrorInfo("Giờ học không được trùng nhau !", grow);
            }
            
        }
        listSubID.Add(grow);
        return true;
    }

    //  Check condition about all preinfo to register item
    protected bool CheckCondition(List<GridViewRow> listSubID, ref int sum)
    {
        ShowInfo.Text = "";
        listSubID = new List<GridViewRow>();
        SqlDataReader sReader;
        using (SqlConnection scon = new SqlConnection(ConnectionString))
        {
            scon.Open();
            using (SqlCommand scom = new SqlCommand("Select SI.PreSubID,S.SubNm,SI.typ from SubInfo as SI, Subject " +
            "as S where ( SI.PreSubID = S.subID ) and ( SI.SubID = @SubID ) order by typ ", scon))
            {
                using(SqlCommand scom1 = new SqlCommand("SELECT count(*) FROM Mark " +
                "WHERE (StuId = @StuID) AND (SubId = @SubID) AND (Mark >= 50) ",scon))
                {
                    scom1.Parameters.Add("@StuID", userName);
                    scom.Parameters.Add("@SubID","");
                    scom1.Parameters.Add("@SubID", "");
                    foreach (GridViewRow grow in GridView1.Rows)
                    {
                        //  If row is checked then break in 
                        grow.BackColor = System.Drawing.Color.Transparent;
                        if (((CheckBox)grow.FindControl("chkSelect")).Checked)
                        {
                            //  Check about same subID and date
                            grow.BackColor = System.Drawing.Color.AliceBlue;
                            string SubID = ((HiddenField)grow.FindControl("Môn")).Value;
                            bool isCheck = CheckGrow(grow);
                            if (!isCheck) return isCheck;

                            //  Check condition about preSubID
                            scom.Parameters["@SubID"].Value = SubID;
                            try
                            {
                                //scom.Prepare();
                                sReader = scom.ExecuteReader();
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
                                        S += sReader.GetValue(1) + " ( " + sReader.GetValue(0) + " ),";
                                }
                                if (!S.Equals(""))
                                    displayErrorInfo("Bạn chưa học môn " + S.Remove(S.Length - 1) +
                                    " là môn tiên quyết của môn " + ((LinkButton)grow.FindControl("A")).Text, grow);
                 
                                //if (!S.Equals(""))
                                //{
                                //    //ShowInfo.Text = S;
                                //    return false;
                                //}
                                sReader.Close();
                            }
                            catch(Exception ex){}
                            sum += int.Parse(grow.Cells[1].Text);
                        }
                    }
                }
            }
        }
        //  Check condition about Qui che : MaxReg
        //  Num of credits must larger than 0
        if ( sum == 0 )
            displayErrorInfo("Tổng số TC đăng kí là : " + sum + " . Bạn phải đăng kí số TC > 0.");

        //  Check conditonn about  MinReg
        //  Check condition about Qui che : maxReg of TB and Yeu
        //  if( TB Student : StuID = @StuID and AMark >= 5.0 & < 6 --> Sum < SumMaxTB
        //  else Average >=4.0 & < 5.0 --> Sum < SumMaxYeu        
        if (ShowInfo.Text.Equals(""))
            return true;
        else return false;
    }

    int GetState()
    {
        if (Session["State"] == null)
            Session.Add("State", 0);
        return (int)Session["State"];
    }

    void UpdateDatabase(List<GridViewRow> list)
    {
        using (SqlConnection scon = new SqlConnection(ConnectionString))
        {
            scon.Open();
            using(SqlCommand scom = new SqlCommand("select count(*) from RegisterInfo where (SubID = @SubID) "+
            "and ( LecID = @LecID )",scon))
            {
                scom.Parameters.Add("@SubID","");
                scom.Parameters.Add("@LecID","");
                using (SqlCommand scom1 = new SqlCommand("Update ScheduleM set CurNm = @Number" +
                " where (Subid = @SubID) and (LecID = @LecID)",scon))
                {
                    scom1.Parameters.Add("@SubID", "");
                    scom1.Parameters.Add("@LecID", "");
                    scom1.Parameters.Add("@Number", 0);
                    foreach (GridViewRow grow in GridView1.Rows)
                    {
                        scom.Parameters["@SubID"].Value = scom1.Parameters["@SubID"].Value = 
                            ((HiddenField)grow.FindControl("Môn")).Value;
                        scom.Parameters["@LecID"].Value = scom1.Parameters["@LecID"].Value = 
                            ((HiddenField)grow.FindControl("gv")).Value;
                        try
                        {
                            grow.Cells[7].Text = getInt(scom.ExecuteScalar()).ToString();
                            scom1.Parameters["@Number"].Value = grow.Cells[7].Text;
                            scom1.ExecuteNonQuery();
                        }
                        catch (Exception ex) { }
                    }
                }
            }
        }
        Session["State"] = 0;
        SetDataSourceInfo();
        SetDisplayForm();
        GridView1.DataBind();
    }
   
    int UpdateDatabaseSchedule(ref List<GridViewRow> listMain, bool updateState)
    {
        List<GridViewRow> list = new List<GridViewRow>();
        int sum = 0;
        using (SqlConnection scon = new SqlConnection(ConnectionString))
        {
            scon.Open();
            using (SqlCommand scom = new SqlCommand("delete from RegisterInfo where (StuID = @StuID ) and (Suggest = 0)", scon))
            {
                scom.Parameters.Add("@StuID", userName);
                if (GetState() == 6)
                {
                    scom.ExecuteNonQuery();
                }
                scom.CommandText = "Insert into RegisterInfo(StuId,SubID,LecID,Suggest,ReReg) values" +
                "(@StuID,@SubID,@LecID,0,@Value)";
                scom.Parameters.Add("@LecID", "");
                scom.Parameters.Add("@SubID", "");
                scom.Parameters.Add("@Value", 0);
                foreach (GridViewRow grow in GridView1.Rows)
                {
                    if (((CheckBox)grow.FindControl("chkselect")).Checked)
                    {
                        grow.BackColor = System.Drawing.Color.Transparent;
                        scom.Parameters["@SubID"].Value = ((HiddenField)grow.FindControl("Môn")).Value;
                        scom.Parameters["@LecID"].Value = ((HiddenField)grow.FindControl("gv")).Value;
                        if (getRereg().Contains(scom.Parameters["@SubID"].Value.ToString()))
                            scom.Parameters["@Value"].Value = 1;
                        else scom.Parameters["@Value"].Value = 0;
                        try { scom.ExecuteNonQuery(); sum += int.Parse(grow.Cells[1].Text); }
                        catch (Exception e) { ShowInfo.Text = "Có lỗi xảy ra"; }
                    }
                }
            }
        }
        return sum;
    }

    List<String> getRereg()
    {
        if (Session["ReReg"] == null) Session.Add("ReReg", Reregsubject);
        return (List<String>) Session["Rereg"];
    }

    void SetReregSession()
    {
        if (Session["ReReg"] == null) Session.Add("ReReg", Reregsubject);
        else Session["Rereg"] = Reregsubject;
    }

    //  Confirm user and give some info to user
    int  ConfirmtoReg()
    {
        int i = 0;
        int sum = 0;
        string Comment = "";
        using (SqlConnection scon = new SqlConnection(ConnectionString))
        {
            scon.Open();
            using (SqlCommand scom = new SqlCommand("Select count(*) from Mark where StuID = @StuID and (SubID = @SubID) and (Mark >= 50)", scon))
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
                        scom.Parameters["@SubID"].Value =  ((HiddenField)grow.FindControl("Môn")).Value;
                        string SubNm = ((LinkButton)grow.FindControl("A")).Text;
                        try
                        {
                            if (getInt(scom.ExecuteScalar()) > 0)
                            {
                                Comment += SubNm + " ( " + scom.Parameters["@SubID"].Value + " ) ,";
                                grow.BackColor = System.Drawing.Color.AntiqueWhite;
                                sum += int.Parse(grow.Cells[1].Text);
                                Reregsubject.Add(scom.Parameters["@SubID"].Value.ToString());
                            }
                        }
                        catch (Exception ex) { }
                    }
                }
            }
        }
        if (Comment != "") ShowInfo.Text += "**** Chú ý : <br/>Bạn đã học môn " + Comment.Remove(Comment.Length - 1) +
        ". Bạn có muốn đăng kí học lại không ?<br/>";
        else ShowInfo.Text = "*** Bạn có đồng ý đăng kí những môn học trên không ?<br/>";
        EditButton1.Text = "Đồng ý ";
        return sum;
    }

    protected void EditButton1_Click(object sender, EventArgs e)
    {
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
                //  2 : Update database for schedule
                sum = UpdateDatabaseSchedule(ref listSubID, UpdateSate);
                //  3 : Save data about items that student choose
                UpdateDatabase(listSubID);
                if(ShowInfo.Text.Equals("")) ShowInfo.Text = " *** Bạn đã đăng kí thành công !<br/><br/>";
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
                using (SqlCommand scom = new SqlCommand("Select [SubID],[LecID] from RegisterInfo where (StuID = @StuID) and (Suggest = 0)", scon))
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
                                    string Subid = ((HiddenField)grow.FindControl("Môn")).Value;
                                    string LecID = ((HiddenField)grow.FindControl("gv")).Value;
                                    if (Subid == sreader.GetValue(0).ToString() && LecID == sreader.GetValue(1).ToString())
                                    {
                                        grow.BackColor = System.Drawing.Color.AliceBlue;
                                        ((CheckBox)grow.FindControl("chkSelect")).Checked = true;
                                        break;
                                    }
                                }
                            }
                        }
                    }catch(Exception ex){}
                }
            }
        }
        else
        {
            foreach (GridViewRow grow in GridView1.Rows)
            {
                try
                {
                    if (GetState() == 0)
                        sum += int.Parse(grow.Cells[1].Text);
                    else if (((CheckBox)grow.FindControl("chkselect")).Checked)
                    {
                        sum += int.Parse(grow.Cells[1].Text);
                    }
                }catch(Exception ex){}
            }
            DK.Text = sum.ToString();
            Sum.Text = (sum + int.Parse(Dahoc.Text) - subRegifReReg).ToString();
            SumTL.Text = (sum + int.Parse(DaTL.Text) - subRegifReReg).ToString();
        }
    }

    protected void LinkButton3_Click(object sender, EventArgs e)
    {
        using (SqlConnection scon = new SqlConnection(ConnectionString))
        {
            scon.Open();
            using (SqlCommand scom = new SqlCommand("Insert into RegisterInfo(StuId,SubID,Suggest) " +
            " values(@StuID,@SubID,1)", scon))
            {
                scom.Parameters.Add("@StuID", userName);
                scom.Parameters.Add("@SubID",DropDownList2.SelectedValue);
                try { scom.ExecuteNonQuery(); ShowInfoAboutSug.Text = "--> Đề nghị thành công !"; }
                catch (Exception ex) { ShowInfoAboutSug.Text = "--> Lỗi : Đã đề nghị môn này!"; }
            }
        }
    }

    public string getHiV() 
    {
        if (GridView1.Rows.Count < 20) 
            return (GridView1.Rows.Count * 17 + 60).ToString() + "px";
        else
        {
            int i = 0;
            foreach (GridViewRow row in GridView1.Rows)
            {
                if (row.Visible) i++;
                if (i > 20) return HeightofDIV;
            }
            return (i * 22 + 55).ToString() + "px";
        }
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
   
}