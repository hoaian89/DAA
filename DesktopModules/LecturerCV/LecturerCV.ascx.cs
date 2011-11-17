using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;

namespace daa
{
    public partial class LecturerCV : PortalModuleBase
    {
        protected void cbxDepts_DataBound(object sender, EventArgs e)
        {
            // Rename display text for more details
            foreach (var item in cbxDepts.Items)
                ((ListItem)item).Text = Helper.GetDeptName(((ListItem)item).Text);

            // Sort the department
            var query = cbxDepts.Items.Cast<ListItem>().OrderBy(o => o.Text).ToArray();
            cbxDepts.Items.Clear();
            cbxDepts.Items.AddRange(query);

            cbxDepts.Items.Insert(0, "-- chọn khoa/phòng --");
        }

        protected void cbxLects_DataBound(object sender, EventArgs e)
        {
            cbxLects.Items.Insert(0, "-- chọn giảng viên --");
            LecturerData.DataBind();
        }
    }
}