using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using DotNetNuke.Entities.Modules;
using ConvertExcelSql;
using ADODB;
using System.Text;
using System.Data.OleDb;
using Excel = Microsoft.Office.Interop.Excel;
using System.Runtime.InteropServices;
using System.Reflection;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Collections.ObjectModel;
using System.Data.Sql;

public partial class DesktopModules_ExcelAndSQL_ExcelAndSQL : PortalModuleBase
{
    private SqlConnection conn;
    protected void Page_Load(object sender, EventArgs e)
    {
        IList<string> tables = ConvertExcelSql.ServerExplorer.GetTablesEx();
        foreach (string table in tables)
        {
            lsbTable.Items.Add(table);
        }
    }


    protected void btnExport_Click(object sender, EventArgs e)
    {
        conn = new SqlConnection(System.Configuration.ConfigurationManager.
            ConnectionStrings["SiteSqlServer"].ToString());
        conn.Open();
        DataSet ds = new DataSet();
        int[] indextable = lsbTable.GetSelectedIndices();
        SqlDataAdapter da;
        foreach (int i in indextable)
        {
            da = new SqlDataAdapter("Select * from " + lsbTable.Items[i].ToString(), conn);
            da.Fill(ds, lsbTable.Items[i].ToString());
        }
        string file = Server.MapPath("~\\exdb.xlsx");
        if (File.Exists(file)) File.Delete(file);
        ConvertExcelSql.ExcelManager.Create(file, ds);
        Response.Redirect("~\\exdb.xlsx");
        conn.Close();
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        try
        {
            FileInfo fi = new FileInfo(fileupload.FileName);

            if (fi.Extension.CompareTo(".xlsx") == 0)
            {
                string file = Server.MapPath("~\\" + fi.Name);
                fileupload.SaveAs(file);
                ConvertExcelSql.ConvertExcelSql.ConnectSql(".\\SQLEXPRESS", "|DataDirectory|QLSV.mdf", "", "", true);
                ConvertExcelSql.ConvertExcelSql.ImportExcelToSQL(file);
            }
        }
        catch { }
    }
}

namespace ConvertExcelSql
{
    public static class Commons
    {
        public static ADODB.DataTypeEnum TranslateType(Type columnType)
        {
            //Translates the Datatable column types to Recordset column types
            switch (columnType.UnderlyingSystemType.ToString())
            {
                case "System.Boolean":
                    return ADODB.DataTypeEnum.adBoolean;
                case "System.Byte":
                    return ADODB.DataTypeEnum.adUnsignedTinyInt;
                case "System.Char":
                    return ADODB.DataTypeEnum.adChar;
                case "System.DateTime":
                    return ADODB.DataTypeEnum.adDate;
                case "System.Decimal":
                    return ADODB.DataTypeEnum.adCurrency;
                case "System.Double":
                    return ADODB.DataTypeEnum.adDouble;
                case "System.Int16":
                    return ADODB.DataTypeEnum.adSmallInt;
                case "System.Int32":
                    return ADODB.DataTypeEnum.adInteger;
                case "System.Int64":
                    return ADODB.DataTypeEnum.adBigInt;
                case "System.SByte":
                    return ADODB.DataTypeEnum.adTinyInt;
                case "System.Single":
                    return ADODB.DataTypeEnum.adSingle;
                case "System.UInt16":
                    return ADODB.DataTypeEnum.adUnsignedSmallInt;
                case "System.UInt32":
                    return ADODB.DataTypeEnum.adUnsignedInt;
                case "System.UInt64":
                    return ADODB.DataTypeEnum.adUnsignedBigInt;
                case "System.String":
                    return ADODB.DataTypeEnum.adVarChar;
                default:
                    return ADODB.DataTypeEnum.adVarChar;
            }
            //ADODB.DataTypeEnum.adWChar
        }
        public static bool IsUnicode(string s)
        {
            foreach (char c in s)
            {
                if (c >= 128)
                    return true;
            }
            return false;
        }
    }

    public static class ExcelManager
    {
        public static DataTable getExcelTable(string sheetName, string fileName)
        {
            OleDbConnection dbConnection = null;
            try
            {
                dbConnection = new OleDbConnection();
                dbConnection.ConnectionString = "provider = Microsoft.ACE.OLEDB.12.0;data source=" + fileName + ";Extended Properties=\"Excel 12.0 Xml;HDR=YES\";";
                dbConnection.Open();
                StringBuilder stbQuery = new StringBuilder();
                stbQuery.Append("SELECT * FROM [" + sheetName + "$]");
                OleDbDataAdapter adp = new OleDbDataAdapter(stbQuery.ToString(), dbConnection);
                DataTable dsXLS = new DataTable();
                adp.Fill(dsXLS);
                dbConnection.Close();
                return dsXLS;
            }
            catch
            {
                return null;
            }
            finally
            {
                // Clean up.
                if (dbConnection != null)
                {
                    dbConnection.Close();
                }
            }
        }
        public static string[] getSheetNames(string fileName)
        {
            OleDbConnection dbConnection = new OleDbConnection();
            dbConnection.ConnectionString = "provider=Microsoft.ACE.OLEDB.12.0;data source=" + fileName + ";Extended Properties=\"Excel 12.0 Xml;HDR=YES\";";
            System.Data.DataTable dt = null;

            try
            {
                // Connection String. Change the excel file to the file you

                // will search.

                dbConnection.Open();
                // Get the data table containg the schema guid.

                dt = dbConnection.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);

                if (dt == null)
                {
                    return null;
                }

                String[] excelSheets = new String[dt.Rows.Count];
                int i = 0;

                // Add the sheet name to the string array.

                foreach (DataRow row in dt.Rows)
                {
                    excelSheets[i] = row["TABLE_NAME"].ToString().Replace("$", "");
                    i++;
                }

                // Loop through all of the sheets if you want too...

                for (int j = 0; j < excelSheets.Length; j++)
                {
                    // Query each excel sheet.

                }

                return excelSheets;
            }
            catch (Exception ex)
            {
                return null;
            }
            finally
            {
                // Clean up.

                if (dbConnection != null)
                {
                    dbConnection.Close();
                }
                if (dt != null)
                {
                    dt.Dispose();
                }
            }

        }

        public static string Create(string sFile, DataSet dsDataset)
        {
            string sResult = "";
            DataTable dtTable;

            //'Create Excel Application, Workbook, and WorkSheets
            Excel.Application xlExcel = new Excel.Application();
            Excel.Workbooks xlBooks;
            Excel.Workbook xlBook;
            Excel.Worksheet tblSheet;
            Excel.Range xlCells;

            xlExcel.Visible = false;
            xlExcel.DisplayAlerts = false;
            xlBooks = xlExcel.Workbooks;
            xlBook = xlBooks.Add(Missing.Value);

            try
            {
                for (int i = 0; i < dsDataset.Tables.Count; i++)
                {
                    dtTable = dsDataset.Tables[i];
                    tblSheet = (Excel.Worksheet)xlBook.Worksheets.Add(Missing.Value, Missing.Value, Missing.Value, Missing.Value);
                    tblSheet.Name = dtTable.TableName;
                    xlCells = tblSheet.Cells;
                    for (int iCol = 0; iCol < dtTable.Columns.Count; iCol++)
                    {
                        xlCells[1, iCol + 1] = dtTable.Columns[iCol].ColumnName;
                        ((Excel.Range)xlCells[1]).EntireRow.Font.Bold = true;
                    }
                    if (dsDataset.Tables[i].Rows.Count > 0)
                    {
                        tblSheet.Range["A2"].CopyFromRecordset(ConvertToRecordset(dtTable));
                    }
                    xlCells.Columns.AutoFit();
                }
                sResult = "OK";
            }
            catch (Exception ex)
            {
                sResult = ex.Message;
            }
            //'Remove initial excel sheets. Within a try catch because the database could be empty 
            //'(a workbook without worksheets is not allowed)
            try
            {
                int SheetCount = xlExcel.Sheets.Count;
                ((Excel.Worksheet)xlExcel.Sheets[SheetCount - 0]).Delete();
                ((Excel.Worksheet)xlExcel.Sheets[SheetCount - 1]).Delete();
                ((Excel.Worksheet)xlExcel.Sheets[SheetCount - 2]).Delete();
            }
            catch { }


            //'Save the excel file
            xlBook.SaveAs(sFile);

            //'Make sure all objects are disposed
            xlBook.Close();
            xlExcel.Quit();
            //Marshal.ReleaseComObject(xlCells);
            //Marshal.ReleaseComObject(tblSheet);
            Marshal.ReleaseComObject(xlBook);
            Marshal.ReleaseComObject(xlBooks);
            Marshal.ReleaseComObject(xlExcel);

            xlExcel = null;
            xlBooks = null;
            xlBook = null;
            tblSheet = null;
            xlCells = null;
            //'Let Garbage Collector know it can do it's cleanup
            GC.Collect();
            return sResult;
        }
        private static ADODB.Recordset ConvertToRecordset(DataTable inTable)
        {
            //'Converts a DataTable to a Recordset
            ADODB.Recordset result = new ADODB.Recordset();
            result.CursorLocation = ADODB.CursorLocationEnum.adUseClient;
            ADODB.Fields resultFields = result.Fields;
            DataColumnCollection inColumns = inTable.Columns;
            for (int columnIndex = 0; columnIndex < inColumns.Count; columnIndex++)
            {
                if (Commons.IsUnicode(inTable.Rows[0][columnIndex].ToString()))
                {
                    resultFields.Append(inColumns[columnIndex].ColumnName, ADODB.DataTypeEnum.adWChar, inColumns[columnIndex].MaxLength, (inColumns[columnIndex].AllowDBNull ? ADODB.FieldAttributeEnum.adFldIsNullable : ADODB.FieldAttributeEnum.adFldUnspecified), null);
                }
                else resultFields.Append(inColumns[columnIndex].ColumnName, Commons.TranslateType(inColumns[columnIndex].DataType), inColumns[columnIndex].MaxLength, (inColumns[columnIndex].AllowDBNull ? ADODB.FieldAttributeEnum.adFldIsNullable : ADODB.FieldAttributeEnum.adFldUnspecified), null);
            }
            //foreach (DataColumn inColumn in inColumns)
            //{
            //    resultFields.Append(inColumn.ColumnName, Commons.TranslateType(inColumn.DataType), inColumn.MaxLength, (inColumn.AllowDBNull?ADODB.FieldAttributeEnum.adFldIsNullable:ADODB.FieldAttributeEnum.adFldUnspecified), null);
            //}
            result.Open(System.Reflection.Missing.Value, System.Reflection.Missing.Value, ADODB.CursorTypeEnum.adOpenStatic, ADODB.LockTypeEnum.adLockOptimistic, 0);
            foreach (DataRow dr in inTable.Rows)
            {
                result.AddNew(System.Reflection.Missing.Value, System.Reflection.Missing.Value);
                for (int columnIndex = 0; columnIndex < inColumns.Count; columnIndex++)
                {
                    resultFields[columnIndex].Value = dr[columnIndex];
                }
            }
            return result;
        }
    }

    public class ConvertExcelSql
    {
        private static SqlConnection con;
        public static void ConnectSql(string serverName, string databaseName, string userName, string password, bool useIntegratedSecurity)
        {
            con = ServerExplorer.GetActiveConnection(serverName, databaseName, userName, password, useIntegratedSecurity);
        }
        public static void ExportExcelFromSQL(string excelFile)
        {
            con.Open();
            DataSet ds = new DataSet();
            //SqlDataAdapter da = new SqlDataAdapter();
            IList<string> lstTables = ServerExplorer.GetTables("", con.Database, "", "", true);
            foreach (string table in lstTables)
            {
                SqlDataAdapter da = new SqlDataAdapter("select * from " + table, con);
                da.Fill(ds, table);
            }
            ExcelManager.Create(excelFile, ds);
            con.Close();
        }
        public static void ExportExcelFromSQL(string[] tables, string excelFile)
        {
            con.Open();
            DataSet ds = new DataSet();
            //SqlDataAdapter da = new SqlDataAdapter();
            //IList<string> lstTables = ServerExplorer.GetTables("", con.Database, "", "", true);
            foreach (string table in tables)
            {
                SqlDataAdapter da = new SqlDataAdapter("select * from " + table, con);
                da.Fill(ds, table);
            }
            ExcelManager.Create(excelFile, ds);
            con.Close();
        }
        public static void ImportExcelToSQL(string excelFile)
        {
            string[] sheets = ExcelManager.getSheetNames(excelFile);
            foreach (string sheetName in sheets)
            {
                ImportExcelToSQL(sheetName, excelFile);
            }
        }
        public static void ImportExcelToSQL(string sheetName, string excelFile)
        {
            DataTable dtExcel = ExcelManager.getExcelTable(sheetName, excelFile);
            List<string> lstColumnNames = new List<string>();
            for (int i = 0; i < dtExcel.Columns.Count; i++)
                lstColumnNames.Add(dtExcel.Columns[i].ColumnName);
            object tmp;
            List<string> lstRemove = new List<string>();
            for (int i = 0; i < dtExcel.Rows.Count; i++)
            {
                string strValue = "";

                for (int j = 0; j < lstColumnNames.Count; j++)
                {
                    if (Commons.IsUnicode(dtExcel.Rows[i][lstColumnNames[j]].ToString()))
                    {
                        tmp = "N'" + dtExcel.Rows[i][lstColumnNames[j]] + "',";
                    }
                    else
                    {
                        tmp = "'" + dtExcel.Rows[i][lstColumnNames[j]] + "',";
                        if (dtExcel.Rows[i][lstColumnNames[j]].ToString().CompareTo("") == 0)
                        {
                            lstRemove.Add(lstColumnNames[j]);
                            tmp = "";
                        }
                    }

                    strValue += tmp;
                    // loi unicode
                    strValue = strValue.Replace(" ْ", "");
                    strValue = strValue.Replace('*', ' ');
                }

                // xoa cac cot khong co du lieu
                foreach (string remove in lstRemove)
                {
                    lstColumnNames.Remove(remove);
                }

                // gan chuoi strColumnName
                string strColumnName = "";
                for (int k = 0; k < lstColumnNames.Count; k++)
                {
                    strColumnName += lstColumnNames[k] + ",";
                }
                strColumnName = strColumnName.Remove(strColumnName.Length - 1);


                strValue = strValue.Remove(strValue.Length - 1);
                string strCommand = "insert into " + sheetName + "(" + strColumnName + ") values(" + strValue + ")";
                con.Open();
                SqlCommand cmd = new SqlCommand(strCommand, con);
                try
                {
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException err)
                {
                }
                con.Close();
            }
            if (dtExcel != null)
                dtExcel.Dispose();
        }
        public static SqlConnection getSqlConnection()
        {
            return con;
        }

    }

    public class ServerExplorer
    {
        public static IList<string> GetActiveServers()
        {

            Collection<string> result = new Collection<string>();

            SqlDataSourceEnumerator instanceEnumerator = SqlDataSourceEnumerator.Instance;

            DataTable instancesTable = instanceEnumerator.GetDataSources();

            foreach (DataRow row in instancesTable.Rows)
            {

                if (!string.IsNullOrEmpty(row["InstanceName"].ToString()))

                    result.Add(string.Format(@"{0}\{1}", row["ServerName"], row["InstanceName"]));

                else

                    result.Add(row["ServerName"].ToString());

            }

            return result;

        }
        public static IList<string> GetDatabases(string serverName, string userId, string password, bool windowsAuthentication)
        {

            Collection<string> result = new Collection<string>();

            using (

                SqlConnection connection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SiteSqlServer"].ToString()))
            {

                connection.Open();

                DataTable dt = connection.GetSchema(SqlClientMetaDataCollectionNames.Databases);

                foreach (DataRow row in dt.Rows)
                {

                    result.Add(string.Format("{0}", row[0]));

                }

            }

            return result;

        }

        /// <summary>
        /// Lấy connection
        /// </summary>
        /// <param name="serverName"></param>
        /// <param name="databaseName"></param>
        /// <param name="userName"></param>
        /// <param name="password"></param>
        /// <param name="useIntegratedSecurity"></param>
        /// <returns></returns>
        public static SqlConnection GetActiveConnection(string databaseName)
        {
            return new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SiteSqlServer"].ToString());
        }

        public static SqlConnection GetActiveConnection(string serverName, string databaseName, string userName, string password, bool useIntegratedSecurity)
        {

            SqlConnectionStringBuilder connBuilder = new SqlConnectionStringBuilder();

            connBuilder.DataSource = serverName;
            connBuilder.AttachDBFilename = databaseName;
            connBuilder.IntegratedSecurity = useIntegratedSecurity;
            connBuilder.UserInstance = true;

            if (useIntegratedSecurity)
            {
                connBuilder.UserID = userName;
                connBuilder.Password = password;
            }

            return new SqlConnection(connBuilder.ConnectionString);
        }

        /// <summary>
        /// Lấy table
        /// </summary>
        /// <param name="serverName"></param>
        /// <param name="databaseName"></param>
        /// <param name="userId"></param>
        /// <param name="password"></param>
        /// <param name="windowsAuthentication"></param>
        /// <returns></returns>
        public static IList<string> GetTables(string serverName, string databaseName, string userId, string password, bool windowsAuthentication)
        {

            string[] restrictions = new string[4];

            restrictions[0] = databaseName; // database/catalog name   

            restrictions[1] = "dbo"; // owner/schema name   

            restrictions[2] = null; // table name   

            restrictions[3] = "BASE TABLE"; // table type    

            Collection<string> result = new Collection<string>();

            using (

                SqlConnection connection =

                    GetActiveConnection(serverName, databaseName, userId, password, windowsAuthentication))
            {

                connection.Open();

                DataTable dt = connection.GetSchema(SqlClientMetaDataCollectionNames.Tables, restrictions);

                foreach (DataRow row in dt.Rows)
                {

                    if (!row[2].ToString().StartsWith("sys"))

                        result.Add(string.Format(@"{0}", row[2]));

                }

            }

            return result;
        }

        public static IList<string> GetTablesEx()
        {

            string[] restrictions = new string[4];

            restrictions[1] = "dbo"; // owner/schema name   

            restrictions[2] = null; // table name   

            restrictions[3] = "BASE TABLE"; // table type    

            Collection<string> result = new Collection<string>();

            using (

                SqlConnection connection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SiteSqlServer"].ToString()))
            {

                connection.Open();

                restrictions[0] = connection.Database;

                DataTable dt = connection.GetSchema(SqlClientMetaDataCollectionNames.Tables, restrictions);

                foreach (DataRow row in dt.Rows)
                {

                    if (!row[2].ToString().StartsWith("sys"))

                        result.Add(string.Format(@"{0}", row[2]));

                }

            }

            return result;

        }

        /// <summary>
        /// Lấy số cột
        /// </summary>
        /// <param name="serverName"></param>
        /// <param name="databaseName"></param>
        /// <param name="userId"></param>
        /// <param name="password"></param>
        /// <param name="windowsAuthentication"></param>
        /// <param name="tableName"></param>
        /// <returns></returns>
        public static IList<string> GetColumns(string serverName, string databaseName, string userId, string password, bool windowsAuthentication, string tableName)
        {

            SqlConnection connection =
                new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SiteSqlServer"].ToString());

            string[] restrictions = new string[3];

            restrictions[0] = connection.Database; // database/catalog name      

            restrictions[1] = "dbo"; // owner/schema name      

            restrictions[2] = tableName; // table name      

            IList<string> result = new Collection<string>();

            using (connection)
            {

                connection.Open();

                DataTable columns = connection.GetSchema(SqlClientMetaDataCollectionNames.Columns, restrictions);

                foreach (DataRow row in columns.Rows)
                {

                    string columnName = row[3].ToString();

                    string columnDataType = row[7].ToString();

                    if (columnDataType.IndexOf("char") > -1)
                    {

                        // row[8] - CHARACTER_MAXIMUM_LENGTH    

                        columnDataType = string.Format("{0}({1})", columnDataType, row[8]);

                    }

                    if (columnDataType.IndexOf("decimal") > -1)
                    {

                        // row[10] - CHARACTER_OCTET_LENGTH    

                        // row[11] - NUMERIC_PRECISION    

                        columnDataType = string.Format("{0}({1},{2})", columnDataType, row[10], row[11]);

                    }

                    result.Add(string.Format("{0},{1}", columnName, columnDataType));

                }

                return result;

            }

        }
        public static IList<string> GetIndexes(SqlConnection connection, string tableName)
        {

            string[] restrictions = new string[3];

            restrictions[0] = connection.Database; // database/catalog name      

            restrictions[1] = "dbo"; // owner/schema name      

            restrictions[2] = tableName; // table name      

            IList<string> result = new Collection<string>();

            using (connection)
            {

                connection.Open();

                DataTable columns = connection.GetSchema(SqlClientMetaDataCollectionNames.IndexColumns, restrictions);

                foreach (DataRow row in columns.Rows)
                {

                    string columnName = row["column_name"].ToString();

                    string indexName = row["index_name"].ToString();

                    bool isPrimaryKey = row["constraint_name"].ToString().StartsWith("PK");

                    result.Add(string.Format("Index:{0}, on column:{1}, PK:{2}", indexName, columnName, isPrimaryKey));

                }

                return result;

            }

        }
        public static SqlParameter[] DiscoverStoredProcedureParameters(SqlConnection sqlConnection, string storedProcedureName)
        {

            SqlCommand cmd = new SqlCommand(storedProcedureName, sqlConnection);

            cmd.CommandType = CommandType.StoredProcedure;

            using (sqlConnection)
            {

                sqlConnection.Open();

                SqlCommandBuilder.DeriveParameters(cmd);

            }

            SqlParameter[] discoveredParameters = new SqlParameter[cmd.Parameters.Count];

            cmd.Parameters.CopyTo(discoveredParameters, 0);

            return discoveredParameters;

        }
    }

}
