#region Copyright
// 
// DotNetNuke® - http://www.dotnetnuke.com
// Copyright (c) 2002-2012
// by DotNetNuke Corporation
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
// documentation files (the "Software"), to deal in the Software without restriction, including without limitation 
// the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and 
// to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all copies or substantial portions 
// of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED 
// TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
// CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
// DEALINGS IN THE SOFTWARE.
#endregion
#region Usings

using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.Common;
using System.Globalization;
using System.IO;
using System.Net;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.XPath;

using DotNetNuke.Application;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;
using DotNetNuke.Entities.Controllers;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Users;
using DotNetNuke.Framework;
using DotNetNuke.Security;
using DotNetNuke.Security.Membership;
using DotNetNuke.Services.Authentication;
using DotNetNuke.Services.Localization;
using DotNetNuke.Services.Localization.Internal;
using DotNetNuke.UI.Utilities;

using DataCache = DotNetNuke.Common.Utilities.DataCache;
using Globals = DotNetNuke.Common.Globals;

#endregion

namespace DotNetNuke.Services.Install
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The InstallWizard class provides the Installation Wizard for DotNetNuke
    /// </summary>
    /// <remarks>
    /// </remarks>
    /// <history>
    /// 	[cnurse]	01/23/2007 Created
    /// </history>
    /// -----------------------------------------------------------------------------
    public partial class UpgradeWizard : Page
    {
        #region Private Members

        protected string LocalResourceFile = "~/Install/App_LocalResources/UpgradeWizard.aspx.resx";
        private Version _dataBaseVersion;
        private const string LocalesFile = "/Install/App_LocalResources/Locales.xml";

        #endregion

        #region Protected Members

        protected Version ApplicationVersion
        {
            get
            {
                return DotNetNukeContext.Current.Application.Version;
            }
        }

        protected Version DatabaseVersion
        {
            get
            {
                return _dataBaseVersion ?? (_dataBaseVersion = DataProvider.Instance().GetVersion());
            }
        }

        #endregion

        #region Private Methods


        /// -----------------------------------------------------------------------------
        /// <summary>
        /// EnableButton enables/Disables a Navigation Button
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	02/28/2007 Created
        /// </history>
        /// -----------------------------------------------------------------------------
        private static void EnableButton(LinkButton button, bool enabled)
        {
            if (button != null)
            {
                button.OnClientClick = "return !checkDisabled(this);";
                button.CssClass = enabled
                                    ? ((button.CommandName == "MoveNext") ? "dnnPrimaryAction" : "dnnSecondaryAction")
                                    : "dnnPrimaryAction dnnDisabledAction";
            }
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// GetInstallerLocales gets an ArrayList of the Locales
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	01/23/2007 Created
        /// </history>
        /// -----------------------------------------------------------------------------
        private static ArrayList GetInstallerLocales()
        {
            ArrayList supportedLocales = new ArrayList();
            string filePath = Globals.ApplicationMapPath + LocalesFile.Replace("/", "\\");

            if (File.Exists(filePath))
            {
                XPathDocument doc = new XPathDocument(filePath);
                foreach (XPathNavigator nav in doc.CreateNavigator().Select("root/language"))
                {
                    if (nav.NodeType != XPathNodeType.Comment)
                    {
                        Locale objLocale = new Locale();
                        objLocale.Text = nav.GetAttribute("name", "");
                        objLocale.Code = nav.GetAttribute("key", "");
                        objLocale.Fallback = nav.GetAttribute("fallback", "");

                        supportedLocales.Add(objLocale);
                    }
                }
            }
            else
            {
                Locale objLocale = new Locale();
                objLocale.Text = "English";
                objLocale.Code = "en-US";
                objLocale.Fallback = "";
                supportedLocales.Add(objLocale);
            }
            return supportedLocales;
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// GetWizardButton gets a wizard button from the template
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	02/28/2007 Created
        /// </history>
        /// -----------------------------------------------------------------------------
        private LinkButton GetWizardButton(string containerID, string buttonID)
        {
            Control navContainer = wizInstall.FindControl(containerID);
            LinkButton button = null;
            if (navContainer != null)
            {
                button = navContainer.FindControl(buttonID) as LinkButton;
            }
            return button;
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// LocalizePage sets up the Localized Text
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	02/09/2007 Created
        /// </history>
        /// -----------------------------------------------------------------------------
        private void LocalizePage()
        {
            //Main Title
            Title = LocalizeString("Title");

            //Page Titles
            for (int i = 0; i <= wizInstall.WizardSteps.Count - 1; i++)
            {
                wizInstall.WizardSteps[i].Title = LocalizeString("Page" + i + ".Title");
            }

            //Wizard Buttons
            LinkButton nextButton = GetWizardButton("StepNavigationTemplateContainerID", "StepNextButton");
            nextButton.Text = LocalizeString("Next");

            nextButton = GetWizardButton("StartNavigationTemplateContainerID", "StartNextButton");
            nextButton.Text = LocalizeString("Next");

            LinkButton previousButton = GetWizardButton("StepNavigationTemplateContainerID", "StepPreviousButton");
            previousButton.Text = LocalizeString("Previous");

            switch (wizInstall.ActiveStepIndex)
            {
                case 0: //Page 0 - Welcome
                    versionLabel.Text = string.Format(LocalizeString("Version"), Globals.FormatVersion(ApplicationVersion));
                    currentVersionLabel.Text = string.Format(LocalizeString("CurrentVersion"), Globals.FormatVersion(DatabaseVersion));
                    introDetailLabel.Text = LocalizeString("IntroDetail");
                    bestPracticesLabel.Text = LocalizeString("BestPractices");
                    
                    break;
            }
        }

        #endregion

        #region Protected Methods

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// LocalizeString is a helper function for localizing strings
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	01/23/2007 Created
        /// </history>
        /// -----------------------------------------------------------------------------
        protected string LocalizeString(string key)
        {
            return Localization.Localization.GetString(key, LocalResourceFile, cboLanguages.SelectedValue.ToLower());
        }

        protected override void OnError(EventArgs e)
        {
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Server.Transfer("~/ErrorPage.aspx");
        }

        #endregion

        #region Event Handlers

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// Page_Init runs when the Page is initialised
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	02/14/2007	Created
        /// </history>
        /// -----------------------------------------------------------------------------
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            cboLanguages.SelectedIndexChanged += cboLanguages_SelectedIndexChanged;
            wizInstall.NextButtonClick += wizInstall_NextButtonClick;
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// Page_Load runs when the Page loads
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	02/09/2007	Created
        /// </history>
        /// -----------------------------------------------------------------------------
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);


            if (!Page.IsPostBack)
            {
                cboLanguages.DataSource = GetInstallerLocales();
                cboLanguages.DataBind();
                SelectBrowserLanguage(); 
                wizInstall.ActiveStepIndex = 0;

                LocalizePage();

            }
        }

        private void SelectBrowserLanguage()
        {
            IList<string> codes = new List<string>();
            foreach(ListItem item in cboLanguages.Items)
            {
                codes.Add(item.Value);
            }
            string cultureCode = TestableLocalization.Instance.BestCultureCodeBasedOnBrowserLanguages(codes);

            cboLanguages.Items.FindByValue(cultureCode).Selected = true;
        }

        // ReSharper disable InconsistentNaming

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// Runs when the Selected Language is changed
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	02/09/2007	Created
        /// </history>
        /// -----------------------------------------------------------------------------
        protected void cboLanguages_SelectedIndexChanged(object sender, EventArgs e)
        {
            LocalizePage();
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// Runs when the Wizard's Next button is clicked
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	02/20/2007	Created
        /// </history>
        /// -----------------------------------------------------------------------------
        protected void wizInstall_NextButtonClick(object sender, WizardNavigationEventArgs e)
        {
            switch (e.CurrentStepIndex)
            {
                case 0:
                    //validate user
                    UserLoginStatus loginStatus = UserLoginStatus.LOGIN_FAILURE;
                    UserInfo hostUser = UserController.ValidateUser(-1, userNameTextBox.Text, passwordTextBox.Text, "DNN", "", "", AuthenticationLoginBase.GetIPAddress(), ref loginStatus);

                    if (loginStatus != UserLoginStatus.LOGIN_FAILURE && hostUser.IsSuperUser)
                    {
                        Response.Redirect("~/Install/Install.aspx?mode=upgrade");
                    }
                    else
                    {
                        Response.Redirect("~/Install/UpgradeWizard.aspx");
                    }
                    break;
            }
        }

        // ReSharper restore InconsistentNaming

        #endregion
    }
}