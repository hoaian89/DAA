using System;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Drawing;

using System.Data.SqlTypes;
using System.IO;


namespace webRegister
{
    public partial class _Default : System.Web.UI.Page
    {
        #region Khai bao bien

        string strEmptyError = "- Bạn chưa điền ";
        string strGroupError = "- Bạn phải có ít nhất ";
        string strValid = "Thông tin đã hợp lệ";

        bool bCertific;
        int iJobYear;
        float fCerMark;
        string strProfileCode;
        string[] astrExSubCode;

        DateTime dtmBirth, dtmUnion, dtmParty, dtmCer;
        DateTime[] adtmArt, adtmRes;
        ArrayList alArticle, alResearch, alHistory, alSchool;
        SqlConnection cnn;
        SqlCommand objCommand;
        SqlDataReader drdSQL;

        string CapIm1
        {
            get
            {
                if (ViewState["CaptchaIm1"] != null)
                    return ViewState["CaptchaIm1"].ToString();
                return null;
            }
            set
            {
                ViewState["CaptchaIm1"] = value;
            }
        }
        string CapIm2
        {
            get
            {
                if (ViewState["CaptchaIm2"] != null)
                    return ViewState["CaptchaIm2"].ToString();
                return null;
            }
            set
            {
                ViewState["CaptchaIm2"] = value;
            }
        }
        float[] afMarkMA
        {
            get
            {
                if (Session["MarkMA"] == null)
                {
                    return null;
                }
                return (float[])Session["MarkMA"];
            }
            set
            {
                Session["MarkMA"] = value;
            }
        }
        float[] afMarkRS
        {
            get
            {
                if (Session["MarkRS"] == null)
                {
                    return null;
                }
                return (float[])Session["MarkRS"];
            }
            set
            {
                Session["MarkRS"] = value;
            }
        }
        int[] aiValidLimit
        {
            get
            {
                if (Session["YearLimit"] == null)
                {
                    return null;
                }
                return (int[])Session["YearLimit"];
            }
            set
            {
                Session["YearLimit"] = value;
            }
        }
        int iATCount
        {
            get
            {
                if (ViewState["ATCount"] != null)
                    return (int)ViewState["ATCount"];
                return 0;
            }
            set
            {
                ViewState["ATCount"] = value;
            }
        }
        bool[] abSupCer
        {
            get
            {
                if (Session["SupCer"] == null)
                {
                    return null;
                }
                return (bool[])Session["SupCer"];
            }
            set
            {
                Session["SupCer"] = value;
            }
        }

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            InitProperty();
            if (!Page.IsPostBack)
            {
                cnn.Open();
                InitDropDownLists();
                InitObjectData();
                cnn.Close();
                CaptchaInit();
            }
            InitATB();
            InitEvent();
        }

        #region Cac ham khoi tao

        void InitProperty()
        {
           // cnn = new SqlConnection();
            /*string c = "";
            try
            {
                string t = HttpContext.Current.Server.MapPath("Default.aspx").Replace("Default.aspx", "Connection");
                StreamReader sr = File.OpenText(t);
                
                try
                {
                    c = sr.ReadLine();
                    sr.Close();
                }
                catch
                {
                    sr.Close();
                    return;
                }
            }
            catch
            {
                return;
            }*/
            string c = ConfigurationManager.ConnectionStrings["SiteSqlServer1"].ConnectionString;
                cnn = new SqlConnection(c);
           // cnn.ConnectionString = @"server = .\sqlexpress ;integrated security = true ;database = QLTSSDHv2";
           //  cnn.ConnectionString = @"Data Source =.\sqlexpress;Initial Catalog=QLTSSDHv2;User Id=qlts;Password=npk@IT#2010";
            objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.Text;
            objCommand.Connection = cnn;
        }

        void InitATB()
        {
            //thong tin ca nhan
            atbFirstName.Tag = lblError1;
            atbLastName.Tag = lblError1;
            atbPlaceBirth.Tag = lblError1;
            atbEthnic.Tag = lblError1;
            atbReligion.Tag = lblError1;
            atbYearBirth.Tag = lblError2;

            atbFirstName.strErr = "Họ";
            atbLastName.strErr = "Tên";
            atbPlaceBirth.strErr = "Nơi sinh";
            atbEthnic.strErr = "Dân tộc";
            atbReligion.strErr = "Tôn giáo";
            atbYearBirth.strErr = "Ngày sinh";

            //thong tin lien lac
            atbAddressHome.Tag = lblError3;
            atbWorkPhone.Tag = lblError3;
            atbJobName.Tag = lblError4;
            atbJobPlace.Tag = lblError4;
            atbContactPerson.Tag = lblError4;
            atbContactAddress.Tag = lblError4;
            atbContactPhone.Tag = lblError4;
            atbEmail.Tag = lblError4;
            atbJobYear.Tag = lblError5;
            atbYearUnion.Tag = lblError5;
            atbYearParty.Tag = lblError5;

            atbJobYear.strErr = "Năm công tác";
            atbJobName.strErr = "Nghề nghiệp";
            atbJobPlace.strErr = "Nơi làm việc";
            atbContactPerson.strErr = "Người liên lạc";
            atbContactAddress.strErr = "Địa chỉ người liên lạc";
            atbContactPhone.strErr = "Điện thoại người liên lạc";
            atbEmail.strErr = "Email";
            atbYearUnion.strErr = "Ngày vào Đoàn";
            atbYearParty.strErr = "Ngày vào Đảng";

            //Chung chi
            atbYearCer.Tag = lblError6;
            atbCerMark.Tag = lblError7;

            atbYearCer.strErr = "Ngày cấp chứng chỉ";
            atbCerMark.strErr = " *Điểm thi ngoại ngữ";

            //Bai bao
            advArtName1.Tag = lblError8;
            advArtName2.Tag = lblError8;
            advArtName3.Tag = lblError8;
            advArtName4.Tag = lblError8;
            advArtName5.Tag = lblError8;
            advArtField1.Tag = lblError8;
            advArtField2.Tag = lblError8;
            advArtField3.Tag = lblError8;
            advArtField4.Tag = lblError8;
            advArtField5.Tag = lblError8;
            advArtMag1.Tag = lblError8;
            advArtMag2.Tag = lblError8;
            advArtMag3.Tag = lblError8;
            advArtMag4.Tag = lblError8;
            advArtMag5.Tag = lblError8;
            atbYearArt1.Tag = lblError9;
            atbYearArt2.Tag = lblError9;
            atbYearArt3.Tag = lblError9;
            atbYearArt4.Tag = lblError9;
            atbYearArt5.Tag = lblError9;

            advArtField1.strErr = "lĩnh vực của bài báo 1";
            advArtField2.strErr = "lĩnh vực của bài báo 2";
            advArtField3.strErr = "lĩnh vực của bài báo 3";
            advArtField4.strErr = "lĩnh vực của bài báo 4";
            advArtField5.strErr = "lĩnh vực của bài báo 5";
            advArtMag1.strErr = "tạp chí đăng bài báo 1";
            advArtMag2.strErr = "tạp chí đăng bài báo 2";
            advArtMag3.strErr = "tạp chí đăng bài báo 3";
            advArtMag4.strErr = "tạp chí đăng bài báo 4";
            advArtMag5.strErr = "tạp chí đăng bài báo 5";
            advArtName1.strErr = "tên bài báo 1";
            advArtName2.strErr = "tên bài báo 2";
            advArtName3.strErr = "tên bài báo 3";
            advArtName4.strErr = "tên bài báo 4";
            advArtName5.strErr = "tên bài báo 5";
            atbYearArt1.strErr = "Ngày đăng bài báo 1";
            atbYearArt2.strErr = "Ngày đăng bài báo 2";
            atbYearArt3.strErr = "Ngày đăng bài báo 3";
            atbYearArt4.strErr = "Ngày đăng bài báo 4";
            atbYearArt5.strErr = "Ngày đăng bài báo 5";

            //cong trinh
            advResField1.Tag = lblError10;
            advResField2.Tag = lblError10;
            advResField3.Tag = lblError10;
            advResField4.Tag = lblError10;
            advResGuide1.Tag = lblError10;
            advResGuide2.Tag = lblError10;
            advResGuide3.Tag = lblError10;
            advResGuide4.Tag = lblError10;
            advResName1.Tag = lblError10;
            advResName2.Tag = lblError10;
            advResName3.Tag = lblError10;
            advResName4.Tag = lblError10;
            advResPlace2.Tag = lblError10;
            advResPlace3.Tag = lblError10;
            advResPlace4.Tag = lblError10;
            atbYearRes2.Tag = lblError11;
            atbYearRes3.Tag = lblError11;
            atbYearRes4.Tag = lblError11;

            advResField1.strErr = "lĩnh vực công trình nghiên cứu 1";
            advResField2.strErr = "lĩnh vực công trình nghiên cứu 2";
            advResField3.strErr = "lĩnh vực công trình nghiên cứu 3";
            advResField4.strErr = "lĩnh vực công trình nghiên cứu 4";
            advResGuide1.strErr = "giáo viên hướng dẫn công trình nghiên cứu 1";
            advResGuide2.strErr = "giáo viên hướng dẫn công trình nghiên cứu 2";
            advResGuide3.strErr = "giáo viên hướng dẫn công trình nghiên cứu 3";
            advResGuide4.strErr = "giáo viên hướng dẫn công trình nghiên cứu 4";
            advResName1.strErr = "tên công trình nghiên cứu 1";
            advResName2.strErr = "tên công trình nghiên cứu 2";
            advResName3.strErr = "tên công trình nghiên cứu 3";
            advResName4.strErr = "tên công trình nghiên cứu 4";
            advResPlace2.strErr = "nơi công bố công trình nghiên cứu 2";
            advResPlace3.strErr = "nơi công bố công trình nghiên cứu 3";
            advResPlace4.strErr = "nơi công bố công trình nghiên cứu 4";
            atbYearRes2.strErr = "Ngày công bố 2";
            atbYearRes3.strErr = "Ngày công bố 3";
            atbYearRes4.strErr = "Ngày công bố 4";

            //qua trinh
            advHisArchi1.Tag = lblError12;
            advHisArchi2.Tag = lblError12;
            advHisArchi3.Tag = lblError12;
            advHisArchi4.Tag = lblError12;
            advHisArchi5.Tag = lblError12;
            advHisDate1.Tag = lblError12;
            advHisDate2.Tag = lblError12;
            advHisDate3.Tag = lblError12;
            advHisDate4.Tag = lblError12;
            advHisDate5.Tag = lblError12;
            advHisPlace1.Tag = lblError12;
            advHisPlace2.Tag = lblError12;
            advHisPlace3.Tag = lblError12;
            advHisPlace4.Tag = lblError12;
            advHisPlace5.Tag = lblError12;
            advHisWork1.Tag = lblError12;
            advHisWork2.Tag = lblError12;
            advHisWork3.Tag = lblError12;
            advHisWork4.Tag = lblError12;
            advHisWork5.Tag = lblError12;

            advHisArchi1.strErr = "kết quả đạt được 1";
            advHisArchi2.strErr = "kết quả đạt được 2";
            advHisArchi3.strErr = "kết quả đạt được 3";
            advHisArchi4.strErr = "kết quả đạt được 4";
            advHisArchi5.strErr = "kết quả đạt được 5";
            advHisDate1.strErr = "ngày tháng năm 1";
            advHisDate2.strErr = "ngày tháng năm 2";
            advHisDate3.strErr = "ngày tháng năm 3";
            advHisDate4.strErr = "ngày tháng năm 4";
            advHisDate5.strErr = "ngày tháng năm 5";
            advHisPlace1.strErr = "nơi chốn 1";
            advHisPlace2.strErr = "nơi chốn 2";
            advHisPlace3.strErr = "nơi chốn 3";
            advHisPlace4.strErr = "nơi chốn 4";
            advHisPlace5.strErr = "nơi chốn 5";
            advHisWork1.strErr = "học làm việc 1";
            advHisWork2.strErr = "học làm việc 2";
            advHisWork3.strErr = "học làm việc 3";
            advHisWork4.strErr = "học làm việc 4";
            advHisWork5.strErr = "học làm việc 5";

            //daihoc, caohoc
            advSchMark1.Tag = lblError15;
            advSchMark2.Tag = lblError15;
            advSchMark3.Tag = lblError15;
            advSchMark4.Tag = lblError15;
            advSchMark5.Tag = lblError15;
            advSchName1.Tag = lblError14;
            advSchName2.Tag = lblError14;
            advSchName3.Tag = lblError14;
            advSchName4.Tag = lblError14;
            advSchName5.Tag = lblError14;
            advSchYearBegin1.Tag = lblError15;
            advSchYearBegin2.Tag = lblError15;
            advSchYearBegin3.Tag = lblError15;
            advSchYearBegin4.Tag = lblError15;
            advSchYearBegin5.Tag = lblError15;
            advSchYearEnd1.Tag = lblError15;
            advSchYearEnd2.Tag = lblError15;
            advSchYearEnd3.Tag = lblError15;
            advSchYearEnd4.Tag = lblError15;
            advSchYearEnd5.Tag = lblError15;

            advSchMark1.strErr = "Điểm trung bình 1";
            advSchMark2.strErr = "Điểm trung bình 2";
            advSchMark3.strErr = "Điểm trung bình 3";
            advSchMark4.strErr = "Điểm trung bình 4";
            advSchMark5.strErr = "Điểm trung bình 5";
            advSchName1.strErr = "tên trường 1";
            advSchName2.strErr = "tên trường 2";
            advSchName3.strErr = "tên trường 3";
            advSchName4.strErr = "tên trường 4";
            advSchName5.strErr = "tên trường 5";
            advSchYearBegin1.strErr = "Năm bắt đầu 1";
            advSchYearBegin2.strErr = "Năm bắt đầu 2";
            advSchYearBegin3.strErr = "Năm bắt đầu 3";
            advSchYearBegin4.strErr = "Năm bắt đầu 4";
            advSchYearBegin5.strErr = "Năm bắt đầu 5";
            advSchYearEnd1.strErr = "Năm kết thúc 1";
            advSchYearEnd2.strErr = "Năm kết thúc 2";
            advSchYearEnd3.strErr = "Năm kết thúc 3";
            advSchYearEnd4.strErr = "Năm kết thúc 4";
            advSchYearEnd5.strErr = "Năm kết thúc 5";
        }

        //tao du lieu cho cac dropdownlist
        void InitDropDownLists()
        {
            SetComboDate(ddlDayBirth, ddlMonthBirth);
            SetComboDate(ddlDayUnion, ddlMonthUnion);
            SetComboDate(ddlDayParty, ddlMonthParty);
            SetComboDate(ddlDayCer, ddlMonthCer);

            SetComboDate(ddlDayArt1, ddlMonthArt1);
            SetComboDate(ddlDayArt2, ddlMonthArt2);
            SetComboDate(ddlDayArt3, ddlMonthArt3);
            SetComboDate(ddlDayArt4, ddlMonthArt4);
            SetComboDate(ddlDayArt5, ddlMonthArt5);
            SetComboDate(ddlDayRes2, ddlMonthRes2);
            SetComboDate(ddlDayRes3, ddlMonthRes3);
            SetComboDate(ddlDayRes4, ddlMonthRes4);

            //bind du lieu cho cac combobox
            ddlPriority.Items.Add("");
            BindingDataSQL("UuTien", 1, ddlPriority);
            BindingDataSQL("CumThi", 1, ddlGroupExam);
            ddlCertificate.Items.Add("");
            BindingDataSQL("NgoaiNgu", 1, ddlCertificate);

            ArrayList al = new ArrayList();
            BindingObject(ref al, "Nganh", 1);
            ListItem[] ali = new ListItem[al.Count];
            for (int i = 0; i < ali.Length; i++)
                ali[i] = new ListItem(al[i].ToString());
            ddlSchMajor1.Items.AddRange(ali);
            ddlSchMajor2.Items.AddRange(ali);
            ddlSchMajor3.Items.AddRange(ali);
            //ddlSchMajor4.Items.AddRange(ali);
            //ddlSchMajor5.Items.AddRange(ali);

            FindSession();
        }

        //khoi tao du lieu
        void InitObjectData()
        {
            ArrayList al = new ArrayList();
            float[] af;

            al.Clear();
            BindingObject(ref al, "CumThi", 0);
            for (int i = 0; i < ddlGroupExam.Items.Count; i++)
                ddlGroupExam.Items[i].Value = al[i].ToString();

            al.Clear();
            BindingObject(ref al, "NgoaiNgu", 0);
            for (int i = 1; i < ddlCertificate.Items.Count; i++)
                ddlCertificate.Items[i].Value = al[i - 1].ToString();

            al.Clear();
            BindingObject(ref al, "NgoaiNgu", 2);
            af = new float[al.Count];
            for (int i = 0; i < af.Length; i++)
                af[i] = float.Parse(al[i].ToString());
            afMarkMA = af;

            al.Clear();
            BindingObject(ref al, "NgoaiNgu", 3);
            af = new float[al.Count];
            for (int i = 0; i < af.Length; i++)
                af[i] = float.Parse(al[i].ToString());
            afMarkRS = af;

            al.Clear();
            BindingObject(ref al, "NgoaiNgu", 4);
            int[] ai = new int[al.Count];
            for (int i = 0; i < ai.Length; i++)
                ai[i] = int.Parse(al[i].ToString());
            aiValidLimit = ai;

            al.Clear();
            BindingObject(ref al, "UuTien", 0);
            string[] astr = new string[al.Count];
            for (int i = 1; i < ddlPriority.Items.Count; i++)
                ddlPriority.Items[i].Value = al[i - 1].ToString();

            al.Clear();
            BindingObject(ref al, "Nganh", 2);
            bool[] ab = new bool[al.Count];
            for (int i = 0; i < ab.Length; i++)
                ab[i] = bool.Parse(al[i].ToString());
            abSupCer = ab;

            al.Clear();
            BindingObject(ref al, "Nganh", 1);
            ArrayList al1 = new ArrayList();
            for (int i = 0; i < ab.Length; i++)
                if (!ab[i])
                    al1.Add(al[i]);
            ListItem[] ali = new ListItem[al1.Count];
            for (int i = 0; i < ali.Length; i++)
                ali[i] = new ListItem(al1[i].ToString());
            ddlSchMajor4.Items.AddRange(ali);
            ddlSchMajor5.Items.AddRange(ali);
        }

        //tim khoa hoc
        void FindSession()
        {
            objCommand.CommandText = "SELECT MAX(MaTS) FROM TuyenSinh";
            lblCourseStudy.Text = objCommand.ExecuteScalar().ToString();
            //lblCourseStudy.Text = "03";
            objCommand.CommandText = "SELECT NamThi FROM TuyenSinh WHERE MaTS = '" + lblCourseStudy.Text + "'";
            lblYearStudy.Text = objCommand.ExecuteScalar().ToString();

            objCommand.CommandText = "SELECT NganhTuyenSinh FROM TuyenSinh WHERE MaTS = '" + lblCourseStudy.Text + "'";
            lblMajorStudy.Text = objCommand.ExecuteScalar().ToString();


            objCommand.CommandText = "SELECT CH_NCS FROM TuyenSinh WHERE MaTS = '" + lblCourseStudy.Text + "'";
            string iLimit = objCommand.ExecuteScalar().ToString();
            switch (iLimit)
            {
                case "NULL": rdlRegMajor.Items[0].Enabled = true; rdlRegMajor.Items[1].Enabled = true;
                    rdlRegMajor.Items[0].Selected = true; break;
                case "True": rdlRegMajor.Items[0].Enabled = true; rdlRegMajor.Items[1].Enabled = false;
                    rdlRegMajor.Items[0].Selected = true; break;
                case "False": rdlRegMajor.Items[0].Enabled = false; rdlRegMajor.Items[1].Enabled = true;
                    rdlRegMajor.Items[1].Selected = true; break;
            }
            /*    int iLimit = 0;
                objCommand.CommandText = "SELECT ChiTieu FROM ChiTieuTuyenSinh WHERE MaTS = '" + lblCourseStudy.Text + "'";
                iLimit = int.Parse(objCommand.ExecuteScalar().ToString());
                if (iLimit == 0)
                {
                    rdlRegMajor.Items[0].Enabled = false;
                    rdlRegMajor.Items[1].Selected = true;
                }

                objCommand.CommandText = "SELECT ChiTieuNCS FROM ChiTieuTuyenSinh WHERE KhoaHoc = '" + lblCourseStudy.Text + "'";
                iLimit = int.Parse(objCommand.ExecuteScalar().ToString());
                if (iLimit == 0)
                {
                    rdlRegMajor.Items[1].Enabled = false;
                    rdlRegMajor.Items[0].Selected = true;
                }*/
        }

        //tao doi tuong tu CSDL
        void BindingObject(ref ArrayList al, string strTable, int iColumn)
        {
            bool bOpen = false;
            if (cnn.State != ConnectionState.Open)
            {
                cnn.Open();
                bOpen = true;
            }
            try
            {
                objCommand.CommandText = "SELECT * FROM " + strTable;
                drdSQL = objCommand.ExecuteReader();

                al = new ArrayList();
                while (drdSQL.Read())
                {
                    al.Add(drdSQL.GetValue(iColumn));
                }
            }
            finally
            {
                drdSQL.Close();
            }
            if (bOpen)
                cnn.Close();
        }

        //tao ngay thang
        void SetComboDate(DropDownList cmbDay, DropDownList cmbMonth)
        {
            for (int i = 1; i < 32; i++)
            {
                cmbDay.Items.Add(i.ToString());
            }
            //khoi tao thang
            for (int i = 1; i < 13; i++)
            {
                cmbMonth.Items.Add(i.ToString());
            }
        }

        //rang buoc du lieu
        void BindingDataSQL(string strTable, int iColumn, DropDownList cmb)
        {
            try
            {
                objCommand.CommandText = "SELECT * FROM " + strTable;
                drdSQL = objCommand.ExecuteReader();
                Object obj;
                while (drdSQL.Read())
                {
                    obj = drdSQL.GetValue(iColumn);
                    if (cmb.Items.Count > 1 && obj.Equals(cmb.Items[cmb.Items.Count - 1]))
                        continue;
                    cmb.Items.Add(obj.ToString());
                }
            }
            finally
            {
                drdSQL.Close();
            }
            cmb.SelectedIndex = 0;
        }

        //su kien
        void InitEvent()
        {
            btnTestPInfo.Click += new EventHandler(btn_Click);
            btnTestArchive.Click += new EventHandler(btn_Click);
            btnTestHisSchl.Click += new EventHandler(btn_Click);
            btnRegister.Click += new EventHandler(btn_Click);
            btnCaptchaReload.Click += new ImageClickEventHandler(btnCaptchaReload_Click);
        }

        #endregion

        #region Cac ham kiem tra hop le

        //kiem tra tran du lieu
        bool CheckFullDB()
        {
            try
            {
                objCommand.CommandText = "SELECT Count(MaHS) FROM HoSo WHERE MaHS LIKE '" + lblCourseStudy.Text + ddlGroupExam.SelectedValue + "%'";
                int iNumProfile = int.Parse(objCommand.ExecuteScalar().ToString());
                if (iNumProfile > 9900)
                    return true;
            }
            catch
            {
                return true;
            }
            return false;
        }

        //Kiem tra textbox
        bool CheckTextError(advTextbox atb)
        {
            if (atb.Text != "")
            {
                atb.BackColor = Color.White;
                return false;
            }

            Label lbl = (Label)atb.Tag;
            if (lbl.Text == "")
                lbl.Text = strEmptyError + atb.strErr;
            else
                lbl.Text += ", " + atb.strErr;

            atb.BackColor = Color.Yellow;
            //atb.Focus();
            return true;
        }

        //kiem tra nhieu textbox
        bool CheckMultiError(advTextbox[] a_atb)
        {
            bool bErr = false;
            foreach (advTextbox atb in a_atb)
            {
                if (CheckTextError(atb))
                    bErr = true;
            }
            return bErr;
        }

        //kiem tra 1 nhom textbox
        bool CheckGroupText(advTextbox[] aatb, string strError)
        {
            foreach (advTextbox atb in aatb)
                if (atb.Text != "")
                {
                    return false;
                }
            Label lbl = (Label)aatb[0].Tag;
            if (lbl.Text == "")
                lbl.Text = strGroupError + strError;
            else
                lbl.Text += ", " + strError;

            //aatb[0].Focus();
            return true;
        }

        //kiem tra diem
        bool CheckMarkError(advTextbox atbMark)
        {
            float fMark = 0;

            try
            {
                fMark = float.Parse(atbMark.Text);
                if (fMark < 5)
                {
                    ((Label)atbMark.Tag).Text += "*" + atbMark.strErr + " : điểm phải lớn hơn hoặc bằng 5; ";
                    atbMark.BackColor = Color.Yellow;
                    return true;
                }
            }
            catch
            {
                ((Label)atbMark.Tag).Text += "*" + atbMark.strErr + " : điểm phải là số thực; ";
                atbMark.BackColor = Color.Yellow;
                return true;
            }
            atbMark.BackColor = Color.White;
            return false;
        }

        //kiem tra nam
        int CheckYear(advTextbox atbYear, advTextbox atbYLess)
        {
            int iYear;
            Label lbl = (Label)atbYear.Tag;

            if (atbYear.Text == "")
            {
                lbl.Text += "*" + atbYear.strErr + " : Bạn chưa ghi năm; ";
                atbYear.BackColor = Color.Yellow;
                return 0;
            }
            try
            {
                iYear = int.Parse(atbYear.Text);

                if (atbYLess != null && atbYLess.Text != "")
                {
                    try
                    {
                        int iYLess = int.Parse(atbYLess.Text);
                        if (iYLess >= iYear)
                        {
                            lbl.Text += "*" + atbYear.strErr + " : Năm của " + atbYear.strErr + " phải lớn hơn năm của " + atbYLess.strErr + "; ";
                            return 0;
                        }
                    }
                    catch
                    { }
                }

                if (iYear < 1957 || iYear > DateTime.Today.Year)
                {
                    lbl.Text += "*" + atbYear.strErr + " : Năm phải từ 1957 đến " + (DateTime.Today.Year).ToString() + "; ";
                    atbYear.BackColor = Color.Yellow;
                    return 0;
                }
            }
            catch
            {
                lbl.Text += "*" + atbYear.strErr + " : Năm phải là số nguyên; ";
                atbYear.BackColor = Color.Yellow;
                return 0;
            }
            atbYear.BackColor = Color.White;
            return iYear;
        }

        //kiem tra ngay thang
        bool CheckDateError(DropDownList ddlDay, DropDownList ddlMonth, advTextbox atbYear, advTextbox atbYLess, ref DateTime dtm)
        {
            int iYear;
            Label lbl = (Label)atbYear.Tag;

            iYear = CheckYear(atbYear, atbYLess);
            if (iYear == 0)
            {
                return true;
            }

            int iDay = ddlDay.SelectedIndex + 1;
            int iMonth = ddlMonth.SelectedIndex + 1;

            if (iMonth == 2)
            {
                if (((iYear % 100 != 0 && iYear % 4 == 0) || iYear % 400 == 0) && iDay > 29)
                {
                    lbl.Text += "*" + atbYear.strErr + " : Tháng 2 của năm " + iYear.ToString() + " không có ngày " + iDay.ToString() + "; ";
                    return true;
                }
                if ((iYear % 100 == 0 || iYear % 4 != 0) && iYear % 400 != 0 && iDay > 28)
                {
                    lbl.Text += "*" + atbYear.strErr + " : Tháng 2 của năm " + iYear.ToString() + " không có ngày " + iDay.ToString() + "; ";
                    return true;
                }
            }

            if (iDay == 31)
            {
                if (iMonth == 4 || iMonth == 6 || iMonth == 9 || iMonth == 11)
                {
                    lbl.Text += "*" + atbYear.strErr + " : Tháng " + iMonth.ToString() + " không có ngày " + iDay.ToString() + "; ";
                    return true;
                }
            }

            dtm = new DateTime(iYear, iMonth, iDay);
            return false;
        }

        //Kiem tra thong tin ca nhan
        bool CheckPriInfo()
        {
            bool bOK = true;
            lblError1.Text = "";
            lblError2.Text = "";
            lblError3.Text = "";
            lblError4.Text = "";
            lblError5.Text = "";

            if (CheckTextError(atbFirstName))
                bOK = false;
            if (CheckTextError(atbLastName))
                bOK = false;
            if (CheckTextError(atbPlaceBirth))
                bOK = false;
            /*if(CheckTextError(atbEthnic))
                bOK = false;
            if(CheckTextError(atbReligion))
                bOK = false;*/

            if (CheckDateError(ddlDayBirth, ddlMonthBirth, atbYearBirth, null, ref dtmBirth))
                bOK = false;

            advTextbox[] a_atb = new advTextbox[] { atbAddressHome, atbAddressCur };
            if (CheckGroupText(a_atb, "1 địa chỉ liên lạc (địa chỉ thường trú hoặc địa chỉ hiện nay)"))
                bOK = false;
            a_atb = new advTextbox[] { atbWorkPhone, atbHomePhone, atbCellPhone };
            if (CheckGroupText(a_atb, "1 số điện thoại (điện thoại cơ quan, điện thoại nhà riêng hoặc điện thoại di động)"))
                bOK = false;

            if (atbJobName.Text != "" || atbJobPlace.Text != "" || atbJobYear.Text != "")
            {
                if (CheckTextError(atbJobName))
                    bOK = false;
                if (CheckTextError(atbJobPlace))
                    bOK = false;
                iJobYear = CheckYear(atbJobYear, atbYearBirth);
                if (iJobYear == 0)
                    bOK = false;
            }

            if (atbPlaceUnion.Text != "" && CheckDateError(ddlDayUnion, ddlMonthUnion, atbYearUnion, atbYearBirth, ref dtmUnion))
                bOK = false;
            if (atbPlaceParty.Text != "" && CheckDateError(ddlDayParty, ddlMonthParty, atbYearParty, atbYearUnion, ref dtmParty))
                bOK = false;

            if (CheckTextError(atbContactPerson))
                bOK = false;
            if (CheckTextError(atbContactPhone))
                bOK = false;
            if (CheckTextError(atbContactAddress))
                bOK = false;
            if (CheckTextError(atbEmail))
                bOK = false;

            return bOK;
        }

        //kiem tra chung chi
        bool CheckCertificate()
        {
            bool bOK = true;
            bCertific = false;

            if (ddlCertificate.SelectedIndex > 0)
            {
                int iIndex = ddlCertificate.SelectedIndex - 1;

                if (aiValidLimit[iIndex] == -1)
                    return true;

                if (CheckDateError(ddlDayCer, ddlMonthCer, atbYearCer, atbYearBirth, ref dtmCer))
                    bOK = false;
                else
                {
                    if (DateTime.Now.Year - dtmCer.Year > aiValidLimit[iIndex])
                    {
                        bOK = false;
                        lblError7.Text += " -Chứng chỉ " + ddlCertificate.SelectedItem.ToString() + " của bạn đã quá hạn;";
                    }
                }

                try
                {
                    fCerMark = float.Parse(atbCerMark.Text);
                    if (fCerMark != 0 && rdlRegMajor.Items[0].Selected && fCerMark < afMarkMA[iIndex])
                    {
                        bOK = false;
                        ((Label)atbCerMark.Tag).Text += " -Bạn chưa đủ điểm miễn thi anh văn " + rdlRegMajor.Items[0].Text + ";";
                    }
                    if (fCerMark != 0 && rdlRegMajor.Items[1].Selected && fCerMark < afMarkRS[iIndex])
                    {
                        bOK = false;
                        ((Label)atbCerMark.Tag).Text += " -Bạn chưa đủ điểm miễn thi anh văn " + rdlRegMajor.Items[1].Text + ";";
                    }
                }
                catch
                {
                    ((Label)atbCerMark.Tag).Text += " -Điểm thi chứng chỉ phải là số nguyên;";
                    bOK = false;
                }
                bCertific = true;
            }
            return bOK;
        }

        //kiem tra bai bao
        bool CheckArticle()
        {
            bool bOK = true;
            adtmArt = new DateTime[5];

            if (advArtField1.Text != "" || advArtMag1.Text != "" || advArtName1.Text != "")
            {
                advTextbox[] a_atb = new advTextbox[] { advArtName1, advArtField1, advArtMag1 };
                if (CheckMultiError(a_atb))
                    bOK = false;
                if (CheckDateError(ddlDayArt1, ddlMonthArt1, atbYearArt1, atbYearBirth, ref adtmArt[0]))
                    bOK = false;
            }
            if (advArtField2.Text != "" || advArtMag2.Text != "" || advArtName2.Text != "")
            {
                advTextbox[] a_atb = new advTextbox[] { advArtName2, advArtField2, advArtMag2 };
                if (CheckMultiError(a_atb))
                    bOK = false;
                if (CheckDateError(ddlDayArt2, ddlMonthArt2, atbYearArt2, atbYearBirth, ref adtmArt[1]))
                    bOK = false;
            }
            if (advArtField3.Text != "" || advArtMag3.Text != "" || advArtName3.Text != "")
            {
                advTextbox[] a_atb = new advTextbox[] { advArtName3, advArtField3, advArtMag3 };
                if (CheckMultiError(a_atb))
                    bOK = false;
                if (CheckDateError(ddlDayArt3, ddlMonthArt3, atbYearArt3, atbYearBirth, ref adtmArt[2]))
                    bOK = false;
            }
            if (advArtField4.Text != "" || advArtMag4.Text != "" || advArtName4.Text != "")
            {
                advTextbox[] a_atb = new advTextbox[] { advArtName4, advArtField4, advArtMag4 };
                if (CheckMultiError(a_atb))
                    bOK = false;
                if (CheckDateError(ddlDayArt4, ddlMonthArt4, atbYearArt4, atbYearBirth, ref adtmArt[3]))
                    bOK = false;
            }
            if (advArtField5.Text != "" || advArtMag5.Text != "" || advArtName5.Text != "")
            {
                advTextbox[] a_atb = new advTextbox[] { advArtName5, advArtField5, advArtMag5 };
                if (CheckMultiError(a_atb))
                    bOK = false;
                if (CheckDateError(ddlDayArt5, ddlMonthArt5, atbYearArt5, atbYearBirth, ref adtmArt[4]))
                    bOK = false;
            }
            return bOK;
        }

        //kiem tra cong trinh
        bool CheckResearchWork()
        {
            bool bOK = true;
            adtmRes = new DateTime[4];

            if (advResField1.Text != "" || advResGuide1.Text != "" || advResName1.Text != "")
            {
                advTextbox[] a_atb = new advTextbox[] { advResName1, advResField1, advResGuide1 };
                if (CheckMultiError(a_atb))
                    bOK = false;
                //if (CheckDateError(ddlDayRes1, ddlMonthRes1, atbYearRes1, atbYearBirth, ref adtmRes[0]))
                //    bOK = false;
            }
            if (advResField2.Text != "" || advResGuide2.Text != "" || advResName2.Text != "" || advResPlace2.Text != "")
            {
                advTextbox[] a_atb = new advTextbox[] { advResName2, advResField2, advResPlace2, advResGuide2 };
                if (CheckMultiError(a_atb))
                    bOK = false;
                if (CheckDateError(ddlDayRes2, ddlMonthRes2, atbYearRes2, atbYearBirth, ref adtmRes[1]))
                    bOK = false;
            }
            if (advResField3.Text != "" || advResGuide3.Text != "" || advResName3.Text != "" || advResPlace3.Text != "")
            {
                advTextbox[] a_atb = new advTextbox[] { advResName3, advResField3, advResPlace3, advResGuide3 };
                if (CheckMultiError(a_atb))
                    bOK = false;
                if (CheckDateError(ddlDayRes3, ddlMonthRes3, atbYearRes3, atbYearBirth, ref adtmRes[2]))
                    bOK = false;
            }
            if (advResField4.Text != "" || advResGuide4.Text != "" || advResName4.Text != "" || advResPlace4.Text != "")
            {
                advTextbox[] a_atb = new advTextbox[] { advResName4, advResField4, advResPlace4, advResGuide4 };
                if (CheckMultiError(a_atb))
                    bOK = false;
                if (CheckDateError(ddlDayRes4, ddlMonthRes4, atbYearRes4, atbYearBirth, ref adtmRes[3]))
                    bOK = false;
            }
            return bOK;
        }

        //kiem tra thanh tich
        bool CheckArchive()
        {
            bool bOK = true;

            if (!CheckCertificate())
                bOK = false;
            if (!CheckArticle())
                bOK = false;
            if (!CheckResearchWork())
                bOK = false;

            return bOK;
        }

        //kiem tra qua trinh
        bool CheckHistory()
        {
            bool bOK = true;

            if (advHisArchi1.Text != "" || advHisDate1.Text != "" || advHisPlace1.Text != "" || advHisWork1.Text != "")
            {
                advTextbox[] a_atb = new advTextbox[] { advHisDate1, advHisWork1, advHisPlace1, advHisArchi1 };
                if (CheckMultiError(a_atb))
                    bOK = false;
            }
            if (advHisArchi2.Text != "" || advHisDate2.Text != "" || advHisPlace2.Text != "" || advHisWork2.Text != "")
            {
                advTextbox[] a_atb = new advTextbox[] { advHisDate2, advHisWork2, advHisPlace2, advHisArchi2 };
                if (CheckMultiError(a_atb))
                    bOK = false;
            }
            if (advHisArchi3.Text != "" || advHisDate3.Text != "" || advHisPlace3.Text != "" || advHisWork3.Text != "")
            {
                advTextbox[] a_atb = new advTextbox[] { advHisDate3, advHisWork3, advHisPlace3, advHisArchi3 };
                if (CheckMultiError(a_atb))
                    bOK = false;
            }
            if (advHisArchi4.Text != "" || advHisDate4.Text != "" || advHisPlace4.Text != "" || advHisWork4.Text != "")
            {
                advTextbox[] a_atb = new advTextbox[] { advHisDate4, advHisWork4, advHisPlace4, advHisArchi4 };
                if (CheckMultiError(a_atb))
                    bOK = false;
            }
            if (advHisArchi5.Text != "" || advHisDate5.Text != "" || advHisPlace5.Text != "" || advHisWork5.Text != "")
            {
                advTextbox[] a_atb = new advTextbox[] { advHisDate5, advHisWork5, advHisPlace5, advHisArchi5 };
                if (CheckMultiError(a_atb))
                    bOK = false;
            }
            if (bOK)
            {
                if (advHisWork1.Text == "" && advHisWork2.Text == "" && advHisWork3.Text == "" && advHisWork4.Text == "" && advHisWork5.Text == "")
                {
                    bOK = false;
                    lblError12.Text += " *Bạn chưa ghi đầy đủ thông tin quá trình học tập, làm việc";
                }
            }
            return bOK;
        }

        //kiem tra dh, ch
        bool CheckSchool()
        {
            bool bOK = true;

            if (advSchName1.Text != "" || advSchYearBegin1.Text != "" || advSchYearEnd1.Text != "" || advSchMark1.Text != "")
            {
                if (CheckTextError(advSchName1))
                    bOK = false;
                if (CheckMarkError(advSchMark1))
                    bOK = false;
                if (CheckYear(advSchYearBegin1, atbYearBirth) == 0)
                    bOK = false;
                if (CheckYear(advSchYearEnd1, advSchYearBegin1) == 0)
                    bOK = false;
            }
            if (advSchName2.Text != "" || advSchYearBegin2.Text != "" || advSchYearEnd2.Text != "" || advSchMark2.Text != "")
            {
                if (CheckTextError(advSchName2))
                    bOK = false;
                if (CheckMarkError(advSchMark2))
                    bOK = false;
                if (CheckYear(advSchYearBegin2, atbYearBirth) == 0)
                    bOK = false;
                if (CheckYear(advSchYearEnd2, advSchYearBegin2) == 0)
                    bOK = false;
            }
            if (advSchName3.Text != "" || advSchYearBegin3.Text != "" || advSchYearEnd3.Text != "" || advSchMark3.Text != "")
            {
                if (CheckTextError(advSchName3))
                    bOK = false;
                if (CheckMarkError(advSchMark3))
                    bOK = false;
                if (CheckYear(advSchYearBegin3, atbYearBirth) == 0)
                    bOK = false;
                if (CheckYear(advSchYearEnd3, advSchYearBegin3) == 0)
                    bOK = false;
            }
            iATCount++;
            if (advSchName4.Text != "" || advSchYearBegin4.Text != "" || advSchYearEnd4.Text != "" || advSchMark4.Text != "")
            {
                if (CheckTextError(advSchName4))
                    bOK = false;
                if (CheckMarkError(advSchMark4))
                    bOK = false;
                if (CheckYear(advSchYearBegin4, atbYearBirth) == 0)
                    bOK = false;
                if (CheckYear(advSchYearEnd4, advSchYearBegin4) == 0)
                    bOK = false;
            }
            if (advSchName5.Text != "" || advSchYearBegin5.Text != "" || advSchYearEnd5.Text != "" || advSchMark5.Text != "")
            {
                if (CheckTextError(advSchName5))
                    bOK = false;
                if (CheckMarkError(advSchMark5))
                    bOK = false;
                if (CheckYear(advSchYearBegin5, atbYearBirth) == 0)
                    bOK = false;
                if (CheckYear(advSchYearEnd5, advSchYearBegin5) == 0)
                    bOK = false;
            }

            if (bOK)
            {
                if (advSchName1.Text == "" && advSchName2.Text == "" && advSchName3.Text == "")
                {
                    bOK = false;
                    lblError14.Text += " *Bạn chưa ghi thông tin đại học";
                }
                if (rdlRegMajor.Items[1].Selected && advSchName4.Text == "" && advSchName5.Text == "")
                {
                    bOK = false;
                    lblError15.Text += " *Bạn chưa ghi thông tin cao học";
                }
            }
            return bOK;
        }

        bool CheckHisSch()
        {
            bool bOK = true;
            if (!CheckHistory())
                bOK = false;
            if (!CheckSchool())
                bOK = false;
            return bOK;
        }

        //kiem tra thi cao hoc
        bool CheckMA()
        {
            bool bOK = true;
            int iCount = 0;

            if (advSchName1.Text != "" && (ddlSchRank1.SelectedIndex != 3 || ddlSchRank1.SelectedIndex != 4))
                iCount++;
            if (advSchName2.Text != "" && (ddlSchRank2.SelectedIndex != 3 || ddlSchRank2.SelectedIndex != 4))
                iCount++;
            if (advSchName3.Text != "" && (ddlSchRank3.SelectedIndex != 3 || ddlSchRank3.SelectedIndex != 4))
                iCount++;
            if (advSchName4.Text != "" && (ddlSchRank4.SelectedIndex != 3 || ddlSchRank4.SelectedIndex != 4))
                iCount++;
            if (advSchName5.Text != "" && (ddlSchRank5.SelectedIndex != 3 || ddlSchRank5.SelectedIndex != 4))
                iCount++;

            if (iCount == 0)
            {
                if (CheckTextError(atbJobName) || CheckTextError(atbJobPlace) || CheckTextError(atbJobYear))
                {
                    bOK = false;
                    lblError3.Text = " -Nếu chưa đạt loại khá trở lên ở đại học thì bạn phải có ít nhất 2 năm kinh nghiệm làm việc mới được thi cao học";
                }
                else
                {
                    iJobYear = CheckYear(atbJobYear, atbYearBirth);
                    if (iJobYear == 0)
                        bOK = false;
                    else
                        if (DateTime.Now.Year - iJobYear < 2)
                        {
                            bOK = false;
                            lblError3.Text = " -Nếu chưa đạt loại khá trở lên ở đại học thì bạn phải có ít nhất 2 năm kinh nghiệm làm việc mới được thi cao học";
                        }
                }
            }
            return bOK;
        }

        //kiem tra thi ncs
        bool CheckRS()
        {
            int iCount;
            bool bOK = true;

            if (advArtName1.Text == "" && advArtName2.Text == "" && advArtName3.Text == "")
            {
                bOK = false;
                lblError9.Text += " -Bạn phải có ít nhất 1 bài báo mới được thi nghiên cứu sinh";
            }

            if (advResName1.Text == "" && advResName2.Text == "" && advResName3.Text == "")
            {
                bOK = false;
                lblError11.Text += " -Bạn phải có ít nhất 1 công trình nghiên cứu ở dạng đề cương mới được thi nghiên cứu sinh";
            }
            else
            {
                iCount = 0;
                if (advResName1.Text != "" && cbResDraft1.Checked)
                    iCount++;
                /*if (advResName2.Text != "" && cbResDraft2.Checked)
                    iCount++;
                if (advResName3.Text != "" && cbResDraft3.Checked)
                    iCount++;*/
                if (iCount == 0)
                {
                    bOK = false;
                    lblError11.Text += " -Bạn phải có ít nhất 1 công trình nghiên cứu ở dạng đề cương mới được thi nghiên cứu sinh";
                }
            }

            iCount = 0;
            if (advSchName1.Text != "" && ddlSchRank1.SelectedIndex == 0)
                iCount++;
            if (advSchName2.Text != "" && ddlSchRank2.SelectedIndex == 0)
                iCount++;
            if (advSchName3.Text != "" && ddlSchRank3.SelectedIndex == 0)
                iCount++;
            if (advSchName4.Text != "" && ddlSchRank4.SelectedIndex == 0)
                iCount++;
            if (advSchName5.Text != "" && ddlSchRank5.SelectedIndex == 0)
                iCount++;

            if (iCount == 0)
            {
                if (CheckTextError(atbJobName) || CheckTextError(atbJobPlace) || CheckTextError(atbJobYear))
                {
                    bOK = false;
                    lblError3.Text += " -Nếu chưa từng đạt loại xuất sắc thì bạn phải có ít nhất 2 năm kinh nghiệm làm việc mới được thi nghiên cứu sinh";
                }
                else
                {
                    iJobYear = CheckYear(atbJobYear, atbYearBirth);
                    if (iJobYear == 0)
                        bOK = false;
                    else
                        if (DateTime.Now.Year - iJobYear < 2)
                        {
                            bOK = false;
                            lblError3.Text += " -Nếu chưa từng đạt loại xuất sắc thì bạn phải có ít nhất 2 năm kinh nghiệm làm việc mới được thi nghiên cứu sinh";
                        }
                }
            }

            if (advSchName4.Text == "" && advSchName5.Text == "")
            {
                bOK = false;
                lblError15.Text += " -Bạn phải có bằng cao học mới được thi nghiên cứu sinh";
            }

            return bOK;
        }

        bool CheckAll()
        {
            bool bOK = true;
            if (!CheckPriInfo())
                bOK = false;
            if (!CheckArchive())
                bOK = false;
            if (!CheckHisSch())
                bOK = false;

            if (bOK)
            {
                if (rdlRegMajor.Items[0].Selected)
                {
                    if (!CheckMA())
                        bOK = false;
                }
                else
                {
                    if (!CheckRS())
                        bOK = false;
                }
            }

            if (!CheckCaptchaInput())
            {
                bOK = false;
                lblError16.Text = "Các ký tự xác thực bạn nhập không khớp với ảnh";
            }
            if (!bOK)
                CaptchaInit();

            return bOK;
        }

        #endregion

        #region sinh du lieu

        //sinh mahs
        bool GenerateProfileCode()
        {
            int iNumHS;
            string strPrefix = "";
            strProfileCode = null;


            strPrefix = lblCourseStudy.Text;
            //xac dinh cum thi       
            strPrefix += ddlGroupExam.SelectedValue;


            try
            {
                objCommand.CommandText = "SELECT MaHS FROM HoSo WHERE MaHS LIKE '" + strPrefix + "%'";
                drdSQL = objCommand.ExecuteReader();

                iNumHS = 1;
                strProfileCode = new string('0', 4 - iNumHS.ToString().Length);
                strProfileCode = strPrefix + strProfileCode + iNumHS.ToString();

                while (drdSQL.Read())
                {
                    if (strProfileCode == drdSQL[0].ToString())
                    {
                        iNumHS++;
                        strProfileCode = new string('0', 4 - iNumHS.ToString().Length);
                        strProfileCode = strPrefix + strProfileCode + iNumHS.ToString();
                    }
                    else
                    {
                        break;
                    }
                }
                drdSQL.Close();
            }
            catch
            {
                drdSQL.Close();
                return false;
            }
            return true;
        }

        //kiem tra ccbt
        bool GetSupplement()
        {
            if (advSchName4.Text != "" || advSchName5.Text != "" || (advSchName1.Text != "" && !abSupCer[ddlSchMajor1.SelectedIndex]) ||
                (advSchName2.Text != "" && !abSupCer[ddlSchMajor2.SelectedIndex]) || (advSchName3.Text != "" && !abSupCer[ddlSchMajor3.SelectedIndex]))
                return false;
            return true;
        }

        //lay bai bao
        void GetArticle()
        {
            cArticle cArt;
            alArticle = new ArrayList();

            if (advArtName1.Text != "")
            {
                cArt = new cArticle(advArtName1.Text, advArtField1.Text, advArtMag1.Text, adtmArt[0]);
                alArticle.Add(cArt);
            }
            if (advArtName2.Text != "")
            {
                cArt = new cArticle(advArtName2.Text, advArtField2.Text, advArtMag2.Text, adtmArt[1]);
                alArticle.Add(cArt);
            }
            if (advArtName3.Text != "")
            {
                cArt = new cArticle(advArtName3.Text, advArtField3.Text, advArtMag3.Text, adtmArt[2]);
                alArticle.Add(cArt);
            }
            if (advArtName4.Text != "")
            {
                cArt = new cArticle(advArtName4.Text, advArtField4.Text, advArtMag4.Text, adtmArt[3]);
                alArticle.Add(cArt);
            }
            if (advArtName5.Text != "")
            {
                cArt = new cArticle(advArtName5.Text, advArtField5.Text, advArtMag5.Text, adtmArt[4]);
                alArticle.Add(cArt);
            }
            int iLimit;
            try
            {
                objCommand.CommandText = "SELECT Max(MaBB) FROM BaiBao ";
                iLimit = int.Parse(objCommand.ExecuteScalar().ToString()) + 1;
            }
            catch
            {
                iLimit = 1;
            }
            for (int i = 0; i < alArticle.Count; i++)
            {
                ((cArticle)alArticle[i]).strCode = int.Parse((i + iLimit).ToString());
            }
        }
        //lay cong trinh nghien cuu
        void GetResearch()
        {
            cResearchWork cRes;
            alResearch = new ArrayList();

            if (advResName1.Text != "")
            {
                cRes = new cResearchWork(advResName1.Text, advResField1.Text, ddlResRole1.SelectedValue,
                    SqlString.Null, advResGuide1.Text, SqlDateTime.Null, cbResDraft1.Checked);
                alResearch.Add(cRes);
            }
            if (advResName2.Text != "")
            {
                cRes = new cResearchWork(advResName2.Text, advResField2.Text, ddlResRole2.SelectedValue,
                    advResPlace2.Text, advResGuide2.Text, adtmRes[1], false);
                alResearch.Add(cRes);
            }
            if (advResName3.Text != "")
            {
                cRes = new cResearchWork(advResName3.Text, advResField3.Text, ddlResRole3.SelectedValue,
                    advResPlace3.Text, advResGuide3.Text, adtmRes[2], false);
                alResearch.Add(cRes);
            }
            if (advResName4.Text != "")
            {
                cRes = new cResearchWork(advResName4.Text, advResField4.Text, ddlResRole4.SelectedValue,
                    advResPlace4.Text, advResGuide4.Text, adtmRes[3], false);
                alResearch.Add(cRes);
            }
            int iLimit;
            try
            {
                objCommand.CommandText = "SELECT Max(MaCT) FROM CTNC ";
                iLimit = int.Parse(objCommand.ExecuteScalar().ToString()) + 1;
            }
            catch
            {
                iLimit = 1;
            }
            for (int i = 0; i < alResearch.Count; i++)
            {
                ((cResearchWork)alResearch[i]).strCode = int.Parse((i + iLimit).ToString());
            }
        }

        //lay qua trinh hoc tap
        void GetHistory()
        {
            cHistory cHis;
            alHistory = new ArrayList();

            if (advHisWork1.Text != "")
            {
                cHis = new cHistory(advHisDate1.Text, advHisWork1.Text, advHisPlace1.Text, advHisArchi1.Text);
                alHistory.Add(cHis);
            }
            if (advHisWork2.Text != "")
            {
                cHis = new cHistory(advHisDate2.Text, advHisWork2.Text, advHisPlace2.Text, advHisArchi2.Text);
                alHistory.Add(cHis);
            }
            if (advHisWork3.Text != "")
            {
                cHis = new cHistory(advHisDate3.Text, advHisWork3.Text, advHisPlace3.Text, advHisArchi3.Text);
                alHistory.Add(cHis);
            }
            if (advHisWork4.Text != "")
            {
                cHis = new cHistory(advHisDate4.Text, advHisWork4.Text, advHisPlace4.Text, advHisArchi4.Text);
                alHistory.Add(cHis);
            }
            if (advHisWork5.Text != "")
            {
                cHis = new cHistory(advHisDate5.Text, advHisWork5.Text, advHisPlace5.Text, advHisArchi5.Text);
                alHistory.Add(cHis);
            }
            int iLimit;
            try
            {
                objCommand.CommandText = "SELECT Max(STT) FROM HTLV ";
                iLimit = int.Parse(objCommand.ExecuteScalar().ToString()) + 1;
            }
            catch
            {
                iLimit = 1;
            }
            for (int i = 0; i < alHistory.Count; i++)
            {
                ((cHistory)alHistory[i]).strCode = int.Parse((i + iLimit).ToString());
            }
        }

        //lay dh_ch
        void GetSchool()
        {
            cSchool cSch;
            alSchool = new ArrayList();
            int iLimit;
            try
            {
                objCommand.CommandText = "SELECT Max(MaDH_CH) FROM DH_CH ";
                iLimit = int.Parse(objCommand.ExecuteScalar().ToString());
            }
            catch
            {
                iLimit = 0;
            }
            if (advSchName1.Text != "")
            {
                iLimit++;
                cSch = new cSchool(iLimit, advSchName1.Text, true, ddlSchMajor1.Text, ddlSchMethod1.Text, ddlSchRank1.Text,
                    float.Parse(advSchMark1.Text), int.Parse(advSchYearBegin1.Text), int.Parse(advSchYearEnd1.Text));
                alSchool.Add(cSch);
            }
            if (advSchName2.Text != "")
            {
                iLimit++;
                cSch = new cSchool(iLimit, advSchName2.Text, true, ddlSchMajor2.Text, ddlSchMethod2.Text, ddlSchRank2.Text,
                    float.Parse(advSchMark2.Text), int.Parse(advSchYearBegin2.Text), int.Parse(advSchYearEnd2.Text));
                alSchool.Add(cSch);
            }
            if (advSchName3.Text != "")
            {
                iLimit++;
                cSch = new cSchool(iLimit, advSchName3.Text, true, ddlSchMajor3.Text, ddlSchMethod3.Text, ddlSchRank3.Text,
                    float.Parse(advSchMark3.Text), int.Parse(advSchYearBegin3.Text), int.Parse(advSchYearEnd3.Text));
                alSchool.Add(cSch);
            }
            if (advSchName4.Text != "")
            {
                iLimit++;
                cSch = new cSchool(iLimit, advSchName4.Text, false, ddlSchMajor4.Text, ddlSchMethod4.Text, ddlSchRank4.Text,
                    float.Parse(advSchMark4.Text), int.Parse(advSchYearBegin4.Text), int.Parse(advSchYearEnd4.Text));
                alSchool.Add(cSch);
            }
            if (advSchName5.Text != "")
            {
                iLimit++;
                cSch = new cSchool(iLimit, advSchName5.Text, false, ddlSchMajor5.Text, ddlSchMethod5.Text, ddlSchRank5.Text,
                    float.Parse(advSchMark5.Text), int.Parse(advSchYearBegin5.Text), int.Parse(advSchYearEnd5.Text));
                alSchool.Add(cSch);
            }

            /*          for (int i = 0; i < alSchool.Count; i++)
                      {
                          ((cSchool)alSchool[i]).strCode = ((cSchool)alSchool[i]).strCode.Insert(3, (i + 1).ToString());
                      }*/
        }

        //ma mon thi
        bool ExamSubjectCode()
        {
            if (rdlRegMajor.Items[1].Selected)
            {
                if (ddlCertificate.SelectedIndex > 0)
                {
                    astrExSubCode = new string[1];
                    astrExSubCode[0] = "Mon04";
                    return true;
                }
                astrExSubCode = new string[2];
                astrExSubCode[0] = "Mon01";
                astrExSubCode[1] = "Mon04";
                return true;
            }

            string strCode;
            try
            {
                ArrayList al = new ArrayList();
                if (!bCertific)
                    al.Add("Mon01");
                objCommand.CommandText = "SELECT Mon1 FROM TuyenSinh WHERE (MaTS = '" + lblCourseStudy.Text + "')";
                strCode = objCommand.ExecuteScalar().ToString();
                if (strCode != "Mon01")
                    al.Add(strCode);

                objCommand.CommandText = "SELECT Mon2 FROM TuyenSinh WHERE (MaTS = '" + lblCourseStudy.Text + "')";
                strCode = objCommand.ExecuteScalar().ToString();
                if (strCode != "Mon01")
                    al.Add(strCode);

                /*          objCommand.CommandText = "SELECT Mon3 FROM ChiTieuTuyenSinh WHERE (KhoaHoc = '" + lblCourseStudy.Text + "')";
                          strCode = objCommand.ExecuteScalar().ToString();
                          if (strCode != "Mon01" || (strCode == "Mon01" && !bCertific))
                              al.Add(strCode);*/

                astrExSubCode = new string[al.Count];
                for (int i = 0; i < astrExSubCode.Length; i++)
                    astrExSubCode[i] = al[i].ToString();
            }
            catch
            {
                return false;
            }
            return true;
        }

        bool GenerateData()
        {
            if (!GenerateProfileCode())
                return false;
            if (!ExamSubjectCode())
                return false;
            GetArticle();
            GetResearch();
            GetHistory();
            GetSchool();
            return true;
        }

        #endregion

        #region Dua vao CSDL

        //Ghi vao bang ho so
        bool FillProfile()
        {
            try
            {
                objCommand.CommandText = "INSERT INTO HoSo VALUES (@MaHS, @NgayNop,@MaTS, @CH, @LePhi, @HopLe, @SBD, @MaPT, @Dau)";

                objCommand.Parameters.Clear();
                objCommand.Parameters.Add("@MaHS", SqlDbType.Char).Value = strProfileCode;
                objCommand.Parameters.Add("@NgayNop", SqlDbType.SmallDateTime).Value = DateTime.Today;
                objCommand.Parameters.Add("@MaTS", SqlDbType.Char).Value = lblCourseStudy.Text;
                objCommand.Parameters.Add("@CH", SqlDbType.Bit).Value = bool.Parse(rdlRegMajor.SelectedValue.ToString());
                objCommand.Parameters.Add("@LePhi", SqlDbType.Bit).Value = false;
                objCommand.Parameters.Add("@HopLe", SqlDbType.Bit).Value = false;
                objCommand.Parameters.Add("@SBD", SqlDbType.Char).Value = SqlChars.Null;
                objCommand.Parameters.Add("@MaPT", SqlDbType.Char).Value = SqlChars.Null;
                objCommand.Parameters.Add("@Dau", SqlDbType.Bit).Value = false;
                //cap nhat
                objCommand.ExecuteNonQuery();
            }
            catch
            {
                return false;
            }
            return true;
        }

        //bang ly lich ngoai ngu
        bool FillForegnLang()
        {
            if (ddlCertificate.SelectedIndex == 0)
                return true;

            try
            {
                objCommand.CommandText = "INSERT INTO LLNN Values (@MaNN, @MaHS, @NgayCap, @Diem)";

                objCommand.Parameters.Clear();
                objCommand.Parameters.Add("@MaNN", SqlDbType.Char).Value = ddlCertificate.SelectedValue;
                objCommand.Parameters.Add("@MaHS", SqlDbType.Char).Value = strProfileCode;
                if (dtmCer != DateTime.MinValue)
                    objCommand.Parameters.Add("@NgayCap", SqlDbType.SmallDateTime).Value = dtmCer;
                else
                    objCommand.Parameters.Add("@NgayCap", SqlDbType.SmallDateTime).Value = SqlDateTime.Null;

                objCommand.Parameters.Add("@Diem", SqlDbType.Float).Value = fCerMark;
                //cap nhat
                objCommand.ExecuteNonQuery();
            }
            catch
            {
                return false;
            }
            return true;
        }

        //bang so yeu ly lich
        bool FillResume()
        {
            try
            {
                objCommand.CommandText = "INSERT INTO SYLL Values (@MaHS, @Ho, @Ten, @GioiTinh, @NgaySinh, @NoiSinh, " +
                                        "@DanToc, @TonGiao, @NgheNghiep, @NoiLamViec, @NamCongTac, @ChinhSach, " +
                                        "@DCThuongTru, @DCHienNay, @NgayVaoDoan, @NoiVaoDoan, @NgayVaoDang, @NoiVaoDang, " +
                                        "@DTCoQuan, @DTNhaRieng, @DTDiDong, @Email, @NguoiLienLac, @DC_NLL, @DT_NLL)";

                objCommand.Parameters.Clear();
                objCommand.Parameters.Add("@MaHS", SqlDbType.Char).Value = strProfileCode;
                objCommand.Parameters.Add("@Ho", SqlDbType.NVarChar).Value = atbFirstName.Text;
                objCommand.Parameters.Add("@Ten", SqlDbType.NVarChar).Value = atbLastName.Text;
                objCommand.Parameters.Add("@GioiTinh", SqlDbType.Bit).Value = bool.Parse(grdGender.SelectedValue);
                objCommand.Parameters.Add("@NgaySinh", SqlDbType.SmallDateTime).Value = dtmBirth;
                objCommand.Parameters.Add("@NoiSinh", SqlDbType.NVarChar).Value = atbPlaceBirth.Text;

                if (atbEthnic.Text != "")
                    objCommand.Parameters.Add("@DanToc", SqlDbType.NVarChar).Value = atbEthnic.Text;
                else
                    objCommand.Parameters.Add("@DanToc", SqlDbType.NVarChar).Value = SqlString.Null;
                if (atbReligion.Text != "")
                    objCommand.Parameters.Add("@TonGiao", SqlDbType.NVarChar).Value = atbReligion.Text;
                else
                    objCommand.Parameters.Add("@TonGiao", SqlDbType.NVarChar).Value = SqlString.Null;
                if (atbJobName.Text != "")
                {
                    objCommand.Parameters.Add("@NgheNghiep", SqlDbType.NVarChar).Value = atbJobName.Text;
                    objCommand.Parameters.Add("@NoiLamViec", SqlDbType.NVarChar).Value = atbJobPlace.Text;
                    objCommand.Parameters.Add("@NamCongTac", SqlDbType.Int).Value = iJobYear;
                }
                else
                {
                    objCommand.Parameters.Add("@NgheNghiep", SqlDbType.NVarChar).Value = SqlString.Null;
                    objCommand.Parameters.Add("@NoiLamViec", SqlDbType.NVarChar).Value = SqlString.Null;
                    objCommand.Parameters.Add("@NamCongTac", SqlDbType.Int).Value = SqlInt32.Null;
                }

                if (ddlPriority.SelectedIndex > 0)
                {
                    objCommand.Parameters.Add("@ChinhSach", SqlDbType.Char).Value = ddlPriority.SelectedValue;
                }
                else
                    objCommand.Parameters.Add("@ChinhSach", SqlDbType.Char).Value = SqlChars.Null;

                if (atbAddressHome.Text != "")
                    objCommand.Parameters.Add("@DCThuongTru", SqlDbType.NVarChar).Value = atbAddressHome.Text;
                else
                    objCommand.Parameters.Add("@DCThuongTru", SqlDbType.NVarChar).Value = SqlString.Null;

                if (atbAddressCur.Text != "")
                    objCommand.Parameters.Add("@DCHienNay", SqlDbType.NVarChar).Value = atbAddressCur.Text;
                else
                    objCommand.Parameters.Add("@DCHienNay", SqlDbType.NVarChar).Value = SqlString.Null;

                if (atbPlaceUnion.Text != "")
                {
                    objCommand.Parameters.Add("@NgayVaoDoan", SqlDbType.SmallDateTime).Value = dtmUnion;
                    objCommand.Parameters.Add("@NoiVaoDoan", SqlDbType.NVarChar).Value = atbPlaceUnion.Text;
                }
                else
                {
                    objCommand.Parameters.Add("@NgayVaoDoan", SqlDbType.SmallDateTime).Value = SqlDateTime.Null;
                    objCommand.Parameters.Add("@NoiVaoDoan", SqlDbType.NVarChar).Value = SqlString.Null;
                }
                if (atbPlaceParty.Text != "")
                {
                    objCommand.Parameters.Add("NgayVaoDang", SqlDbType.SmallDateTime).Value = dtmParty;
                    objCommand.Parameters.Add("NoiVaoDang", SqlDbType.NVarChar).Value = atbPlaceParty.Text;
                }
                else
                {
                    objCommand.Parameters.Add("@NgayVaoDang", SqlDbType.SmallDateTime).Value = SqlDateTime.Null;
                    objCommand.Parameters.Add("@NoiVaoDang", SqlDbType.NVarChar).Value = SqlString.Null;
                }
                if (atbWorkPhone.Text != "")
                    objCommand.Parameters.Add("@DTCoQuan", SqlDbType.VarChar).Value = atbWorkPhone.Text;
                else
                    objCommand.Parameters.Add("@DTCoQuan", SqlDbType.VarChar).Value = SqlString.Null;

                if (atbHomePhone.Text != "")
                    objCommand.Parameters.Add("@DTNhaRieng", SqlDbType.VarChar).Value = atbHomePhone.Text;
                else
                    objCommand.Parameters.Add("@DTNhaRieng", SqlDbType.VarChar).Value = SqlString.Null;

                if (atbCellPhone.Text != "")
                    objCommand.Parameters.Add("@DTDiDong", SqlDbType.VarChar).Value = atbCellPhone.Text;
                else
                    objCommand.Parameters.Add("@DTDiDong", SqlDbType.VarChar).Value = SqlString.Null;

                if (atbEmail.Text != "")
                    objCommand.Parameters.Add("@Email", SqlDbType.VarChar).Value = atbEmail.Text;
                else
                    objCommand.Parameters.Add("@Email", SqlDbType.VarChar).Value = SqlString.Null;

                objCommand.Parameters.Add("@NguoiLienLac", SqlDbType.NVarChar).Value = atbContactPerson.Text;
                objCommand.Parameters.Add("@DC_NLL", SqlDbType.NVarChar).Value = atbContactAddress.Text;
                objCommand.Parameters.Add("@DT_NLL", SqlDbType.VarChar).Value = atbContactPhone.Text;
                //cap nhat
                objCommand.ExecuteNonQuery();
            }
            catch
            {
                return false;
            }
            return true;
        }

        //bang hoso, giayto
        bool CheckFillPapers()
        {
            try
            {
                objCommand.CommandText = "select*from giayto";
                drdSQL = objCommand.ExecuteReader();
                ArrayList ch = new ArrayList();
                ArrayList ncs = new ArrayList();
                while (drdSQL.Read())
                {
                    if (drdSQL[2].ToString() == "True")
                    {
                        ch.Add(drdSQL[0].ToString());
                    }
                    if (drdSQL[3].ToString() == "True")
                    {
                        ncs.Add(drdSQL[0].ToString());
                    }
                }
                drdSQL.Close();

                objCommand.CommandText = "INSERT INTO HS_GT Values (@MaHS, @MaGiayTo, @HopLe)";

                objCommand.Parameters.Clear();
                objCommand.Parameters.Add("@MaHS", SqlDbType.Char);
                objCommand.Parameters.Add("@MaGiayTo", SqlDbType.Char);
                objCommand.Parameters.Add("@HopLe", SqlDbType.Bit);

                //don du tuyen                
                objCommand.Parameters["@MaHS"].Value = strProfileCode;
                objCommand.Parameters["@MaGiayTo"].Value = "GT01";
                objCommand.Parameters["@HopLe"].Value = false;
                objCommand.ExecuteNonQuery();

                //so yeu ly lich                
                objCommand.Parameters["@MaHS"].Value = strProfileCode;
                objCommand.Parameters["@MaGiayTo"].Value = "GT02";
                objCommand.Parameters["@HopLe"].Value = false;
                objCommand.ExecuteNonQuery();

                //bang tot nghiep                
                objCommand.Parameters["@MaHS"].Value = strProfileCode;
                objCommand.Parameters["@MaGiayTo"].Value = "GT03";
                objCommand.Parameters["@HopLe"].Value = false;
                objCommand.ExecuteNonQuery();

                //phieu suc khoe                
                objCommand.Parameters["@MaHS"].Value = strProfileCode;
                objCommand.Parameters["@MaGiayTo"].Value = "GT09";
                objCommand.Parameters["@HopLe"].Value = false;
                objCommand.ExecuteNonQuery();

                //anh                
                objCommand.Parameters["@MaHS"].Value = strProfileCode;
                objCommand.Parameters["@MaGiayTo"].Value = "GT11";
                objCommand.Parameters["@HopLe"].Value = false;
                objCommand.ExecuteNonQuery();

                //phong bi
                objCommand.Parameters["@MaHS"].Value = strProfileCode;
                objCommand.Parameters["@MaGiayTo"].Value = "GT12";
                objCommand.Parameters["@HopLe"].Value = false;
                objCommand.ExecuteNonQuery();

                //cong van
                if (cbOffical.Checked)
                {
                    objCommand.Parameters["@MaHS"].Value = strProfileCode;
                    objCommand.Parameters["@MaGiayTo"].Value = "GT05";
                    objCommand.Parameters["@HopLe"].Value = false;
                    objCommand.ExecuteNonQuery();
                }
                //quyet dinh
                if (atbJobName.Text != "")
                {
                    objCommand.Parameters["@MaHS"].Value = strProfileCode;
                    objCommand.Parameters["@MaGiayTo"].Value = "GT06";
                    objCommand.Parameters["@HopLe"].Value = false;
                    objCommand.ExecuteNonQuery();
                }
                //chinh sach
                if (ddlPriority.SelectedIndex != 0)
                {
                    objCommand.Parameters["@MaHS"].Value = strProfileCode;
                    objCommand.Parameters["@MaGiayTo"].Value = "GT10";
                    objCommand.Parameters["@HopLe"].Value = false;
                    objCommand.ExecuteNonQuery();
                }
                //giay mien thi av
                if (ddlCertificate.SelectedIndex != 0)
                {
                    objCommand.Parameters["@MaHS"].Value = strProfileCode;
                    objCommand.Parameters["@MaGiayTo"].Value = "GT08";
                    objCommand.Parameters["@HopLe"].Value = false;
                    objCommand.ExecuteNonQuery();
                }

                if (rdlRegMajor.Items[1].Selected)
                {
                    //thu gioi thieu
                    objCommand.Parameters["@MaHS"].Value = strProfileCode;
                    objCommand.Parameters["@MaGiayTo"].Value = "GT19";
                    objCommand.Parameters["@HopLe"].Value = false;
                    objCommand.ExecuteNonQuery();
                    //ban sao tot nghiep CH
                    objCommand.Parameters["@MaHS"].Value = strProfileCode;
                    objCommand.Parameters["@MaGiayTo"].Value = "GT13";
                    objCommand.Parameters["@HopLe"].Value = false;
                    objCommand.ExecuteNonQuery();
                    //ban sao bang diem CH
                    objCommand.Parameters["@MaHS"].Value = strProfileCode;
                    objCommand.Parameters["@MaGiayTo"].Value = "GT14";
                    objCommand.Parameters["@HopLe"].Value = false;
                    objCommand.ExecuteNonQuery();
                    if (advResName1.Text != "")
                    {
                        //ban sao de cuong
                        objCommand.Parameters["@MaHS"].Value = strProfileCode;
                        objCommand.Parameters["@MaGiayTo"].Value = "GT15";
                        objCommand.Parameters["@HopLe"].Value = false;
                        objCommand.ExecuteNonQuery();
                    }
                    if (advResName2.Text != "" || advResName3.Text != "" || advResName4.Text != "")
                    {
                        //ban sao CT         
                        objCommand.Parameters["@MaHS"].Value = strProfileCode;
                        objCommand.Parameters["@MaGiayTo"].Value = "GT17";
                        objCommand.Parameters["@HopLe"].Value = false;
                        objCommand.ExecuteNonQuery();
                    }
                    //giay dong y
                    objCommand.Parameters["@MaHS"].Value = strProfileCode;
                    objCommand.Parameters["@MaGiayTo"].Value = "GT16";
                    objCommand.Parameters["@HopLe"].Value = false;
                    objCommand.ExecuteNonQuery();
                    //ban sao BB         
                    objCommand.Parameters["@MaHS"].Value = strProfileCode;
                    objCommand.Parameters["@MaGiayTo"].Value = "GT18";
                    objCommand.Parameters["@HopLe"].Value = false;
                    objCommand.ExecuteNonQuery();
                }
                else
                {
                    //bang diem                
                    objCommand.Parameters["@MaHS"].Value = strProfileCode;
                    objCommand.Parameters["@MaGiayTo"].Value = "GT04";
                    objCommand.Parameters["@HopLe"].Value = false;
                    objCommand.ExecuteNonQuery();
                }

                //bo tuc kien thuc
                if (GetSupplement())
                {
                    objCommand.Parameters["@MaHS"].Value = strProfileCode;
                    objCommand.Parameters["@MaGiayTo"].Value = "GT07";
                    objCommand.Parameters["@HopLe"].Value = false;
                    objCommand.ExecuteNonQuery();
                }
            }
            catch
            {
                return false;
            }
            return true;
        }

        //bang bai bao
        bool FillArticle()
        {
            if (alArticle.Count == 0)
                return true;

            try
            {
                objCommand.CommandText = "INSERT INTO BaiBao Values (@MaBB, @MaHS, @TenBB, @LinhVuc, @TapChiDang, @NgayDang)";

                objCommand.Parameters.Clear();
                objCommand.Parameters.Add("@MaBB", SqlDbType.Int);
                objCommand.Parameters.Add("@MaHS", SqlDbType.Char);
                objCommand.Parameters.Add("@TenBB", SqlDbType.NVarChar);
                objCommand.Parameters.Add("@LinhVuc", SqlDbType.NVarChar);
                objCommand.Parameters.Add("@TapChiDang", SqlDbType.NVarChar);
                objCommand.Parameters.Add("@NgayDang", SqlDbType.SmallDateTime);

                for (int i = 0; i < alArticle.Count; i++)
                {
                    objCommand.Parameters["@MaBB"].Value = ((cArticle)alArticle[i]).strCode;
                    objCommand.Parameters["@MaHS"].Value = strProfileCode;
                    objCommand.Parameters["@TenBB"].Value = ((cArticle)alArticle[i]).strName;
                    objCommand.Parameters["@LinhVuc"].Value = ((cArticle)alArticle[i]).strField;
                    objCommand.Parameters["@TapChiDang"].Value = ((cArticle)alArticle[i]).strMagazine;
                    objCommand.Parameters["@NgayDang"].Value = ((cArticle)alArticle[i]).dtmDate;
                    //cap nhat
                    objCommand.ExecuteNonQuery();
                }
            }
            catch
            {
                return false;
            }
            return true;
        }

        //bang cong trinh nghien cuu
        bool FillResearchWork()
        {
            if (alResearch.Count < 1)
                return true;

            try
            {
                objCommand.CommandText = "INSERT INTO CTNC Values (@MaCT, @MaHS, @TenCT, @LinhVuc, @VaiTro, @NoiCongBo, @NgayCongBo, @GVHuongDan, @DeCuong)";

                objCommand.Parameters.Clear();
                objCommand.Parameters.Add("@MaCT", SqlDbType.Int);
                objCommand.Parameters.Add("@MaHS", SqlDbType.Char);
                objCommand.Parameters.Add("@TenCT", SqlDbType.NVarChar);
                objCommand.Parameters.Add("@LinhVuc", SqlDbType.NVarChar);
                objCommand.Parameters.Add("@VaiTro", SqlDbType.NVarChar);
                objCommand.Parameters.Add("@NoiCongBo", SqlDbType.NVarChar);
                objCommand.Parameters.Add("@NgayCongBo", SqlDbType.SmallDateTime);
                objCommand.Parameters.Add("@GVHuongDan", SqlDbType.NVarChar);
                objCommand.Parameters.Add("@DeCuong", SqlDbType.Bit);

                for (int i = 0; i < alResearch.Count; i++)
                {
                    objCommand.Parameters["@MaCT"].Value = ((cResearchWork)alResearch[i]).strCode;
                    objCommand.Parameters["@MaHS"].Value = strProfileCode;
                    objCommand.Parameters["@TenCT"].Value = ((cResearchWork)alResearch[i]).strName;
                    objCommand.Parameters["@LinhVuc"].Value = ((cResearchWork)alResearch[i]).strField;
                    objCommand.Parameters["@VaiTro"].Value = ((cResearchWork)alResearch[i]).strRole;
                    objCommand.Parameters["@NoiCongBo"].Value = ((cResearchWork)alResearch[i]).strPlace;
                    objCommand.Parameters["@NgayCongBo"].Value = ((cResearchWork)alResearch[i]).dtmDate;
                    objCommand.Parameters["@GVHuongDan"].Value = ((cResearchWork)alResearch[i]).strGuider;
                    objCommand.Parameters["@DeCuong"].Value = ((cResearchWork)alResearch[i]).bDraft;
                    //cap nhat
                    objCommand.ExecuteNonQuery();
                }
            }
            catch
            {
                return false;
            }
            return true;
        }

        //bang qt hoc tap
        bool FillStudyProcess()
        {
            if (alHistory.Count < 1)
                return true;

            try
            {
                /*int iRCount=1;
                try
                {
                    objCommand.CommandText = "SELECT Max(STT) FROM HTLV";
                    iRCount = (int)objCommand.ExecuteScalar() + 1;
                }
                catch
                {
                    iRCount = 1;
                }
                */

                objCommand.CommandText = "INSERT INTO HTLV Values (@STT, @MaHS, @NgayThangNam, @Hoc_LamViec, @NoiChon, @ThanhTich)";

                objCommand.Parameters.Clear();
                objCommand.Parameters.Add("@STT", SqlDbType.Int);
                objCommand.Parameters.Add("@MaHS", SqlDbType.Char);
                objCommand.Parameters.Add("@NgayThangNam", SqlDbType.VarChar);
                objCommand.Parameters.Add("@Hoc_LamViec", SqlDbType.NVarChar);
                objCommand.Parameters.Add("@NoiChon", SqlDbType.NVarChar);
                objCommand.Parameters.Add("@ThanhTich", SqlDbType.NVarChar);

                for (int i = 0; i < alHistory.Count; i++)
                {
                    objCommand.Parameters["@STT"].Value = i + ((cHistory)alHistory[i]).strCode;
                    objCommand.Parameters["@MaHS"].Value = strProfileCode;
                    objCommand.Parameters["@NgayThangNam"].Value = ((cHistory)alHistory[i]).strDate;
                    objCommand.Parameters["@Hoc_LamViec"].Value = ((cHistory)alHistory[i]).strWork;
                    objCommand.Parameters["@NoiChon"].Value = ((cHistory)alHistory[i]).strPlace;
                    objCommand.Parameters["@ThanhTich"].Value = ((cHistory)alHistory[i]).strAchievement;
                    //cap nhat
                    objCommand.ExecuteNonQuery();
                }
            }
            catch
            {
                return false;
            }
            return true;
        }

        //bang dh_ch
        bool FillSchools()
        {
            if (alSchool.Count < 1)
                return true;

            try
            {
                objCommand.CommandText = "INSERT INTO DH_CH Values (@MaDH_CH, @MaHS,@DH, @TenTruong, " +
                                        "@NganhHoc, @HeDaoTao, @DiemTB, @XepLoai, @NamBatDau, @NamTotNghiep, @CCBoTuc)";

                objCommand.Parameters.Clear();
                objCommand.Parameters.Add("@MaDH_CH", SqlDbType.Int);
                objCommand.Parameters.Add("@MaHS", SqlDbType.Char);
                objCommand.Parameters.Add("@DH", SqlDbType.Bit);
                objCommand.Parameters.Add("@TenTruong", SqlDbType.NVarChar);
                objCommand.Parameters.Add("@NganhHoc", SqlDbType.NVarChar);
                objCommand.Parameters.Add("@HeDaoTao", SqlDbType.NVarChar);
                objCommand.Parameters.Add("@DiemTB", SqlDbType.Float);
                objCommand.Parameters.Add("@XepLoai", SqlDbType.NVarChar);
                objCommand.Parameters.Add("@NamBatDau", SqlDbType.Int);
                objCommand.Parameters.Add("@NamTotNghiep", SqlDbType.Int);
                objCommand.Parameters.Add("@CCBoTuc", SqlDbType.NVarChar);

                for (int i = 0; i < alSchool.Count; i++)
                {
                    objCommand.Parameters["@MaDH_CH"].Value = ((cSchool)alSchool[i]).strCode;
                    objCommand.Parameters["@MaHS"].Value = strProfileCode;
                    objCommand.Parameters["@DH"].Value = ((cSchool)alSchool[i]).DH;
                    objCommand.Parameters["@TenTruong"].Value = ((cSchool)alSchool[i]).strName;
                    objCommand.Parameters["@NganhHoc"].Value = ((cSchool)alSchool[i]).strField;
                    objCommand.Parameters["@HeDaoTao"].Value = ((cSchool)alSchool[i]).strMethod;
                    objCommand.Parameters["@DiemTB"].Value = ((cSchool)alSchool[i]).fMark;
                    objCommand.Parameters["@XepLoai"].Value = ((cSchool)alSchool[i]).strRank;
                    objCommand.Parameters["@NamBatDau"].Value = ((cSchool)alSchool[i]).iYearBegin;
                    objCommand.Parameters["@NamTotNghiep"].Value = ((cSchool)alSchool[i]).iYearEnd;
                    objCommand.Parameters["@CCBoTuc"].Value = SqlChars.Null;

                    //cap nhat
                    objCommand.ExecuteNonQuery();
                }
            }
            catch
            {
                return false;
            }
            return true;
        }

        //bang danhsachthi
        bool FillExamList()
        {
            try
            {
                objCommand.CommandText = "INSERT INTO DanhSachThi Values (@MaHS, @MaMT, @Vang, @KyLuat,@MaPhach,@TuiBai,@Diem)";

                objCommand.Parameters.Clear();
                objCommand.Parameters.Add("@MaHS", SqlDbType.Char);
                objCommand.Parameters.Add("@MaMT", SqlDbType.VarChar);
                objCommand.Parameters.Add("@Vang", SqlDbType.Bit);
                objCommand.Parameters.Add("@KyLuat", SqlDbType.NVarChar);
                objCommand.Parameters.Add("@MaPhach", SqlDbType.Char);
                objCommand.Parameters.Add("@TuiBai", SqlDbType.Char);
                objCommand.Parameters.Add("@Diem", SqlDbType.Float);

                for (int i = 0; i < astrExSubCode.Length; i++)
                {
                    objCommand.Parameters["@MaHS"].Value = strProfileCode;
                    objCommand.Parameters["@MaMT"].Value = astrExSubCode[i];
                    objCommand.Parameters["@Vang"].Value = false;
                    objCommand.Parameters["@KyLuat"].Value = SqlString.Null;
                    objCommand.Parameters["@MaPhach"].Value = SqlString.Null;
                    objCommand.Parameters["@TuiBai"].Value = SqlString.Null;
                    objCommand.Parameters["@Diem"].Value = SqlDouble.Null;
                    //cap nhat
                    objCommand.ExecuteNonQuery();
                }
            }
            catch
            {
                return false;
            }
            return true;
        }

        //bang BangDiem
        /*bool FillMarkRecord()
        {
            try
            {
                objCommand.CommandText = "INSERT INTO BangDiem Values (@MaHS, @MaMT, @Diem)";

                objCommand.Parameters.Clear();
                objCommand.Parameters.Add("@MaHS", SqlDbType.Char).Value = strProfileCode;
                objCommand.Parameters.Add("@MaMT", SqlDbType.VarChar).Value = "Mon01";
                objCommand.Parameters.Add("@Diem", SqlDbType.Float).Value = -1;
            }
            catch
            {
                return false;
            }
            return true;
        }*/

        bool FillAll()
        {
            if (!FillProfile())
                return false;
            if (!FillForegnLang())
                return false;
            if (!FillResume())
                return false;
            if (!CheckFillPapers())
                return false;
            if (!FillArticle())
                return false;
            if (!FillResearchWork())
                return false;
            if (!FillStudyProcess())
                return false;
            if (!FillSchools())
                return false;
            if (!FillExamList())
                return false;
            /*      if (ddlCertificate.SelectedIndex > 0)
                      if (!FillMarkRecord())
                          return false;*/
            return true;
        }

        #endregion

        //xoa rac
        void CleanProfile()
        {
            try
            {
                objCommand.CommandText = "DELETE FROM BaiBao WHERE MaHS = '" + strProfileCode.ToString() + "'";
                objCommand.ExecuteNonQuery();
                objCommand.CommandText = "DELETE FROM CTNC WHERE MaHS = '" + strProfileCode.ToString() + "'";
                objCommand.ExecuteNonQuery();
                objCommand.CommandText = "DELETE FROM DH_CH WHERE MaHS = '" + strProfileCode.ToString() + "'";
                objCommand.ExecuteNonQuery();
                objCommand.CommandText = "DELETE FROM DanhSachThi WHERE MaHS = '" + strProfileCode.ToString() + "'";
                objCommand.ExecuteNonQuery();
                objCommand.CommandText = "DELETE FROM HS_GT WHERE MaHS = '" + strProfileCode.ToString() + "'";
                objCommand.ExecuteNonQuery();
                objCommand.CommandText = "DELETE FROM LLNN WHERE MaHS = '" + strProfileCode.ToString() + "'";
                objCommand.ExecuteNonQuery();
                objCommand.CommandText = "DELETE FROM HTLV WHERE MaHS = '" + strProfileCode.ToString() + "'";
                objCommand.ExecuteNonQuery();
                objCommand.CommandText = "DELETE FROM SYLL WHERE MaHS = '" + strProfileCode.ToString() + "'";
                objCommand.ExecuteNonQuery();
                objCommand.CommandText = "DELETE FROM HoSo WHERE MaHS = '" + strProfileCode.ToString() + "'";
                objCommand.ExecuteNonQuery();
            }
            catch
            {
            }
        }

        //dang ky
        void SubmitRegister()
        {
            if (!CheckAll())
            {
                lblError0.Text = "Bạn chưa thể đăng ký vì thông tin chưa hợp lệ. Xem chi tiết thông báo ở từng phần";
                cnn.Close();
                return;
            }

            cnn.Open();

            if (CheckFullDB())
            {
                lblError0.ForeColor = Color.Red;
                lblError0.Text = "Số lượng hồ sơ đăng ký vào cụm thi " + ddlGroupExam.SelectedItem.ToString() +
                    " đã quá tải, bạn có thể liên hệ với phòng đào tạo sau đại học trường đại học Công nghệ thông tin để được giải quyết hoặc quay lại sau";
                cnn.Close();
                return;
            }

            if (!GenerateData())
            {
                lblError0.Text = "Không thể đăng ký vì chưa thể sinh dữ liệu";
                cnn.Close();
                return;
            }
            if (!FillAll())
            {
                lblError0.Text = "Chưa thể kết nối với CSDL";
                cnn.Close();
                return;
            }

            cnn.Close();

            ClearChildViewState();
            ClearChildControlState();
            ClearChildState();
            Request.Cookies.Clear();
            ViewState.Clear();
            Session.Clear();

            Session["ProfileCode"] = strProfileCode;
            Session["StudentName"] = atbFirstName.Text + " " + atbLastName.Text;
            Response.Redirect("Thanks.aspx");
        }

        void btn_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            switch (btn.ID)
            {
                //nut kiem tra
                case "btnTestPInfo":
                    if (CheckPriInfo())
                    {
                        lblError1.ForeColor = Color.Green;
                        lblError1.Text = strValid;
                        lblError3.ForeColor = Color.Green;
                        lblError3.Text = strValid;
                    }
                    btnTestPInfo.Focus();
                    break;

                case "btnTestArchive":
                    if (CheckArchive())
                    {
                        lblError6.ForeColor = Color.Green;
                        lblError6.Text = strValid;
                        lblError8.ForeColor = Color.Green;
                        lblError8.Text = strValid;
                        lblError10.ForeColor = Color.Green;
                        lblError10.Text = strValid;
                    }
                    btnTestArchive.Focus();
                    break;

                case "btnTestHisSchl":
                    if (CheckHisSch())
                    {
                        lblError12.ForeColor = Color.Green;
                        lblError12.Text = strValid;
                        lblError13.ForeColor = Color.Green;
                        lblError13.Text = strValid;
                    }
                    btnTestHisSchl.Focus();
                    break;

                case "btnRegister":
                    SubmitRegister();
                    break;
            }
        }

        void btnCaptchaReload_Click(object sender, EventArgs e)
        {
            CaptchaInit();
            if (iATCount == 64)
            {
                Captcha1.ImageUrl = "~/tssdh/Register_Resources/images 71.JPG";
                Captcha2.ImageUrl = "~/tssdh/Register_Resources/images 64.JPG";
            }
            btnCaptchaReload.Focus();
        }

        void CaptchaInit()
        {
            Random ran;
            int i = 1;
            ran = new Random();
            i = ran.Next(1, 30);
            //if (ViewState["CaptchaIm1"] == null)
            //{
            Captcha1.ImageUrl =  "~/tssdh/Register_Resources/images " + i.ToString() + ".jpg";
            CapIm1 = "images " + i.ToString();
            //}
            //else
            //{
            //    Captcha1.ImageUrl = "~/" + ViewState["CaptchaIm1"] + ".jpg";
            //    CapIm1 = ViewState["CaptchaIm1"].ToString();
            //}

            //if (ViewState["CaptchaIm2"] == null)
            //{
            i = ran.Next(i, i + 29) - (i - 1);

            Captcha2.ImageUrl = "~/tssdh/Register_Resources/images " + (((i + i % 10) % 30) + 1).ToString() + ".jpg";
            CapIm2 = "images " + (((i + i % 10) % 30) + 1).ToString();
            //}
            //else
            //{
            //    Captcha2.ImageUrl = "~/" + ViewState["CaptchaIm2"] + ".jpg";
            //    CapIm2 = ViewState["CaptchaIm2"].ToString();
            //}
        }

        private bool CheckCaptchaInput()
        {

            /*if (ViewState["CaptchaIm1"] != null)
                CapIm1 = ViewState["CaptchaIm1"].ToString();
            if (ViewState["CaptchaIm2"] != null)
                CapIm2 = ViewState["CaptchaIm2"].ToString();*/

            string Captcha = GetCaptcha(CapIm1) + " " + GetCaptcha(CapIm2);
            if (atbCaptcha.Text == Captcha)
                return true;
            else
                return false;
        }

        private string GetCaptcha(string CaptImageName)
        {
            switch (CaptImageName)
            {
                case "images 1":
                    return "cvdmk";
                case "images 2":
                    return "7gfmc";
                case "images 3":
                    return "z963zv";
                case "images 4":
                    return "51qgsv";
                case "images 5":
                    return "p64vz2";
                case "images 6":
                    return "9hqwvs";
                case "images 7":
                    return "rr92zg";
                case "images 8":
                    return "zxyt4";
                case "images 9":
                    return "3pvvhf";
                case "images 10":
                    return "xtmyb";
                case "images 11":
                    return "y5d77";
                case "images 12":
                    return "j4zrdm";
                case "images 13":
                    return "bfzcdr";
                case "images 14":
                    return "cwyyh";
                case "images 15":
                    return "j87y28";
                case "images 16":
                    return "4vkf7z";
                case "images 17":
                    return "t8hrhg";
                case "images 18":
                    return "3hftf";
                case "images 19":
                    return "x4487";
                case "images 20":
                    return "vs5m5z";
                case "images 21":
                    return "d37b5";
                case "images 22":
                    return "w54bpn";
                case "images 23":
                    return "7swnk";
                case "images 24":
                    return "t3nkr";
                case "images 25":
                    return "jcn5m3";
                case "images 26":
                    return "mpqss";
                case "images 27":
                    return "mpqss";
                case "images 28":
                    return "kfygy";
                case "images 29":
                    return "68b273";
                case "images 30":
                    return "fpy3wy";
                default:
                    return "";

            }
        }
    }
}