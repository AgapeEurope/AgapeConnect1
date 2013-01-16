#region Usings

using System;
using System.Linq;
using System.Net;
using System.Web;

using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Host;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Users;
using DotNetNuke.Instrumentation;
using DotNetNuke.Security.Membership;
using DotNetNuke.Services.Authentication;
using DotNetNuke.Services.Localization;
using DotNetNuke.UI.Skins.Controls;
using DotNetNuke.UI.Utilities;

using Globals = DotNetNuke.Common.Globals;

#endregion

namespace DotNetNuke.Modules.AgapeFR.Authentication
{

    /// <summary>
    /// The Login AuthenticationLoginBase is used to provide a login for a registered user
    /// portal.
    /// </summary>
    public partial class Login : AuthenticationLoginBase
    {

        #region Public Properties

        /// <summary>
        /// Check if the Auth System is Enabled (for the Portal)
        /// </summary>
        /// <remarks></remarks>
        /// <history>
        /// 	[cnurse]	07/04/2007	Created
        /// </history>
        public override bool Enabled
        {
            get
            {
                return AgapeAuthConfig.GetConfig(PortalId).Enabled;
            }
        }

        #endregion

        #region Event Handlers

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            cmdLogin.Click += OnLoginClick;

            ClientAPI.RegisterKeyCapture(Parent, cmdLogin, 13);

            lblLogin.Text = Localization.GetSystemMessage(PortalSettings, "MESSAGE_LOGIN_INSTRUCTIONS");

            var returnUrl = Globals.NavigateURL();
            string url;

            if (!string.IsNullOrEmpty(Request.QueryString["returnurl"]))
            {
                returnUrl = Request.QueryString["returnurl"];
            }
            returnUrl = HttpUtility.UrlEncode(returnUrl);

            //DAVID: Mettre retuen URL en session pour la récupérer dans register ?

            //see if the portal supports persistant cookies
            chkCookie.Visible = Host.RememberCheckbox;

            url = Globals.NavigateURL("SendPassword", "returnurl=" + returnUrl);
            passwordLink.NavigateUrl = url;
            if (PortalSettings.EnablePopUps)
            {
                passwordLink.Attributes.Add("onclick", "return " + UrlUtils.PopUpUrl(url, this, PortalSettings, true, false, 300, 650));
            }


            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["verificationcode"]) &&
                    PortalSettings.UserRegistration == (int)Globals.PortalRegistrationType.VerifiedRegistration)
                {
                    if (Request.IsAuthenticated)
                    {
                        Controls.Clear();
                    }

                    var verificationCode = Request.QueryString["verificationcode"];


                    try
                    {
                        UserController.VerifyUser(verificationCode.Replace(".", "+").Replace("-", "/").Replace("_", "="));
                        UI.Skins.Skin.AddModuleMessage(this, Localization.GetString("VerificationSuccess", LocalResourceFile), ModuleMessage.ModuleMessageType.GreenSuccess);
                    }
                    catch (UserAlreadyVerifiedException)
                    {
                        UI.Skins.Skin.AddModuleMessage(this, Localization.GetString("UserAlreadyVerified", LocalResourceFile), ModuleMessage.ModuleMessageType.YellowWarning);
                    }
                    catch (InvalidVerificationCodeException)
                    {
                        UI.Skins.Skin.AddModuleMessage(this, Localization.GetString("InvalidVerificationCode", LocalResourceFile), ModuleMessage.ModuleMessageType.RedError);
                    }
                    catch (UserDoesNotExistException)
                    {
                        UI.Skins.Skin.AddModuleMessage(this, Localization.GetString("UserDoesNotExist", LocalResourceFile), ModuleMessage.ModuleMessageType.RedError);
                    }
                    catch (Exception)
                    {
                        UI.Skins.Skin.AddModuleMessage(this, Localization.GetString("InvalidVerificationCode", LocalResourceFile), ModuleMessage.ModuleMessageType.RedError);
                    }
                }
            }

            if (!Request.IsAuthenticated)
            {
                if (Page.IsPostBack == false)
                {
                    try
                    {
                        if (Request.QueryString["username"] != null)
                        {
                            txtUsername.Text = Request.QueryString["username"];
                        }
                    }
                    catch (Exception ex)
                    {
                        //control not there 
                        DnnLog.Error(ex);
                    }
                }
                try
                {
                    Globals.SetFormFocus(string.IsNullOrEmpty(txtUsername.Text) ? txtUsername : txtPassword);
                }
                catch (Exception ex)
                {
                    //Not sure why this Try/Catch may be necessary, logic was there in old setFormFocus location stating the following
                    //control not there or error setting focus
                    DnnLog.Error(ex);
                }
            }

            var registrationType = PortalController.GetPortalSettingAsInteger("Registration_RegistrationFormType", PortalId, 0);
            bool useEmailAsUserName;
            if (registrationType == 0)
            {
                useEmailAsUserName = PortalController.GetPortalSettingAsBoolean("Registration_UseEmailAsUserName", PortalId, false);
            }
            else
            {
                var registrationFields = PortalController.GetPortalSetting("Registration_RegistrationFields", PortalId, String.Empty);
                useEmailAsUserName = !registrationFields.Contains("Username");
            }

            plUsername.Text = LocalizeString(useEmailAsUserName ? "Email" : "Username");
        }

        private void OnLoginClick(object sender, EventArgs e)
        {
            var loginStatus = UserLoginStatus.LOGIN_FAILURE;
            var objUser = UserController.ValidateUser(PortalId, txtUsername.Text, txtPassword.Text, "DNN", string.Empty, PortalSettings.PortalName, IPAddress, ref loginStatus);
            var authenticated = Null.NullBoolean;
            var message = Null.NullString;
            if (loginStatus == UserLoginStatus.LOGIN_USERNOTAPPROVED)
            {
                message = "UserNotAuthorized";
            }
            else
            {
                authenticated = (loginStatus != UserLoginStatus.LOGIN_FAILURE);
            }

            //Raise UserAuthenticated Event
            var eventArgs = new UserAuthenticatedEventArgs(objUser, txtUsername.Text, loginStatus, "DNN")
                                {
                                    Authenticated = authenticated,
                                    Message = message,
                                    RememberMe = chkCookie.Checked
                                };
            OnUserAuthenticated(eventArgs);
        }


        #endregion

    }
}