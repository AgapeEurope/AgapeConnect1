<%@ Control language="c#" CodeBehind="DefaultAddressCheckout.ascx.cs" Inherits="DotNetNuke.Modules.Store.Providers.Address.DefaultAddressProvider.DefaultAddressCheckout" AutoEventWireup="True" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnnstore" TagName="address" Src="~/DesktopModules/Store/Providers/AddressProviders/DefaultAddressProvider/StoreAddress.ascx" %>
<fieldset class="StoreAccountCheckoutBillingAddress">
    <legend>
        <asp:Label id="lblBillingAddressTitle" runat="server" resourcekey="lblBillingAddressTitle">Billing Address</asp:Label>
    </legend>
    <table id="rowListBillAddress" runat="server" class="StoreAccountCheckoutSelectBillingAddress">
	    <tr>
		    <td class="StoreAddressLabel">
			    <dnn:label id="lblBillAddress" controlname="lstBillAddress" runat="server"></dnn:label>
		    </td>
		    <td class="StoreAddressField">
			    <asp:dropdownlist id="lstBillAddress" runat="server" CssClass="NormalTextBox" AutoPostBack="true" onselectedindexchanged="lstBillAddress_SelectedIndexChanged"></asp:dropdownlist>
		    </td>
	    </tr>
    </table>
    <dnnstore:address id="addressBilling" runat="server" StartTabIndex="3"></dnnstore:address>
</fieldset>
<fieldset class="StoreAccountCheckoutShippingAddress">
    <legend>
        <asp:Label id="lblShippingAddressTitle" runat="server" resourcekey="lblShippingAddressTitle">Shipping Address</asp:Label>
    </legend>
    <table class="StoreAccountCheckoutSelectShippingAddress">
	    <tr>
		    <td>
			    <dnn:label id="lblShipAddressOptions" controlname="radBilling" runat="server"></dnn:label>
		    </td>
		    <td>
			    <asp:radiobutton id="radNone" tabIndex="20" runat="server" autopostback="True" groupname="radShipAddress" Visible="false" oncheckedchanged="radNone_CheckedChanged"></asp:radiobutton>
			    <dnn:label id="lblNone" controlname="radNone" runat="server" visible="false"></dnn:label>
			    <asp:radiobutton id="radBilling" tabIndex="21" runat="server" autopostback="True" groupname="radShipAddress" oncheckedchanged="radBilling_CheckedChanged"></asp:radiobutton>
			    <dnn:label id="lblUseBillingAddress" controlname="radBilling" runat="server"></dnn:label>
			    <asp:radiobutton id="radShipping" tabIndex="22" runat="server" autopostback="True" groupname="radShipAddress" oncheckedchanged="radShipping_CheckedChanged"></asp:radiobutton>
			    <dnn:label id="lblUseShippingAddress" controlname="radShipping" runat="server"></dnn:label>
		    </td>
	    </tr>
	    <tr id="rowListShipAddress" runat="server" >
		    <td class="StoreAddressLabel">
			    <dnn:label id="lblShipAddress" controlname="lstShipAddress" runat="server"></dnn:label>
		    </td>
		    <td class="StoreAddressField">
			    <asp:dropdownlist id="lstShipAddress" tabIndex="23" runat="server" CssClass="NormalTextBox" autopostback="True" onselectedindexchanged="lstShipAddress_SelectedIndexChanged"></asp:dropdownlist>
		    </td>
	    </tr>
    </table>
    <dnnstore:address id="addressShipping" runat="server" StartTabIndex="24"></dnnstore:address>
</fieldset>
