<%@ Control language="vb" CodeBehind="AtosPayment.ascx.vb" Inherits="DotNetNuke.Modules.Store.Cart.AtosPayment" AutoEventWireup="false" %>
<asp:Label id="lblError" runat="server" CssClass="NormalRed"></asp:Label>
<asp:Panel id="pnlProceedToAtos" runat="server" CssClass="StoreAccountCheckoutAtosProvider">
    <p>
        <asp:Label ID="lblConfirmMessage" runat="server" CssClass="Normal"></asp:Label>        
	    <br />
        <asp:Image ID="imgBankLogo" runat="server" AlternateText="Click here to pay using your credit/debit card." /><br />
        <asp:Button ID="btnConfirmOrder" runat="server" resourcekey="btnConfirmOrder" Text="Confirm Order" OnClick="btnConfirmOrder_Click" CssClass="StandardButton" />
    </p>
</asp:Panel>