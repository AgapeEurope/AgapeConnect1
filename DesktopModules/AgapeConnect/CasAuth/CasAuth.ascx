<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CasAuth.ascx.vb" Inherits="DotNetNuke.Modules.AgapePortal.CasAuth" %>

<style type="text/css">
    .CasAuthModuleDiv {
        /*clear: both;*/
        height: 100px;
        text-align: right;
        padding-right: 20px;
        border-top:2px solid #EEE9E9;
        font-size: 12pt;
    }

    #BtnTheKey {
        margin-top: 100px;
    }
</style>

<div class="CasAuthModuleDiv">
    <asp:Label ID="LblTheKey" runat="server" ResourceKey="LblTheKey"></asp:Label>&nbsp;
    <asp:LinkButton ID="BtnTheKey" runat="server" ResourceKey="BtnTheKey" CssClass="Agape_OragneLink" />
</div>