using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke;

namespace DotNetNuke.Modules.AgapeUK.QuickRender
{
    public partial class ViewQuickRender : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {
                    string thisText = "";
                    thisText = (string)Settings["ThisText"];
                    phMain.Controls.Add(new LiteralControl(thisText));
                }
                catch (Exception ex)
                {
                    phMain.Controls.Add(new LiteralControl("<p>You have yet to add anything to this, go to this module's settings.</p>"));
                }
            }
        }
    }
}