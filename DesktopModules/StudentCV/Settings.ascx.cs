using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Services.Exceptions;

namespace daa
{
    public partial class StudentCVSettings : ModuleSettingsBase
    {
        public override void LoadSettings()
        {
            try
            {
                if (!Page.IsPostBack && Settings["Email"] != null)
                    txtEmail.Text = Settings["Email"] as string;
            }
            catch (Exception ex)
            {
                Exceptions.ProcessModuleLoadException(this, ex);
            }
        }

        public override void UpdateSettings()
        {
            try
            {
                if (Page.IsValid)
                {
                    var objModules = new ModuleController();
                    objModules.UpdateModuleSetting(ModuleId, "Email", txtEmail.Text);
                }
            }
            catch (Exception ex)
            {
                Exceptions.ProcessModuleLoadException(this, ex);
            }
        }
    }
}