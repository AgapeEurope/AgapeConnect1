<%@ Page Language="C#" AutoEventWireup="false" Inherits="DotNetNuke.Services.Install.InstallWizard" CodeFile="InstallWizard.aspx.cs" %>
<%@ Import Namespace="DotNetNuke.UI.Utilities" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="WizardUser" Src="~/Install/WizardUser.ascx" %>
<%@ Register TagPrefix="dnncrm" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <asp:PlaceHolder runat="server" ID="ClientDependencyHeadCss"></asp:PlaceHolder>
    <asp:PlaceHolder runat="server" ID="ClientDependencyHeadJs"></asp:PlaceHolder>
    <link rel="stylesheet" type="text/css" href="../Portals/_default/default.css?refresh" />
    <link rel="stylesheet" type="text/css" href="Install.css?refresh" />    
    <script type="text/javascript" src="../Resources/Shared/scripts/jquery/jquery.min.js"></script>
    <asp:placeholder id="SCRIPTS" runat="server"></asp:placeholder>
</head>
<body>      
    <script type="text/javascript">
        var BARS = 20;  // The number of bars to display
        var CLASS = "Progress"; // Style class name when bar is off
        var CLASS_ON_SUFFIX = "On";  // Suffix to append to style class name when bar is on
        var SPEED = 200; // Delay in milliseconds for animation

        var ELEMENT_ID_PREFIX = "Progress_"; // ID prefix for progress bar elements
        var current = 0; // Last rendered progress bar element
        var pageNo = <%=ClientAPI.GetSafeJSString(wizInstall.ActiveStepIndex.ToString())%>;
        var initialAction = '<%=GetBaseDatabaseVersion()%>';
        var nextButtonID = 'wizInstall_StepNavigationTemplateContainerID_StepNextButton';
        var prevButtonID = 'wizInstall_StepNavigationTemplateContainerID_StepPreviousButton';
        var timeOut;

         //Localization Vars
        var m_sLocaleComplete = '<%=ClientAPI.GetSafeJSString(LocalizeString("Complete"))%>';
        var m_sLocaleSuccess = '<%=ClientAPI.GetSafeJSString(LocalizeString("Success"))%>';
        var m_sLocaleFailure = '<%=ClientAPI.GetSafeJSString(LocalizeString("Failure"))%>';
        var m_sLocaleInstalling = '<%=ClientAPI.GetSafeJSString(LocalizeString("Installing"))%>';
        var m_sLocaleInstallComplete = '<%=ClientAPI.GetSafeJSString(LocalizeString("InstallComplete"))%>';
        var m_sLocaleInstallDatabase = '<%=ClientAPI.GetSafeJSString(LocalizeString("InstallDatabase"))%>';
        var m_sLocaleInstallScript = '<%=ClientAPI.GetSafeJSString(LocalizeString("InstallScript"))%>';
        var m_sLocaleInstallFailed = '<%=ClientAPI.GetSafeJSString(LocalizeString("InstallFailed"))%>';
        
        function animate()
        {
           var progressObj = document.getElementById(ELEMENT_ID_PREFIX + current);
           progressObj.className = CLASS + (progressObj.className == CLASS ? CLASS_ON_SUFFIX : "");

           current++;
           if (current == BARS)
               current = 0;      

           timeOut = window.setTimeout("animate()", SPEED);
        }

        function createAnimation()
        {
           // Create the progress bar
           var progress = document.getElementById("Progress");
           for(var p=0;p<BARS;p++)
           {
               var pDiv = document.createElement("div");
               pDiv.innerHTML = "&nbsp;&nbsp;";
               pDiv.className = CLASS;
               pDiv.id = "Progress_" + p;
               progress.appendChild(pDiv);
           }

           // Start the animation
           animate();
        }
        
        function stopAnimation()
        {
            window.clearTimeout(timeOut);                 
        }
        
        function installScripts()
        {
            if (pageNo == 3)
            {
                createAnimation();
                doCallbackAction(initialAction);
            }
        }

        function doCallbackAction(sAction)
        {
            var sFeedback;
            if (sAction == initialAction)
            {
                sFeedback = m_sLocaleInstallDatabase.replace('{0}', sAction);
            }
            else 
            {
                if (sAction.indexOf(".") > 0)
                {
                    sFeedback = m_sLocaleInstallScript.replace('{0}', sAction);
                }
            }
            reportAction(sFeedback + '...');
            var sCB = dnn.getVar('ActionCallback');
            eval(sCB.replace('[ACTIONTOKEN]', "'" + sAction + "'"));
        }
        
        function checkDisabled(button)
        {
            //return false;
            if (button.className == "dnnPrimaryAction dnnDisabledAction")
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        function reportAction(s)
        {
            $get('txtFeedback').value += s;
        }

        function successFunc(result, ctx)
        {
	        if (result != 'Done')
            {
                if (result.indexOf("ERROR") < 0)
                {
                    reportAction(m_sLocaleSuccess + '\n');
                    doCallbackAction(result);
                }
                else
                    errorFunc(result, ctx);
            }
            else
            {
                reportAction(m_sLocaleSuccess + '\n');
	            reportAction(m_sLocaleComplete + '\n');
                var progress = document.getElementById("Progress");
                progress.innerHTML = m_sLocaleInstallComplete;
                stopAnimation();
                var nextButton = document.getElementById(nextButtonID);
                nextButton.disabled = false;
                nextButton.className = "dnnPrimaryAction";
	        }
        }

        function errorFunc(result, ctx)
        {
	        reportAction(m_sLocaleFailure + ' ' + result + '\n');
            var progress = document.getElementById("Progress");
            progress.innerHTML = m_sLocaleInstallFailed;
            stopAnimation();
        }
    </script>
	<asp:placeholder runat="server" id="ClientResourceIncludes" />
    <form id="form1" runat="server">
        <asp:placeholder id="BodySCRIPTS" runat="server">
            <script type="text/javascript" src="../js/dnn.js"></script>
            <script type="text/javascript" src="../js/dnn.xml.js"></script>
            <script type="text/javascript" src="../js/dnn.xml.jsparser.js"></script>
            <script type="text/javascript" src="../js/dnn.xmlhttp.js"></script>
            <script type="text/javascript" src="../js/dnn.xmlhttp.jsxmlhttprequest.js"></script>
            <script type="text/javascript" src="../js/dnncore.js"></script>
            <script type="text/javascript" src="../js/dnn.jquery.js"></script>
            <script type="text/javascript" src="../Resources/Shared/Scripts/jquery/jquery.hoverIntent.min.js"></script>
            <script type="text/javascript" src="../Resources/Shared/Scripts/jquery/jquery-ui.min.js"></script>
            <script type="text/javascript" src="../Resources/Shared/Scripts/initTooltips.js"></script>
        </asp:placeholder>
        
        <div class="dnnForm dnnInstall dnnClear" id="dnnInstall">
            <asp:Wizard ID="wizInstall" runat="server" 
                ActiveStepIndex="0"
                Font-Names="Verdana" CellPadding="5" CellSpacing="5"
                FinishCompleteButtonType="Link"
                FinishPreviousButtonType="Link" 
                StartNextButtonType="Link" 
                StepNextButtonType="Link"
                StepPreviousButtonType="Link" 
                DisplaySideBar="false">
                <StepStyle VerticalAlign="Top" />
                <StartNavigationTemplate>
                    <ul class="dnnActions dnnClear">
    	                <li><asp:LinkButton id="StartNextButton" runat="server" CssClass="dnnPrimaryAction" CommandName="MoveNext" /></li>
                    </ul>
                </StartNavigationTemplate>
                <StepNavigationTemplate>
                    <ul class="dnnActions dnnClear">
    	                <li><asp:LinkButton id="StepNextButton" runat="server" CssClass="dnnPrimaryAction" CommandName="MoveNext" /></li>
                        <li><asp:LinkButton id="StepPreviousButton" runat="server" CssClass="dnnSecondaryAction" CommandName="MovePrevious" /></li>
                        <li><asp:LinkButton id="CustomButton" runat="server" CssClass="dnnSecondaryAction" Visible="false" OnClick="customButton_Click" /></li>
                    </ul>
                </StepNavigationTemplate>
                <HeaderTemplate>
                    <img src="../images/branding/logo.gif" border="0" alt="DotNetNuke">
                </HeaderTemplate>
                <WizardSteps>
                    <asp:WizardStep ID="introStep" runat="Server" Title="Welcome">
                        <h2><asp:Label ID="introTitleLabel" runat="server" /></h2>
                        <asp:Label ID="introDetailLabel" runat="Server" />
                        <hr />
                        <div id="languagePanel" runat="server" class="dnnForm">
							<div class="dnnFormItem">
                                <label for="<%=cboLanguages.ClientID%>"><%=LocalizeString("ChooseLanguage")%></label>
                                <asp:DropDownList ID="cboLanguages" AutoPostBack="true" runat="Server" DataTextField="Text" DataValueField="Code" />
                            </div>
                            <div class="dnnFormItem">
                                <label for="<%=installTypeRadioButton.ClientID%>"><%=LocalizeString("ChooseInstall")%></label>
                                <asp:RadioButtonList ID="installTypeRadioButton" runat="Server" RepeatDirection="Vertical" CssClass="installRadioButtons" />
                            </div>
                        </div>
                        <asp:Label ID="databaseWarningLabel" runat="server" CssClass="NormalRed" ResourceKey="DatabaseWarning" />
                        <asp:Label ID="hostWarningLabel" runat="server" CssClass="NormalRed" ResourceKey="HostWarning" />
                    </asp:WizardStep>
                    <asp:WizardStep ID="filePermissionsStep" runat="server" Title="FilePermissions">
                        <h2><asp:Label ID="filePermissionsTitleLabel" runat="server"  resourceKey="PermissionsTitle" /></h2>
                        <asp:Label ID="filePermissionsDetailLabel" runat="Server" resourceKey="PermissionsDetail" />
                        <hr />
                        <div class="dnnForm">
                            <div class="dnnFormItem">
                                    <label for="<%=lstPermissions.ClientID%>"><%=LocalizeString("Permissions")%></label>
                            </div>
                            <div class="dnnFormItem">
                                    <asp:CheckBoxList ID="lstPermissions" runat="server" CssClass="permissionsCheckBoxes" DataTextField="Name" DataValueField="Permission" TextAlign="Left" />
                            </div>
                        </div>
                        <asp:Label ID="permissionsErrorLabel" runat="server" />
                    </asp:WizardStep>
                    <asp:WizardStep ID="databaseConfigStep" runat="server" Title="ConnectionString" AllowReturn="false">
                        <h2><asp:Label ID="databaseConfigTitleLabel" runat="server" /></h2>
                        <asp:Label ID="databaseConfigDetailLabel" runat="Server" />
                        <hr />
                        <div class="dnnForm">
                            <div class="dnnFormItem">
                                <label for="<%=rblDatabases.ClientID%>"><%=LocalizeString("ChooseDatabase")%></label>
                                <asp:RadioButtonList ID="rblDatabases" runat="Server" CssClass="databaseRadioButtons"
                                    AutoPostBack="true" RepeatDirection="Vertical" RepeatColumns="1" />
                            </div>
                        </div>
                        <div id="databasePanel" runat="Server" visible="False" class="dnnForm">
                            <div class="dnnFormItem">
                                <dnn:Label runat="server" ResourceKey="Server" HelpKey="ServerHelp" ControlName="txtServer" />
                                <asp:TextBox ID="txtServer" runat="Server" />
                            </div>
                            <div id="fileRow" runat="server" class="dnnFormItem">
                                <dnn:Label ResourceKey="DatabaseFile" HelpKey="DatabaseFileHelp" runat="server" ControlName="txtFile" />
                                <asp:TextBox ID="txtFile" runat="Server" />
                            </div>
                            <div id="databaseRow" runat="server" class="dnnFormItem">
                                <dnn:Label ResourceKey="Database" HelpKey="DatabaseHelp" runat="server" ControlName="txtDatabase" />
                                <asp:TextBox ID="txtDatabase" runat="Server" />
                            </div>
                            <div id="integratedRow" runat="server" class="dnnFormItem">
                                <dnn:Label runat="server" ResourceKey="Integrated" HelpKey="IntegratedHelp" ControlName="chkIntegrated" />
                                <asp:CheckBox ID="chkIntegrated" runat="Server" AutoPostBack="True" />
                            </div>
                            <div id="userRow" runat="server" class="dnnFormItem">
                                <dnn:Label runat="server" ControlName="txtUserId" ResourceKey="UserId" HelpKey="UserHelp" />
                                <asp:TextBox ID="txtUserId" runat="Server" />
                            </div>
                            <div id="passwordRow" runat="server" class="dnnFormItem">
                                <dnn:Label runat="server" ControlName="txtPassword" ResourceKey="Password" HelpKey="PasswordHelp" />
                                <asp:TextBox ID="txtPassword" runat="Server" TextMode="Password" />
                            </div>
                            <div class="dnnFormItem">
                                <dnn:Label runat="server" ControlName="chkOwner" ResourceKey="Owner" HelpKey="OwnerHelp" />
                                <asp:CheckBox ID="chkOwner" runat="Server" />
                            </div>
                            <div class="dnnFormItem">
                                <dnn:Label runat="server" ControlName="txtqualifier" ResourceKey="Qualifier" HelpKey="QualifierHelp" />
                                <asp:TextBox ID="txtqualifier" runat="Server" />
                                <asp:RegularExpressionValidator ID="valQualifier" runat="server"
                                  resourcekey="InvalidQualifier.Text" 
                                  CssClass="dnnFormMessage dnnFormError"                                   
                                  ControlToValidate="txtqualifier"
                                  ValidationExpression="^[a-zA-Z][a-zA-Z0-9_]{0,19}$"
                                  ></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <br />
                        <asp:Label ID="databaseErrorLabel" runat="server" />
                    </asp:WizardStep>
                    <asp:WizardStep ID="databaseInstallStep" runat="server" Title="Database" AllowReturn="false">
                        <h2><asp:Label ID="databaseInstallTitleLabel" runat="server" /></h2>
                        <asp:Label ID="databaseInstallDetailLabel" runat="Server" />
                        <br />
                            <div id="Progress"><asp:Label ID="Label5" runat="server" resourceKey="Installing" /></div>
                        <br />
                        <textarea id="txtFeedback" class="FeedBack" cols="80" rows="15"></textarea>
                        <asp:Label ID="installErrorLabel" runat="server" />
                    </asp:WizardStep>
                    <asp:WizardStep ID="modulesStep" runat="server" Title="Modules" AllowReturn="false">
                        <h2><asp:Label ID="modulesTitleLabel" runat="server" /></h2>
                        <asp:Label ID="modulesDetailLabel" runat="Server" />
                        <hr />
                        <h3><asp:Label ID="lblModules" runat="server" /></h3>
                        <asp:CheckBoxList ID="lstModules" runat="server" RepeatColumns="3" RepeatDirection="Horizontal" />
                        <asp:Label ID="lblNoModules" runat="server" />
                        <hr />
                        <asp:Label ID="modulesErrorLabel" runat="server" />
                    </asp:WizardStep>
                    <asp:WizardStep ID="skinsStep" runat="server" Title="Skins" AllowReturn="false">
                        <h2><asp:Label ID="skinsTitleLabel" runat="server" /></h2>
                        <asp:Label ID="skinsDetailLabel" runat="Server" />
                        <hr />
                        <h3><asp:Label ID="lblSkins" runat="server" /></h3>
                        <asp:CheckBoxList ID="lstSkins" runat="server" RepeatColumns="3" RepeatDirection="Horizontal" />
                        <asp:Label ID="lblNoSkins" runat="server" />
                        <br />
                        <h3><asp:Label ID="lblContainers" runat="server" /></h3>
                        <asp:CheckBoxList ID="lstContainers" runat="server" RepeatColumns="3" RepeatDirection="Horizontal" />
                        <asp:Label ID="lblNoContainers" runat="server" />
                        <hr />
                        <asp:Label ID="skinsErrorLabel" runat="server" />
                    </asp:WizardStep>
                    <asp:WizardStep ID="languagesStep" runat="server" Title="Languages" AllowReturn="false">
                        <h2><asp:Label ID="languagesTitleLabel" runat="server" /></h2>
                        <asp:Label ID="languagesDetailLabel" runat="Server" />
                        <hr />
                        <h3><asp:Label ID="lblLanguages" runat="server" /></h3>
                        <asp:CheckBoxList ID="lstLanguages" runat="server" RepeatColumns="3" RepeatDirection="Horizontal" />
                        <asp:Label ID="lblNoLanguages" runat="server" />
                        <hr />
                        <asp:Label ID="languagesErrorLabel" runat="server" />
                    </asp:WizardStep>
                    <asp:WizardStep ID="authSystemsStep" runat="server" Title="AuthSystems" AllowReturn="false">
                        <h2><asp:Label ID="authSystemsTitleLabel" runat="server" /></h2>
                        <asp:Label ID="authSystemDetailLabel" runat="Server" />
                        <hr />
                        <h3><asp:Label ID="lblAuthSystems" runat="server" /></h3>
                        <asp:CheckBoxList ID="lstAuthSystems" runat="server" RepeatColumns="3" RepeatDirection="Horizontal" />
                        <asp:Label ID="lblNoAuthSystems" runat="server" />
                        <hr />
                        <asp:Label ID="AuthSystemsErrorLabel" runat="server" />
                    </asp:WizardStep>
                    <asp:WizardStep ID="providersStep" runat="server" Title="Providers" AllowReturn="false">
                        <h2><asp:Label ID="providersTitleLabel" runat="server" /></h2>
                        <asp:Label ID="providersDetailLabel" runat="Server" />
                        <hr />
                        <h3><asp:Label ID="lblProviders" runat="server" /></h3>
                        <asp:CheckBoxList ID="lstProviders" runat="server" RepeatColumns="3" RepeatDirection="Horizontal" />
                        <asp:Label ID="lblNoProviders" runat="server" />
                        <hr />
                        <asp:Label ID="providersErrorLabel" runat="server" />
                    </asp:WizardStep>
                    <asp:WizardStep ID="adminUserStep" runat="server" Title="Portal" AllowReturn="false">
                        <h2><asp:Label ID="adminUserTitleLabel" runat="server" ResourceKey="HostUserTitle" /></h2>
                        <h3><asp:Label ID="lblAdminUser" runat="server" /></h3>
                        <asp:Label ID="adminUserDetailLabel" runat="Server" ResourceKey="HostUserDetail" />
                        <dnn:WizardUser ID="usrAdmin" runat="server" />
                        <hr />
                        <h3><asp:Label ID="lblPortal" runat="server" /></h3>
                        <asp:Label ID="portalDetailLabel" runat="Server" />
                        <div class="dnnForm">
                            <div class="dnnFormItem">
                                <label for="<%=txtPortalTitle.ClientID%>"><%=LocalizeString("PortalTitle")%></label>
                                <asp:TextBox ID="txtPortalTitle" runat="server" MaxLength="128" />
                            </div>
                            <div class="dnnFormItem">
                                <label for="<%=cboPortalTemplate.ClientID%>"><%=LocalizeString("PortalTemplate")%></label>
                                <asp:DropDownList ID="cboPortalTemplate" runat="server" />
                            </div>
                        </div>
                        <asp:Panel ID="SMTPSettingsPanel" runat="server" Visible="false">
                            <hr />
                            <h3><asp:Label ID="lblSMTPSettings" runat="server" /></h3>
                            <asp:Label ID="lblSMTPSettingsHelp" runat="Server" />
                            <div class="dnnForm">
                                <div class="dnnFormItem">
									    <label for="<%=txtSMTPServer.ClientID%>"><%=LocalizeString("SMTPServer")%></label>
                                    <asp:TextBox ID="txtSMTPServer" runat="server" MaxLength="256" />
                                </div>
                                <div class="dnnFormItem">
									<label for="<%=optSMTPAuthentication.ClientID%>"><%=LocalizeString("SMTPAuthentication")%></label>
                                    <asp:RadioButtonList ID="optSMTPAuthentication" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Value="0" resourcekey="SMTPAnonymous" Selected="True" />
                                        <asp:ListItem Value="1" resourcekey="SMTPBasic" />
                                        <asp:ListItem Value="2" resourcekey="SMTPNTLM" />
                                    </asp:RadioButtonList>
                                </div>
                                <div class="dnnFormItem">
									<label for="<%=chkSMTPEnableSSL.ClientID%>"><%=LocalizeString("SMTPEnableSSL")%></label>
                                    <asp:Checkbox ID="chkSMTPEnableSSL" runat="server" />
                                </div>
                                <div id="SMTPUserNameRow" class="dnnFormItem">
									<label for="<%=txtSMTPUsername.ClientID%>"><%=LocalizeString("SMTPUsername")%></label>
                                    <asp:TextBox ID="txtSMTPUsername" runat="server" MaxLength="256" />
                                </div>
                                <div id="SMTPPasswordRow" class="dnnFormItem">
									<label for="<%=txtSMTPPassword.ClientID%>"><%=LocalizeString("SMTPPassword")%></label>
                                    <asp:TextBox ID="txtSMTPPassword" runat="server" MaxLength="256" TextMode="Password" />
                                </div>
                            </div>
                        </asp:Panel>
                        <asp:Label ID="adminUserErrorLabel" runat="server" />
                    </asp:WizardStep>
                    <asp:WizardStep ID="Complete" runat="server" StepType="Finish" Title="Installation Complete">
                        <h2><asp:Label ID="lblCompleteTitle" runat="server" /></h2>
                        <asp:Label ID="lblCompleteDetail" runat="server" />
                    </asp:WizardStep>
                </WizardSteps>
            </asp:Wizard>
        </div>
        <input id="ScrollTop" runat="server" name="ScrollTop" type="hidden" />
        <input type="hidden" id="__dnnVariable" runat="server" />
        <asp:Label ID="txtErrorMessage" runat="server" />
    </form>   
    <script type="text/javascript">

        //This code is to force a refresh of browser cache
        //in case an old version of dnn.js is loaded
        //It should be removed as soon as .js versioning is added
        jQuery(document).ready(function () {
            if (typeof dnnJscriptVersion === 'undefined' || dnnJscriptVersion !== "6.0.0")
                window.location.reload(true);
        });

        /*globals jQuery, window, Sys */
        (function ($, Sys) {
            function toggleSmtpCredentials() {
                var smtpVal = $('#<%= optSMTPAuthentication.ClientID %> input:checked').val(); //0,1,2
                if (smtpVal == "1") {
                    $('#SMTPUserNameRow,#SMTPPasswordRow').slideDown();
                }
                else {
                    $('#SMTPUserNameRow,#SMTPPasswordRow').slideUp();
                }
            }

            function setUp() {
                if (pageNo === 4) {
                    toggleSmtpCredentials();
                    $('#<%= optSMTPAuthentication.ClientID %>').click(function () {
                        toggleSmtpCredentials();
                    });
                }
            	
            	//prevent next button to be click twice, install scripts' button will be handled by other function.
            	if(pageNo !== 2 && pageNo !== 3) {
            		$("#" + nextButtonID).click(function(e) {
            			if (!$(this).hasClass("dnnDisabledAction")) {
            				$(this).addClass("dnnDisabledAction");
            			}
            			else {
            				e.preventDefault();
            			}
            		});
            	}
            }

            $(document).ready(function () {
                installScripts();
                setUp();
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                    setUp();
                });
            });
        } (jQuery, window.Sys));
    </script>
</body>
</html>
