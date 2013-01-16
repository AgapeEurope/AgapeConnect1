<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Register.ascx.cs" Inherits="DotNetNuke.Modules.AgapeFR.Authentication.Register" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls"%>

<div class="dnnForm dnnRegistrationForm">
    <div class="dnnFormItem dnnFormHelp dnnClear"><p class="dnnFormRequired"><span><%=LocalizeString("RequiredFields")%></span></p></div>
    <div class="dnnFormItem dnnClear">
        <dnn:DnnFormEditor id="userForm" runat="Server" FormMode="Short" />
    </div>     
    <ul id="actionsRow" runat="server" class="dnnActions dnnClear">
        <li><asp:LinkButton id="registerButton" runat="server" CssClass="dnnPrimaryAction" resourcekey="cmdRegister" /></li>
        <li><asp:LinkButton id="cancelButton" runat="server" CssClass="dnnSecondaryAction" resourcekey="cmdCancel" CausesValidation="false" /></li>
    </ul>
</div>
