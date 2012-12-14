<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Control language="c#" CodeBehind="DefaultShippingCheckout.ascx.cs" Inherits="DotNetNuke.Modules.Store.Providers.Shipping.DefaultShippingProvider.DefaultShippingCheckout" AutoEventWireup="True" %>
<table>
	<tr>
		<td>
	        <dnn:label id="lblShippingTotal" runat="server" controlname="lblOrderShippingCost"></dnn:label>
	    </td>
		<td class="StoreAccountCheckoutShippingTotal">
		    <asp:Label ID="lblOrderShippingCost" runat="server"></asp:Label>
		</td>
	</tr>
</table>