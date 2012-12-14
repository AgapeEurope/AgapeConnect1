<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Controls.Agape.SkinMinicart" CodeFile="SkinMinicart.ascx.vb" %>

<div class="minicart">
    <asp:LinkButton ID="BtnCart" CausesValidation="false" runat="server">
        <div class="minicart_background">
            <div class="minicart_bubble">
                <asp:Label ID="LblMinicartText" runat="server"></asp:Label>
            </div>
        </div>
    </asp:LinkButton>
</div>
