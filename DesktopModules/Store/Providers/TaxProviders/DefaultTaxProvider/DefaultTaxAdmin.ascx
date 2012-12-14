<%@ Control language="c#" CodeBehind="DefaultTaxAdmin.ascx.cs" Inherits="DotNetNuke.Modules.Store.Providers.Tax.DefaultTaxProvider.DefaultTaxAdmin" AutoEventWireup="True" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<table style="text-align:left;">
	<tr>
	    <td class="SubHead" style="width:200px;">
	        <dnn:label id="lblEnableTax" runat="server"></dnn:label>
	    </td>
	    <td>
	        <asp:CheckBox ID="cbEnableTax" runat="server" CssClass="NormalTextBox" />
	    </td>
	</tr>
	<tr>
		<td class="SubHead" style="width:200px;">
			<dnn:label id="lblTaxRate" runat="server" controlname="txtTaxRate"></dnn:label>
		</td>
		<td>
			<asp:textbox id="txtTaxRate" runat="server" cssclass="NormalTextBox" />
			<br />
			<asp:Label ID="lblError" runat="server" CssClass="NormalRed"></asp:Label>
		</td>
	</tr>
	<tr>
		<td colspan="2" class="Normal">
			<asp:linkbutton id="btnSaveTaxRates" runat="server" CssClass="CommandButton" resourcekey="btnSaveTax">Update Tax Settings</asp:linkbutton>
		</td>
	</tr>
</table>
