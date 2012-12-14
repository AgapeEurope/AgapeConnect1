<%@ Control language="c#" CodeBehind="PayPalAdmin.ascx.cs" Inherits="DotNetNuke.Modules.Store.Cart.PayPalAdmin" AutoEventWireup="True" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<table style="text-align:left;">
	<tr>
		<td class="SubHead" style="width:200px">
			<dnn:label id="lblUseSandbox" runat="server" controlname="chkUseSandbox"></dnn:label>
		</td>
		<td>
			<asp:checkbox id="chkUseSandbox" runat="server" cssclass="NormalTextBox" Checked="false"></asp:checkbox>
	    </td>
	</tr>
	<tr>
		<td class="SubHead" style="width:200px">
			<dnn:label id="lblPayPalID" runat="server" controlname="txtPayPalID"></dnn:label>
		</td>
		<td>
			<asp:textbox id="txtPayPalID" runat="server" Width="200px" MaxLength="50" cssclass="NormalTextBox"></asp:textbox>
		</td>
	</tr>
	<tr>
		<td class="SubHead" style="width:200px">
			<dnn:label id="lblSecureID" runat="server" controlname="txtSecureID"></dnn:label>
		</td>
		<td>
			<asp:textbox id="txtSecureID" runat="server" Width="200px" MaxLength="50" cssclass="NormalTextBox"></asp:textbox>
		</td>
	</tr>
	<tr>
		<td class="SubHead" style="width:200px">
			<dnn:label id="lblPayPalVerificationURL" runat="server" controlname="txtPayPalVerificationURL"></dnn:label>
		</td>
		<td>
			<asp:textbox id="txtPayPalVerificationURL" runat="server" Width="300px" MaxLength="255" cssclass="NormalTextBox"></asp:textbox>
		</td>
	</tr>
	<tr>
		<td class="SubHead" style="width:200px">
			<dnn:label id="lblPayPalPaymentURL" runat="server" controlname="txtPayPalPaymentURL"></dnn:label>
		</td>
		<td>
			<asp:textbox id="txtPayPalPaymentURL" runat="server" Width="300px" MaxLength="255" cssclass="NormalTextBox"></asp:textbox>
		</td>
	</tr>
	<tr>
		<td class="SubHead" style="width:200px">
			<dnn:label id="lblPayPalLanguage" runat="server" controlname="txtPayPalLanguage"></dnn:label>
		</td>
		<td>
			<asp:textbox id="txtPayPalLanguage" runat="server" Width="30px" MaxLength="2" cssclass="NormalTextBox"></asp:textbox>
		</td>
	</tr>
	<tr>
		<td class="SubHead" style="width:200px">
			<dnn:label id="lblPayPalCharset" runat="server" controlname="txtPayPalCharset"></dnn:label>
		</td>
		<td>
			<asp:textbox id="txtPayPalCharset" runat="server" Width="200px" MaxLength="25" cssclass="NormalTextBox"></asp:textbox>
		</td>
	</tr>
	<tr>
		<td class="SubHead" style="width:200px">
			<dnn:label id="lblPayPalButtonURL" runat="server" controlname="txtPayPalButtonURL"></dnn:label>
		</td>
		<td>
			<asp:textbox id="txtPayPalButtonURL" runat="server" Width="300px" MaxLength="255" cssclass="NormalTextBox"></asp:textbox>
		</td>
	</tr>
	<tr>
		<td class="SubHead" style="width:200px">
			<dnn:label id="lblCurrency" runat="server" controlname="txtPayPalCurrency"></dnn:label>
		</td>
		<td>
			<asp:textbox id="txtPayPalCurrency" runat="server" Width="50px" MaxLength="3" cssclass="NormalTextBox">USD</asp:textbox>
		</td>
	</tr>
	<tr>
		<td class="SubHead" style="width:200px">
			<dnn:label id="lblSurchargePercent" runat="server" controlname="txtSurchargePercent"></dnn:label>
		</td>
		<td>
			<asp:textbox id="txtSurchargePercent" runat="server" cssclass="NormalTextBox">0</asp:textbox>
		</td>
	</tr>
	<tr>
		<td class="SubHead" style="width:200px">
			<dnn:label id="lblSurchargeFixed" runat="server" controlname="txtSurchargeFixed"></dnn:label>
		</td>
		<td>
			<asp:textbox id="txtSurchargeFixed" runat="server" cssclass="NormalTextBox">0</asp:textbox>
	    </td>
	</tr>
	<tr>
	    <td colspan="2">
	        <asp:Label ID="lblError" runat="server" CssClass="NormalRed"></asp:Label>
	    </td>
	</tr>
</table>
