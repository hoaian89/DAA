using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;

namespace daa
{
    /// <summary>
    /// Summary description for Helper
    /// </summary>
    public static class Helper
    {
        /// <summary>
        /// Encodes a string to be represented as a string literal. The format
        /// is essentially a JSON string.
        /// 
        /// The string returned includes outer quotes 
        /// Example Output: "Hello \"Rick\"!\r\nRock on"
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        public static string EncodeJsString(string s)
        {
            var sb = new StringBuilder();
            sb.Append("\"");
            foreach (char c in s)
                if (c == '\"')
                    sb.Append("\\\"");
                else if (c == '\\')
                    sb.Append("\\\\");
                else if (c == '\b')
                    sb.Append("\\b");
                else if (c == '\f')
                    sb.Append("\\f");
                else if (c == '\n')
                    sb.Append("\\n");
                else if (c == '\r')
                    sb.Append("\\r");
                else if (c == '\t')
                    sb.Append("\\t");
                else
                {
                    int i = (int)c;
                    if (i < 32 || i > 127)
                        sb.AppendFormat("\\u{0:X04}", i);
                    else
                        sb.Append(c);
                }
            sb.Append("\"");

            return sb.ToString();
        }

        public static string GetValueName(object value)
        {
            return Helper.GetValueName(value, "{0}");
        }

        public static string GetValueName(object value, string format)
        {
            return Helper.GetValueName(value, format, "Chưa cập nhật");
        }

        public static string GetValueName(object value, string format, string defaultvalue)
        {
            if (value == null || string.IsNullOrEmpty(value.ToString()))
                return defaultvalue;
            else
                return string.Format(format, value);
        }

        public static string GetAYear(string code)
        {
            if (!string.IsNullOrEmpty(code) && code.Length == 4)
                return code.Insert(2, "-");
            else
                return GetValueName(code);
        }

        public static string GetGenderName(bool? code)
        {
            if (code == false)
                return "Nam";
            else if (code == true)
                return "Nữ";
            else
                return GetValueName(code);
        }

        public static string GetSPostName(string code)
        {
            if (string.Compare(code, "TS", true) == 0)
                return "Tiến sĩ";
            else if (string.Compare(code, "TSKH", true) == 0)
                return "Tiến sĩ khoa học";
            else if (string.Compare(code, "ThS", true) == 0)
                return "Thạc sĩ";
            else if (string.Compare(code, "NCS", true) == 0)
                return "Nghiên cứu sinh";
            else if (string.Compare(code, "CN", true) == 0)
                return "Cử nhân";
            else
                return GetValueName(code);
        }

        public static string GetAPostName(string code)
        {
            if (string.Compare(code, "NCV", true) == 0)
                return "Nghiên cứu viên";
            else if (string.Compare(code, "NCVC", true) == 0)
                return "Nghiên cứu viên chính";
            else if (string.Compare(code, "GS", true) == 0)
                return "Giáo sư";
            else if (string.Compare(code, "PGS", true) == 0)
                return "Phó giáo sư";
            else if (string.Compare(code, "GVC", true) == 0)
                return "Giảng viên chính";
            else if (string.Compare(code, "GV", true) == 0)
                return "Giảng viên";
            else if (string.Compare(code, "CV", true) == 0)
                return "Chuyên viên";
            else if (string.Compare(code, "GV", true) == 0)
                return "Chuyên viên chính";
            else
                return GetValueName(code);
        }

        public static string GetOPostName(string code)
        {
            if (string.Compare(code, "TP", true) == 0)
                return "Trưởng phòng";
            else if (string.Compare(code, "BTÐ", true) == 0)
                return "Bí thư Đoàn";
            else if (string.Compare(code, "GÐ", true) == 0)
                return "Giám đốc";
            else if (string.Compare(code, "HT", true) == 0)
                return "Hiệu trưởng";
            else if (string.Compare(code, "PBM", true) == 0)
                return "Phó bộ môn";
            else if (string.Compare(code, "PGÐ", true) == 0)
                return "Phó giám đốc";
            else if (string.Compare(code, "PHT", true) == 0)
                return "Phó hiệu trưởng";
            else if (string.Compare(code, "PTK", true) == 0)
                return "Phó trưởng khoa";
            else if (string.Compare(code, "PTP", true) == 0)
                return "Phó trưởng phòng";
            else if (string.Compare(code, "QGÐ", true) == 0)
                return "Quyền giám đốc";
            else if (string.Compare(code, "QTK", true) == 0)
                return "Quyền trưởng khoa";
            else if (string.Compare(code, "QTP", true) == 0)
                return "Quyền trưởng phòng";
            else if (string.Compare(code, "TBM", true) == 0)
                return "Trưởng bộ môn";
            else if (string.Compare(code, "TK", true) == 0)
                return "Thư kí";
            else if (string.Compare(code, "VPÐ", true) == 0)
                return "Văn phòng Đoàn";
            else
                return GetValueName(code);
        }

        public static string GetDeptName(string code)
        {
            if (string.Compare(code, "MIC", true) == 0)
                return "Trung tâm Sáng tạo Microsoft";
            else if (string.Compare(code, "CITD", true) == 0)
                return "Trung tâm Phát triển CNTT";
            else if (string.Compare(code, "AA", true) == 0)
                return "Phòng Đào tạo";
            else if (string.Compare(code, "CS", true) == 0)
                return "Khoa học máy tính";
            else if (string.Compare(code, "CE", true) == 0)
                return "Kỹ thuật máy tính";
            else if (string.Compare(code, "SE", true) == 0)
                return "Kỹ thuật phần mềm";
            else if (string.Compare(code, "NT", true) == 0)
                return "Mạng máy tính & Truyền thông";
            else if (string.Compare(code, "IS", true) == 0)
                return "Hệ thống thông tin";
            else if (string.Compare(code, "TB", true) == 0)
                return "Lớp Cử nhân tài năng";
            else if (string.Compare(code, "MP", true) == 0)
                return "Bộ môn Toán lý";
            else if (string.Compare(code, "PE", true) == 0)
                return "Bộ môn Giáo dục thể chất";
            else if (string.Compare(code, "ED", true) == 0)
                return "Bộ môn Anh văn";
            else if (string.Compare(code, "OE", true) == 0)
                return "Trung tâm Đào tạo trực tuyến";
            else if (string.Compare(code, "MG", true) == 0)
                return "Giảng viên thỉnh giảng";
            else if (string.Compare(code, "PI", true) == 0)
                return "Giảng viên tập sự";
            else
                return GetValueName(code);
        }

        public static string GetDegreeName(string code)
        {
            // Đ has 2 value in ASCII & Unicode
            if (string.Compare(code, "ĐH", true) == 0)
                return "Đại học";
            else if (string.Compare(code, "CH", true) == 0)
                return "Cao học";
            else if (string.Compare(code, "TS", true) == 0)
                return "Tiến sĩ";
            else
                return GetValueName(code);
        }

        public static string GetStatusName(string code)
        {
            if (string.Compare(code, "CQ", true) == 0)
                return "Chính qui";
            else if (string.Compare(code, "TX", true) == 0)
                return "Từ xa";
            else if (string.Compare(code, "TC", true) == 0)
                return "Tại chức";
            else
                return GetValueName(code);
        }
    }
}