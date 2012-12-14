<%@ Control language="c#" CodeBehind="AuthorizeNetPayment.ascx.cs" Inherits="DotNetNuke.Modules.Store.Cart.AuthorizeNetPayment" AutoEventWireup="True" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/labelcontrol.ascx" %>
<asp:Panel id="pnlProceedToAuthorize" runat="server" Visible="true" CssClass="StoreAccountCheckoutAuthorizeProvider">
    <fieldset>
        <legend>
            <dnn:label id="lblPaymentTitle" runat="server"></dnn:label>
        </legend>
        <table class="StoreAccountCheckoutAuthorizeCardInfos">
            <tr id="trCardType" runat="server" visible="false">
                <td class="StoreAccountCheckoutAuthorizeCardLabel">
                    <asp:Label id="lblCard" CssClass="SubHead" runat="server">Card Type:</asp:Label>
                </td>
                <td class="StoreAccountCheckoutAuthorizeCardValue">
                    <asp:RadioButtonList id="rbCard" CssClass="Normal" runat="server" Width="160px" RepeatDirection="Horizontal">
                        <asp:ListItem Value="Visa" Selected="true">Visa</asp:ListItem>
                        <asp:ListItem Value="MasterCard">MasterCard</asp:ListItem>
                    </asp:RadioButtonList>
				    <asp:RequiredFieldValidator id="rfvCard" runat="server" ControlToValidate="rbCard" CssClass="NormalRed">* Required</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr id="trNameOnCard" runat="server" visible="false">
                <td class="StoreAccountCheckoutAuthorizeCardLabel">
			        <asp:Label id="lblName" runat="server" CssClass="SubHead">Name on Card:</asp:Label>
                </td>
                <td class="StoreAccountCheckoutAuthorizeCardValue">
			        <asp:TextBox id="txtName" runat="server" CssClass="NormalTextBox" Width="200px" MaxLength="255"></asp:TextBox>
			        <asp:RequiredFieldValidator id="rfvName" runat="server" ControlToValidate="txtName" CssClass="NormalRed">* Required</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="StoreAccountCheckoutAuthorizeCardLabel">
			       <dnn:Label ID="lblCardNumber" runat="server" ControlName="txtNumber" Suffix=":"></dnn:Label>
                </td>
                <td class="StoreAccountCheckoutAuthorizeCardValue">
			        <asp:TextBox id="txtNumber" runat="server" CssClass="NormalTextBox" Width="130px" MaxLength="100"></asp:TextBox>
			        <asp:RequiredFieldValidator ID="rfvNumber" runat="server" ControlToValidate="txtNumber" CssClass="NormalRed" resourcekey="rfvNumber.ErrorMessage" ErrorMessage="* Required"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="StoreAccountCheckoutAuthorizeCardLabel">
			        <dnn:Label id="lblExpiryDate" runat="server" ControlName="ddlMonth" suffix=":"></dnn:Label>
                </td>
                <td class="StoreAccountCheckoutAuthorizeCardValue">
			        <asp:DropDownList id="ddlMonth" runat="server" CssClass="NormalTextBox">
				        <asp:ListItem Value="01">01</asp:ListItem>
				        <asp:ListItem Value="02">02</asp:ListItem>
				        <asp:ListItem Value="03">03</asp:ListItem>
				        <asp:ListItem Value="04">04</asp:ListItem>
				        <asp:ListItem Value="05">05</asp:ListItem>
				        <asp:ListItem Value="06">06</asp:ListItem>
				        <asp:ListItem Value="07">07</asp:ListItem>
				        <asp:ListItem Value="08">08</asp:ListItem>
				        <asp:ListItem Value="09">09</asp:ListItem>
				        <asp:ListItem Value="10">10</asp:ListItem>
				        <asp:ListItem Value="11">11</asp:ListItem>
				        <asp:ListItem Value="12">12</asp:ListItem>
			        </asp:DropDownList>
			        <asp:Label id="lblSlash" runat="server" CssClass="Normal">&nbsp;/&nbsp;</asp:Label>
			        <asp:DropDownList id="ddlYear" runat="server" CssClass="NormalTextBox"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="StoreAccountCheckoutAuthorizeCardLabel">
			        <dnn:label id="lblCSC" runat="server" ControlName="txtVer" suffix=":"></dnn:label>
                </td>
                <td class="StoreAccountCheckoutAuthorizeCardValue">
			        <asp:TextBox id="txtVer" runat="server" CssClass="NormalTextBox" Width="60px" MaxLength="4"></asp:TextBox>
			        <asp:RequiredFieldValidator id="rfvVer" runat="server" ControlToValidate="txtVer" CssClass="NormalRed" resourcekey="rfvVer.ErrorMessage" ErrorMessage="* Required"></asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
	</fieldset>
    <p>
        <asp:Label id="lblConfirmMessage" runat="server" CssClass="Normal"></asp:Label>        
    </p>
    <asp:button id="btnProcess" runat="server" resourcekey="btnProcess" cssclass="StandardButton" Text="Confirm Order" onclick="btnProcess_Click"></asp:button>
</asp:Panel>
<asp:Label id="lblError" runat="server" CssClass="NormalRed" Visible="false"></asp:Label>
