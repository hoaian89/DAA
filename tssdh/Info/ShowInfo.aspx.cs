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
namespace Show_Info
{
    public class DB
    {
        public static String ConnectionString = ConfigurationManager.ConnectionStrings["SiteSqlServer1"].ConnectionString;
        public static SqlConnection DBConnection = new SqlConnection(ConnectionString);
        public static SqlCommand CreateCommand(String sql,String HoTen,String SBD)
        {
            SqlCommand cmd = new SqlCommand(sql,DB.DBConnection );
            cmd.Parameters.Add("@HoTen", SqlDbType.NVarChar).Value = HoTen.Trim();
            cmd.Parameters.Add("SoBD", SqlDbType.NVarChar).Value = SBD.Trim();
            return cmd;
        }
    }
    public partial class ShowInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                DB.DBConnection.Open();
                string sql = "Select MAX(TG_KetThuc) from TUYENSINH";
                SqlCommand cmd = new SqlCommand(sql, DB.DBConnection);
                DateTime TG_KetThuc = Convert.ToDateTime(cmd.ExecuteScalar());
                sql = "Select Count(MaHS) from HOSO where SBD IS NULL";
                cmd = new SqlCommand(sql, DB.DBConnection);
                int num_SBD = Convert.ToInt32(cmd.ExecuteScalar());
                DB.DBConnection.Close();
                if (DateTime.Now.Date < TG_KetThuc || num_SBD >= 1)
                {
                    Response.Redirect("Error.aspx");
                }
            }
            catch
            {
                Response.Redirect("Error.aspx");
            }
        }
        void InsertAV(String SBD,ref DataTable tb)
        {
            try
            {
                string sql = "select D.tennn+' '+ISNULL(Convert(varchar(50),C.Diem,13),' ') AS CC  from hoso A,syll B,llnn C,NgoaiNgu D" +
" where C.mann=D.mann and A.mahs=C.mahs and A.mahs=B.mahs" +
" and A.SBD like'"+SBD.Trim()+"%'";
                SqlCommand cmd = new SqlCommand(sql, DB.DBConnection);
                string t=(string)cmd.ExecuteScalar();
                tb.Rows[0]["AV"] = t.Trim();
            }
            catch
            {

            }
        }
        protected void XemThongTin_Click(object sender, EventArgs e)
        {
            try
            {
                string sql = @"Select Ho,HS.CH,ChinhSach
                           From HOSO HS,TUYENSINH TS,SYLL,CUMTHI CT,PHONGTHI PT
                           Where HS.MaHS = SYLL.MaHS AND HS.MaTS = TS.MaTS AND HS.MaCT = CT.MaCT AND HS.MaPT = PT.MaPT AND @HoTen LIKE Ho+' '+Ten AND HS.SBD = @SoBD";
                DB.DBConnection.Open();
                SqlCommand cmd = DB.CreateCommand(sql, HoTen.Text, SoBaoDanh.Text);
                SqlDataReader reader = cmd.ExecuteReader();
                DataTable tb = new DataTable();
                DataTable tb1 = new DataTable();
                if (reader.Read())
                {
                    
                    if (reader.GetBoolean(1))
                    {
                        sql = @"Select Ho+' '+Ten as HoTen,convert(varchar(50),NgaySinh,103) as NgaySinh,NoiSinh,NganhTuyenSinh,case HS.CH when 1 then N'Cao Học' else N'Nghiên Cứu Sinh' end as CaoHoc,KhoaCH as Khoa,TenCT,HS.MaPT as MPT,DiaChi,SBD";
                           
                    }
                    else
                    {
                        sql = @"Select Ho+' '+Ten as HoTen,convert(varchar(50),NgaySinh,103) as NgaySinh,NoiSinh,NganhTuyenSinh,case HS.CH when 1 then N'Cao Học' else N'Nghiên Cứu Sinh' end as CaoHoc,KhoaNCS as Khoa,TenCT,HS.MaPT as MPT,DiaChi,SBD";
                    }
                    if (reader.GetValue(2) == DBNull.Value )
                    {
                        sql = sql + ",N'Không' as CS,'' AS AV " + @" From HOSO HS,TUYENSINH TS,SYLL,CUMTHI CT,PHONGTHI PT
                           Where HS.MaHS = SYLL.MaHS AND HS.MaTS = TS.MaTS AND HS.MaCT = CT.MaCT AND HS.MaPT = PT.MaPT AND @HoTen LIKE Ho+' '+Ten AND HS.SBD = @SoBD";
                    }
                    else
                    {
                        sql = sql + ",TenUT as CS,''As AV "+@" From HOSO HS,TUYENSINH TS,SYLL,CUMTHI CT,PHONGTHI PT,UUTIEN UT
                           Where HS.MaHS = SYLL.MaHS AND HS.MaTS = TS.MaTS AND HS.MaCT = CT.MaCT AND HS.MaPT = PT.MaPT AND @HoTen LIKE Ho+' '+Ten AND HS.SBD = @SoBD AND UT.MaUT = SYLL.ChinhSach";
                    }
                    reader.Close();
                    cmd = DB.CreateCommand(sql, HoTen.Text, SoBaoDanh.Text);
                    new SqlDataAdapter(cmd).Fill(tb1);
                    DetailsView_ThongTinTS.DataSource = tb1;
                    DetailsView_ThongTinTS.DataBind();
                    lblTTTS.Visible = true;
                    DetailsView_ThongTinTS.Visible = true;
                    bool CH = true;
                    if (tb1.Rows[0]["CaoHoc"].ToString() == "Nghiên Cứu Sinh")
                    {
                        CH = false;
                    }
                    
                    //Bảng điểm
                    sql = @"Select TenMT,case Vang when 1 then N'X' else ' ' end as Vang,KyLuat,Diem,ChinhSach
                           From HOSO HS,MONTHI MT,DANHSACHTHI DST,SYLL,TUYENSINH TS
                           Where HS.MaTS = TS.MaTS AND HS.MaHS = SYLL.MaHS AND HS.MaHS = DST.MaHS AND DST.MaMT = MT.MaMT AND @HoTen LIKE Ho+' '+Ten AND HS.SBD = @SoBD";
                    cmd = DB.CreateCommand(sql, HoTen.Text, SoBaoDanh.Text);
                    tb.Clear();
                    new SqlDataAdapter(cmd).Fill(tb);
                    if (CH)
                    {
                        if (tb.Rows.Count == 3)
                        {
                            DetailsView_ThongTinTS.Rows[11].Visible = false;
                        }
                        else
                        {
                            InsertAV(SoBaoDanh.Text,ref tb1);
                            DetailsView_ThongTinTS.DataSource = tb1;
                            DetailsView_ThongTinTS.DataBind();
                            DetailsView_ThongTinTS.Rows[11].Visible = true;
                        }
                    }
                    else
                    {
                        if (tb.Rows.Count == 2)
                        {
                            DetailsView_ThongTinTS.Rows[11].Visible = false;
                        }
                        else
                        {
                            InsertAV(SoBaoDanh.Text, ref tb1);
                            DetailsView_ThongTinTS.DataSource = tb1;
                            DetailsView_ThongTinTS.DataBind();
                            DetailsView_ThongTinTS.Rows[11].Visible = true;
                        }
                    }
                    
                    
                    lblKQT.Visible = false;
                    Grid_BangDiem.Visible = false;
                    for (int i = 0; i < tb.Rows.Count; i++)
                    {
                        if (tb.Rows[i]["Diem"].ToString() != "")
                        {
                            Grid_BangDiem.DataSource = tb;
                            Grid_BangDiem.DataBind();
                            lblKQT.Visible = true;
                            Grid_BangDiem.Visible = true;
                            break;
                        }
                    }
                    //Phúc khảo
                    sql = @"Select TenMT,PK.Diem1,PK.Diem2,GhiChu
                           From HOSO HS,MONTHI MT,SYLL,PHUCKHAO PK,TUYENSINH TS
                           Where HS.MaTS = TS.MaTS AND HS.MaHS = SYLL.MaHS AND HS.MaHS = PK.MaHS AND PK.MaMT = MT.MaMT AND @HoTen LIKE Ho+' '+Ten AND HS.SBD = @SoBD";
                    cmd = DB.CreateCommand(sql, HoTen.Text, SoBaoDanh.Text);
                    tb.Clear();
                    new SqlDataAdapter(cmd).Fill(tb);
                    lblKQPK.Visible = false;
                    Grid_PhucKhao.Visible = false;
                    if (tb.Rows.Count != 0)
                    {
                        lblKQPK.Visible = true;
                        Grid_PhucKhao.Visible = true;
                        Grid_PhucKhao.DataSource = tb;
                        Grid_PhucKhao.DataBind();
                    }
                    DB.DBConnection.Close();
                }
                else
                {
                    DB.DBConnection.Close();
                    Response.Redirect("Error.aspx");
                } 
            }
            catch
            {
                Response.Redirect("Error.aspx");
            }
        }
    }
}
