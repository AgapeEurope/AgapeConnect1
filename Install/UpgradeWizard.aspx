<%@ Page Language="C#" AutoEventWireup="false" Inherits="DotNetNuke.Services.Install.UpgradeWizard" CodeFile="UpgradeWizard.aspx.cs" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="../Portals/_default/default.css?refresh" />
    <link rel="stylesheet" type="text/css" href="Install.css?refresh" />
    <asp:placeholder id="SCRIPTS" runat="server" />
</head>
<body>
    <form id="form1" runat="server">
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
                    </ul>
                </StepNavigationTemplate>
                <HeaderTemplate>
                    <img src="../images/branding/logo.gif" border="0" alt="DotNetNuke">
                </HeaderTemplate>
                <WizardSteps>
                    <asp:WizardStep ID="introStep" runat="Server" Title="Welcome">
                        <h2><asp:Label ID="versionLabel" runat="server" /></h2>
                        <h2><asp:Label ID="currentVersionLabel" runat="server" /></h2>
                        <asp:Label ID="introDetailLabel" runat="Server" />
                        <asp:Label ID="bestPracticesLabel" runat="Server" />
                        <hr />
                        <div id="languagePanel" runat="server" class="dnnForm">
                            <div class="dnnFormItem">
                                <label for="<%=cboLanguages.ClientID%>"><%=LocalizeString("ChooseLanguage")%></label>
                                <asp:DropDownList ID="cboLanguages" AutoPostBack="true" runat="Server" DataTextField="Text" DataValueField="Code" />
                            </div>
                        </div>
                        <div class="dnnForm">
                            <div class="dnnFormItem">
								<label for="<%=userNameTextBox.ClientID%>"><%=LocalizeString("Username")%></label>
                                <asp:TextBox ID="userNameTextBox" runat="server" MaxLength="256" />
                            </div>
                            <div class="dnnFormItem">
								<label for="<%=passwordTextBox.ClientID%>"><%=LocalizeString("Password")%></label>
                                <asp:TextBox ID="passwordTextBox" runat="server" MaxLength="256" TextMode="Password" />
                            </div>
                        </div>
                    </asp:WizardStep>
                    <asp:WizardStep ID="Complete" runat="server" StepType="Finish" Title="Installation Complete">
                        <h2><asp:Label ID="lblCompleteTitle" runat="server" /></h2>
                        <asp:Label ID="lblCompleteDetail" runat="server" />
                    </asp:WizardStep>
                </WizardSteps>
            </asp:Wizard>
        </div>
        <asp:Label ID="txtErrorMessage" runat="server" />
    </form>
</body>
</html>
