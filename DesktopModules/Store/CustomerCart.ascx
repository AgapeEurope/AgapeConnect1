<%@ Control language="c#" CodeBehind="CustomerCart.ascx.cs" Inherits="DotNetNuke.Modules.Store.WebControls.CustomerCart" AutoEventWireup="True" %>
<%@ Register Src="CartDetail.ascx" TagName="CartDetail" TagPrefix="store" %>
<%@ Register TagPrefix="dnn" TagName="label" Src="~/controls/LabelControl.ascx" %>
<div class="StoreAccountCustomerCart">
    <store:CartDetail id="cartControl" runat="server"></store:CartDetail>
    <div class="StoreAccountCheckout">
        <p id="pCheckoutMessage" runat="server" class="StoreAccountCheckoutMessage" visible="false">
            <asp:Label id="lblCheckoutMode" runat="server" cssclass="NormalBold StoreAccountCheckoutMode">Message about the Checkout Mode</asp:Label>
        </p>
        <p class="StoreAccountCheckoutContinue">
            <asp:linkbutton id="btnCheckout" runat="server" cssclass="StoreAccountCheckoutButton" CausesValidation="false" OnClick="btnCheckout_Click"><span><span><asp:label ID="lblCheckout" runat="server" >Checkout</asp:label></span></span></asp:linkbutton>
        </p>
    </div>
</div>
