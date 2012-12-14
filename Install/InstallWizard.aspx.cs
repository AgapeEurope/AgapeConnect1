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
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.XPath;
using ASP;
using DotNetNuke.Application;
using DotNetNuke.Common;
using DotNetNuke.Common.Internal;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Data;
using DotNetNuke.Entities.Controllers;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Portals.Internal;
using DotNetNuke.Entities.Users;
using DotNetNuke.Framework;
using DotNetNuke.Instrumentation;
using DotNetNuke.Security.Membership;
using DotNetNuke.Services.Localization;
using DotNetNuke.Services.Localization.Internal;
using DotNetNuke.UI.Skins.Controls;
using DotNetNuke.UI.Utilities;
using DotNetNuke.Web.Client.ClientResourceManagement;

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
    public partial class InstallWizard : PageBase, IClientAPICallbackEventHandler
    {
        #region Private Members

        private readonly DataProvider _dataProvider = DataProvider.Instance();
        protected new string LocalResourceFile = "~/Install/App_LocalResources/InstallWizard.aspx.resx";
        private Version _dataBaseVersion;
        private XmlDocument _installTemplate;
        private const string LocalesFile = "/Install/App_LocalResources/Locales.xml";
        private string _connectionString = Null.NullString;

        #endregion

		#region Private Properties

    	private bool PortalBinded
    	{
    		get
    		{
    			if(ViewState["PortalBinded"] == null)
    			{
    				return false;
    			}

    			return Convert.ToBoolean(ViewState["PortalBinded"]);
    		}
    		set
			{
				ViewState["PortalBinded"] = value;
			}
    	}
        
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

        protected Version BaseVersion
        {
            get
            {
                return Upgrade.Upgrade.GetInstallVersion(InstallTemplate);
            }
        }

        protected XmlDocument InstallTemplate
        {
            get
            {
                if (_installTemplate == null)
                {
                    _installTemplate = new XmlDocument();
                    Upgrade.Upgrade.GetInstallTemplate(_installTemplate);
                }
                return _installTemplate;
            }
        }

        protected bool PermissionsValid
        {
            get
            {
                bool valid = false;
                if (ViewState["PermissionsValid"] != null)
                {
                    valid = Convert.ToBoolean(ViewState["PermissionsValid"]);
                }
                return valid;
            }
            set
            {
                ViewState["PermissionsValid"] = value;
            }
        }

        protected int PortalId
        {
            get
            {
                int portalId = Null.NullInteger;
                if (ViewState["PortalId"] != null)
                {
                    portalId = Convert.ToInt32(ViewState["PortalId"]);
                }
                return portalId;
            }
            set
            {
                ViewState["PortalId"] = value;
            }
        }

        protected string Versions
        {
            get
            {
                string versions = Null.NullString;
                if (ViewState["Versions"] != null)
                {
                    versions = Convert.ToString(ViewState["Versions"]);
                }
                return versions;
            }
            set
            {
                ViewState["Versions"] = value;
            }
        }

        #endregion

        #region IClientAPICallbackEventHandler Members

        public string RaiseClientAPICallbackEvent(string eventArgument)
        {
            return ProcessAction(eventArgument);
        }

        #endregion

        #region Private Methods

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// BindAuthSystems binds the Authentication Systems checkbox list
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	02/28/2008 Created
        /// </history>
        /// -----------------------------------------------------------------------------
        private void BindAuthSystems()
        {
            BindPackageItems("AuthSystem", lstAuthSystems, lblNoAuthSystems, "NoAuthSystems", AuthSystemsErrorLabel);
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// BindConnectionString binds the connection String info
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	01/23/2007 Created
        /// </history>
        /// -----------------------------------------------------------------------------
        private void BindConnectionString()
        {
            string connection = Config.GetConnectionString();
            foreach (string connectionParam in connection.Split(';'))
            {
                int index = connectionParam.IndexOf("=");
                if (index > 0)
                {
                    string key = connectionParam.Substring(0, index);
                    string value = connectionParam.Substring(index + 1);
                    switch (key.ToLower())
                    {
                        case "server":
                        case "data source":
                        case "address":
                        case "addr":
                        case "network address":
                            txtServer.Text = value;
                            break;
                        case "database":
                        case "initial catalog":
                            txtDatabase.Text = value;
                            break;
                        case "uid":
                        case "user id":
                        case "user":
                            txtUserId.Text = value;
                            break;
                        case "pwd":
                        case "password":
                            txtPassword.Text = value;
                            break;
                        case "integrated security":
                            chkIntegrated.Checked = (value.ToLower() == "true");
                            break;
                        case "attachdbfilename":
                            txtFile.Text = value.Replace("|DataDirectory|", "");
                            break;
                    }
                }
            }
            if (chkIntegrated.Checked)
            {
                chkOwner.Checked = true;
            }
            chkOwner.Enabled = !chkIntegrated.Checked;
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// Gets the userid for the upgradeConnectionString
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[smehaffie]	07/13/2008 Created
        /// </history>
        /// -----------------------------------------------------------------------------
        private static string GetUpgradeConnectionStringUserID()
        {
            string dbUser = "";
            string connection = Config.GetUpgradeConnectionString();

            //If connection string does not use integrated security, then get user id.
            if (connection.ToLower().Contains("user id") || connection.ToLower().Contains("uid") || connection.ToLower().Contains("user"))
            {
                string[] connectionParams = connection.Split(';');

                foreach (string connectionParam in connectionParams)
                {
                    int index = connectionParam.IndexOf("=");
                    if (index > 0)
                    {
                        string key = connectionParam.Substring(0, index);
                        string value = connectionParam.Substring(index + 1);
                        if ("user id|uuid|user".Contains(key.Trim().ToLower()))
                        {
                            dbUser = value.Trim();
                        }
                    }
                }
            }
            return dbUser;
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// BindDatabases binds the supported databases
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	02/23/2007 Created
        /// </history>
        /// -----------------------------------------------------------------------------
        private void BindDatabases()
        {
            if ((Config.GetDefaultProvider("data").Name == "SqlDataProvider"))
            {
                string connection = Config.GetConnectionString();
                if (connection.ToLower().Contains("attachdbfilename"))
                {
                    rblDatabases.Items.FindByValue("SQLFile").Selected = true;
                }
                else
                {
                    rblDatabases.Items.FindByValue("SQLDatabase").Selected = true;
                }
            }
            if ((Config.GetDefaultProvider("data").Name == "OracleDataProvider"))
            {
                rblDatabases.Items.Add(new ListItem(LocalizeString("Oracle"), "Oracle"));
                rblDatabases.SelectedIndex = 2;
            }
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// BindLanguages binds the languages checkbox list
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	02/20/2007 Created
        /// </history>
        /// -----------------------------------------------------------------------------
        private void BindLanguages()
        {
            BindPackageItems("Language", lstLanguages, lblNoLanguages, "NoLanguages", languagesErrorLabel);
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// BindModules binds the modules checkbox list
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	02/19/2007 Created
        /// </history>
        /// -----------------------------------------------------------------------------
        private void BindModules()
        {
            BindPackageItems("Module", lstModules, lblNoModules, "NoModules", modulesErrorLabel);
        }

        private void BindPackageItems(string packageType, CheckBoxList list, Label noItemsLabel, string noItemsKey, Label errorLabel)
        {
            string installPath = Globals.ApplicationMapPath + "\\Install\\" + packageType;
            list.Items.Clear();
            if (Directory.Exists(installPath))
            {
                string[] arrFiles = Directory.GetFiles(installPath);
                foreach (string strFile in arrFiles)
                {
                    string strResource = strFile.Replace(installPath + "\\", "");
                    if (strResource.ToLower().EndsWith(".zip") || strResource.ToLower().EndsWith(".resources"))
                    {
                        var packageItem = new ListItem();
                        //*.zip packages are installed by default
                        if (strResource.ToLower().EndsWith(".zip"))
                        {
                            packageItem.Selected = true;
                            packageItem.Enabled = false;
                        }
                        else //*.resources packages will be optional
                        {
                            packageItem.Selected = false;
                            packageItem.Enabled = true;
                        }
                        packageItem.Value = strResource;
                        strResource = Regex.Replace(strResource, ".zip", "", RegexOptions.IgnoreCase);
                        strResource = Regex.Replace(strResource, ".resources", "", RegexOptions.IgnoreCase);
                        strResource = Regex.Replace(strResource, "_Install", ")", RegexOptions.IgnoreCase);
                        strResource = Regex.Replace(strResource, "_Source", ")", RegexOptions.IgnoreCase);
                        strResource = strResource.Replace("_0", " (0");
                        packageItem.Text = strResource;

                        list.Items.Add(packageItem);
                    }
                }
            }
            if (list.Items.Count > 0)
            {
                noItemsLabel.Visible = false;
            }
            else
            {
                noItemsLabel.Visible = true;
                noItemsLabel.Text = LocalizeString(noItemsKey);
            }
            if (errorLabel != null)
            {
                errorLabel.Text = Null.NullString;
            }
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// BindPermissions binds the permissions checkbox list
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	01/23/2007 Created
        /// </history>
        /// -----------------------------------------------------------------------------
        private void BindPermissions(bool test)
        {
            PermissionsValid = true;

            lstPermissions.Items.Clear();
            var permissionItem = new ListItem();
            var verifiers = new List<FileSystemPermissionVerifier>
                                {
                                    new FileSystemPermissionVerifier(Server.MapPath("~")),
                                    new FileSystemPermissionVerifier(Server.MapPath("~/App_Data"))
                                };

            //FolderCreate
			if (test && PermissionsValid)
			{
			    permissionItem.Selected = verifiers.All(v => v.VerifyFolderCreate());
                PermissionsValid = PermissionsValid && permissionItem.Selected;
            }
            permissionItem.Enabled = false;
            permissionItem.Text = LocalizeString("FolderCreate");
            lstPermissions.Items.Add(permissionItem);

            //FileCreate
            permissionItem = new ListItem();
			if (test && PermissionsValid)
            {
                permissionItem.Selected = verifiers.All(v => v.VerifyFileCreate());
                PermissionsValid = PermissionsValid && permissionItem.Selected;
            }
            permissionItem.Enabled = false;
            permissionItem.Text = LocalizeString("FileCreate");
            lstPermissions.Items.Add(permissionItem);

            //FileDelete
            permissionItem = new ListItem();
			if (test && PermissionsValid)
            {
                permissionItem.Selected = verifiers.All(v => v.VerifyFileDelete());
                PermissionsValid = PermissionsValid && permissionItem.Selected;
            }
            permissionItem.Enabled = false;
            permissionItem.Text = LocalizeString("FileDelete");
            lstPermissions.Items.Add(permissionItem);

            //FolderDelete
            permissionItem = new ListItem();
			if (test && PermissionsValid)
            {
                permissionItem.Selected = verifiers.All(v => v.VerifyFolderDelete());
                PermissionsValid = PermissionsValid && permissionItem.Selected;
            }
            permissionItem.Enabled = false;
            permissionItem.Text = LocalizeString("FolderDelete");
            lstPermissions.Items.Add(permissionItem);
            if (test)
            {
                var paths = string.Join("; ", (from v in verifiers select v.BasePath).ToArray());
                permissionsErrorLabel.Text = PermissionsValid ? LocalizeString("PermissionsOk") : LocalizeString("PermissionsError").Replace("{0}", paths);
            }
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// BindPortal binds the portal information
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	02/19/2007 Created
        /// </history>
        /// -----------------------------------------------------------------------------
        private void BindPortal()
        {
			if(PortalBinded)
			{
				return;
			}

            XmlNode portalNode = InstallTemplate.SelectSingleNode("//dotnetnuke/portals/portal");
            XmlNode superUserNode = InstallTemplate.SelectSingleNode("//dotnetnuke/superuser");
            if (portalNode != null)
            {
                if (superUserNode != null)
                {
                    usrAdmin.FirstName = XmlUtils.GetNodeValue(superUserNode.CreateNavigator(), "firstname");
                    usrAdmin.LastName = XmlUtils.GetNodeValue(superUserNode.CreateNavigator(), "lastname");
                    usrAdmin.UserName = XmlUtils.GetNodeValue(superUserNode.CreateNavigator(), "username");
                    usrAdmin.Email = XmlUtils.GetNodeValue(superUserNode.CreateNavigator(), "email");
                }
                txtPortalTitle.Text = XmlUtils.GetNodeValue(portalNode.CreateNavigator(), "portalname");

                string templateName = XmlUtils.GetNodeValue(portalNode.CreateNavigator(), "templatefile");

                BindTemplates(templateName);
            }
            adminUserErrorLabel.Text = Null.NullString;

        	PortalBinded = true;
        }

        private class TemplateDisplayComparer : IComparer<PortalController.PortalTemplateInfo>
        {
            public int Compare(PortalController.PortalTemplateInfo x, PortalController.PortalTemplateInfo y)
            {
                var cultureCompare = String.Compare(x.CultureCode, y.CultureCode, StringComparison.CurrentCulture);
                if (cultureCompare == 0)
                {
                    return String.Compare(x.Name, y.Name, StringComparison.CurrentCulture);
                }

                //put blank cultures last
                if (string.IsNullOrEmpty(x.CultureCode) || string.IsNullOrEmpty(y.CultureCode))
                {
                    cultureCompare *= -1;
                }
                return cultureCompare;
            }
        }

        private void BindTemplates(string templateName)
        {
            var templates = TestablePortalController.Instance.GetAvailablePortalTemplates();
            templates = templates.OrderBy(x => x, new TemplateDisplayComparer()).ToList();

            foreach (var template in templates)
            {
                cboPortalTemplate.Items.Add(CreateListItem(template));
            }

            SelectADefaultTemplate(templates, templateName);

            if (cboPortalTemplate.Items.Count == 0)
            {
                UI.Skins.Skin.AddModuleMessage(this, "", Localization.Localization.GetString("PortalMissing", LocalResourceFile),
                                                ModuleMessage.ModuleMessageType.RedError);
            }
            cboPortalTemplate.Items.Insert(0, new ListItem(Localization.Localization.GetString("None_Specified"), "-1"));
        }

        private void SelectADefaultTemplate(IList<PortalController.PortalTemplateInfo> templates, string templateName)
        {
            string currentCulture = Thread.CurrentThread.CurrentUICulture.Name;

            var defaultTemplates =
                templates.Where(x => Path.GetFileName(x.TemplateFilePath) == templateName).ToList();

            var match = defaultTemplates.FirstOrDefault(x => x.CultureCode == currentCulture);
            if (match == null)
            {
                match = defaultTemplates.FirstOrDefault(x => x.CultureCode.StartsWith(currentCulture.Substring(0, 2)));
            }
            if (match == null)
            {
                match = defaultTemplates.FirstOrDefault(x => string.IsNullOrEmpty(x.CultureCode));
            }

            if (match != null)
            {
                cboPortalTemplate.SelectedIndex = templates.IndexOf(match);
            }
        }

        ListItem CreateListItem(PortalController.PortalTemplateInfo template)
        {
            string text, value;
            if (string.IsNullOrEmpty(template.CultureCode))
            {
                text = template.Name;
                value = Path.GetFileName(template.TemplateFilePath);
            }
            else
            {
                text = string.Format("{0} - {1}", template.Name, Localization.Localization.GetLocaleName(template.CultureCode, CultureDropDownTypes.NativeName));
                value = string.Format("{0}|{1}", Path.GetFileName(template.TemplateFilePath), template.CultureCode);
            }

            return new ListItem(text, value);
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// BindProviders binds the Providers checkbox list
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	06/24/2008 Created
        /// </history>
        /// -----------------------------------------------------------------------------
        private void BindProviders()
        {
            BindPackageItems("Provider", lstProviders, lblNoProviders, "NoProviders", providersErrorLabel);
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// BindSkins binds the skins checkbox list
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	02/16/2007 Created
        /// </history>
        /// -----------------------------------------------------------------------------
        private void BindSkins()
        {
            BindPackageItems("Skin", lstSkins, lblNoSkins, "NoSkins", skinsErrorLabel);

            BindPackageItems("Container", lstContainers, lblNoContainers, "NoContainers", null);
        }

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
            var supportedLocales = new ArrayList();
            string filePath = Globals.ApplicationMapPath + LocalesFile.Replace("/", "\\");

            if (File.Exists(filePath))
            {
                var doc = new XPathDocument(filePath);
                foreach (XPathNavigator nav in doc.CreateNavigator().Select("root/language"))
                {
                    if (nav.NodeType != XPathNodeType.Comment)
                    {
                        var objLocale = new Locale
                                            {
                                                Text = nav.GetAttribute("name", ""),
                                                Code = nav.GetAttribute("key", ""),
                                                Fallback = nav.GetAttribute("fallback", "")
                                            };

                        supportedLocales.Add(objLocale);
                    }
                }
            }
            else
            {
                var objLocale = new Locale
                                    {
                                        Text = "English",
                                        Code = "en-US",
                                        Fallback = ""
                                    };
                supportedLocales.Add(objLocale);
            }
            return supportedLocales;
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// GetNextScriptVersion gets the next script to Install
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	02/15/2007 Created
        /// </history>
        /// -----------------------------------------------------------------------------
        private string GetNextScriptVersion(string strProviderPath, Version currentVersion)
        {
            string strNextVersion = "Done";

            if (currentVersion == null)
            {
                strNextVersion = GetBaseDatabaseVersion();
            }
            else
            {
                string strScriptVersion = Null.NullString;
                ArrayList arrScripts = Upgrade.Upgrade.GetUpgradeScripts(strProviderPath, currentVersion);

                if (arrScripts.Count > 0)
                {
                    //First Script is next script
                    strScriptVersion = Path.GetFileNameWithoutExtension(Convert.ToString(arrScripts[0]));
                }
                if (!string.IsNullOrEmpty(strScriptVersion))
                {
                    strNextVersion = strScriptVersion;
                }
            }
            return strNextVersion;
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

        private void Initialise()
        {
            if (TestDataBaseInstalled())
            {
                //running current version, so redirect to site home page
                Response.Redirect("~/Default.aspx", true);
            }
            else
            {
                if (DatabaseVersion > new Version(0, 0, 0))
                {
                    //Upgrade
                    languagePanel.Visible = false;
                    introTitleLabel.Text = string.Format(LocalizeString("UpgradeTitle"), ApplicationVersion.ToString(3));
                    introDetailLabel.Text = string.Format(LocalizeString("Upgrade"), Upgrade.Upgrade.GetStringVersion(DatabaseVersion));
                }
                else
                {
                    //Install
                    UpdateMachineKey();
                }
            }
        }

        private bool InstallAuthSystems()
        {
            return InstallPackageItems("AuthSystem", lstAuthSystems, lblNoAuthSystems, "InstallAuthSystemError");
        }

        private string InstallDatabase()
        {
            string strErrorMessage;

            string strProviderPath = _dataProvider.GetProviderPath();
            if (!strProviderPath.StartsWith("ERROR:"))
            {
                //Install Base Version
                strErrorMessage = Upgrade.Upgrade.InstallDatabase(BaseVersion, strProviderPath, InstallTemplate, false);
            }
            else
            {
                //provider error
                strErrorMessage = strProviderPath;
            }
            if (string.IsNullOrEmpty(strErrorMessage))
            {
                //Get Next Version
                strErrorMessage = GetNextScriptVersion(strProviderPath, BaseVersion);
            }
            else if (!strErrorMessage.StartsWith("ERROR:"))
            {
                strErrorMessage = "ERROR: " + string.Format(LocalizeString("ScriptError"), Upgrade.Upgrade.GetLogFile(strProviderPath, BaseVersion));
            }
            return strErrorMessage;
        }

        private bool InstallHost()
        {
            bool success = false;
            try
            {
                //Initialise Host Settings
                Upgrade.Upgrade.InitialiseHostSettings(InstallTemplate, false);


                Upgrade.Upgrade.InstallFiles(InstallTemplate, false);

                if (!string.IsNullOrEmpty(txtSMTPServer.Text))
                {
                    HostController.Instance.Update("SMTPServer", txtSMTPServer.Text);
                    HostController.Instance.Update("SMTPAuthentication", optSMTPAuthentication.SelectedItem.Value);
                    HostController.Instance.Update("SMTPUsername", txtSMTPUsername.Text, true);
                    HostController.Instance.Update("SMTPPassword", txtSMTPPassword.Text, true);
                    HostController.Instance.Update("SMTPEnableSSL", chkSMTPEnableSSL.Checked ? "Y" : "N");
                }

                //Clear Host Cache
                DataCache.ClearHostCache(false);

                success = true;
            }
            catch (Exception exc)
            {
                DnnLog.Error(exc);
                success = false;
            }

            return success;
        }

        private bool InstallLanguages()
        {
            return InstallPackageItems("Language", lstLanguages, languagesErrorLabel, "InstallLanguageError");
        }

        private bool InstallModules()
        {
            return InstallPackageItems("Module", lstModules, modulesErrorLabel, "InstallModuleError");
        }

        private bool InstallPackageItems(string packageType, CheckBoxList list, Label errorLabel, string errorKey)
        {
            bool success = false;
            string strErrorMessage = Null.NullString;

            //Get current Script time-out
            int scriptTimeOut = Server.ScriptTimeout;
            try
            {
                //Set Script timeout to MAX value
                Server.ScriptTimeout = int.MaxValue;

                string installPath = Globals.ApplicationMapPath + "\\Install\\" + packageType;
                foreach (ListItem packageItem in list.Items)
                {
                    if (packageItem.Selected)
                    {
                        if ((File.Exists(installPath + "\\" + packageItem.Value)))
                        {
                            success = Upgrade.Upgrade.InstallPackage(installPath + "\\" + packageItem.Value, packageType, false);
                            if (!success)
                            {
                                strErrorMessage += string.Format(LocalizeString(errorKey), packageItem.Text);
                            }
                        }
                    }
                }

                success = string.IsNullOrEmpty(strErrorMessage) || packageType == "Language";
            }
            catch (Exception ex)
            {
                DnnLog.Error(ex);
                strErrorMessage = ex.StackTrace;
            }
            finally
            {
                //restore Script timeout
                Server.ScriptTimeout = scriptTimeOut;
            }
            if (!success)
            {
                errorLabel.Text += strErrorMessage;
            }
            return success;
        }

        private bool InstallPortal()
        {
            string strErrorMessage = usrAdmin.Validate();

            if (!string.IsNullOrEmpty(strErrorMessage))
            {
                string strError = LocalizeString(strErrorMessage);
                if (strErrorMessage == "PasswordLength")
                {
                    strError = string.Format(strError, MembershipProviderConfig.MinPasswordLength);
                }
                adminUserErrorLabel.Text = string.Format(LocalizeString("AdminUserError"), strError);
                return false;
            }

            if(cboPortalTemplate.SelectedIndex == 0)
            {
                string error = LocalizeString("MustSelecteATemplate");
                adminUserErrorLabel.Text = error;
                return false;
            }

            bool success = false;
            try
            {
                string strServerPath = Globals.ApplicationMapPath + "\\";
                string strPortalAlias = Globals.GetDomainName(HttpContext.Current.Request, true).Replace("/Install", "");
                PortalController.PortalTemplateInfo template = LoadPortalTemplateInfoForSelectedItem();

                UserInfo adminUser = CreateUserInfo();

                if (template.CultureCode != "en-US")
                {
                    //Check if language is installed
                    var locale = LocaleController.Instance.GetLocale(template.CultureCode);

                    //If not installed - install it
                    if (locale == null)
                    {
                        string installPath = Globals.ApplicationMapPath + "\\Install\\Language";
                        string languagePack = String.Format(installPath + "\\ResourcePack.Full.{0}.{1}.resources", Globals.FormatVersion(ApplicationVersion, "00", 3, "."), template.CultureCode);
                        if (File.Exists(languagePack))
                        {
                            success = Upgrade.Upgrade.InstallPackage(languagePack, "Language", false);
                        }
                    }
                }

                //Create Portal
                PortalId = TestablePortalController.Instance.CreatePortal(txtPortalTitle.Text,
                                                                            adminUser,
                                                                            "",
                                                                            "", 
                                                                            template,
                                                                            "",
                                                                            strPortalAlias,
                                                                            strServerPath,
                                                                            "",
                                                                            false);
                success = (PortalId > Null.NullInteger);

                if (template.CultureCode != "en-US")
                {
                    var locale = LocaleController.Instance.GetLocale("en-US");

                    //remove en-US from portal
                    Localization.Localization.RemoveLanguageFromPortal(PortalId, locale.LanguageId);
                }

                //Set admin user to be a superuser
                adminUser = UserController.GetUserByName(PortalId, usrAdmin.UserName);
                adminUser.IsSuperUser = true;
                UserController.UpdateUser(PortalId, adminUser);

                //Log user in to site
                UserLoginStatus loginStatus = UserLoginStatus.LOGIN_FAILURE;
                UserController.UserLogin(PortalId, usrAdmin.UserName, usrAdmin.Password, "", "", "", ref loginStatus, false);

                Config.Touch();
                Response.Redirect("~/Default.aspx", true);
            }
            catch (ThreadAbortException)
            {
                //do nothing - we swallow this exception - becuase of redirect
            }
            catch (Exception ex)
            {
                DnnLog.Error(ex);
                success = false;
                strErrorMessage = ex.Message;
            }
            if (!success)
            {
                adminUserErrorLabel.Text = string.Format(LocalizeString("InstallPortalError"), strErrorMessage);
            }
            
            return success;
        }

        private UserInfo CreateUserInfo()
        {
            var adminUser = new UserInfo();
            adminUser.FirstName = usrAdmin.FirstName;
            adminUser.LastName = usrAdmin.LastName;
            adminUser.Username = usrAdmin.UserName;
            adminUser.DisplayName = usrAdmin.FirstName + " " + usrAdmin.LastName;
            adminUser.Membership.Password = usrAdmin.Password;
            adminUser.Email = usrAdmin.Email;
            adminUser.IsSuperUser = false;
            adminUser.Membership.Approved = true;
            adminUser.Profile.FirstName = usrAdmin.FirstName;
            adminUser.Profile.LastName = usrAdmin.LastName;
            return adminUser;
        }

        PortalController.PortalTemplateInfo LoadPortalTemplateInfoForSelectedItem()
        {
            var values = cboPortalTemplate.SelectedItem.Value.Split('|');

            return TestablePortalController.Instance.GetPortalTemplate(Path.Combine(TestableGlobals.Instance.HostMapPath, values[0]), values.Length > 1 ? values[1] : null);
        }

        private bool InstallProviders()
        {
            return InstallPackageItems("Provider", lstProviders, providersErrorLabel, "InstallProviderError");
        }

        private bool InstallSkins()
        {
            bool skinSuccess = InstallPackageItems("Skin", lstSkins, skinsErrorLabel, "InstallSkinError");
            bool containerSuccess = InstallPackageItems("Container", lstContainers, skinsErrorLabel, "InstallContainerError");
            return skinSuccess && containerSuccess;
        }

        private string InstallVersion(string strVersion)
        {
            string strErrorMessage = Null.NullString;
            var version = new Version(strVersion);
            string strScriptFile = Null.NullString;
            string strProviderPath = _dataProvider.GetProviderPath();
            if (!strProviderPath.StartsWith("ERROR:"))
            {
                //Install Version
                strScriptFile = Upgrade.Upgrade.GetScriptFile(strProviderPath, version);
                strErrorMessage += Upgrade.Upgrade.UpgradeVersion(strScriptFile, false);
                Versions += "," + strVersion;
            }
            else
            {
                //provider error
                strErrorMessage = strProviderPath;
            }
            if (string.IsNullOrEmpty(strErrorMessage))
            {
                //Get Next Version
                strErrorMessage = GetNextScriptVersion(strProviderPath, version);
            }
            else
            {
                strErrorMessage = "ERROR: (see " + Path.GetFileName(strScriptFile).Replace("." + Upgrade.Upgrade.DefaultProvider, ".log") + " for more information)";
            }
            return strErrorMessage;
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
            Title = LocalizeString("Title") + @" - " + LocalizeString("Page" + wizInstall.ActiveStepIndex + ".Title");

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
                    introTitleLabel.Text = string.Format(LocalizeString("IntroTitle"), Globals.FormatVersion(ApplicationVersion));
                    introDetailLabel.Text = LocalizeString("IntroDetail");
                
                    installTypeRadioButton.Items[0].Text = LocalizeString("Typical");
                    installTypeRadioButton.Items[1].Text = LocalizeString("Full");
                    installTypeRadioButton.Items[2].Text = LocalizeString("Auto");

                       break;
				case 1: //Page 1 - File Permissions
                    BindPermissions(false);

                    LinkButton customButton = GetWizardButton("StepNavigationTemplateContainerID", "CustomButton");
                    customButton.Text = LocalizeString("TestPerm");
                    break;
				case 2://Page 2 - Database Configuration
					databaseConfigTitleLabel.Text = LocalizeString("DatabaseConfigTitle");
					databaseConfigDetailLabel.Text = LocalizeString("DatabaseConfigDetail");

					rblDatabases.Items[0].Text = LocalizeString("SQLServerXPress");
					rblDatabases.Items[1].Text = LocalizeString("SQLServer");
					break;
				case 3: //Page 3 - Database Installation
                    databaseInstallTitleLabel.Text = LocalizeString("DatabaseInstallTitle");
                    databaseInstallDetailLabel.Text = LocalizeString("DatabaseInstallDetail");
                    break;
                case 4: //Page 4 - Modules
                    modulesTitleLabel.Text = LocalizeString("ModulesTitle");
                    modulesDetailLabel.Text = LocalizeString("ModulesDetail");
                    lblModules.Text = LocalizeString("Modules");
                    break;
                case 5: //Page 5 - Skins/Conatiners
                    skinsTitleLabel.Text = LocalizeString("SkinsTitle");
                    skinsDetailLabel.Text = LocalizeString("SkinsDetail");
                    lblSkins.Text = LocalizeString("Skins");
                    lblContainers.Text = LocalizeString("Containers");
                    break;
                case 6: //Page 6 - Languages
                    languagesTitleLabel.Text = LocalizeString("LanguagesTitle");
                    languagesDetailLabel.Text = LocalizeString("LanguagesDetail");
                    lblLanguages.Text = LocalizeString("Languages");
                    break;
                case 7: //Page 7 - Auth Systems
                    authSystemsTitleLabel.Text = LocalizeString("AuthSystemsTitle");
                    authSystemDetailLabel.Text = LocalizeString("AuthSystemsDetail");
                    lblAuthSystems.Text = LocalizeString("AuthSystems");
                    break;
                case 8: //Page 8 - Providers
                    providersTitleLabel.Text = LocalizeString("ProvidersTitle");
                    providersDetailLabel.Text = LocalizeString("ProvidersDetail");
                    lblProviders.Text = LocalizeString("Providers");
                    break;
                case 9: //Page 9 - User/Portal Configuration
					adminUserTitleLabel.Text = LocalizeString("AdminUserTitle");
					adminUserDetailLabel.Text = LocalizeString("AdminUserDetail");
					usrAdmin.FirstNameLabel = LocalizeString("FirstName");
					usrAdmin.LastNameLabel = LocalizeString("LastName");
					usrAdmin.UserNameLabel = LocalizeString("UserName");
					usrAdmin.PasswordLabel = LocalizeString("Password");
					usrAdmin.ConfirmLabel = LocalizeString("Confirm");
					usrAdmin.EmailLabel = LocalizeString("Email");
					lblAdminUser.Text = LocalizeString("AdminUser");
					lblPortal.Text = LocalizeString("Portal");
					portalDetailLabel.Text = LocalizeString("PortalDetail");
					lblSMTPSettings.Text = LocalizeString("SMTPSettings");
					lblSMTPSettingsHelp.Text = LocalizeString("SMTPSettingsHelp");
                    break;
            }
        }

        private void SetupDatabasePage()
        {
            if (rblDatabases.SelectedIndex > Null.NullInteger)
            {
                bool isSQLFile = (rblDatabases.SelectedValue == "SQLFile");
                bool isSQLDb = (rblDatabases.SelectedValue == "SQLDatabase");
                bool isOracle = (rblDatabases.SelectedValue == "Oracle");
                databasePanel.Visible = true;
                fileRow.Visible = isSQLFile;
                databaseRow.Visible = isSQLDb;
                integratedRow.Visible = !isOracle;
                userRow.Visible = !chkIntegrated.Checked || isOracle;
                passwordRow.Visible = !chkIntegrated.Checked || isOracle;
                chkOwner.Enabled = isSQLDb;
                chkOwner.Checked = (Config.GetDataBaseOwner() == "dbo.");
                txtqualifier.Text = Config.GetObjectQualifer();
            }
            else
            {
                databasePanel.Visible = false;
            }
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// SetupPage updates the WizardPage
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	01/23/2007 Created
        /// </history>
        /// -----------------------------------------------------------------------------
        private void SetupPage()
        {
            LinkButton nextButton = GetWizardButton("StepNavigationTemplateContainerID", "StepNextButton");
            LinkButton prevButton = GetWizardButton("StepNavigationTemplateContainerID", "StepPreviousButton");
            LinkButton customButton = GetWizardButton("StepNavigationTemplateContainerID", "CustomButton");
            EnableButton(nextButton, true);
            EnableButton(prevButton, true);
            ShowButton(customButton, false);
            switch (wizInstall.ActiveStepIndex)
            {
                case 0: //Page 0 - Welcome
                    permissionsErrorLabel.Text = "";
                    break;
                case 1:
                    databaseErrorLabel.Text = "";
                    ShowButton(customButton, true);
                    break;
                case 2: //Page 2 - Database Configuration
                    permissionsErrorLabel.Text = "";
                    SetupDatabasePage();
                    break;
                case 3:
                    databaseErrorLabel.Text = "";
                    installErrorLabel.Text = "";
                    installErrorLabel.Visible = false;
                    EnableButton(nextButton, false);
                    ShowButton(prevButton, false);
                    break;
                case 4: //Page 4 - Modules
                    BindModules();
					ShowButton(prevButton, false);
					break;
                case 5: //Page 5 - Skins/Conatiners
                    BindSkins();
                    ShowButton(prevButton, false);
                    break;
                case 6: //Page 6 - Languages
                    BindLanguages();
                    ShowButton(prevButton, false);
                    break;
                case 7: //Page 7 - Auth Systems
                    BindAuthSystems();
                    ShowButton(prevButton, false);
                    break;
                case 8: //Page 8 - Providers
                    BindProviders();
                    ShowButton(prevButton, false);
                    break;
                case 9: //Page 9 - User/Portal Configuration
                //    BindSuperUser();
                //    ShowButton(prevButton, false);
                //    break;
                //case 10: //Page 10 - Portal
                    BindPortal();
                    ShowButton(prevButton, false);
                    break;
            }
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// ShowButton shows/hides a Navigation Button
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	02/28/2007 Created
        /// </history>
        /// -----------------------------------------------------------------------------
        private static void ShowButton(LinkButton button, bool enabled)
        {
            if (button != null)
            {
                button.Visible = enabled;
            }
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// TestDatabaseConnection checks the Database connection properties provided
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	01/23/2007 Created
        /// </history>
        /// -----------------------------------------------------------------------------
        private bool TestDatabaseConnection()
        {
            bool success = false;

            if (string.IsNullOrEmpty(rblDatabases.SelectedValue))
            {
                _connectionString = "ERROR:" + LocalizeString("ChooseDbError");
            }
            else
            {
                bool isSQLFile = (rblDatabases.SelectedValue == "SQLFile");
                bool isOracle = (rblDatabases.SelectedValue == "Oracle");
                DbConnectionStringBuilder builder = _dataProvider.GetConnectionStringBuilder();
                if (!string.IsNullOrEmpty(txtServer.Text))
                {
                    builder["Data Source"] = txtServer.Text;
                }
                if (!string.IsNullOrEmpty(txtDatabase.Text) && !isSQLFile)
                {
                    builder["Initial Catalog"] = txtDatabase.Text;
                }
                if (string.IsNullOrEmpty(txtDatabase.Text) && !isSQLFile)
                {
                    databaseErrorLabel.Text = LocalizeString("DbNameError");
                    if (!isOracle) return false;
                }
                if (!string.IsNullOrEmpty(txtFile.Text) && isSQLFile)
                {
                    builder["attachdbfilename"] = "|DataDirectory|" + txtFile.Text;
                }
                if (chkIntegrated.Checked)
                {
                    builder["integrated security"] = "true";
                }
                if (!string.IsNullOrEmpty(txtUserId.Text))
                {
                    builder["uid"] = txtUserId.Text;
                }
                if (!string.IsNullOrEmpty(txtPassword.Text))
                {
                    builder["pwd"] = txtPassword.Text;
                }
                if (isSQLFile)
                {
                    builder["user instance"] = "true";
                }
                string owner = txtUserId.Text + ".";
                if (chkOwner.Checked)
                {
                    owner = "dbo.";
                }
                _connectionString = DataProvider.Instance().TestDatabaseConnection(builder, owner, txtqualifier.Text);
            }
            if (_connectionString.StartsWith("ERROR:"))
            {
                databaseErrorLabel.Text = string.Format(LocalizeString("ConnectError"), _connectionString.Replace("ERROR:", ""));
            }
            else
            {
                success = true;
                databaseErrorLabel.Text = LocalizeString("ConnectSuccess");
            }
            return success;
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// TestDataBaseInstalled checks whether the Database is the current version
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	02/16/2007 Created
        /// </history>
        /// -----------------------------------------------------------------------------
        private bool TestDataBaseInstalled()
        {
            bool success = true;
            if (DatabaseVersion == null || DatabaseVersion.Major != ApplicationVersion.Major || DatabaseVersion.Minor != ApplicationVersion.Minor || DatabaseVersion.Build != ApplicationVersion.Build)
            {
                success = false;
            }
            if (!success)
            {
                installErrorLabel.Text = LocalizeString("Install.Error");
            }
            return success;
        }

        private bool TestSMTPSettings()
        {
            if (!string.IsNullOrEmpty(usrAdmin.Email))
            {
                try
                {
                    var emailMessage = new MailMessage(usrAdmin.Email, usrAdmin.Email, LocalizeString("EmailTestMessageSubject"), string.Empty);

                    var smtpClient = new SmtpClient(txtSMTPServer.Text);

                    string[] smtpHostParts = txtSMTPServer.Text.Split(':');
                    if (smtpHostParts.Length > 1)
                    {
                        smtpClient.Host = smtpHostParts[0];
                        smtpClient.Port = Convert.ToInt32(smtpHostParts[1]);
                    }


                    switch (optSMTPAuthentication.SelectedItem.Value)
                    {
                        case "":
                        case "0":
                            // anonymous
                            break;
                        case "1":
                            // basic
                            if (!string.IsNullOrEmpty(txtSMTPUsername.Text) && !string.IsNullOrEmpty(txtSMTPPassword.Text))
                            {
                                smtpClient.UseDefaultCredentials = false;
                                smtpClient.Credentials = new NetworkCredential(txtSMTPUsername.Text, txtSMTPPassword.Text);
                            }
                            break;
                        case "2":
                            // NTLM
                            smtpClient.UseDefaultCredentials = true;
                            break;
                    }

                    smtpClient.EnableSsl = chkSMTPEnableSSL.Checked;

                    smtpClient.Send(emailMessage);

                    adminUserErrorLabel.Text = string.Format(LocalizeString("SMTPSuccess"), LocalizeString("EmailSentMessage"));

                    return true;
                }
                catch (Exception ex)
                {
                    DnnLog.Error(ex);
                    adminUserErrorLabel.Text = string.Format(LocalizeString("SMTPError"), string.Format(LocalizeString("EmailErrorMessage"), ex.Message));

                    return false;
                }
            }
            adminUserErrorLabel.Text = string.Format(LocalizeString("SMTPError"), LocalizeString("SpecifyHostEmailMessage"));
            return false;
        }

        private void UpdateMachineKey()
        {
            string installationDate = Config.GetSetting("InstallationDate");

            if (installationDate == null || String.IsNullOrEmpty(installationDate))
            {
                string strError = Config.UpdateMachineKey();
                if (String.IsNullOrEmpty(strError))
                {
                    //send a new request to the application to initiate step 2
                    Response.Redirect(HttpContext.Current.Request.RawUrl, true);
                }
                else
                {
                    //403-3 Error - Redirect to ErrorPage
                    string strURL = "~/ErrorPage.aspx?status=403_3&error=" + strError;
                    HttpContext.Current.Response.Clear();
                    HttpContext.Current.Server.Transfer(strURL);
                }
            }
        }

        #endregion

        #region Protected Methods

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// GetBaseDataBaseVersion gets the Base Database Version as a string
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	03/02/2007 Created
        /// </history>
        /// -----------------------------------------------------------------------------
        protected string GetBaseDatabaseVersion()
        {
            return Upgrade.Upgrade.GetStringVersion(BaseVersion);
        }

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
            chkIntegrated.CheckedChanged += chkIntegrated_CheckedChanged;
            rblDatabases.SelectedIndexChanged += rblDatabases_SelectedIndexChanged;
            wizInstall.ActiveStepChanged += wizInstall_ActiveStepChanged;
            wizInstall.NextButtonClick += wizInstall_NextButtonClick;

            ClientAPI.HandleClientAPICallbackEvent(this);
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
			//Register jquery reference.
			jQuery.RequestRegistration();

            //register variable ActionCallback with script necessary to perform callback
            //[ACTIONTOKEN] will be replaced on the client side with real action
            ClientAPI.RegisterClientVariable(Page, "ActionCallback", ClientAPI.GetCallbackEventReference(this, "[ACTIONTOKEN]", "successFunc", "this", "errorFunc"), true);

            hostWarningLabel.Visible = !Regex.IsMatch(Request.Url.Host, "^([a-zA-Z0-9.-]+)$", RegexOptions.IgnoreCase);

			//update current thread culture to make dnn label work correctly
			Thread.CurrentThread.CurrentUICulture = new CultureInfo(cboLanguages.SelectedValue);

            if (!Page.IsPostBack)
            {
				//Adding ClientDependency Resources config to web.config
				BindPermissions(true);
				if (PermissionsValid && !ClientResourceManager.IsInstalled())
				{
					ClientResourceManager.AddConfiguration();
					Response.Redirect(Request.RawUrl);
				}
                installTypeRadioButton.Items.Clear();
                installTypeRadioButton.Items.Add(new ListItem(LocalizeString("Typical"), "Typical"));
                installTypeRadioButton.Items.Add(new ListItem(LocalizeString("Full"), "Full"));
                installTypeRadioButton.Items.Add(new ListItem(LocalizeString("Auto"), "Auto"));
                installTypeRadioButton.SelectedIndex = 0;

                rblDatabases.Items.Clear();
                rblDatabases.Items.Add(new ListItem(LocalizeString("SQLServerXPress"), "SQLFile"));
                rblDatabases.Items.Add(new ListItem(LocalizeString("SQLServer"), "SQLDatabase"));

                //Parse the conneection String to the form
                BindConnectionString();

                //Database Choices
                BindDatabases();

                if (TestDatabaseConnection())
                {
                    Initialise();

                    installTypeRadioButton.Items[2].Enabled = true;
                    databaseWarningLabel.Visible = false;
                }
                else
                {
                    //Install but connection string not configured to point at a valid SQL Server
                    UpdateMachineKey();

                    installTypeRadioButton.Items[2].Enabled = false;
                    databaseWarningLabel.Visible = true;
                }
                cboLanguages.DataSource = GetInstallerLocales();
                cboLanguages.DataBind();
                SelectBrowserLanguage();
                wizInstall.ActiveStepIndex = 0;

                LocalizePage();
                SetupPage();
            }
        }

        private void SelectBrowserLanguage()
        {
            var codes = cboLanguages.Items.Cast<ListItem>().Select(x => x.Value);
            string cultureCode = TestableLocalization.Instance.BestCultureCodeBasedOnBrowserLanguages(codes);

            cboLanguages.Items.FindByValue(cultureCode).Selected = true;
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// Page_PreRender runs just before the page is rendered
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	02/15/2007	Created
        /// </history>
        /// -----------------------------------------------------------------------------
        protected override void OnPreRenderComplete(EventArgs e)
        {
            base.OnPreRenderComplete(e);

            //Make sure that the password is not cleared on pastback
            txtPassword.Attributes["value"] = txtPassword.Text;
            txtSMTPPassword.Attributes["value"] = txtSMTPPassword.Text;
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
        /// Runs when the Integrated Security Checkbox value is changed
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	02/23/2007	Created
        /// </history>
        /// -----------------------------------------------------------------------------
        protected void chkIntegrated_CheckedChanged(object sender, EventArgs e)
        {
            userRow.Visible = !chkIntegrated.Checked;
            passwordRow.Visible = !chkIntegrated.Checked;
            if (chkIntegrated.Checked)
            {
                chkOwner.Checked = true;
            }
            chkOwner.Enabled = !chkIntegrated.Checked;
            LocalizePage();
        }

        protected void customButton_Click(object sender, EventArgs e)
        {
            BindPermissions(true);
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// Runs when there is a ClientCallback
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	02/09/2007	Created
        /// </history>
        /// -----------------------------------------------------------------------------
        public string ProcessAction(string someAction)
        {
            //First check that we are not being targetted by an AJAX HttpPost, so get the current DB version
            string strProviderPath = _dataProvider.GetProviderPath();
            string nextVersion = GetNextScriptVersion(strProviderPath, DatabaseVersion);
            if (someAction != nextVersion)
            {
                Exceptions.Exceptions.LogException(new Exception("Attempt made to run a Database Script - Possible Attack"));
                return "Error: Possible Attack";
            }
            if (someAction == GetBaseDatabaseVersion())
            {
                string result = InstallDatabase();
                if (result == "Done")
                {
                    //Complete Installation
                    Upgrade.Upgrade.UpgradeApplication();
                }
                return result;
            }
            else if (someAction.Contains("."))
            {
                //Upgrade Database
                string result = InstallVersion(someAction);
                if (result == "Done")
                {
                    ArrayList arrVersions = Upgrade.Upgrade.GetUpgradeScripts(strProviderPath, BaseVersion);
                    string strErrorMessage = Null.NullString;
                    for (int i = 0; i <= arrVersions.Count - 1; i++)
                    {
                        string strVersion = Path.GetFileNameWithoutExtension(Convert.ToString(arrVersions[i]));
                        var version = new Version(strVersion);
                        if (version != null)
                        {
                            strErrorMessage += Upgrade.Upgrade.UpgradeApplication(strProviderPath, version, false);

                            //delete files which are no longer used
                            strErrorMessage += Upgrade.Upgrade.DeleteFiles(strProviderPath, version, false);

                            //execute config file updates
                            strErrorMessage += Upgrade.Upgrade.UpdateConfig(strProviderPath, version, false);
                        }
                    }

                    //Complete Installation
                    Upgrade.Upgrade.UpgradeApplication();
                    if (!string.IsNullOrEmpty(strErrorMessage))
                    {
                        result = "ERROR: " + strErrorMessage;
                    }
                }
                return result;
            }
            else
            {
                return "Done";
            }
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// Runs when the Selected Database is changed
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	02/23/2007	Created
        /// </history>
        /// -----------------------------------------------------------------------------
        protected void rblDatabases_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindConnectionString();
            SetupDatabasePage();
            LocalizePage();
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// Runs when the Active Wizard Step has changed
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// 	[cnurse]	02/09/2007	Created
        /// </history>
        /// -----------------------------------------------------------------------------
        protected void wizInstall_ActiveStepChanged(object sender, EventArgs e)
        {
            //Main Title
            Title = LocalizeString("Title") + " - " + LocalizeString("Page" + wizInstall.ActiveStepIndex + ".Title");

			LocalizePage();

            switch (wizInstall.ActiveStepIndex)
            {
                case 1: //Page 1 - File Permissions
                    BindPermissions(true);
                    break;
				case 2: //Page 2 - Bind database connection form
					BindConnectionString();
            		break;
                case 4: //Page 4 - Modules
                    if (installTypeRadioButton.SelectedValue == "Typical")
                    {
                        BindModules();
                        if (InstallModules())
                        {
                            //Skip Modules Page
                            wizInstall.ActiveStepIndex = 5;
                        }
                    }
                    break;
                case 5: //Page 5 - Skins/Conatiners
                    if (installTypeRadioButton.SelectedValue == "Typical")
                    {
                        BindSkins();
                        if (InstallSkins())
                        {
                            //Skip Skins Page
                            wizInstall.ActiveStepIndex = 6;
                        }
                    }
                    break;
                case 6: //Page 6 - Languages
                    if (installTypeRadioButton.SelectedValue == "Typical")
                    {
                        BindLanguages();
                        if (InstallLanguages())
                        {
                            //Skip Languages Page
                            wizInstall.ActiveStepIndex = 7;
                        }
                    }
                    break;
                case 7: //Page 7 - Auth Systems
                    if (installTypeRadioButton.SelectedValue == "Typical")
                    {
                        BindAuthSystems();
                        if (InstallAuthSystems())
                        {
                            //Skip Auth Systems Page
                            wizInstall.ActiveStepIndex = 8;
                        }
                    }
                    break;
                case 8: //Page 8 - Providers
                    if (installTypeRadioButton.SelectedValue == "Typical")
                    {
                        BindProviders();
                        if (InstallProviders())
                        {
                            //Skip Providers Page
                            wizInstall.ActiveStepIndex = 9;
                        }
                    }
                    break;
                case 9: //Page 9 - SMTP Settings
                    if (installTypeRadioButton.SelectedValue == "Full")
                    {
                        SMTPSettingsPanel.Visible = true;
                    }
					break;
            }
            
            SetupPage();
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
                    if (installTypeRadioButton.SelectedValue == "Auto")
                    {
                        Response.Redirect("~/Install/Install.aspx?mode=install");
                    }
                    break;
                case 1: //Page 1 - File Permissions
                    BindPermissions(true);
                    e.Cancel = !PermissionsValid;
                    break;
                case 2: //Page 2 - Database Configuration
                    bool canConnect = TestDatabaseConnection();
                    if (canConnect)
                    {
                        //Update Connection String
                        Config.UpdateConnectionString(_connectionString);
                        string dbOwner;
                        if (chkOwner.Checked)
                        {
                            dbOwner = "dbo";
                        }
                        else
                        {
                            dbOwner = (string.IsNullOrEmpty(GetUpgradeConnectionStringUserID()))
                                            ? txtUserId.Text
                                            : GetUpgradeConnectionStringUserID();
                        }
                        if (rblDatabases.SelectedValue == "Oracle")
                        {
                            Config.UpdateDataProvider("OracleDataProvider", "", txtqualifier.Text);
                        }
                        else
                        {
                            Config.UpdateDataProvider("SqlDataProvider", dbOwner, txtqualifier.Text);
                        }

                        //Get Base DatabaseVersion
                        GetBaseDatabaseVersion();
                    }
                    else
                    {
                        e.Cancel = true;
                    }

                    break;
                case 3: //Page 3 - Database Installation
                    e.Cancel = !TestDataBaseInstalled();
                    break;
                case 4: //Page 4 - Modules
                    e.Cancel = !InstallModules();
                    break;
                case 5: //Page 5 - Skins/Containers
                    e.Cancel = !InstallSkins();
                    break;
                case 6: //Page 6 - Languages
                    e.Cancel = !InstallLanguages();
                    break;
                case 7: //Page 7 - Auth Systems
                    e.Cancel = !InstallAuthSystems();
                    break;
                case 8: //Page 8 - Providers
                    e.Cancel = !InstallProviders();
                    break;
                case 9: //Page 9 - Admin/Host User
					//Check if SMTP needs to be tested
					if (!String.IsNullOrEmpty(txtSMTPServer.Text))
					{
						if (!TestSMTPSettings())
						{
							e.Cancel = true;
							return;
						}
					}
					if (!InstallHost())
					{
						e.Cancel = true;
						return;
					}
                    e.Cancel = !InstallPortal();
                    break;
            }
        }

        // ReSharper restore InconsistentNaming

        #endregion
    }
}
