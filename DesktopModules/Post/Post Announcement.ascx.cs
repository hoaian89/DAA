using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Reflection;
using System.Text;

public partial class DesktopModules_Post_Announcement_Post_Announcement : PortalModuleBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AnnounmentList.SelectParameters["ModuleID"].DefaultValue = (string)Settings["template"];
        if (!IsPostBack)
        {
            if (DotNetNuke.Framework.AJAX.IsInstalled())
                DotNetNuke.Framework.AJAX.RegisterScriptManager();
            StartDate.Text = DateTime.Now.ToShortDateString();
            EnDate.Text = DateTime.Now.AddDays(14).ToShortDateString();
        }
        if (DropDownList1.Items.Count == 0)
            DropDownList1.DataBind();
        Suslabel.Text = "";
    }

    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (RadioButtonList1.SelectedValue.Equals("1"))
            DropDownList1.Visible = DelButton.Visible = false;
        else DropDownList1.Visible = DelButton.Visible = true;
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Title.Text = DropDownList1.SelectedItem.ToString();

        using (SqlConnection scon = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SiteSqlServer"].ToString()))
        {
            scon.Open();
            try
            {
                using (SqlCommand scom = new SqlCommand("select PublishDate,ExpireDate,Content,Description,Target from Announcements where ITemID = @ItemID", scon))
                {
                    scom.Parameters.Add("@ItemID", DropDownList1.SelectedValue);
                    SqlDataReader sreader = scom.ExecuteReader();
                    sreader.Read();
                    StartDate.Text = DateTime.Parse(sreader.GetValue(0).ToString()).ToShortDateString();
                    EnDate.Text = sreader.GetValue(1).ToString().Equals("") ? DateTime.Parse(StartDate.Text).AddDays(14).ToShortDateString() :
                        DateTime.Parse(sreader.GetValue(1).ToString()).ToShortDateString();
                    teContent.Text = Server.HtmlDecode(sreader.GetValue(2).ToString());
                    description.Text = Server.HtmlDecode(sreader.GetValue(3).ToString());

                    TargetDrop.SelectedValue = sreader.GetValue(4).ToString();
                    sreader.Close();
                }

                using (SqlCommand scom1 = new SqlCommand("select fileName from AttachedFiles where ID = @ItemID", scon))
                {
                    //  get infos about files 
                    scom1.Parameters.Add("@ItemID", DropDownList1.SelectedValue);
                    SqlDataReader sreader1 = scom1.ExecuteReader();
                    MyObjects.clearAll();

                    while (sreader1.Read())
                    {
                        MyObjects.addRow(sreader1.GetValue(0).ToString());
                    }
                    myNewRowGridView.DataBind();
                }
            }
            catch (Exception ex) { Suslabel.Text = ex.Message; }
        }
    }

    string getDescription()
    {
        using (SqlConnection scon = new SqlConnection
        (System.Configuration.ConfigurationManager.ConnectionStrings["SiteSqlServer"].ToString()))
        {
            scon.Open();
            try
            {
                using (SqlCommand scom = new SqlCommand
                ("select Description from Announcements where ItemID = @ItemID", scon))
                {
                    scom.Parameters.Add(new SqlParameter("@ItemID", DropDownList1.SelectedValue));
                    return (String)scom.ExecuteScalar();
                }
            }
            catch (Exception ex) { return "Dữ liệu không tồn tại !"; }
        }
    }

    int InsertTable()
    {
        if (Title.Text == "") { Suslabel.Text = "Chưa điền tựa đề !"; return -1; }
        else if (description.Text == "") { Suslabel.Text = "Thiếu mô tả !"; return -1; }
        else if (teContent.Text == "") { Suslabel.Text = "Thiếu nội dung!"; return -1; }

        using (SqlConnection scon = new SqlConnection
        (System.Configuration.ConfigurationManager.ConnectionStrings["SiteSqlServer"].ToString()))
        {
            scon.Open();
            try
            {
                using (SqlCommand scom = new SqlCommand
                ("Set Identity_Insert Announcements ON", scon))
                {
                    scom.ExecuteNonQuery();
                    scom.CommandText = "Select ItemID from Announcements order by ItemID ";
                    SqlDataReader sreader = scom.ExecuteReader();
                    int ItemID = 0;
                    while (sreader.Read())
                    {
                        if (((int)sreader.GetValue(0)) == ItemID)
                            ItemID++;
                        else { break; }
                    }
                    sreader.Close();
                    scom.CommandText = "insert into Announcements(ItemID,ModuleID,CreatedDate,Title,Description,Content," +
                    "PublishDate,ExpireDate,CreatedByUser,Target) values(@ItemID,@ModuleID,getdate(),@Title,@Description,@Content,getdate(),@ExpireDate,1,@Target)";
                    scom.Parameters.Add(new SqlParameter("@ItemID", ItemID));
                    scom.Parameters.Add(new SqlParameter("@ModuleID", (string)Settings["template"]));
                    scom.Parameters.Add(new SqlParameter("@Title", Title.Text));
                    scom.Parameters.Add(new SqlParameter("@Description", description.Text));
                    scom.Parameters.Add(new SqlParameter("@Content", teContent.Text));
                    scom.Parameters.Add(new SqlParameter("@Target", TargetDrop.SelectedValue));
                    try { scom.Parameters.Add(new SqlParameter("@PublishDate", DateTime.Parse(StartDate.Text))); }
                    catch (Exception ex) { scom.Parameters.Add(new SqlParameter("@PublishDate", DateTime.Now.ToShortDateString())); }
                    try { scom.Parameters.Add(new SqlParameter("@ExpireDate", DateTime.Parse(EnDate.Text))); }
                    catch (Exception ex) { scom.Parameters.Add(new SqlParameter("@ExpireDate", DateTime.Parse(StartDate.Text).AddDays(14).ToShortDateString())); }
                    scom.ExecuteNonQuery();

                    //  save files to database
                    scom.CommandText = "Insert into AttachedFiles values(@ItemID,getdate(),@fileName)";
                    scom.Parameters.Add("@fileName", "");

                    foreach (GridViewRow changedRow in this.myNewRowGridView.Rows)
                    {
                        TextBox txtName = (TextBox)changedRow.Cells[1].FindControl("TextBox1");
                        CheckBox cbIsManager = (CheckBox)changedRow.FindControl("check");

                        if (cbIsManager.Checked)
                        {

                            scom.Parameters["@fileName"].Value = txtName.Text;
                            scom.ExecuteNonQuery();

                        }
                    }

                    Suslabel.Text = "Thành công!";
                    return DropDownList1.Items.Count;
                }
            }
            catch (Exception ex) { Suslabel.Text = ex.Message; return -1; }
        }
    }

    int UpdateTable()
    {
        using (SqlConnection scon = new SqlConnection
        (System.Configuration.ConfigurationManager.ConnectionStrings["SiteSqlServer"].ToString()))
        {
            scon.Open();
            try
            {
                using (SqlCommand scom = new SqlCommand
                ("Update Announcements set Title = @Title,Description = @Description ,PublishDate = @PublishDate " +
                ",ExpireDate = @ExpireDate , Content = @Content , Target = @Target where ItemID = @ItemID", scon))
                {
                    scom.Parameters.Add(new SqlParameter("@Title", Title.Text));
                    scom.Parameters.Add(new SqlParameter("@Description", description.Text));
                    scom.Parameters.Add(new SqlParameter("@Content", teContent.Text));
                    scom.Parameters.Add(new SqlParameter("@ItemID", DropDownList1.SelectedValue));
                    scom.Parameters.Add(new SqlParameter("@Target", TargetDrop.SelectedValue));
                    try { scom.Parameters.Add(new SqlParameter("@PublishDate", DateTime.Parse(StartDate.Text))); }
                    catch (Exception ex) { scom.Parameters.Add(new SqlParameter("@PublishDate", DateTime.Now.ToShortDateString())); }
                    try { scom.Parameters.Add(new SqlParameter("@ExpireDate", DateTime.Parse(EnDate.Text))); }
                    catch (Exception ex) { scom.Parameters.Add(new SqlParameter("@ExpireDate", DateTime.Parse(StartDate.Text).AddDays(14).ToShortDateString())); }
                    scom.ExecuteNonQuery();

                    //  del
                    scom.CommandText = "delete from AttachedFiles where ID = @ID";
                    scom.Parameters.AddWithValue("@ID", DropDownList1.SelectedValue);
                    scom.ExecuteNonQuery();

                    //  reInsert
                    scom.CommandText = "insert into AttachedFiles values(@ItemID,getdate(),@fileName)";
                    scom.Parameters.Add("@fileName", "");

                    foreach (GridViewRow changedRow in this.myNewRowGridView.Rows)
                    {
                        TextBox txtName = (TextBox)changedRow.Cells[1].FindControl("TextBox1");
                        CheckBox cbIsManager = (CheckBox)changedRow.FindControl("check");

                        if (cbIsManager.Checked)
                        {
                            try
                            {
                                scom.Parameters["@fileName"].Value = txtName.Text;
                                scom.ExecuteNonQuery();
                            }
                            catch (Exception ex) { }
                        }
                    }

                    Suslabel.Text = "Thành công!";
                    return DropDownList1.SelectedIndex;
                }
            }
            catch (Exception ex) { Suslabel.Text = "Có lỗi!"; return -1; }
        }
    }

    int DelTable()
    {
        using (SqlConnection scon = new SqlConnection
        (System.Configuration.ConfigurationManager.ConnectionStrings["SiteSqlServer"].ToString()))
        {
            scon.Open();
            try
            {
                using (SqlCommand scom = new SqlCommand
                ("Delete from Announcements where ItemID = @ItemID", scon))
                {
                    scom.Parameters.Add(new SqlParameter("@ItemID", DropDownList1.SelectedValue));
                    scom.ExecuteNonQuery();

                    scom.CommandText = "delete from AttachedFiles where ID = @ItemID";
                    scom.ExecuteNonQuery();

                    Suslabel.Text = "Đã xóa!";
                    return 1;
                }
            }
            catch (Exception ex) { Suslabel.Text = "Có lỗi!"; return -1; }
        }
    }

    void Save()
    {
        int Index = -1;
        if (RadioButtonList1.SelectedValue.Equals("1")) Index = InsertTable();
        else Index = UpdateTable();
        if (Index != -1)
        {
            DropDownList1.DataBind();
            DropDownList1.SelectedIndex = Index;
        }
    }

    protected void LinkButton1_Click(object sender, ImageClickEventArgs e)
    {
        Save();
    }

    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        Save();
    }

    protected void LinkButton3_Click(object sender, EventArgs e)
    {
        if (DelTable() != -1) DropDownList1.DataBind();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (FileUpload1.HasFile)
            FileUpload1.PostedFile.SaveAs(Server.MapPath("~\\Data\\UploadedFiles\\" + FileUpload1.FileName));
        MyObjects.addRow(FileUpload1.FileName);
        myNewRowGridView.DataBind();
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        MyObjects.clearAll();
        myNewRowGridView.DataBind();
    }

    private Control FindControl(Control control, Type type)
    {
        Control refCtr = null;
        this.FindControlByType(ref refCtr, control, type);
        return refCtr;
    }

    private void FindControlByType(ref Control refCtr, Control control, Type type)
    {
        if (refCtr == null)
        {
            foreach (Control ctr in control.Controls)
            {
                if (ctr.GetType().Equals(type))
                {
                    refCtr = ctr;
                }
                else if (ctr.HasControls())
                {
                    this.FindControlByType(ref refCtr, ctr, type);
                }
            }
        }
    }
}
