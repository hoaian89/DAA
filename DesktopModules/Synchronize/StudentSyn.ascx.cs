using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using Microsoft.ApplicationBlocks.Data;
using System.Configuration;
using DotNetNuke.Common.Utilities;
using System.Data;
using DotNetNuke.Security.Roles;
using DotNetNuke.Entities.Users;
using DotNetNuke.Security.Membership;

namespace daa
{
    public partial class StudentSyn : PortalModuleBase
    {
        const int TimeOut = 3600; // 1 hour

        protected void Page_Load(object sender, EventArgs e)
        {
            // Show statistic
            if (!Page.IsPostBack)
            {
                // Get list of all students
                var allStus = SqlHelper.ExecuteDataset(Config.GetConnectionString(), CommandType.Text, "SELECT StuId FROM Student").Tables[0];
                // Count all students
                int total = allStus.Rows.Count;
                var allStuIds = from r in allStus.Rows.Cast<DataRow>()
                                select (string)r["StuId"];
                lblStuTotal.Text = total.ToString();

                // Count registered students
                var roleCtlr = new RoleController();
                var roleId = roleCtlr.GetRoleByName(PortalId, "Student").RoleID;
                var regStus = SqlHelper.ExecuteDataset(Config.GetConnectionString(), CommandType.Text,
                    string.Format("SELECT Users.Username FROM UserRoles INNER JOIN Users ON UserRoles.UserID = Users.UserID WHERE (UserRoles.RoleID = {0})", roleId)).Tables[0]; ;

                int no_reg = regStus.Rows.Count;
                var regStuIds = from u in regStus.Rows.Cast<DataRow>()
                                select (string)u["Username"];
                lblNoRegStu.Text = no_reg.ToString();

                // Count free students
                int no_free = total - no_reg;
                var freeStuIds = allStuIds.Except(regStuIds).ToArray();
                lblNoFreeStu.Text = no_free.ToString();
                lblFreeStus.Text = string.Join(", ", freeStuIds);
            }
        }

        protected void btnSynStu_Click(object sender, EventArgs e)
        {
            // Prepare for longtime jobs
            Server.ScriptTimeout = TimeOut;

            // Get list of all students
            var allStus = SqlHelper.ExecuteDataset(Config.GetConnectionString(), CommandType.Text, "SELECT StuId, StuNm, BDay, Email FROM Student").Tables[0];
            int total = allStus.Rows.Count;
            lblStuTotal.Text = total.ToString();
            // Count all students
            var allStuIds = (from r in allStus.Rows.Cast<DataRow>()
                             select (string)r["StuId"]).ToList();
            // Get StuId with profile
            var allStuInfos = (from r in allStus.Rows.Cast<DataRow>()
                               select r).ToDictionary(
                               r => (string)r["StuId"],
                               r => new
                               {
                                   Name = r["StuNm"] == DBNull.Value ? null : (string)r["StuNm"],
                                   BDay = r["BDay"] == DBNull.Value ? null : (DateTime?)r["BDay"],
                                   Email = r["Email"] == DBNull.Value ? null : (string)r["Email"],
                               });

            // Count registered students
            var roleCtlr = new RoleController();
            var roleId = roleCtlr.GetRoleByName(PortalId, "Student").RoleID;
            var regStus = SqlHelper.ExecuteDataset(Config.GetConnectionString(), CommandType.Text,
                string.Format("SELECT Users.Username FROM UserRoles INNER JOIN Users ON UserRoles.UserID = Users.UserID WHERE (UserRoles.RoleID = {0})", roleId)).Tables[0]; ;
            var regStuIds = (from u in regStus.Rows.Cast<DataRow>()
                             select (string)u["Username"]).ToList();

            // Count free students
            var freeStuIds = allStuIds.Except(regStuIds).ToArray();
            foreach (var stuid in freeStuIds)
            {
                var userinfo = new UserInfo
                {
                    PortalID = PortalId,
                    Username = stuid,
                    DisplayName = allStuInfos[stuid].Name,
                    FullName = allStuInfos[stuid].Name,
                    Email = allStuInfos[stuid].Email,
                };
                if (allStuInfos[stuid].BDay.HasValue)
                    userinfo.Membership.Password = string.Format("{0}{1}", stuid, allStuInfos[stuid].BDay.Value.Year % 100);
                else
                    userinfo.Membership.Password = stuid;
                var status = UserController.CreateUser(ref userinfo);
                if (status == UserCreateStatus.UserAlreadyRegistered)
                {
                    var userid = UserController.GetUserByName(PortalId, stuid).UserID;
                    // Add user to Student role
                    roleCtlr.AddUserRole(PortalId, userid, roleId, DateTime.MinValue);
                    regStuIds.Add(stuid);
                }
                else if (status == UserCreateStatus.Success)
                {
                    // Add user to Student role
                    roleCtlr.AddUserRole(PortalId, userinfo.UserID, roleId, DateTime.MaxValue);
                    regStuIds.Add(stuid);
                }
            }

            int no_reg = regStuIds.Count();
            lblNoRegStu.Text = no_reg.ToString();
            int no_free = total - no_reg;
            lblNoFreeStu.Text = no_free.ToString();
            freeStuIds = allStuIds.Except(regStuIds).ToArray();
            lblFreeStus.Text = string.Join(", ", freeStuIds);
        }
    }
}