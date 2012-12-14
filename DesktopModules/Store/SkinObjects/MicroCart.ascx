<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="MicroCart.ascx.cs" Inherits="DotNetNuke.Modules.Store.SkinObjects.MicroCart" %>
<div id="divStoreMicroCart" class="StoreMicroCart">
    <asp:PlaceHolder ID="phControls" runat="server">
        <p id="pStoreMicroCartItems" class="StoreMicroCartItems">
            <asp:Label ID="lblStoreMicroCartItemsTitle" runat="server">Your cart:</asp:Label>
            <asp:Label ID="lblStoreMicroCartItems" runat="server">0 item(s)</asp:Label>
        </p>
        <p id="pStoreMicroCartTotal" class="StoreMicroCartTotal">
            <asp:Label ID="lblStoreMicroCartTotalTitle" runat="server">Total:</asp:Label>
            <asp:Label ID="lblStoreMicroCartTotal" runat="server">$0.00</asp:Label>
        </p>
    </asp:PlaceHolder>
</div>