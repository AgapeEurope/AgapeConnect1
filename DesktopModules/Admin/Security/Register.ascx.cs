#region Copyright

// 
// DotNetNuke® - http://www.dotnetnuke.com
// Copyright (c) 2002-2011
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
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Globalization;
using System.IO;
using System.Web;

using DotNetNuke.Common;
using DotNetNuke.Common.Lists;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Users;
using DotNetNuke.Entities.Users.Internal;
using DotNetNuke.Security;
using DotNetNuke.Security.Membership;
using DotNetNuke.Security.Permissions;
using DotNetNuke.Services.Authentication;
using DotNetNuke.Services.Exceptions;
using DotNetNuke.Services.Localization;
using DotNetNuke.UI.Skins.Controls;
using DotNetNuke.Entities.Profile;
using DotNetNuke.Web.UI.WebControls;
using DotNetNuke.UI.WebControls;
using System.Web.UI.WebControls;

#endregion

namespace DotNetNuke.Modules.Admin.Users
{
    public partial class Register : UserUserControlBase
    {
        private readonly List<AuthenticationLoginBase> _loginControls = new List<AuthenticationLoginBase>();

        #region Protected Properties

        protected string AuthenticationType
        {
            get
            {
                var authenticationType = Null.NullString;
                if (ViewState["AuthenticationType"] != null)
                {
                    authenticationType = Convert.ToString(ViewState["AuthenticationType"]);
                }
                return authenticationType;
            }
            set
            {
                ViewState["AuthenticationType"] = value;
            }
        }

        protected UserCreateStatus CreateStatus { get; set; }

        protected string DisplayNameFormat
        {
            get
            {
                return GetSettingValue("Security_DisplayNameFormat");
            }
        }

        protected string EmailValidator
        {
            get
            {
                return GetSettingValue("Security_EmailValidation");
            }
        }

        protected string ExcludeTerms
        {
            get
            {
                string excludeTerms = GetSettingValue("Registration_ExcludeTerms");
                string regex = String.Empty;
                if (!String.IsNullOrEmpty(excludeTerms))
                {
                    regex = @"^(?:(?!" + excludeTerms.Replace(" ", "").Replace(",", "|") + @").)*$\r?\n?";
                }
                return regex;
            }
        }

        protected bool IsValid
        {
            get
            {
                return Validate();
            }
        }

        protected bool RandomPassword
        {
            get
            {
                return Convert.ToBoolean(GetSetting(PortalId, "Registration_RandomPassword"));
            }
        }

        protected string RedirectURL
        {
            get
            {
                string _RedirectURL = "";

                object setting = GetSetting(PortalId, "Redirect_AfterRegistration");

                if (Convert.ToInt32(setting) == Null.NullInteger)
                {
                    if (Request.QueryString["returnurl"] != null)
                    {
                        //return to the url passed to register
                        _RedirectURL = HttpUtility.UrlDecode(Request.QueryString["returnurl"]);
                        //redirect url should never contain a protocol ( if it does, it is likely a cross-site request forgery attempt )
                        if (_RedirectURL.Contains("://"))
                        {
                            _RedirectURL = "";
                        }
                        if (_RedirectURL.Contains("?returnurl"))
                        {
                            string baseURL = _RedirectURL.Substring(0, _RedirectURL.IndexOf("?returnurl", StringComparison.Ordinal));
                            string returnURL = _RedirectURL.Substring(_RedirectURL.IndexOf("?returnurl", StringComparison.Ordinal) + 11);

                            _RedirectURL = string.Concat(baseURL, "?returnurl", HttpUtility.UrlEncode(returnURL));
                        }
                    }
                    if (String.IsNullOrEmpty(_RedirectURL))
                    {
                        //redirect to current page 
                        _RedirectURL = Globals.NavigateURL();
                    }
                }
                else //redirect to after registration page
                {
                    _RedirectURL = Globals.NavigateURL(Convert.ToInt32(setting));
                }
                return _RedirectURL;
            }
        }

        protected string RegistrationFields
        {
            get
            {
                return GetSettingValue("Registration_RegistrationFields");
            }
        }

        protected int RegistrationFormType
        {
            get
            {
                return Convert.ToInt32(GetSettingValue("Registration_RegistrationFormType"));
            }
        }

        protected bool RequirePasswordConfirm
        {
            get
            {
                return Convert.ToBoolean(GetSetting(PortalId, "Registration_RequireConfirmPassword"));
            }
        }

        protected bool RequireUniqueDisplayName
        {
            get
            {
                return Convert.ToBoolean(GetSetting(PortalId, "Registration_RequireUniqueDisplayName"));
            }
        }

        protected bool RequireValidProfile
        {
            get
            {
                return Convert.ToBoolean(GetSetting(PortalId, "Security_RequireValidProfile"));
            }
        }

        protected bool UseAuthProviders
        {
            get
            {
                return Convert.ToBoolean(GetSetting(PortalId, "Registration_UseAuthProviders"));
            }
        }

        protected bool UseCaptcha
        {
            get
            {
                return Convert.ToBoolean(GetSetting(PortalId, "Security_CaptchaRegister"));
            }
        }

        protected bool UseEmailAsUserName
        {
            get
            {
                return Convert.ToBoolean(GetSetting(PortalId, "Registration_UseEmailAsUserName"));
            }
        }

        protected string UserNameValidator
        {
            get
            {
                return GetSettingValue("Security_UserNameValidation");
            }
        }

        protected bool UseProfanityFilter
        {
            get
            {
                return Convert.ToBoolean(GetSetting(PortalId, "Registration_UseProfanityFilter"));
            }
        }

        protected string UserToken
        {
            get
            {
                var userToken = "";
                if (ViewState["UserToken"] != null)
                {
                    userToken = Convert.ToString(ViewState["UserToken"]);
                }
                return userToken;
            }
            set
            {
                ViewState["UserToken"] = value;
            }
        }

        #endregion

        private void AddField(string dataField, string dataMember, bool required, string regexValidator, TextBoxMode textMode)
        {
            var formItem = new DnnFormTextBoxItem
                               {
                                   ID = dataField,
                                   DataField = dataField,
                                   DataMember = dataMember,
                                   Visible = true,
                                   Required = required,
                                   TextMode = textMode
                               };
            if (!String.IsNullOrEmpty(regexValidator))
            {
                formItem.ValidationExpression = regexValidator;
            }            
            userForm.Items.Add(formItem);
        }

        private void AddProperty(ProfilePropertyDefinition property)
        {
            var controller = new ListController();
            ListEntryInfo imageType = controller.GetListEntryInfo("DataType", "Image");
            if (property.DataType != imageType.EntryID)
            {
                DnnFormEditControlItem formItem = new DnnFormEditControlItem
                                                        {
                                                            ID = property.PropertyName,
                                                            ResourceKey = String.Format("ProfileProperties_{0}", property.PropertyName),
                                                            LocalResourceFile = "~/DesktopModules/Admin/Security/App_LocalResources/Profile.ascx.resx",
                                                            ControlType = EditorInfo.GetEditor(property.DataType),
                                                            DataMember = "Profile",
                                                            DataField = property.PropertyName,
                                                            Visible = property.Visible,
                                                            Required = property.Required
                                                        };
                //To check if the property has a deafult value
                if (!String.IsNullOrEmpty(property.DefaultValue))
                {
                    formItem.Value = property.DefaultValue;
                }
                userForm.Items.Add(formItem);
            }

        }

        private void BindLoginControl(AuthenticationLoginBase authLoginControl, AuthenticationInfo authSystem)
        {
            //set the control ID to the resource file name ( ie. controlname.ascx = controlname )
            //this is necessary for the Localization in PageBase
            authLoginControl.AuthenticationType = authSystem.AuthenticationType;
            authLoginControl.ID = Path.GetFileNameWithoutExtension(authSystem.LoginControlSrc) + "_" + authSystem.AuthenticationType;
            authLoginControl.LocalResourceFile = authLoginControl.TemplateSourceDirectory + "/" + Localization.LocalResourceDirectory + "/" +
                                                 Path.GetFileNameWithoutExtension(authSystem.LoginControlSrc);
            authLoginControl.RedirectURL = RedirectURL;
            authLoginControl.ModuleConfiguration = ModuleConfiguration;

            authLoginControl.UserAuthenticated += UserAuthenticated;
        }

        private void CreateUser()
        {
            //Update DisplayName to conform to Format
            UpdateDisplayName();

            User.Membership.Approved = PortalSettings.UserRegistration == (int)Globals.PortalRegistrationType.PublicRegistration;
            var user = User;
            CreateStatus = UserController.CreateUser(ref user);

            DataCache.ClearPortalCache(PortalId, true);

            try
            {
                if (CreateStatus == UserCreateStatus.Success)
                {
                    //hide the succesful captcha
                    captchaRow.Visible = false;

                    //Assocate alternate Login with User and proceed with Login
                    if(!String.IsNullOrEmpty(AuthenticationType))
                    {
                        AuthenticationController.AddUserAuthentication(User.UserID, AuthenticationType, UserToken);
                    }

                    string strMessage = CompleteUserCreation(CreateStatus, user, true, IsRegister);

                    if ((string.IsNullOrEmpty(strMessage)))
                    {
                        Response.Redirect(RedirectURL, true);
                    }
                }
                else
                {
                    AddLocalizedModuleMessage(UserController.GetUserCreateStatus(CreateStatus), ModuleMessage.ModuleMessageType.RedError, true);
                }
            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }

        private string GetSettingValue(string key)
        {
            var value = String.Empty;
            var setting = GetSetting(UserPortalID, key);
            if ((setting != null) && (!String.IsNullOrEmpty(Convert.ToString(setting))))
            {
                value = Convert.ToString(setting);
            }
            return value;
           
        }

        private void UpdateDisplayName()
        {
            //Update DisplayName to conform to Format
            object setting = GetSetting(UserPortalID, "Security_DisplayNameFormat");
            if ((setting != null) && (!string.IsNullOrEmpty(Convert.ToString(setting))))
            {
                User.UpdateDisplayName(Convert.ToString(setting));
            }
        }

        private bool Validate()
        {
            CreateStatus = UserCreateStatus.AddUser;
            var portalSecurity = new PortalSecurity();

            //Check User Editor
            bool _IsValid = userForm.IsValid;

            if (RegistrationFormType == 0)
            {
                //Update UserName
                if (UseEmailAsUserName)
                {
                    User.Username = User.Email;
                    if (String.IsNullOrEmpty(User.DisplayName))
                    {
                        User.DisplayName = User.Email.Substring(0, User.Email.IndexOf("@", StringComparison.Ordinal));
                    }
                }

                //Check Password is valid
                if (!RandomPassword)
                {
                    //Check Password is Valid
                    if (CreateStatus == UserCreateStatus.AddUser && !UserController.ValidatePassword(User.Membership.Password))
                    {
                        CreateStatus = UserCreateStatus.InvalidPassword;
                    }

                    if (RequirePasswordConfirm && String.IsNullOrEmpty(AuthenticationType))
                    {
                        if (User.Membership.Password != User.Membership.PasswordConfirm)
                        {
                            CreateStatus = UserCreateStatus.PasswordMismatch;
                        }
                    }
                }
                else
                {
                    //Generate a random password for the user
                    User.Membership.Password = UserController.GeneratePassword();
                    User.Membership.PasswordConfirm = User.Membership.Password;
                }

            }
            else
            {
                //Set Username to Email
                if (String.IsNullOrEmpty(User.Username))
                {
                    User.Username = User.Email;
                }

                //Set DisplayName
                if (String.IsNullOrEmpty(User.DisplayName))
                {
                    User.DisplayName = String.IsNullOrEmpty(User.FirstName + " " + User.LastName)
                                           ? User.Email.Substring(0, User.Email.IndexOf("@", StringComparison.Ordinal))
                                           : User.FirstName + " " + User.LastName;
                }
                
                //Random Password
                if (String.IsNullOrEmpty(User.Membership.Password))
                {
                    //Generate a random password for the user
                    User.Membership.Password = UserController.GeneratePassword();
                }

                //Password Confirm
                if (!String.IsNullOrEmpty(User.Membership.PasswordConfirm))
                {
                    if (User.Membership.Password != User.Membership.PasswordConfirm)
                    {
                        CreateStatus = UserCreateStatus.PasswordMismatch;
                    }
                }
            }

            ////Validate Exclude Terms
            //if (!String.IsNullOrEmpty(ExcludeTerms))
            //{
            //    string[] excludeTerms = ExcludeTerms.Split(',');
            //    foreach (string term in excludeTerms)
            //    {
            //        var trimmedTerm = term.Trim().ToLowerInvariant();
            //        if (User.Username.ToLowerInvariant().Contains(trimmedTerm))
            //        {
            //            CreateStatus = UserCreateStatus.InvalidUserName;
            //        }
            //        if (User.DisplayName.ToLowerInvariant().Contains(trimmedTerm))
            //        {
            //            CreateStatus = UserCreateStatus.InvalidDisplayName;
            //        }
            //    }
            //}

            //Validate Profanity
            if (UseProfanityFilter)
            {
                if (!portalSecurity.ValidateInput(User.Username, PortalSecurity.FilterFlag.NoProfanity))
                {
                    CreateStatus = UserCreateStatus.InvalidUserName;
                }
                if (!String.IsNullOrEmpty(User.DisplayName))
                {
                    if (!portalSecurity.ValidateInput(User.DisplayName, PortalSecurity.FilterFlag.NoProfanity))
                    {
                        CreateStatus = UserCreateStatus.InvalidDisplayName;
                    }
                }
            }

            //Validate Unique User Name
            UserInfo user = UserController.GetUserByName(PortalId, User.Username);
            if (user != null)
            {
                if(UseEmailAsUserName)
                {
                    CreateStatus = UserCreateStatus.DuplicateEmail;
                }
                else
                {
                CreateStatus = UserCreateStatus.DuplicateUserName;
                int i = 1;
                string userName = null;
                while (user != null)
                {
                    userName = User.Username + "0" + i.ToString(CultureInfo.InvariantCulture);
                    user = UserController.GetUserByName(PortalId, userName);
                    i++;
                }
                User.Username = userName;
                }
            }

            //Validate Unique Display Name
            if (CreateStatus == UserCreateStatus.AddUser && RequireUniqueDisplayName)
            {
                user = TestableUserController.Instance.GetUserByDisplayname(PortalId, User.DisplayName);
                if (user != null)
                {
                    CreateStatus = UserCreateStatus.DuplicateDisplayName;
                    int i = 1;
                    string displayName = null;
                    while (user != null)
                    {
                        displayName = User.DisplayName + " 0" + i.ToString(CultureInfo.InvariantCulture);
                        user = TestableUserController.Instance.GetUserByDisplayname(PortalId, displayName);
                        i++;
                    }
                    User.DisplayName = displayName;
                }
            }

            //Check Question/Answer
            if (CreateStatus == UserCreateStatus.AddUser && MembershipProviderConfig.RequiresQuestionAndAnswer)
            {
                if (string.IsNullOrEmpty(User.Membership.PasswordQuestion))
                {
                    //Invalid Question
                    CreateStatus = UserCreateStatus.InvalidQuestion;
                }
                if (CreateStatus == UserCreateStatus.AddUser)
                {
                    if (string.IsNullOrEmpty(User.Membership.PasswordAnswer))
                    {
                        //Invalid Question
                        CreateStatus = UserCreateStatus.InvalidAnswer;
                    }
                }
            }

            if (CreateStatus != UserCreateStatus.AddUser)
            {
                _IsValid = false;
            }
            return _IsValid;
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            if (RegistrationFormType == 0)
            {
                //UserName
                if (!UseEmailAsUserName)
                {
                    
                    AddField("Username", String.Empty, true, 
                            String.IsNullOrEmpty(UserNameValidator) ? ExcludeTerms : UserNameValidator, 
                            TextBoxMode.SingleLine);
                }

                //Password
                if (!RandomPassword)
                {
                    AddField("Password", "Membership", true, String.Empty, TextBoxMode.Password);
                    if (RequirePasswordConfirm)
                    {
                        AddField("PasswordConfirm", "Membership", true, String.Empty, TextBoxMode.Password);
                    }
                }

                //Password Q&A
                if (MembershipProviderConfig.RequiresQuestionAndAnswer)
                {
                    AddField("PasswordQuestion", "Membership", true, String.Empty, TextBoxMode.SingleLine);
                    AddField("PasswordAnswer", "Membership", true, String.Empty, TextBoxMode.SingleLine);
                }

                //DisplayName
                if (String.IsNullOrEmpty(DisplayNameFormat))
                {
                    //DisplayName has an additional validator
                    AddField("DisplayName", String.Empty, true, String.Empty, TextBoxMode.SingleLine);
                }
                else
                {
                    AddField("FirstName", String.Empty, true, String.Empty, TextBoxMode.SingleLine);
                    AddField("LastName", String.Empty, true, String.Empty, TextBoxMode.SingleLine);
                }

                //Email
                AddField("Email", String.Empty, true, EmailValidator, TextBoxMode.SingleLine);

                if (RequireValidProfile)
                {
                    foreach (ProfilePropertyDefinition property in User.Profile.ProfileProperties)
                    {
                        if (property.Required)
                        {
                            AddProperty(property);
                        }
                    }
                }
            }
            else
            {
                string[] fields = RegistrationFields.Split(',');
                foreach (string field in fields)
                {
                    var trimmedField = field.Trim();
                    switch (trimmedField)
                    {
                        case "Username":
                            AddField("Username", String.Empty, true, String.IsNullOrEmpty(UserNameValidator) 
                                                                        ? ExcludeTerms : UserNameValidator, 
                                                                        TextBoxMode.SingleLine);
                            break;
                        case "Email":
                            AddField("Email", String.Empty, true, EmailValidator, TextBoxMode.SingleLine);
                            break;
                        case "Password":
                        case "PasswordConfirm":
                            AddField(trimmedField, "Membership", true, String.Empty, TextBoxMode.Password);
                            break;
                        case "PasswordQuestion":
                        case "PasswordAnswer":
                            AddField(trimmedField, "Membership", true, String.Empty, TextBoxMode.SingleLine);
                            break;
                        case "DisplayName":
                            //DisplayName has an additional validator
                            AddField(trimmedField, String.Empty, true, ExcludeTerms, TextBoxMode.SingleLine);
                            break;
                        default:
                            ProfilePropertyDefinition property = User.Profile.GetProperty(trimmedField);
                            if (property != null)
                            {
                                AddProperty(property);
                            }
                            break;
                    }
                }
            }

            //Verify that the current user has access to this page
            if (PortalSettings.UserRegistration == (int)Globals.PortalRegistrationType.NoRegistration && Request.IsAuthenticated == false)
            {
                Response.Redirect(Globals.NavigateURL("Access Denied"), true);
            }

            cancelButton.Click += cancelButton_Click;
            registerButton.Click += registerButton_Click;

            if(UseAuthProviders)
            {
                List<AuthenticationInfo> authSystems = AuthenticationController.GetEnabledAuthenticationServices();
                foreach (AuthenticationInfo authSystem in authSystems)
                {
                    try
                    {
                        var authLoginControl = (AuthenticationLoginBase)LoadControl("~/" + authSystem.LoginControlSrc);
                        if (authSystem.AuthenticationType != "DNN")
                        {
                            BindLoginControl(authLoginControl, authSystem);
                            //Check if AuthSystem is Enabled
                            if (authLoginControl.Enabled && authLoginControl.SupportsRegistration)
                            {
                                authLoginControl.Mode = AuthMode.Register;

                                //Add Login Control to List
                                _loginControls.Add(authLoginControl);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Exceptions.LogException(ex);
                    }
                }
            }
        }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            if (Request.IsAuthenticated)
            {
                //if a Login Page has not been specified for the portal
                if (Globals.IsAdminControl())
                {
                    //redirect to current page 
                    Response.Redirect(Globals.NavigateURL(), true);
                }
                else //make module container invisible if user is not a page admin
                {
                    if (!TabPermissionController.CanAdminPage())
                    {
                        ContainerControl.Visible = false;
                    }
                }
            }

            if (UseCaptcha)
            {
                captchaRow.Visible = true;
                ctlCaptcha.ErrorMessage = Localization.GetString("InvalidCaptcha", LocalResourceFile);
                ctlCaptcha.Text = Localization.GetString("CaptchaText", LocalResourceFile);
            }

            if (UseAuthProviders && String.IsNullOrEmpty(AuthenticationType))
            {
                foreach (AuthenticationLoginBase authLoginControl in _loginControls)
                {
                    socialLoginControls.Controls.Add(authLoginControl);
                }
            }

            //Display relevant message
            userHelpLabel.Text = Localization.GetSystemMessage(PortalSettings, "MESSAGE_REGISTRATION_INSTRUCTIONS");
            switch (PortalSettings.UserRegistration)
            {
                case (int)Globals.PortalRegistrationType.PrivateRegistration:
                    userHelpLabel.Text += Localization.GetString("PrivateMembership", Localization.SharedResourceFile);
                    break;
                case (int)Globals.PortalRegistrationType.PublicRegistration:
                    userHelpLabel.Text += Localization.GetString("PublicMembership", Localization.SharedResourceFile);
                    break;
                case (int)Globals.PortalRegistrationType.VerifiedRegistration:
                    userHelpLabel.Text += Localization.GetString("VerifiedMembership", Localization.SharedResourceFile);
                    break;
            }
            userHelpLabel.Text += Localization.GetString("Required", LocalResourceFile);
            userHelpLabel.Text += Localization.GetString("RegisterWarning", LocalResourceFile);

            userForm.DataSource = User;
            if (!Page.IsPostBack)
            {
                userForm.DataBind();
            }
        }

        private void cancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect(RedirectURL, true);
        }

        private void registerButton_Click(object sender, EventArgs e)
        {
            if ((UseCaptcha && ctlCaptcha.IsValid) || !UseCaptcha)
            {
                if (IsValid)
                {
                    CreateUser();
                }
                else
                {
                    AddLocalizedModuleMessage(UserController.GetUserCreateStatus(CreateStatus), ModuleMessage.ModuleMessageType.RedError, true);
                    userForm.DataBind();
                }                
            }
        }

        private void UserAuthenticated(object sender, UserAuthenticatedEventArgs e)
        {
            NameValueCollection profileProperties = e.Profile;

            User.Username = e.UserToken;
            AuthenticationType = e.AuthenticationType;
            UserToken = e.UserToken;

            foreach (string key in profileProperties)
            {
                switch (key)
                {
                    case "FirstName":
                            User.FirstName = profileProperties[key];
                        break;
                    case "LastName":
                            User.LastName = profileProperties[key];
                        break;
                    case "Email":
                            User.Email = profileProperties[key];
                        break;
                    case "DisplayName":
                            User.DisplayName = profileProperties[key];
                        break;
                    default:
                        User.Profile.SetProfileProperty(key, profileProperties[key]);
                        break;
                }
            }

            //Generate a random password for the user
            User.Membership.Password = UserController.GeneratePassword();

            if (!String.IsNullOrEmpty(User.Email))
            {
                CreateUser();
            }
            else
            {
                AddLocalizedModuleMessage(LocalizeString("NoEmail"), ModuleMessage.ModuleMessageType.RedError, true);
                foreach(DnnFormItemBase formItem in userForm.Items)
                {
                    formItem.Visible = formItem.DataField == "Email";
                }
                userForm.DataBind();
            }
        }
    }
}