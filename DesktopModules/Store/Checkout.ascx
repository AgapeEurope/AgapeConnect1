<%@ Control language="c#" CodeBehind="Checkout.ascx.cs" Inherits="DotNetNuke.Modules.Store.WebControls.Checkout" AutoEventWireup="True" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<div class="StoreAccountCheckoutWrapper">
    <div id="divStoreCheckoutSteps" runat="server" class="StoreAccountCheckoutSteps">
        <ul>
            <li id="liStepShipping" runat="server" class="StoreCheckoutStep">
                <asp:Label ID="lblStepShippingNumber" runat="server" CssClass="StoreCheckoutStepNumber" resourcekey="lblStepShippingNumber">1</asp:Label>
                <asp:Label ID="lblStepShippingText" runat="server" CssClass="StoreCheckoutStepText" resourcekey="lblStepShippingText">Shipping</asp:Label>
            </li>
            <li id="liStepOrderReview" runat="server" class="StoreCheckoutStep">
                <asp:Label ID="lblStepOrderReviewNumber" runat="server" CssClass="StoreCheckoutStepNumber" resourcekey="lblStepOrderReviewNumber">2</asp:Label>
                <asp:Label ID="lblStepOrderReviewText" runat="server" CssClass="StoreCheckoutStepText" resourcekey="lblStepOrderReviewText">Order Review</asp:Label>
            </li>
            <li id="liStepPayment" runat="server" class="StoreCheckoutStep">
                <asp:Label ID="lblStepPaymentNumber" runat="server" CssClass="StoreCheckoutStepNumber" resourcekey="lblStepPaymentNumber">3</asp:Label>
                <asp:Label ID="lblStepPaymentText" runat="server" CssClass="StoreCheckoutStepText" resourcekey="lblStepPaymentText">Payment</asp:Label>
            </li>
            <li id="liStepDone" runat="server" class="StoreCheckoutStep">
                <asp:Label ID="lblStepDoneNumber" runat="server" CssClass="StoreCheckoutStepNumber" resourcekey="lblStepDoneNumber">4</asp:Label>
                <asp:Label ID="lblStepDoneText" runat="server" CssClass="StoreCheckoutStepText" resourcekey="lblStepDoneText">Done</asp:Label>
            </li>
        </ul>
    </div>
    <asp:placeholder id="plhCheckout" runat="server">
        <div id="divStoreCheckoutAddresses" runat="server" class="StoreAccountCheckoutAddresses">
            <fieldset id="fsAccountInfos" runat="server" class="StoreAccountCheckoutAccountInfos" visible="false">
                <legend>
	                <asp:Label id="lblCreateAccountTitle" runat="server" resourcekey="lblCreateAccountTitle">Optional informations to create your account</asp:Label>
                </legend>
                <table>
                    <tr>
                        <td>User Name:
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>Password:
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <asp:placeholder id="plhAddressCheckout" runat="server"></asp:placeholder>
        </div>
        <div id="divStoreCheckoutCart" runat="server" class="StoreAccountCheckoutCart">
            <div class="StoreAccountCheckoutTotal">
                <asp:placeholder id="plhCart" runat="server"></asp:placeholder>
                <asp:PlaceHolder id="plhShippingCheckout" runat="server"></asp:PlaceHolder>
                <asp:PlaceHolder id="plhTaxCheckout" runat="server"></asp:PlaceHolder>
                <table class="StoreAccountCheckoutCart">
                    <tr>
                        <td class="StoreAccountCheckoutCartFooter">
                            <dnn:label id="lblCartTotal" runat="server" controlname="lblGrandTotal"></dnn:label>
                        </td>
                        <td class="StoreAccountCheckoutCartTotal">
                            <asp:Label ID="lblGrandTotal" runat="server" CssClass="StoreAccountCheckoutGrandTotal"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div id="divStoreCheckoutGateway" runat="server" class="StoreAccountCheckoutGateway">
            <asp:placeholder id="plhGateway" runat="server"></asp:placeholder>
        </div>
    </asp:placeholder>
    <asp:placeholder id="plhOrder" runat="server" visible="false">
        <div id="StoreAccountCheckoutOrderResult" class="StoreAccountCheckoutOrderResult">
            <p class="NormalBold">
                <asp:label ID="lblOrderNumber" runat="server" CssClass="StoreAccountCheckoutOrderNumber">Order Number: 0123</asp:label>
                <asp:Button ID="btnDisplayOrder" runat="server" CssClass="StoreAccountCheckoutDisplayOrder StandardButton" Text="Display Order" />
            </p>
            <p class="NormalBold">
                <asp:label id="lblOrderProcessed" runat="server" cssclass="StoreAccountCheckoutOrderProcessed">Your order has been successfully processed.</asp:label>
            </p>
        </div>
    </asp:placeholder>
    <asp:PlaceHolder ID="plhError" runat="server" visible="false">
        <p class="StoreAccountCheckoutError">
            <asp:Label id="lblError" runat="server" CssClass="NormalRed"></asp:Label>
        </p>
    </asp:PlaceHolder>
    <asp:PlaceHolder ID="plhCheckoutNavigation" runat="server">
        <div class="StoreAccountCheckoutNavigation">
            <ul class="StoreAccountCheckoutNavButtons">
                <li id="StoreCheckoutNavPrevious" runat="server">
                    <asp:LinkButton ID="StoreAccountCheckoutPrevious" runat="server" CausesValidation="false" OnClick="StoreAccountCheckoutPrevious_Click" CssClass="CommandButton" resourcekey="Back">Previous</asp:LinkButton>
                </li>
                <li id="StoreCheckoutNavNext" runat="server">
                    <asp:LinkButton ID="StoreAccountCheckoutNext" runat="server" CausesValidation="true" OnClick="StoreAccountCheckoutNext_Click" CssClass="CommandButton" resourcekey="Continue">Next</asp:LinkButton>
                </li>
            </ul>
        </div>
    </asp:PlaceHolder>
</div>
