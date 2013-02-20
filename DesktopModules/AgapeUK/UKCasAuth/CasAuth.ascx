<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CasAuth.ascx.vb" Inherits="DotNetNuke.Modules.AgapePortal.CasAuth" %>

<style type="text/css">
    .CasAuthModuleDiv {
        clear: both;
        height: 100px;
        width: 50%;
        float: right;
        text-align: right;
    }

    .textSize {
        font-size: 12pt;
    }
</style>

<div class="staffLoginBox">
    <div class="CasAuthModuleDiv">
        <asp:Label ID="LblTheKey" runat="server" ResourceKey="LblTheKey" CssClass="textSize"></asp:Label>&nbsp;
    <asp:LinkButton ID="BtnTheKey" runat="server" ResourceKey="BtnTheKey" CssClass="textSize Agape_OragneLink" />
    </div>
</div>
