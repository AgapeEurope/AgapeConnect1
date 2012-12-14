<%@ Control language="c#" CodeBehind="PayPalPayment.ascx.cs" Inherits="DotNetNuke.Modules.Store.Cart.PayPalPayment" AutoEventWireup="True" %>
<asp:Label id="lblError" runat="server" CssClass="NormalRed" Visible="false"></asp:Label>
<asp:Panel id="pnlProceedToPayPal" runat="server" Visible="true" CssClass="StoreAccountCheckoutPayPalProvider">
    <p>
        <asp:Label id="lblConfirmMessage" runat="server" CssClass="Normal"></asp:Label>        
	    <br />
        <asp:Image ID="paypalimage" runat="server" AlternateText="Click here to pay by PayPal using your credit/debit card or PayPal account" /><br />
        <asp:Button ID="btnConfirmOrder" runat="server" resourcekey="btnConfirmOrder" Text="Confirm Order" OnClick="btnConfirmOrder_Click" CssClass="StandardButton" />
    </p>
</asp:Panel>
