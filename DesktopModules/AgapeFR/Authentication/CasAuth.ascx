<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CasAuth.ascx.vb" Inherits="DotNetNuke.Modules.AgapeFR.Authentication.CasAuth" %>

<style type="text/css">
    .CasAuthModuleDiv {
        /*clear: both;
        height: 100px;
        width: 50%;
        float:right;*/
    }

    .BtnTheKey {
        margin-left: 30px;
        margin-bottom: 1em;
    }
</style>

<div class="CasAuthModuleDiv">
    <p><asp:LinkButton id="BtnTheKey" resourcekey="BtnTheKey" cssclass="dnnPrimaryAction BtnTheKey" runat="server" CausesValidation="false" /></p>
</div>