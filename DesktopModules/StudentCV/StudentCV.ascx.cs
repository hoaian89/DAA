using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Framework;
using System.Threading;
using System.Globalization;
using DotNetNuke.Services.Mail;
using DotNetNuke.Entities.Host;

namespace daa
{
    public partial class StudentCV : PortalModuleBase
    {
        protected void StudentDataSource_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
                StudentDataSource.SelectParameters["StuId"].DefaultValue = HttpContext.Current.User.Identity.Name;
        }

        protected void StudentData_CancelCommand(object source, DataListCommandEventArgs e)
        {
            StudentData.EditItemIndex = -1;
            StudentData.DataBind();
        }

        protected void StudentData_EditCommand(object source, DataListCommandEventArgs e)
        {
            StudentData.EditItemIndex = e.Item.ItemIndex;
            StudentData.DataBind();
        }

        protected void StudentData_UpdateCommand(object source, DataListCommandEventArgs e)
        {
            if (Page.IsValid)
                try
                {
                    StudentDataSource.UpdateParameters["StuId"].DefaultValue = HttpContext.Current.User.Identity.Name;
                    // Build update parametter from controls
                    StudentDataSource.UpdateParameters["Address"].DefaultValue = ((TextBox)e.Item.FindControl("txtAddress")).Text;
                    StudentDataSource.UpdateParameters["Phone"].DefaultValue = ((TextBox)e.Item.FindControl("txtPhone")).Text;
                    StudentDataSource.UpdateParameters["Email"].DefaultValue = ((TextBox)e.Item.FindControl("txtEmail")).Text;
                    StudentDataSource.UpdateParameters["Account"].DefaultValue = ((TextBox)e.Item.FindControl("txtAccount")).Text;
                    StudentDataSource.Update();

                    // Rebind to control
                    StudentData.EditItemIndex = -1;
                    StudentData.DataBind();

                    if (!string.IsNullOrEmpty(Settings["Email"] as string))
                        this.CompareAndSendInfo(e.Item);
                }
                catch (Exception ex)
                {
                    // Notice error to the user
                    ((Label)e.Item.FindControl("StudentFailureText")).Text = ex.Message;
                }
        }

        private void CompareAndSendInfo(DataListItem e)
        {
            var changes = new List<string>();
            // Detect changes and save to log
            // StuNm
            if (((TextBox)e.FindControl("txtStuNm")).Text != ((HiddenField)e.FindControl("hdStuNm")).Value)
                changes.Add(string.Format("Họ tên: {0}", ((TextBox)e.FindControl("txtStuNm")).Text));
            // Gender
            if (((RadioButtonList)e.FindControl("optGender")).SelectedValue != ((HiddenField)e.FindControl("hdGender")).Value)
                changes.Add(string.Format("Giới tính: {0}", ((RadioButtonList)e.FindControl("optGender")).SelectedItem.Text));
            // BDay
            if (((TextBox)e.FindControl("txtBDay")).Text != ((HiddenField)e.FindControl("hdBDay")).Value)
                changes.Add(string.Format("Ngày sinh: {0}", ((TextBox)e.FindControl("txtBDay")).Text));
            // Native
            if (((TextBox)e.FindControl("txtNative")).Text != ((HiddenField)e.FindControl("hdNative")).Value)
                changes.Add(string.Format("Quê quán: {0}", ((TextBox)e.FindControl("txtNative")).Text));
            // Eyear
            if (((TextBox)e.FindControl("txtEyear")).Text != ((HiddenField)e.FindControl("hdEyear")).Value)
                changes.Add(string.Format("Nhập học: {0}", ((TextBox)e.FindControl("txtEyear")).Text));
            // Eclass
            if (((TextBox)e.FindControl("txtEclass")).Text != ((HiddenField)e.FindControl("hdEclass")).Value)
                changes.Add(string.Format("Vào lớp: {0}", ((TextBox)e.FindControl("txtEclass")).Text));
            // Dept
            if (((DropDownList)e.FindControl("lstDept")).SelectedValue != ((HiddenField)e.FindControl("hdDept")).Value)
                changes.Add(string.Format("Khoa: {0}", ((DropDownList)e.FindControl("lstDept")).SelectedItem.Text));
            // Status
            if (((DropDownList)e.FindControl("lstStatus")).SelectedValue != ((HiddenField)e.FindControl("hdStatus")).Value)
                changes.Add(string.Format("Hệ: {0}", ((DropDownList)e.FindControl("lstStatus")).SelectedItem.Text));
            // Idnum
            if (((TextBox)e.FindControl("txtIdnum")).Text != ((HiddenField)e.FindControl("hdIdnum")).Value)
                changes.Add(string.Format("Số CMND: {0}", ((TextBox)e.FindControl("txtIdnum")).Text));

            var message = string.Join(Environment.NewLine, changes.ToArray());
            if (!string.IsNullOrEmpty(message))
            {
                var body = string.Format("Mã số sinh viên: {0}{2}{2}Thông tin thay đổi:{2}{1}", HttpContext.Current.User.Identity.Name, message, Environment.NewLine);
                try
                {
                    // Send email to daa
                    Mail.SendEmail(Host.HostEmail, Settings["Email"] as string, "Yêu cầu sửa đổi lí lịch sinh viên", body);
                    var notice = string.Format("Đã gửi yêu cầu sửa đổi thông tin.{1}Lí lịch của bạn sẽ sớm được cập nhật.{1}{1}{0}", message, Environment.NewLine);
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", string.Format("alert({0});", Helper.EncodeJsString(notice)), true);
                }
                catch (Exception ex)
                {
                    // Notice that can't send email
                    var notice = string.Format("Không thể gửi yêu cầu sửa đổi vì lí do sau:{1}{1}{0}", ex.Message, Environment.NewLine);
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", string.Format("alert({0});", Helper.EncodeJsString(notice)), true);
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Init globalization
            var language = "vi-VN";
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(language);
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(language);
        }
    }
}