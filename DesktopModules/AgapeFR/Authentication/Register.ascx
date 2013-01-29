<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Register.ascx.cs" Inherits="DotNetNuke.Modules.AgapeFR.Authentication.Register" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls"%>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>

<style type="text/css">
    #registerContainer .dnnForm {
        min-width: 450px;
    }
    #registerContainer .dnnFormItem.dnnFormHelp p.dnnFormRequired {
        padding-bottom: 10px;
    }
    .btnRegister {
        margin-left:150px;
    }
    #registerContainer .dnnFormItem label, #registerContainer .dnnFormItem .dnnFormLabel, #registerContainer .dnnFormItem .dnnTooltip {
        width:35%;
    }
	#registerContainer .dnnFormItem .dnnTooltip label {
        width:100%;
	}
    #registerContainer .dnnFormItem span.dnnFormMessage.dnnFormError {
        left: 75%;
    }
</style>

<div id="registerContainer">
    <div class="dnnForm dnnRegistrationForm">
        <div class="dnnFormItem dnnFormHelp dnnClear"><p class="dnnFormRequired"><span><%=LocalizeString("RequiredFields")%></span></p></div>
        <div class="dnnFormItem dnnClear">
            <dnn:DnnFormEditor id="userForm" runat="Server" FormMode="Short" ValidationGroup="Register" />
        </div>     
        <ul id="actionsRow" runat="server" class="dnnActions dnnClear">
            <li><asp:LinkButton id="registerButton" runat="server" ValidationGroup="Register" CssClass="dnnPrimaryAction btnRegister" resourcekey="cmdRegister" /></li>
            <li><asp:LinkButton id="cancelButton" runat="server" CssClass="dnnSecondaryAction" resourcekey="cmdCancel" CausesValidation="false" /></li>
        </ul>
    </div>
</div>
