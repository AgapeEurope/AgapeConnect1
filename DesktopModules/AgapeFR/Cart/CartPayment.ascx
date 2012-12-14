<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CartPayment.ascx.vb" Inherits="DotNetNuke.Modules.AgapeFR.Cart.CartPayment" %>

<asp:PlaceHolder ID="PhPaymentMethods" runat="server"></asp:PlaceHolder>

<% 'DAVID: Mettre style dans SkinPopup et frame dans ScelliusPayment  %>
<IFRAME id="frame1" src="/DesktopModules/AgapeFR/Cart/PaymentProviders/ScelliusPaymentFrame.aspx" width="1050" height="150" style="border: none;">
</IFRAME>