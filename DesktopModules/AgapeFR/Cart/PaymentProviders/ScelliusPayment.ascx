<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ScelliusPayment.ascx.vb" Inherits="DotNetNuke.Modules.AgapeFR.Cart.Payment.ScelliusPayment" %>

<IFRAME id="IfrScelliusCall" src="/DesktopModules/AgapeFR/Cart/PaymentProviders/ScelliusPaymentFrame.aspx" width="1050" height="200" style="border: none; overflow:auto;" runat="server" visible="false">
</IFRAME>

<asp:Literal runat="server" ID="LitPageContent" Mode="PassThrough" Visible="false"></asp:Literal>