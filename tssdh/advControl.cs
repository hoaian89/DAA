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
using System.Data.SqlTypes;

namespace webRegister
{
    public class advTextbox: TextBox
    {
        public Object Tag;
        public string strErr;

        public advTextbox()
        {
            Tag = null;            
        }
    }

    public class cArticle
    {
        public int strCode;
        public SqlString strName;
        public SqlString strField;
        public SqlString strMagazine;
        public SqlDateTime dtmDate;

        public cArticle(SqlString artName, SqlString artField, SqlString artMag, SqlDateTime artDate)
        {
            strName = artName;
            strField = artField;
            strMagazine = artMag;
            dtmDate = artDate;
        }
    }

    public class cResearchWork
    {
        public int strCode;
        public SqlString strName;
        public SqlString strField;
        public SqlString strRole;
        public SqlString strPlace;
        public SqlString strGuider;
        public SqlDateTime dtmDate;
        public bool bDraft;

        public cResearchWork(SqlString resName, SqlString resField, SqlString resRole, SqlString resPlace, SqlString resGuider, SqlDateTime resDate, bool draft)
        {
            strName = resName;
            strField = resField;
            strRole = resRole;
            strPlace = resPlace;
            strGuider = resGuider;
            dtmDate = resDate;
            bDraft = draft;
        }
    }

    public class cHistory
    {
        public int strCode;
        public SqlString strDate;
        public SqlString strWork;
        public SqlString strPlace;
        public SqlString strAchievement;

        public cHistory(SqlString hisDate, SqlString hisWork, SqlString hisPlace, SqlString hisAchie)
        {
            strDate = hisDate;
            strWork = hisWork;
            strPlace = hisPlace;
            strAchievement = hisAchie;
        }
    }

    public class cSchool
    {
        public int strCode;
        public SqlString strName;
        public bool DH;
        public SqlString strField;
        public SqlString strMethod;
        public SqlString strRank;
        public float fMark;
        public int iYearBegin;
        public int iYearEnd;

        public cSchool(int schCode, SqlString schName,bool DHcode, SqlString schField, SqlString schMethod,
            SqlString schRank, float schMark, int schYearBegin, int schYearEnd)
        {
            strCode = schCode;
            strName = schName;
            DH = DHcode;
            strField = schField;
            strMethod = schMethod;
            strRank = schRank;
            fMark = schMark;
            iYearBegin = schYearBegin;
            iYearEnd = schYearEnd;
        }
    }
}
