<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CartPayment.ascx.vb" Inherits="DotNetNuke.Modules.AgapeFR.Cart.CartPayment" %>
<%@ Register TagPrefix="dnn2" TagName="CartBreadcrumb" Src="~/DesktopModules/AgapeFR/Cart/CartBreadcrumb.ascx" %>

<dnn2:CartBreadcrumb ID="CartBreadcrumb1" runat="server" CartCheckoutStep="PaymentStep" />

<asp:PlaceHolder ID="PhPaymentMethods" runat="server"></asp:PlaceHolder>
