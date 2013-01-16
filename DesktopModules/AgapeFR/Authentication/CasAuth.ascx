<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CasAuth.ascx.vb" Inherits="DotNetNuke.Modules.AgapeFR.Authentication.CasAuth" %>

<style type="text/css">
    .CasAuthModuleDiv {
        /*clear: both;
        height: 100px;
        width: 50%;
        float:right;*/
    }

    .BtnTheKey {
        margin-top: 30px;
    }
</style>

<div class="CasAuthModuleDiv">
    <asp:Label ID="LblTheKey" runat="server" ResourceKey="LblTheKey" CssClass="AgapeH5"></asp:Label><br />
    <p><asp:LinkButton id="BtnTheKey" resourcekey="BtnTheKey" cssclass="dnnPrimaryAction BtnTheKey" runat="server" CausesValidation="false" Text="Staff Login (A traduire)" /></p>
</div>