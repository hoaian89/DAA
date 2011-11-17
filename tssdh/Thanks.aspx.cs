using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Xml.Linq;

using System.Collections.Generic;


using iTextSharp.text.pdf;
using iTextSharp.text;


using System.Web.Mail;

using System.Net;
using System.Net.Mail;

using Ionic.Zip;
namespace webRegister
{
    public partial class Thanks : System.Web.UI.Page
    {
        SqlConnection cnn;
        string strProfile
        {
            get
            {
                if (ViewState["ProCode"] != null)
                    return ViewState["ProCode"].ToString();
                return null;
            }
            set
            {
                ViewState["ProCode"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            /*if (!IsPostBack)
            {
                Session["ProfileCode"] = "S9001";
                Session["StudentName"] = "abc";
            }*/

            if ((strProfile != null) || (Session["ProfileCode"] != null && Session["StudentName"] != null))
            {
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
                string c = ConfigurationManager.ConnectionStrings["SiteSqlServer"].ConnectionString;
                cnn = new SqlConnection(c);
                //cnn = new SqlConnection();
            //    cnn.ConnectionString = @"server = .\sqlexpress ;integrated security = true ;database = QLTSSDHv2";
               //cnn.ConnectionString = @"Data Source =.\sqlexpress;Initial Catalog=QLTSSDHv2;User Id=qlts;Password=npk@IT#2010";

                if (!IsPostBack)
                {
                    strProfile = Session["ProfileCode"].ToString();
                    lblProfile.Text = strProfile;
                    lblProfileDel.Text = strProfile;
                    lblName.Text = Session["StudentName"].ToString();
                    lblDateBegin.Text = DateTime.Today.Day.ToString() + "/" + DateTime.Today.Month.ToString() + "/" + DateTime.Today.Year.ToString();
                    ///
                    string text = "select b.TG_KetThuc from  hoso a,tuyensinh b where a.mahs='" + strProfile + "' and a.mats=b.mats";
                    if (cnn.State == ConnectionState.Closed) cnn.Open();
                    SqlCommand cmd = new SqlCommand(text, cnn);
                    DateTime dtmEnd = DateTime.Parse(cmd.ExecuteScalar().ToString());
                    cnn.Close();
                    ///
                    //DateTime dtmEnd = DateTime.Today.AddDays(7);
                    lblDateEnd.Text = dtmEnd.Day.ToString() + "/" + dtmEnd.Month.ToString() + "/" + dtmEnd.Year.ToString();
                    lblMoney.Text = MoneyByDoc(strProfile).ToString() + "000 đồng";

                    Session.Clear();
                }
            }
            else
            {
                Response.Redirect("Register.aspx");
                return;
            }
            InitEvent();

            PDFdataSet = new DataSet();
        }

        void InitEvent()
        {
            btnDownload.Click += new EventHandler(btnDownload_Click);
        }

        void btnDownload_Click(object sender, EventArgs e)
        {
            // Export to PDF
            ExportPDF(strProfile);

            Session.Clear();
            Application.Clear();
            Request.Cookies.Clear();
        }

        private SqlDataAdapter PDFdataAdapter;
        private DataSet PDFdataSet;

        protected string GetDataFromFilesID(string FileID)
        {
            string error = "";
            if (cnn.State == ConnectionState.Closed)
                cnn.Open();

            string connectString;
            try
            {
                // Đưa bảng SYLL vào dataset với tên SoYeuLyLich
                if (PDFdataSet.Tables["SoYeuLyLich"] != null)
                {
                    PDFdataSet.Tables.Remove("SoYeuLyLich");
                }
                connectString = "SELECT * FROM SYLL WHERE MaHS like '" + FileID + "'";
                PDFdataAdapter = new SqlDataAdapter(connectString, cnn);
                PDFdataAdapter.Fill(PDFdataSet, "SoYeuLyLich");

                // Đưa bảng HoSo vào dataset với tên HoSo
                if (PDFdataSet.Tables["HoSo"] != null)
                {
                    PDFdataSet.Tables.Remove("HoSo");
                }
                connectString = "SELECT * FROM HoSo WHERE MaHS like '" + FileID + "'";
                PDFdataAdapter = new SqlDataAdapter(connectString, cnn);
                PDFdataAdapter.Fill(PDFdataSet, "HoSo");
                // Đưa thông tin chính sách ưu tiên vào dataset với bảng tên ChinhSachUuTien
                if (PDFdataSet.Tables["ChinhSachUuTien"] != null)
                {
                    PDFdataSet.Tables.Remove("ChinhSachUuTien");
                }
                connectString = "SELECT B.TenUT FROM SYLL A, UuTien B WHERE (A.MaHS like '" + FileID + "')" + " and (A.ChinhSach like B.MaUT)";
                PDFdataAdapter = new SqlDataAdapter(connectString, cnn);
                PDFdataAdapter.Fill(PDFdataSet, "ChinhSachUuTien");
                // Đưa bảng DH_CH vào dataset với tên DaiHoc_CaoHoc
                if (PDFdataSet.Tables["DaiHoc_CaoHoc"] != null)
                {
                    PDFdataSet.Tables.Remove("DaiHoc_CaoHoc");
                }
                connectString = "SELECT * FROM DH_CH WHERE MaHS like '" + FileID + "'";
                PDFdataAdapter = new SqlDataAdapter(connectString, cnn);
                PDFdataAdapter.Fill(PDFdataSet, "DaiHoc_CaoHoc");

                // Đưa các loại giấy tờ vào dataset với bảng tên GiayTo
                if (PDFdataSet.Tables["GiayTo"] != null)
                {
                    PDFdataSet.Tables.Remove("GiayTo");
                }
                connectString = "SELECT A.MaGT FROM GiayTo A, HS_GT B WHERE (B.MaHS like '" + FileID + "') and (A.MaGT like B.MaGT)";
                PDFdataAdapter = new SqlDataAdapter(connectString, cnn);
                PDFdataAdapter.Fill(PDFdataSet, "GiayTo");
                // Đưa các ngoại ngữ vào dataset với bảng tên NgoaiNgu
                if (PDFdataSet.Tables["NgoaiNgu"] != null)
                {
                    PDFdataSet.Tables.Remove("NgoaiNgu");
                }
                connectString = "SELECT A.TenNN, B.Diem, B.NgayCap FROM NgoaiNgu A, LLNN B WHERE (B.MaHS like '" + FileID + "') and (A.MaNN like B.MaNN)";
                PDFdataAdapter = new SqlDataAdapter(connectString, cnn);
                PDFdataAdapter.Fill(PDFdataSet, "NgoaiNgu");
                // Lưu thông tin năm thi của thí sinh vào dataset qua bảng NamThi
                if (PDFdataSet.Tables["NamThi"] != null)
                {
                    PDFdataSet.Tables.Remove("NamThi");
                }
                connectString = "SELECT A.NamThi FROM TuyenSinh A, HoSo B WHERE (B.MaHS like '" + FileID + "') and (A.MaTS like B.MaTS)";
                PDFdataAdapter = new SqlDataAdapter(connectString, cnn);
                PDFdataAdapter.Fill(PDFdataSet, "NamThi");
                // Lưu thông tin hết hạn hồ sơ của thí sinh vào dataset qua bảng HetHan
                if (PDFdataSet.Tables["HetHan"] != null)
                {
                    PDFdataSet.Tables.Remove("HetHan");
                }
                connectString = "SELECT A.TG_KetThuc FROM TuyenSinh A, HoSo B WHERE (B.MaHS like '" + FileID + "') and (A.MaTS like B.MaTS)";
                PDFdataAdapter = new SqlDataAdapter(connectString, cnn);
                PDFdataAdapter.Fill(PDFdataSet, "HetHan");

                // Đưa bảng DH_CH vào dataset với tên QTHocTapLamViec
                if (PDFdataSet.Tables["QTHocTapLamViec"] != null)
                {
                    PDFdataSet.Tables.Remove("QTHocTapLamViec");
                }
                connectString = "SELECT * FROM HTLV WHERE (MaHS like '" + FileID + "')";
                PDFdataAdapter = new SqlDataAdapter(connectString, cnn);
                PDFdataAdapter.Fill(PDFdataSet, "QTHocTapLamViec");
                // Đưa bảng BaiBao vào dataset với tên BaiBao
                if (PDFdataSet.Tables["BaiBao"] != null)
                {
                    PDFdataSet.Tables.Remove("BaiBao");
                }
                connectString = "SELECT * FROM BaiBao WHERE (MaHS like '" + FileID + "')";
                PDFdataAdapter = new SqlDataAdapter(connectString, cnn);
                PDFdataAdapter.Fill(PDFdataSet, "BaiBao");
                // Đưa bảng CTNC vào dataset với tên CongTrinhNghienCuu
                if (PDFdataSet.Tables["CongTrinhNghienCuu"] != null)
                {
                    PDFdataSet.Tables.Remove("CongTrinhNghienCuu");
                }
                connectString = "SELECT * FROM CTNC WHERE (MaHS like '" + FileID + "')";
                PDFdataAdapter = new SqlDataAdapter(connectString, cnn);
                PDFdataAdapter.Fill(PDFdataSet, "CongTrinhNghienCuu");
                // Đưa các lệ phí vào dataset với bảng tên LePhi
                if (PDFdataSet.Tables["LePhi"] != null)
                {
                    PDFdataSet.Tables.Remove("LePhi");
                }
                connectString = "SELECT B.CH";
                connectString += " ,MT1.MaMT as 'MaMonThi1',MT2.MaMT as 'MaMonThi2',MT3.MaMT as 'MaMonThi3',MT4.MaMT as 'MaMonThi4'";
                connectString += " ,MT1.TenMT as 'TenMonThi1',MT2.TenMT as 'TenMonThi2',MT3.TenMT as 'TenMonThi3',MT4.TenMT as 'TenMonThi4'";
                connectString += " ,LePhiCH as 'LePhiCH',LePhi1 as 'LePhi2',LePhi2 as 'LePhi3',LePhiAVCH as 'LePhi1'"; // Lệ phí CH
                connectString += " ,LePhiNCS, LePhiDCNCS, LePhiAVNCS"; // Lệ phí NCS
                connectString += " FROM TuyenSinh A,HoSo B,MonThi MT1, MonThi MT2, MonThi MT3, MonThi MT4";
                connectString += " WHERE (B.MaHS like '" + FileID + "') and (B.MaTS = A.MaTS)";
                connectString += " and (A.Mon1 =  MT2.MaMT)";
                connectString += " and (A.Mon2 =  MT3.MaMT)";
                connectString += " and (MT1.MaMT like 'Mon01')";
                connectString += " and (MT4.MaMT like 'Mon04')";
                //connectString += " and (A.Mon3 =  MT3.MaMT)";
                PDFdataAdapter = new SqlDataAdapter(connectString, cnn);
                PDFdataAdapter.Fill(PDFdataSet, "LePhi");

                cnn.Close();

                error = "Complete";

                if (PDFdataSet.Tables["SoYeuLyLich"].Rows.Count == 0)
                    error = " Có lỗi ở phần Sơ yếu lý lịch";

                if (PDFdataSet.Tables["HoSo"].Rows.Count == 0)
                    error = " Có lỗi ở phần Hồ sơ";

                if (PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows.Count == 0)
                    error = " Có lỗi ở phần Đại học - cao học";

                if (PDFdataSet.Tables["GiayTo"].Rows.Count == 0)
                    error = " Có lỗi ở phần Giấy tờ";

                if (PDFdataSet.Tables["NamThi"].Rows.Count == 0)
                    error = " Có lỗi ở phần Năm thi";


                return error;
            }
            catch
            {
                cnn.Close();
                error = "Kết nối đến Cơ sở dữ liệu gặp lỗi";
                return error;
            }
        }

        protected string ExportPDF(string FileID)
        {
            string result = GetDataFromFilesID(FileID);
            if (result != "Complete")
                return result;
            string[] FormFiles;
            string FormsFolder = "";
            string NewFileFolder = "";

            string[] CaoHoc = new string[1];
            string[] NCS = new string[1];
            result = GetFilesFill(HttpContext.Current.Server.MapPath("Register_Resources") + "\\Ho_So.txt", ref CaoHoc, ref NCS);
            if (result == "Complete")
            {

                if (PDFdataSet.Tables["HoSo"].Rows[0]["CH"].ToString().Trim() == "True")
                {
                    FormsFolder = HttpContext.Current.Server.MapPath("Register_Resources/Cao_Hoc");
                    NewFileFolder = HttpContext.Current.Server.MapPath("Register_TempFolder/Cao_Hoc");

                    FormFiles = new string[CaoHoc.Count()];
                    for (int i = 0; i < FormFiles.Count(); i++)
                    {
                        FormFiles[i] = CaoHoc[i];
                    }
                }
                else
                {
                    FormsFolder = HttpContext.Current.Server.MapPath("Register_Resources/Nghien_Cuu_Sinh");
                    NewFileFolder = HttpContext.Current.Server.MapPath("Register_TempFolder/Nghien_Cuu_Sinh");

                    FormFiles = new string[NCS.Count()];
                    for (int i = 0; i < FormFiles.Count(); i++)
                    {
                        FormFiles[i] = NCS[i];
                    }
                }
            }
            else
            {
                return result;
            }

            for (int i = 0; i < FormFiles.Count(); i++)
            {
                FillForm(FormsFolder + "\\" + FormFiles[i], NewFileFolder + "\\" + FileID + FormFiles[i], FormFiles[i]);
            }

            string[] attachments = new string[FormFiles.Count()];

            for (int i = 0; i < FormFiles.Count(); i++)
            {
                attachments[i] = NewFileFolder + "\\" + FileID + FormFiles[i];
            }
            // Compress file
            result = CompressFile(NewFileFolder + "\\" + FileID + "HoSo.zip", attachments);
            // Download file
            result = DownloadFile(NewFileFolder + "\\" + FileID + "HoSo.zip");

            return result;
        }

        protected string GetFilesFill(string filePath, ref string[] CaoHoc, ref string[] NCS)
        {

            string path = filePath;
            StreamReader reader = new StreamReader(path);
            ArrayList ArrCaoHoc = new ArrayList();
            ArrayList ArrNCS = new ArrayList();
            try
            {
                if (reader.Peek() != -1)
                {
                    string StringRead;
                    StringRead = reader.ReadLine();
                    while (StringRead == "")
                        StringRead = reader.ReadLine();
                    if (StringRead.Trim() == "Cao_Hoc")
                    {
                        StringRead = reader.ReadLine();
                        while (StringRead == "")
                            StringRead = reader.ReadLine();
                        while (StringRead.ToUpper() != "END")
                        {
                            ArrCaoHoc.Add(StringRead.Trim());

                            StringRead = reader.ReadLine();
                            while (StringRead == "")
                                StringRead = reader.ReadLine();
                        }
                    }
                    StringRead = reader.ReadLine();
                    while (StringRead == "")
                        StringRead = reader.ReadLine();
                    if (StringRead.Trim() == "Nghien_Cuu_Sinh")
                    {
                        StringRead = reader.ReadLine();
                        while (StringRead == "")
                            StringRead = reader.ReadLine();
                        while (StringRead.ToUpper() != "END")
                        {
                            ArrNCS.Add(StringRead.Trim());

                            StringRead = reader.ReadLine();
                            while (StringRead == "")
                                StringRead = reader.ReadLine();
                        }
                    }
                }

                CaoHoc = new string[ArrCaoHoc.Count];
                for (int i = 0; i < ArrCaoHoc.Count; i++)
                {
                    CaoHoc[i] = ArrCaoHoc[i].ToString().Trim();
                }

                NCS = new string[ArrNCS.Count];
                for (int i = 0; i < ArrNCS.Count; i++)
                {
                    NCS[i] = ArrNCS[i].ToString().Trim();
                }
                return "Complete";
            }
            catch (Exception e)
            {
                return e.Message;
            }

        }

        protected void SetAcroFields(AcroFields fields, string FileType)
        {
            if (FileType[0] == 'C')
            {
                SetAcroFieldsForMasterInfo(fields, FileType);
            }
            else
            {
                SetAcroFieldsForPhDInfo(fields, FileType);
            }
        }

        protected void SetAcroFieldsForMasterInfo(AcroFields fields, string FileType)
        {
            string MaHS = PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["MaHS"].ToString();
            DateTime DT = new DateTime();
            string NgoaiNgu = "";

            int DaiHocIndex = 1;
            int CaoHocIndex = 1;
            int CongTrinhNCIndex = 1;

            #region Mã hồ sơ
            fields.SetField("$MaHS", MaHS.Trim());
            fields.SetField("$MaHS01", MaHS[0].ToString() + MaHS[1].ToString());
            fields.SetField("$MaHS23", MaHS[2].ToString() + MaHS[3].ToString());
            fields.SetField("$MaHS4", MaHS[4].ToString());
            fields.SetField("$MaHS5", MaHS[5].ToString());
            fields.SetField("$MaHS6", MaHS[6].ToString());
            fields.SetField("$MaHS7", MaHS[7].ToString());
            #endregion
            #region Thông tin thí sinh
            fields.SetField("$NamThi", PDFdataSet.Tables["NamThi"].Rows[0][0].ToString().Trim());
            fields.SetField("$Ten", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["Ho"].ToString().Trim().ToUpper() + " " + PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["Ten"].ToString().Trim().ToUpper());
            fields.SetField("$NoiSinh", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NoiSinh"].ToString().Trim());
            fields.SetField("$NoiLamViec", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NoiLamViec"].ToString().Trim());
            fields.SetField("$NguoiLienLac", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NguoiLienLac"].ToString().Trim());
            fields.SetField("$DiaChiLienLac", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["DC_NLL"].ToString().Trim());
            fields.SetField("$DienThoaiLienLac", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["DT_NLL"].ToString().Trim());
            fields.SetField("$Email", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["Email"].ToString().Trim());
            // Giới tính
            if (PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["GioiTinh"].ToString().ToUpper() == "TRUE")
                fields.SetField("$GioiTinh", "Nữ");
            else
                fields.SetField("$GioiTinh", "Nam");
            // Chính sách ưu tiên
            if (PDFdataSet.Tables["ChinhSachUuTien"].Rows.Count == 0)
                fields.SetField("$ChinhSach", "không có");
            else
                fields.SetField("$ChinhSach", PDFdataSet.Tables["ChinhSachUuTien"].Rows[0]["TenUT"].ToString().Trim());
            // Ngày sinh
            try
            {
                DT = (DateTime)PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NgaySinh"];
                fields.SetField("$NgaySinh", DT.ToString("dd/MM/yyyy"));
            }
            catch
            {
            }
            #endregion
            #region Ngày đăng ký
            try
            {
                DT = (DateTime)PDFdataSet.Tables["HoSo"].Rows[0]["NgayNop"];
                fields.SetField("$NgayDangKy", DT.ToString("dd/MM/yyyy"));
            }
            catch
            {
            }
            #endregion
            #region Ngày hết hạn
            // Ngày hết hạn = ngày nộp + DayExpire
            try
            {
                // DT = (DateTime)PDFdataSet.Tables["HoSo"].Rows[0]["NgayNop"];
                // DT = DT.AddDays(PDFdayExpire);
                DT = (DateTime)PDFdataSet.Tables["HetHan"].Rows[0][0];
                fields.SetField("$NgayHetHan", DT.ToString("dd/MM/yyyy"));
            }
            catch
            {
            }
            #endregion
            #region Chứng chỉ bổ túc
            fields.SetField("$BoTuc", "không có");
            for (int i = 0; i < PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows.Count; i++)
            {
                if (PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[0]["CCBoTuc"].ToString().ToUpper() != "NULL")
                    fields.SetField("$BoTuc", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["CCBoTuc"].ToString().Trim());
            }
            #endregion
            #region Ngoại ngữ
            if (PDFdataSet.Tables["NgoaiNgu"].Rows.Count == 0)
                NgoaiNgu = "không có";
            else
            {
                for (int i = 0; i < PDFdataSet.Tables["NgoaiNgu"].Rows.Count; i++)
                {
                    if (NgoaiNgu == "")
                    {
                        NgoaiNgu += PDFdataSet.Tables["NgoaiNgu"].Rows[i]["TenNN"].ToString().Trim();
                        if (PDFdataSet.Tables["NgoaiNgu"].Rows[i]["Diem"].ToString().Trim() != "0")
                            NgoaiNgu += " " + PDFdataSet.Tables["NgoaiNgu"].Rows[i]["Diem"].ToString().Trim();
                    }
                    else
                    {
                        NgoaiNgu += ", " + PDFdataSet.Tables["NgoaiNgu"].Rows[i]["TenNN"].ToString().Trim();
                        if (PDFdataSet.Tables["NgoaiNgu"].Rows[i]["Diem"].ToString().Trim() != "0")
                            NgoaiNgu += " " + PDFdataSet.Tables["NgoaiNgu"].Rows[i]["Diem"].ToString().Trim();
                    }

                }
            }
            fields.SetField("$NgoaiNgu", NgoaiNgu);
            #endregion
            #region Lệ phí hồ sơ
            SetMoneyFields(fields);
            #endregion
            #region Sai khác trong giấy tờ
            switch (FileType)
            {
                case "CH_BiaHoSo.pdf":
                    #region Số giấy tờ trên Bìa hồ sơ
                    for (int i = 0; i < PDFdataSet.Tables["GiayTo"].Rows.Count; i++)
                    {
                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT01")
                            fields.SetField("$Muc1", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT02")
                            fields.SetField("$Muc2", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT03")
                            fields.SetField("$Muc3", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT04")
                            fields.SetField("$Muc4", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT05")
                            fields.SetField("$Muc5", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT06")
                            fields.SetField("$Muc6", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT07")
                            fields.SetField("$Muc7", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT08")
                            fields.SetField("$Muc8", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT09")
                            fields.SetField("$Muc9", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT10")
                            fields.SetField("$Muc10", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT12")
                            fields.SetField("$Muc11", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT11")
                            fields.SetField("$Muc12", "X");
                    }
                    #endregion
                    break;
                case "CH_BienNhanHoSo.pdf":
                    #region Số giấy tờ trên Biên nhận hồ sơ
                    for (int i = 0; i < PDFdataSet.Tables["GiayTo"].Rows.Count; i++)
                    {
                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT01")
                            fields.SetField("$Muc1", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT02")
                            fields.SetField("$Muc2", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT03")
                            fields.SetField("$Muc3", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT04")
                            fields.SetField("$Muc4", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT05")
                            fields.SetField("$Muc5", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT06")
                            fields.SetField("$Muc6", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT07")
                            fields.SetField("$Muc7", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT08")
                            fields.SetField("$Muc8", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT09")
                            fields.SetField("$Muc9", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT10")
                            fields.SetField("$Muc10", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT12")
                            fields.SetField("$Muc11", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT11")
                            fields.SetField("$Muc12", "X");
                    }

                    #endregion
                    break;
                case "CH_LyLichKhoaHoc.pdf":
                    #region Lý lịch khoa học

                    // 1. Lý lịch bản thân
                    fields.SetField("$Ten", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["Ho"].ToString().Trim() + " " + PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["Ten"].ToString().Trim());
                    if (PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["GioiTinh"].ToString().ToUpper() == "TRUE")
                        fields.SetField("$GioiTinh", "Nữ");
                    else
                        fields.SetField("$GioiTinh", "Nam");
                    try
                    {
                        DT = (DateTime)PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NgaySinh"];
                        fields.SetField("$NgaySinh", DT.ToString("dd/MM/yyyy"));
                    }
                    catch
                    {
                    }
                    fields.SetField("$NoiSinh", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NoiSinh"].ToString().Trim());
                    fields.SetField("$DanToc", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["DanToc"].ToString().Trim());
                    fields.SetField("$TonGiao", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["TonGiao"].ToString().Trim());
                    fields.SetField("$NgheNghiep", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NgheNghiep"].ToString().Trim());
                    fields.SetField("$NoiLamViec", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NoiLamViec"].ToString().Trim());
                    fields.SetField("$NamCongTac", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NamCongTac"].ToString().Trim());
                    fields.SetField("$DCThuongTru", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["DCThuongTru"].ToString().Trim());
                    fields.SetField("$DCHienNay", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["DCHienNay"].ToString().Trim());
                    fields.SetField("$DTCoQuan", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["DTCoQuan"].ToString().Trim());
                    fields.SetField("$DTNhaRieng", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["DTNhaRieng"].ToString().Trim());
                    fields.SetField("$DTDiDong", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["DTDiDong"].ToString().Trim());
                    fields.SetField("$Email", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["Email"].ToString().Trim());
                    try
                    {
                        DT = (DateTime)PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NgayVaoDoan"];
                        fields.SetField("$NgayVaoDoan", DT.ToString("dd/MM/yyyy"));
                    }
                    catch
                    {
                    }
                    fields.SetField("$NoiVaoDoan", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NoiVaoDoan"].ToString().Trim());
                    try
                    {
                        DT = (DateTime)PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NgayVaoDang"];
                        fields.SetField("$NgayVaoDang", DT.ToString("dd/MM/yyyy"));
                    }
                    catch
                    {
                    }
                    fields.SetField("$NoiVaoDang", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NoiVaoDang"].ToString().Trim());
                    if (PDFdataSet.Tables["ChinhSachUuTien"].Rows.Count == 0)
                        fields.SetField("$ChinhSach", "không có");
                    else
                        fields.SetField("$ChinhSach", PDFdataSet.Tables["ChinhSachUuTien"].Rows[0]["TenUT"].ToString().Trim());
                    fields.SetField("$NguoiLienLac", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NguoiLienLac"].ToString().Trim());
                    fields.SetField("$DiaChiLienLac", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["DC_NLL"].ToString().Trim());
                    fields.SetField("$DienThoaiLienLac", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["DT_NLL"].ToString().Trim());

                    // 2. Quá trình đào tạo
                    DaiHocIndex = 1;
                    CaoHocIndex = 1;
                    for (int i = 0; i < PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows.Count; i++)
                    {
                        if ((PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["DH"].ToString().Trim())[0].ToString().ToUpper() == "T")
                        {
                            fields.SetField("$DaiHoc" + DaiHocIndex.ToString() + "_HeDaoTao", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["HeDaoTao"].ToString().Trim());
                            fields.SetField("$DaiHoc" + DaiHocIndex.ToString() + "_NganhHoc", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["NganhHoc"].ToString().Trim());
                            fields.SetField("$DaiHoc" + DaiHocIndex.ToString() + "_TenTruong", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["TenTruong"].ToString().Trim());
                            fields.SetField("$DaiHoc" + DaiHocIndex.ToString() + "_NamBatDau", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["NamBatDau"].ToString().Trim());
                            fields.SetField("$DaiHoc" + DaiHocIndex.ToString() + "_NamTotNghiep", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["NamTotNghiep"].ToString().Trim());
                            fields.SetField("$DaiHoc" + DaiHocIndex.ToString() + "_XepLoai", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["XepLoai"].ToString().Trim());
                            if (PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["CCBoTuc"] != null)
                                fields.SetField("$DaiHoc" + i.ToString() + "_BoTuc", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["CCBoTuc"].ToString().Trim());
                            DaiHocIndex++;
                        }
                        else
                        {
                            fields.SetField("$CaoHoc" + CaoHocIndex.ToString() + "_HeDaoTao", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["HeDaoTao"].ToString().Trim());
                            fields.SetField("$CaoHoc" + CaoHocIndex.ToString() + "_NganhHoc", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["NganhHoc"].ToString().Trim());
                            fields.SetField("$CaoHoc" + CaoHocIndex.ToString() + "_TenTruong", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["TenTruong"].ToString().Trim());
                            fields.SetField("$CaoHoc" + CaoHocIndex.ToString() + "_NamBatDau", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["NamBatDau"].ToString().Trim());
                            fields.SetField("$CaoHoc" + CaoHocIndex.ToString() + "_NamTotNghiep", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["NamTotNghiep"].ToString().Trim());
                            fields.SetField("$CaoHoc" + CaoHocIndex.ToString() + "_XepLoai", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["XepLoai"].ToString().Trim());
                            CaoHocIndex++;
                        }
                    }
                    for (int i = 0; i < PDFdataSet.Tables["NgoaiNgu"].Rows.Count; i++)
                    {
                        fields.SetField("$NgoaiNgu" + (i + 1).ToString() + "_TenNgoaiNgu", PDFdataSet.Tables["NgoaiNgu"].Rows[i]["TenNN"].ToString().Trim());
                        fields.SetField("$NgoaiNgu" + (i + 1).ToString() + "_Diem", PDFdataSet.Tables["NgoaiNgu"].Rows[i]["Diem"].ToString().Trim());
                        try
                        {
                            DT = (DateTime)PDFdataSet.Tables["NgoaiNgu"].Rows[i]["NgayCap"];
                            fields.SetField("$NgoaiNgu" + (i + 1).ToString() + "_NgayCap", DT.ToString("dd/MM/yyyy"));
                        }
                        catch
                        {
                        }
                    }


                    // 3. Quá trình học tập làm việc
                    for (int i = 0; i < PDFdataSet.Tables["QTHocTapLamViec"].Rows.Count; i++)
                    {
                        fields.SetField("$QTHTLV" + "_NgayThangNam" + (i + 1).ToString(), PDFdataSet.Tables["QTHocTapLamViec"].Rows[i]["NgayThangNam"].ToString().Trim());
                        fields.SetField("$QTHTLV" + "_HocVaLamViec" + (i + 1).ToString(), PDFdataSet.Tables["QTHocTapLamViec"].Rows[i]["Hoc_LamViec"].ToString().Trim());
                        fields.SetField("$QTHTLV" + "_NoiChon" + (i + 1).ToString(), PDFdataSet.Tables["QTHocTapLamViec"].Rows[i]["NoiChon"].ToString().Trim());
                        fields.SetField("$QTHTLV" + "_ThanhTich" + (i + 1).ToString(), PDFdataSet.Tables["QTHocTapLamViec"].Rows[i]["ThanhTich"].ToString().Trim());
                    }

                    // 4. Kết quả hoạt động KHKT
                    fields.SetField("$BaiBao" + "_SoBB", PDFdataSet.Tables["BaiBao"].Rows.Count.ToString().Trim());
                    for (int i = 0; i < PDFdataSet.Tables["BaiBao"].Rows.Count; i++)
                    {
                        fields.SetField("$BaiBao" + (i + 1).ToString() + "_TenBB", PDFdataSet.Tables["BaiBao"].Rows[i]["TenBB"].ToString().Trim());
                        fields.SetField("$BaiBao" + (i + 1).ToString() + "_LinhVuc", PDFdataSet.Tables["BaiBao"].Rows[i]["LinhVuc"].ToString().Trim());
                        fields.SetField("$BaiBao" + (i + 1).ToString() + "_TapChiDang", PDFdataSet.Tables["BaiBao"].Rows[i]["TapChiDang"].ToString().Trim());
                        try
                        {
                            DT = (DateTime)PDFdataSet.Tables["BaiBao"].Rows[i]["NgayDang"];
                            fields.SetField("$BaiBao" + (i + 1).ToString() + "_NgayDang", DT.ToString("dd/MM/yyyy"));
                        }
                        catch
                        {
                        }
                    }

                    fields.SetField("$CongTrinhNghienCuu" + "_SoCT", PDFdataSet.Tables["CongTrinhNghienCuu"].Rows.Count.ToString().Trim());
                    CongTrinhNCIndex = 1;
                    for (int i = 0; i < PDFdataSet.Tables["CongTrinhNghienCuu"].Rows.Count; i++)
                    {
                        if (PDFdataSet.Tables["CongTrinhNghienCuu"].Rows[i]["DeCuong"].ToString().ToUpper().Trim() == "TRUE")
                        {
                            fields.SetField("$DeCuong" + "_TenCT", PDFdataSet.Tables["CongTrinhNghienCuu"].Rows[i]["TenCT"].ToString().Trim());
                            fields.SetField("$DeCuong" + "_LinhVuc", PDFdataSet.Tables["CongTrinhNghienCuu"].Rows[i]["LinhVuc"].ToString().Trim());
                            fields.SetField("$DeCuong" + "_VaiTro", PDFdataSet.Tables["CongTrinhNghienCuu"].Rows[i]["VaiTro"].ToString().Trim());
                            fields.SetField("$DeCuong" + "_GVHuongDan", PDFdataSet.Tables["CongTrinhNghienCuu"].Rows[i]["GVHuongDan"].ToString().Trim());

                        }
                        else
                        {
                            fields.SetField("$CongTrinhNghienCuu" + CongTrinhNCIndex.ToString() + "_TenCT", PDFdataSet.Tables["CongTrinhNghienCuu"].Rows[i]["TenCT"].ToString().Trim());
                            fields.SetField("$CongTrinhNghienCuu" + CongTrinhNCIndex.ToString() + "_LinhVuc", PDFdataSet.Tables["CongTrinhNghienCuu"].Rows[i]["LinhVuc"].ToString().Trim());
                            fields.SetField("$CongTrinhNghienCuu" + CongTrinhNCIndex.ToString() + "_VaiTro", PDFdataSet.Tables["CongTrinhNghienCuu"].Rows[i]["VaiTro"].ToString().Trim());
                            fields.SetField("$CongTrinhNghienCuu" + CongTrinhNCIndex.ToString() + "_GVHuongDan", PDFdataSet.Tables["CongTrinhNghienCuu"].Rows[i]["GVHuongDan"].ToString().Trim());
                            fields.SetField("$CongTrinhNghienCuu" + CongTrinhNCIndex.ToString() + "_NoiCongBo", PDFdataSet.Tables["CongTrinhNghienCuu"].Rows[i]["NoiCongBo"].ToString().Trim());
                            try
                            {
                                DT = (DateTime)PDFdataSet.Tables["CongTrinhNghienCuu"].Rows[i]["NgayCongBo"];
                                fields.SetField("$CongTrinhNghienCuu" + CongTrinhNCIndex.ToString() + "_NgayCongBo", DT.ToString("dd/MM/yyyy"));
                            }
                            catch
                            {
                            }
                            CongTrinhNCIndex++;
                        }
                    }
                    #endregion
                    break;
            }
            #endregion
        }

        protected void SetAcroFieldsForPhDInfo(AcroFields fields, string FileType)
        {
            string MaHS = PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["MaHS"].ToString();
            DateTime DT = new DateTime();
            string NgoaiNgu = "";

            int DaiHocIndex = 1;
            int CaoHocIndex = 1;
            int CongTrinhNCIndex = 1;

            #region Mã hồ sơ
            fields.SetField("$MaHS", MaHS.Trim());
            fields.SetField("$MaHS01", MaHS[0].ToString() + MaHS[1].ToString());
            fields.SetField("$MaHS23", MaHS[2].ToString() + MaHS[3].ToString());
            fields.SetField("$MaHS4", MaHS[4].ToString());
            fields.SetField("$MaHS5", MaHS[5].ToString());
            fields.SetField("$MaHS6", MaHS[6].ToString());
            fields.SetField("$MaHS7", MaHS[7].ToString());
            #endregion
            #region Thông tin thí sinh
            fields.SetField("$NamThi", PDFdataSet.Tables["NamThi"].Rows[0][0].ToString().Trim());
            fields.SetField("$Ten", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["Ho"].ToString().Trim().ToUpper() + " " + PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["Ten"].ToString().Trim().ToUpper());
            fields.SetField("$NoiSinh", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NoiSinh"].ToString().Trim());
            fields.SetField("$NoiLamViec", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NoiLamViec"].ToString().Trim());
            fields.SetField("$NguoiLienLac", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NguoiLienLac"].ToString().Trim());
            fields.SetField("$DiaChiLienLac", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["DC_NLL"].ToString().Trim());
            fields.SetField("$DienThoaiLienLac", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["DT_NLL"].ToString().Trim());
            fields.SetField("$Email", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["Email"].ToString().Trim());
            // Giới tính
            if (PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["GioiTinh"].ToString().ToUpper() == "TRUE")
                fields.SetField("$GioiTinh", "Nữ");
            else
                fields.SetField("$GioiTinh", "Nam");
            // Chính sách ưu tiên
            if (PDFdataSet.Tables["ChinhSachUuTien"].Rows.Count == 0)
                fields.SetField("$ChinhSach", "không có");
            else
                fields.SetField("$ChinhSach", PDFdataSet.Tables["ChinhSachUuTien"].Rows[0]["TenUT"].ToString().Trim());
            // Ngày sinh
            try
            {
                DT = (DateTime)PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NgaySinh"];
                fields.SetField("$NgaySinh", DT.ToString("dd/MM/yyyy"));
            }
            catch
            {
            }
            #endregion
            #region Ngày đăng ký
            try
            {
                DT = (DateTime)PDFdataSet.Tables["HoSo"].Rows[0]["NgayNop"];
                fields.SetField("$NgayDangKy", DT.ToString("dd/MM/yyyy"));
            }
            catch
            {
            }
            #endregion
            #region Ngày hết hạn
            // Ngày hết hạn = ngày nộp + DayExpire
            try
            {
                //DT = (DateTime)PDFdataSet.Tables["HoSo"].Rows[0]["NgayNop"];
                //DT = DT.AddDays(PDFdayExpire);
                DT = (DateTime)PDFdataSet.Tables["HetHan"].Rows[0][0];
                fields.SetField("$NgayHetHan", DT.ToString("dd/MM/yyyy"));
            }
            catch
            {
            }
            #endregion
            #region Chứng chỉ bổ túc
            fields.SetField("$BoTuc", "không có");
            for (int i = 0; i < PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows.Count; i++)
            {
                if (PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[0]["CCBoTuc"].ToString().ToUpper() != "NULL")
                    fields.SetField("$BoTuc", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["CCBoTuc"].ToString().Trim());
            }
            #endregion
            #region Ngoại ngữ
            if (PDFdataSet.Tables["NgoaiNgu"].Rows.Count == 0)
                NgoaiNgu = "không có";
            else
            {
                for (int i = 0; i < PDFdataSet.Tables["NgoaiNgu"].Rows.Count; i++)
                {
                    if (NgoaiNgu == "")
                    {
                        NgoaiNgu += PDFdataSet.Tables["NgoaiNgu"].Rows[i]["TenNN"].ToString().Trim();
                        if (PDFdataSet.Tables["NgoaiNgu"].Rows[i]["Diem"].ToString().Trim() != "0")
                            NgoaiNgu += " " + PDFdataSet.Tables["NgoaiNgu"].Rows[i]["Diem"].ToString().Trim();
                    }
                    else
                    {
                        NgoaiNgu += ", " + PDFdataSet.Tables["NgoaiNgu"].Rows[i]["TenNN"].ToString().Trim();
                        if (PDFdataSet.Tables["NgoaiNgu"].Rows[i]["Diem"].ToString().Trim() != "0")
                            NgoaiNgu += " " + PDFdataSet.Tables["NgoaiNgu"].Rows[i]["Diem"].ToString().Trim();
                    }

                }
            }
            fields.SetField("$NgoaiNgu", NgoaiNgu);
            #endregion
            #region Lệ phí hồ sơ
            SetMoneyFields(fields);
            #endregion
            #region Sai khác trong giấy tờ
            switch (FileType)
            {
                case "NCS_BiaHoSo.pdf":
                    #region Số giấy tờ trên Bìa hồ sơ
                    for (int i = 0; i < PDFdataSet.Tables["GiayTo"].Rows.Count; i++)
                    {
                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT01")
                            fields.SetField("$Muc1", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT02")
                            fields.SetField("$Muc2", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT03")
                            fields.SetField("$Muc3", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT13")
                            fields.SetField("$Muc4", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT14")
                            fields.SetField("$Muc5", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT15")
                            fields.SetField("$Muc6", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT16")
                            fields.SetField("$Muc7", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT19")
                            fields.SetField("$Muc8", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT18")
                            fields.SetField("$Muc9", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT17")
                            fields.SetField("$Muc10", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT05")
                            fields.SetField("$Muc11", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT06")
                            fields.SetField("$Muc12", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT08")
                            fields.SetField("$Muc13", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT09")
                            fields.SetField("$Muc14", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT10")
                            fields.SetField("$Muc15", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT12")
                            fields.SetField("$Muc16", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT11")
                            fields.SetField("$Muc17", "X");

                    }
                    #endregion
                    break;
                case "NCS_BienNhanHoSo.pdf":
                    #region Số giấy tờ trên Biên nhận hồ sơ
                    for (int i = 0; i < PDFdataSet.Tables["GiayTo"].Rows.Count; i++)
                    {
                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT01")
                            fields.SetField("$Muc1", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT02")
                            fields.SetField("$Muc2", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT03")
                            fields.SetField("$Muc3", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT13")
                            fields.SetField("$Muc4", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT14")
                            fields.SetField("$Muc5", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT15")
                            fields.SetField("$Muc6", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT16")
                            fields.SetField("$Muc7", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT19")
                            fields.SetField("$Muc8", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT18")
                            fields.SetField("$Muc9", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT17")
                            fields.SetField("$Muc10", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT05")
                            fields.SetField("$Muc11", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT06")
                            fields.SetField("$Muc12", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT08")
                            fields.SetField("$Muc13", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT09")
                            fields.SetField("$Muc14", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT10")
                            fields.SetField("$Muc15", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT12")
                            fields.SetField("$Muc16", "X");

                        if (PDFdataSet.Tables["GiayTo"].Rows[i][0].ToString().Trim() == "GT11")
                            fields.SetField("$Muc17", "X");
                    }
                    #endregion
                    break;
                case "NCS_LyLichKhoaHoc.pdf":
                    #region Lý lịch khoa học

                    // 1. Lý lịch bản thân
                    fields.SetField("$Ten", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["Ho"].ToString().Trim() + " " + PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["Ten"].ToString().Trim());
                    if (PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["GioiTinh"].ToString().ToUpper() == "TRUE")
                        fields.SetField("$GioiTinh", "Nữ");
                    else
                        fields.SetField("$GioiTinh", "Nam");
                    try
                    {
                        DT = (DateTime)PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NgaySinh"];
                        fields.SetField("$NgaySinh", DT.ToString("dd/MM/yyyy"));
                    }
                    catch
                    {
                    }
                    fields.SetField("$NoiSinh", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NoiSinh"].ToString().Trim());
                    fields.SetField("$DanToc", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["DanToc"].ToString().Trim());
                    fields.SetField("$TonGiao", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["TonGiao"].ToString().Trim());
                    fields.SetField("$NgheNghiep", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NgheNghiep"].ToString().Trim());
                    fields.SetField("$NoiLamViec", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NoiLamViec"].ToString().Trim());
                    fields.SetField("$NamCongTac", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NamCongTac"].ToString().Trim());
                    fields.SetField("$DCThuongTru", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["DCThuongTru"].ToString().Trim());
                    fields.SetField("$DCHienNay", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["DCHienNay"].ToString().Trim());
                    fields.SetField("$DTCoQuan", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["DTCoQuan"].ToString().Trim());
                    fields.SetField("$DTNhaRieng", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["DTNhaRieng"].ToString().Trim());
                    fields.SetField("$DTDiDong", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["DTDiDong"].ToString().Trim());
                    fields.SetField("$Email", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["Email"].ToString().Trim());
                    try
                    {
                        DT = (DateTime)PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NgayVaoDoan"];
                        fields.SetField("$NgayVaoDoan", DT.ToString("dd/MM/yyyy"));
                    }
                    catch
                    {
                    }
                    fields.SetField("$NoiVaoDoan", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NoiVaoDoan"].ToString().Trim());
                    try
                    {
                        DT = (DateTime)PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NgayVaoDang"];
                        fields.SetField("$NgayVaoDang", DT.ToString("dd/MM/yyyy"));
                    }
                    catch
                    {
                    }
                    fields.SetField("$NoiVaoDang", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NoiVaoDang"].ToString().Trim());
                    if (PDFdataSet.Tables["ChinhSachUuTien"].Rows.Count == 0)
                        fields.SetField("$ChinhSach", "không có");
                    else
                        fields.SetField("$ChinhSach", PDFdataSet.Tables["ChinhSachUuTien"].Rows[0]["TenUT"].ToString().Trim());
                    fields.SetField("$NguoiLienLac", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["NguoiLienLac"].ToString().Trim());
                    fields.SetField("$DiaChiLienLac", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["DC_NLL"].ToString().Trim());
                    fields.SetField("$DienThoaiLienLac", PDFdataSet.Tables["SoYeuLyLich"].Rows[0]["DT_NLL"].ToString().Trim());

                    // 2. Quá trình đào tạo
                    DaiHocIndex = 1;
                    CaoHocIndex = 1;
                    for (int i = 0; i < PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows.Count; i++)
                    {
                        if ((PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["DH"].ToString().Trim())[0].ToString().ToUpper() == "T")
                        {
                            fields.SetField("$DaiHoc" + DaiHocIndex.ToString() + "_HeDaoTao", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["HeDaoTao"].ToString().Trim());
                            fields.SetField("$DaiHoc" + DaiHocIndex.ToString() + "_NganhHoc", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["NganhHoc"].ToString().Trim());
                            fields.SetField("$DaiHoc" + DaiHocIndex.ToString() + "_TenTruong", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["TenTruong"].ToString().Trim());
                            fields.SetField("$DaiHoc" + DaiHocIndex.ToString() + "_NamBatDau", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["NamBatDau"].ToString().Trim());
                            fields.SetField("$DaiHoc" + DaiHocIndex.ToString() + "_NamTotNghiep", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["NamTotNghiep"].ToString().Trim());
                            fields.SetField("$DaiHoc" + DaiHocIndex.ToString() + "_XepLoai", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["XepLoai"].ToString().Trim());
                            if (PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["CCBoTuc"] != null)
                                fields.SetField("$DaiHoc" + i.ToString() + "_BoTuc", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["CCBoTuc"].ToString().Trim());
                            DaiHocIndex++;
                        }
                        else
                        {
                            fields.SetField("$CaoHoc" + CaoHocIndex.ToString() + "_HeDaoTao", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["HeDaoTao"].ToString().Trim());
                            fields.SetField("$CaoHoc" + CaoHocIndex.ToString() + "_NganhHoc", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["NganhHoc"].ToString().Trim());
                            fields.SetField("$CaoHoc" + CaoHocIndex.ToString() + "_TenTruong", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["TenTruong"].ToString().Trim());
                            fields.SetField("$CaoHoc" + CaoHocIndex.ToString() + "_NamBatDau", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["NamBatDau"].ToString().Trim());
                            fields.SetField("$CaoHoc" + CaoHocIndex.ToString() + "_NamTotNghiep", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["NamTotNghiep"].ToString().Trim());
                            fields.SetField("$CaoHoc" + CaoHocIndex.ToString() + "_XepLoai", PDFdataSet.Tables["DaiHoc_CaoHoc"].Rows[i]["XepLoai"].ToString().Trim());
                            CaoHocIndex++;
                        }
                    }
                    for (int i = 0; i < PDFdataSet.Tables["NgoaiNgu"].Rows.Count; i++)
                    {
                        fields.SetField("$NgoaiNgu" + (i + 1).ToString() + "_TenNgoaiNgu", PDFdataSet.Tables["NgoaiNgu"].Rows[i]["TenNN"].ToString().Trim());
                        fields.SetField("$NgoaiNgu" + (i + 1).ToString() + "_Diem", PDFdataSet.Tables["NgoaiNgu"].Rows[i]["Diem"].ToString().Trim());
                        try
                        {
                            DT = (DateTime)PDFdataSet.Tables["NgoaiNgu"].Rows[i]["NgayCap"];
                            fields.SetField("$NgoaiNgu" + (i + 1).ToString() + "_NgayCap", DT.ToString("dd/MM/yyyy"));
                        }
                        catch
                        {
                        }
                    }


                    // 3. Quá trình học tập làm việc
                    for (int i = 0; i < PDFdataSet.Tables["QTHocTapLamViec"].Rows.Count; i++)
                    {
                        fields.SetField("$QTHTLV" + "_NgayThangNam" + (i + 1).ToString(), PDFdataSet.Tables["QTHocTapLamViec"].Rows[i]["NgayThangNam"].ToString().Trim());
                        fields.SetField("$QTHTLV" + "_HocVaLamViec" + (i + 1).ToString(), PDFdataSet.Tables["QTHocTapLamViec"].Rows[i]["Hoc_LamViec"].ToString().Trim());
                        fields.SetField("$QTHTLV" + "_NoiChon" + (i + 1).ToString(), PDFdataSet.Tables["QTHocTapLamViec"].Rows[i]["NoiChon"].ToString().Trim());
                        fields.SetField("$QTHTLV" + "_ThanhTich" + (i + 1).ToString(), PDFdataSet.Tables["QTHocTapLamViec"].Rows[i]["ThanhTich"].ToString().Trim());
                    }

                    // 4. Kết quả hoạt động KHKT
                    fields.SetField("$BaiBao" + "_SoBB", PDFdataSet.Tables["BaiBao"].Rows.Count.ToString().Trim());
                    for (int i = 0; i < PDFdataSet.Tables["BaiBao"].Rows.Count; i++)
                    {
                        fields.SetField("$BaiBao" + (i + 1).ToString() + "_TenBB", PDFdataSet.Tables["BaiBao"].Rows[i]["TenBB"].ToString().Trim());
                        fields.SetField("$BaiBao" + (i + 1).ToString() + "_LinhVuc", PDFdataSet.Tables["BaiBao"].Rows[i]["LinhVuc"].ToString().Trim());
                        fields.SetField("$BaiBao" + (i + 1).ToString() + "_TapChiDang", PDFdataSet.Tables["BaiBao"].Rows[i]["TapChiDang"].ToString().Trim());
                        try
                        {
                            DT = (DateTime)PDFdataSet.Tables["BaiBao"].Rows[i]["NgayDang"];
                            fields.SetField("$BaiBao" + (i + 1).ToString() + "_NgayDang", DT.ToString("dd/MM/yyyy"));
                        }
                        catch
                        {
                        }
                    }

                    fields.SetField("$CongTrinhNghienCuu" + "_SoCT", PDFdataSet.Tables["CongTrinhNghienCuu"].Rows.Count.ToString().Trim());
                    CongTrinhNCIndex = 1;
                    for (int i = 0; i < PDFdataSet.Tables["CongTrinhNghienCuu"].Rows.Count; i++)
                    {
                        if (PDFdataSet.Tables["CongTrinhNghienCuu"].Rows[i]["DeCuong"].ToString().ToUpper().Trim() == "TRUE")
                        {
                            fields.SetField("$DeCuong" + "_TenCT", PDFdataSet.Tables["CongTrinhNghienCuu"].Rows[i]["TenCT"].ToString().Trim());
                            fields.SetField("$DeCuong" + "_LinhVuc", PDFdataSet.Tables["CongTrinhNghienCuu"].Rows[i]["LinhVuc"].ToString().Trim());
                            fields.SetField("$DeCuong" + "_VaiTro", PDFdataSet.Tables["CongTrinhNghienCuu"].Rows[i]["VaiTro"].ToString().Trim());
                            fields.SetField("$DeCuong" + "_GVHuongDan", PDFdataSet.Tables["CongTrinhNghienCuu"].Rows[i]["GVHuongDan"].ToString().Trim());

                        }
                        else
                        {
                            fields.SetField("$CongTrinhNghienCuu" + CongTrinhNCIndex.ToString() + "_TenCT", PDFdataSet.Tables["CongTrinhNghienCuu"].Rows[i]["TenCT"].ToString().Trim());
                            fields.SetField("$CongTrinhNghienCuu" + CongTrinhNCIndex.ToString() + "_LinhVuc", PDFdataSet.Tables["CongTrinhNghienCuu"].Rows[i]["LinhVuc"].ToString().Trim());
                            fields.SetField("$CongTrinhNghienCuu" + CongTrinhNCIndex.ToString() + "_VaiTro", PDFdataSet.Tables["CongTrinhNghienCuu"].Rows[i]["VaiTro"].ToString().Trim());
                            fields.SetField("$CongTrinhNghienCuu" + CongTrinhNCIndex.ToString() + "_GVHuongDan", PDFdataSet.Tables["CongTrinhNghienCuu"].Rows[i]["GVHuongDan"].ToString().Trim());
                            fields.SetField("$CongTrinhNghienCuu" + CongTrinhNCIndex.ToString() + "_NoiCongBo", PDFdataSet.Tables["CongTrinhNghienCuu"].Rows[i]["NoiCongBo"].ToString().Trim());
                            try
                            {
                                DT = (DateTime)PDFdataSet.Tables["CongTrinhNghienCuu"].Rows[i]["NgayCongBo"];
                                fields.SetField("$CongTrinhNghienCuu" + CongTrinhNCIndex.ToString() + "_NgayCongBo", DT.ToString("dd/MM/yyyy"));
                            }
                            catch
                            {
                            }
                            CongTrinhNCIndex++;
                        }
                    }
                    #endregion
                    break;
            }
            #endregion
        }

        protected void SetMoneyFields(AcroFields fields)
        {
            int LePhi = 0;
            LePhi = 0;
            if (PDFdataSet.Tables["LePhi"].Rows[0]["CH"].ToString().Trim().ToUpper() == "TRUE")
            {
                try
                {
                    LePhi = 0;
                    LePhi += int.Parse(PDFdataSet.Tables["LePhi"].Rows[0]["LePhiCH"].ToString());
                    if (PDFdataSet.Tables["NgoaiNgu"].Rows.Count == 0)
                    {
                        LePhi += int.Parse(PDFdataSet.Tables["LePhi"].Rows[0]["LePhi1"].ToString());
                    }
                    LePhi += int.Parse(PDFdataSet.Tables["LePhi"].Rows[0]["LePhi2"].ToString());
                    LePhi += int.Parse(PDFdataSet.Tables["LePhi"].Rows[0]["LePhi3"].ToString());
                }
                catch
                {
                }

                fields.SetField("$LePhiHS", PDFdataSet.Tables["LePhi"].Rows[0]["LePhiCH"].ToString().Trim() + "000 VNĐ");
                for (int i = 0; i < 3; i++)
                {
                    fields.SetField("$MonThi" + (i + 1).ToString(), PDFdataSet.Tables["LePhi"].Rows[0]["TenMonThi" + (i + 1).ToString()].ToString().Trim());
                    fields.SetField("$LePhiThi" + (i + 1).ToString(), PDFdataSet.Tables["LePhi"].Rows[0]["LePhi" + (i + 1).ToString()].ToString().Trim() + "000");
                }
            }
            else
            {
                try
                {
                    LePhi = 0;
                    LePhi += int.Parse(PDFdataSet.Tables["LePhi"].Rows[0]["LePhiNCS"].ToString());
                    LePhi += int.Parse(PDFdataSet.Tables["LePhi"].Rows[0]["LePhiDCNCS"].ToString());
                    if (PDFdataSet.Tables["NgoaiNgu"].Rows.Count == 0)
                    {
                        LePhi += int.Parse(PDFdataSet.Tables["LePhi"].Rows[0]["LePhiAVNCS"].ToString());
                    }
                }
                catch
                {
                }
                fields.SetField("$LePhiHS", PDFdataSet.Tables["LePhi"].Rows[0]["LePhiNCS"].ToString().Trim() + "000 VNĐ");
                fields.SetField("$MonThi1", PDFdataSet.Tables["LePhi"].Rows[0]["TenMonThi1"].ToString().Trim());
                fields.SetField("$LePhiThi1", PDFdataSet.Tables["LePhi"].Rows[0]["LePhiAVNCS"].ToString().Trim() + "000");
                fields.SetField("$MonThi2", PDFdataSet.Tables["LePhi"].Rows[0]["TenMonThi4"].ToString().Trim());
                fields.SetField("$LePhiThi2", PDFdataSet.Tables["LePhi"].Rows[0]["LePhiDCNCS"].ToString().Trim() + "000");
            }
            if (PDFdataSet.Tables["NgoaiNgu"].Rows.Count > 0)
            {
                fields.SetField("$LePhiThi1", "Miễn");
            }
            fields.SetField("$TongCong", "Tổng cộng: " + LePhi.ToString() + "000 VNĐ");
        }

        protected void FillForm(string formFile, string newFile, string FileType)
        {
            try
            {
                PdfReader reader = new PdfReader(formFile);
                PdfStamper stamper = new PdfStamper(reader, new FileStream(newFile, FileMode.Create));
                AcroFields fields = stamper.AcroFields;


                // Set form fields
                SetAcroFields(fields, FileType);

                // flatten form fields and close document
                stamper.FormFlattening = true;
                reader.Close();
                //stamper.Writer.CloseStream = true;
                stamper.Close();

            }
            catch (Exception e)
            {
                return;
            }
        }

        private string DownloadFile(string FilePath)
        {
            string path = FilePath;

            System.IO.FileInfo file = new System.IO.FileInfo(path);

            if (file.Exists)
            {

                Response.Clear();

                Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);

                Response.AddHeader("Content-Length", file.Length.ToString());

                Response.ContentType = "application/octet-stream";

                Response.WriteFile(file.FullName);

                Response.End();

            }
            else
            {
                //Response.Write("Files hồ sơ của bạn không tồn tại trên server");
                return "Files hồ sơ của bạn không tồn tại trên server";
            }

            try
            {
                File.Delete(FilePath);
            }
            catch (Exception e)
            {
                return e.Message;
            }
            return "Complete";
        }

        private string CompressFile(String newFile, string[] files)
        {
            try
            {
                using (ZipFile zipFile = new ZipFile())
                {
                    for (int i = 0; i < files.Count(); i++)
                    {
                        zipFile.AddFile(files[i], "Ho so du thi");
                    }
                    zipFile.Save(newFile);
                }
                for (int i = 0; i < files.Count(); i++)
                {
                    try
                    {
                        File.Delete(files[i]);
                    }
                    catch (Exception e)
                    {
                        return e.Message;
                    }
                }
            }
            catch (Exception e)
            {
                return e.Message;
            }
            return "Complete";

        }

        //tinh tien
        #region Tính tiền
        private int DocMoney(string hs)
        {
            int money = 0;
            DataTable tbMoney = new DataTable();
            SqlDataAdapter daMoney = new SqlDataAdapter();
            // lệ phí hồ sơ
            string text = "Select a.mahs, a.CH,b.LePhiCH,b.LePhiNCS From HoSo a,TuyenSinh b " +
                 " Where a.MaTS = b.MaTS and a.mahs='" + hs + "'";
            if (cnn.State == ConnectionState.Closed) cnn.Open();
            daMoney = new SqlDataAdapter(text, cnn);
            daMoney.Fill(tbMoney);
            if (tbMoney.Rows.Count == 0) return 0;
            if (tbMoney.Rows[0]["CH"].ToString() == "True")
                money = Convert.ToInt32(tbMoney.Rows[0]["LePhiCH"]);
            else money = Convert.ToInt32(tbMoney.Rows[0]["LePhiNCS"]);
            return money;
        }
        private int MoneyBySub(string hs, int sub)
        {
            int money = 0;
            DataTable tbMoney = new DataTable();
            SqlDataAdapter daMoney = new SqlDataAdapter();
            string ch_ncs = "CH";
            string text = "Select CH from hoso where mahs = '" + hs + "'";
            SqlCommand cmdd = new SqlCommand();
            cmdd.CommandText = text;
            cmdd.Connection = cnn;
            if (cnn.State == ConnectionState.Closed) cnn.Open();
            if (cmdd.ExecuteScalar().ToString() == "True")
                ch_ncs = "CH";
            else
                ch_ncs = "NCS";
            string column = "", subject = "";
            switch (sub)
            {
                case 1: if (ch_ncs == "CH")
                    {
                        column = "b.LePhiAVCH";
                        subject = "'Mon01'";
                    }
                    else
                    {
                        column = "b.LePhiAVNCS";
                        subject = "'Mon01'";
                    }
                    break;
                case 2: column = "b.LePhi1"; subject = "b.Mon1"; break;
                case 3: column = "b.LePhi2"; subject = "b.Mon2"; break;
                case 4: column = "b.LePhiDCNCS"; subject = "'Mon04'"; break;
            }
            text = " Select distinct   a.mahs,a.mamt," + column +
                    " From DanhSachThi a,TuyenSinh b,HoSo c " +
                     " Where c.MaHS like b.MaTS+'%' and a.mahs ='" + hs + "'";
            text += " and a.mamt =" + subject;
            daMoney = new SqlDataAdapter(text, cnn);
            try { tbMoney.Clear(); }
            catch { }
            daMoney.Fill(tbMoney);
            if (tbMoney.Rows.Count == 0)
                return 0;
            column = column.Substring(2);
            money = Convert.ToInt32(tbMoney.Rows[0][column]);
            return money;
        }
        public int MoneyByDoc(string hs)
        {
            //   return 100;
            DataTable tbMoney = new DataTable();
            SqlDataAdapter daMoney = new SqlDataAdapter();

            string text = "Select mahs, CH From HoSo a Where mahs='" + hs + "'";
            if (cnn.State == ConnectionState.Closed) cnn.Open();
            daMoney = new SqlDataAdapter(text, cnn);
            daMoney.Fill(tbMoney);
            cnn.Close();
            if (tbMoney.Rows.Count == 0) return 0;
            int money;
            money = MoneyBySub(hs, 1);
            if (tbMoney.Rows[0]["CH"].ToString() == "True")
            {
                money += MoneyBySub(hs, 2);
                money += MoneyBySub(hs, 3);
            }
            else money += MoneyBySub(hs, 4);
            money += DocMoney(hs);
            cnn.Close();
            return money;
        }
        #endregion
    }
}
