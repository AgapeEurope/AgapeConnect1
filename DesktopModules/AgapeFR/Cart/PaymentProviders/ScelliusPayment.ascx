<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ScelliusPayment.ascx.vb" Inherits="DotNetNuke.Modules.AgapeFR.Cart.Payment.ScelliusPayment" %>

<IFRAME id="IfrScelliusCall" src="/DesktopModules/AgapeFR/Cart/PaymentProviders/ScelliusPaymentFrame.aspx" width="1050" height="200" style="border: none; overflow:auto;" runat="server" visible="false">
</IFRAME> <%--Hide this on return--%>
<asp:HiddenField ID="hfCartId" runat="server" />


<div id="divPaymentCanceled" runat="server" visible="false"> <%--Show this on return--%>
    Il semble que vous avez annulé le paiement de votre panier.<br />Que voulez-vous faire maintenant ?
    <asp:Button ID="BtnPayAgain" runat="server" ResourceKey="BtnPayAgain" Text="" CssClass="aButton" />Recommencer le paiement
    <asp:Button ID="BtnModifyCart" runat="server" ResourceKey="BtnModifyCart" Text="" CssClass="aButton" />Modifier mon panier
    <asp:Button ID="BtnEmptyCart" runat="server" ResourceKey="BtnEmptyCart" Text="" CssClass="aButton" />Vider mon panier

</div>

<asp:Literal runat="server" ID="LitPageContent" Mode="PassThrough" Visible="false"></asp:Literal>

