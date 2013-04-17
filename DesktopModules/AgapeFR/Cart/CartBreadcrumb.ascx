<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.Modules.AgapeFR.Cart.CartBreadcrumb" CodeFile="CartBreadcrumb.ascx.vb" %>

<style type="text/css">
    .CartBreadcrumb {
        width: 1050px;
        margin-top: 20px;
    }
    .CartBreadcrumb ul {
        width: 100%;
        list-style-type:none;
    }
    .CartBreadcrumb li {
        display: inline;
        text-align: center;
        padding: 5px;
        float: left;
        width: 24%;
        border-top: 1px solid #BBB;
        color: #BBB;
    }
    .CartBreadcrumb li.selected {
        font-weight: bold;
        color: #005BBB;
        border-top: 1px solid #005BBB;
    }
    .bottommargin {
        clear: both;
        margin-bottom: 20px;
    }
</style>

<asp:Label ID="LblMyCart" runat="server" class="AgapeH3"></asp:Label>
<div id="CartBreadcrumb" class="CartBreadcrumb" runat="server">
<asp:BulletedList ID="ListCartBreadcrumb" runat="server"></asp:BulletedList>
</div>
<div class="bottommargin"></div>
