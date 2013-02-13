<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CartLogin.ascx.vb" Inherits="DotNetNuke.Modules.AgapeFR.Cart.CartLogin" %>
<%@ Register TagPrefix="dnn" TagName="Login" Src="~/DesktopModules/AgapeFR/Authentication/AgapeAuth.ascx" %>
<%@ Register TagPrefix="dnn2" TagName="CartBreadcrumb" Src="~/DesktopModules/AgapeFR/Cart/CartBreadcrumb.ascx" %>

<dnn2:CartBreadcrumb ID="BreadcrumbModule" runat="server" CartCheckoutStep="Login" />
<dnn:Login ID="LoginModule" runat="server" />

