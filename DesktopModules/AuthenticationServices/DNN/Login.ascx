<%@ Control Language="C#" Inherits="DotNetNuke.Modules.Admin.Authentication.Login" AutoEventWireup="false" CodeFile="Login.ascx.cs" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls"%>
<div class="dnnForm dnnLoginService dnnClear">
    <div class="dnnFormItem">
        <asp:label id="plUsername" AssociatedControlID="txtUsername" runat="server" CssClass="dnnFormLabel" />
        <asp:textbox id="txtUsername" runat="server" />
    </div>
    <div class="dnnFormItem">
        <asp:label id="plPassword" AssociatedControlID="txtPassword" runat="server" resourcekey="Password" CssClass="dnnFormLabel" />
        <asp:textbox id="txtPassword" textmode="Password" runat="server" />
    </div>
    <div class="dnnFormItem" id="divCaptcha1" runat="server" visible="false">
        <asp:label id="plCaptcha" AssociatedControlID="ctlCaptcha" runat="server" resourcekey="Captcha" CssClass="dnnFormLabel" />
    </div>
    <div class="dnnFormItem" id="divCaptcha2" runat="server" visible="false">
        <dnn:captchacontrol id="ctlCaptcha" captchawidth="130" captchaheight="40" runat="server" errorstyle-cssclass="dnnFormMessage dnnFormError" />
    </div>
    <p><asp:LinkButton id="cmdLogin" resourcekey="cmdLogin" cssclass="dnnPrimaryAction" text="Login" runat="server" /></p>
</div>
<div class="dnnLoginRememberMe"><asp:checkbox id="chkCookie" resourcekey="Remember" runat="server" /></div>
<div><asp:label id="lblLogin" runat="server" /></div>
<div class="dnnLoginActions">
    <ul class="dnnActions dnnClear">
        <li id="liRegister" runat="server"><asp:HyperLink ID="registerLink" runat="server" CssClass="dnnSecondaryAction" resourcekey="cmdRegister" /></li>                
        <li id="liPassword" runat="server"><asp:HyperLink ID="passwordLink" runat="server" CssClass="dnnSecondaryAction" resourcekey="cmdPassword" /></li>
    </ul>
</div>
