<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CasAuthOld.ascx.vb" Inherits="DotNetNuke.Modules.AgapePortal.CasAuth" %>

<style type="text/css">
    .CasAuthModuleDiv {
        clear: both;
        height: 100px;
        width: 50%;
        float:right;
    }

    .BtnTheKey {
        margin-top: 30px;
    }
</style>

<div class="CasAuthModuleDiv">
    <asp:Label ID="LblTheKey" runat="server" ResourceKey="LblTheKey" CssClass="AgapeH5"></asp:Label><br />
    <asp:Button ID="BtnTheKey" runat="server" ResourceKey="BtnTheKey" CssClass="BtnTheKey" />
</div>