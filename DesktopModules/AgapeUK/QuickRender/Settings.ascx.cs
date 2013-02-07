using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke;

namespace DotNetNuke.Modules.AgapeUK.QuickRender
{
    public partial class Settings : DotNetNuke.Entities.Modules.ModuleSettingsBase
    {
        public override void LoadSettings()
        {
            base.LoadSettings();
            string thisText = "";
            try
            {
                thisText = TabModuleSettings["ThisText"] as string;
            }
            catch (Exception e)
            {
                thisText = "";
            }
            tbContent.Text = thisText;
        }
        public override void UpdateSettings()
        {
            base.UpdateSettings();
            string newText = "";
            newText = tbContent.Text as string;
            if (!(newText == ""))
            {
                DotNetNuke.Entities.Modules.ModuleController objModules = new DotNetNuke.Entities.Modules.ModuleController();
                objModules.UpdateTabModuleSetting(TabModuleId,"ThisText",newText);
                SynchronizeModule();
            }
        }
    }
}