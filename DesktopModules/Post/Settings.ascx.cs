using System;
using System.Web.UI;
using DotNetNuke;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Services.Exceptions;

public partial class PASettings : ModuleSettingsBase
{
    public override void LoadSettings()
    {
        try
        {
            if (Page.IsPostBack == false)
            {
                if ((string)TabModuleSettings["template"] != null)
                {
                    tx.Text = (string)TabModuleSettings["template"];
                }
            }
        }
        catch (Exception exc) //Module failed to load
        {
            Exceptions.ProcessModuleLoadException(this, exc);
        }
    }

    public override void UpdateSettings()
    {
        try
        {
            ModuleController objModules = new ModuleController();
            objModules.UpdateTabModuleSetting(TabModuleId, "template", tx.Text);

            //refresh cache
            SynchronizeModule();
        }
        catch (Exception exc) //Module failed to load
        {
            Exceptions.ProcessModuleLoadException(this, exc);
        }
    }

}


