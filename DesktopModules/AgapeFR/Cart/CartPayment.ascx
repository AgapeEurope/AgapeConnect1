<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CartPayment.ascx.vb" Inherits="DotNetNuke.Modules.AgapeFR.Cart.CartPayment" %>
<%@ Register TagPrefix="dnn2" TagName="CartBreadcrumb" Src="~/DesktopModules/AgapeFR/Cart/CartBreadcrumb.ascx" %>

<dnn2:CartBreadcrumb ID="CartBreadcrumb1" runat="server" CartCheckoutStep="Payment" />

<asp:PlaceHolder ID="PhPaymentMethods" runat="server"></asp:PlaceHolder>

<%'DAVID Cart : CONTINUER ICI => Dans ScelliusPayment, si code retour 17, rediriger vers cette page avec param paymentcanceled=true et afficher cette zone si le param est présent %>
<div id="divPaymentCanceled" runat="server">
    Il semble que vous avez annulé le paiement de votre panier.<br />Que voulez-vous faire maintenant ?
    <asp:Button ID="BtnPayAgain" runat="server" ResourceKey="BtnPayAgain" Text="" CssClass="aButton" />Recommencer le paiement
    <asp:Button ID="BtnModifyCart" runat="server" ResourceKey="BtnModifyCart" Text="" CssClass="aButton" />Modifier mon panier
    <asp:Button ID="BtnEmptyCart" runat="server" ResourceKey="BtnEmptyCart" Text="" CssClass="aButton" />Vider mon panier

</div>
