<%@ Control language="c#" CodeBehind="AuthorizeNetAdmin.ascx.cs" Inherits="DotNetNuke.Modules.Store.Cart.AuthorizeNetAdmin" AutoEventWireup="True" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<table style="text-align:left;">
	<tr>
		<td class="SubHead" style="width:200px">
			<dnn:label id="lblGateway" runat="server" controlname="txtGateway"></dnn:label>
		</td>
		<td>
			<asp:TextBox id="txtGateway" CssClass="NormalTextBox" runat="server" Width="300px" MaxLength="255"></asp:TextBox>
		</td>
	</tr>
	<tr>
		<td class="SubHead" style="width:200px">
			<dnn:label id="lblVersion" runat="server" controlname="txtVersion"></dnn:label>
		</td>
		<td>
			<asp:TextBox id="txtVersion" CssClass="NormalTextBox" runat="server" Width="60px" MaxLength="10"></asp:TextBox>
		</td>
	</tr>
	<tr>
		<td class="SubHead" style="width:200px">
			<dnn:label id="lblUsername" runat="server" controlname="txtUsername"></dnn:label>
		</td>
		<td>
			<asp:TextBox id="txtUsername" CssClass="NormalTextBox" runat="server" Width="150px" MaxLength="50"></asp:TextBox>
		</td>
	</tr>
	<tr>
		<td class="SubHead" style="width:200px">
			<dnn:label id="lblPassword" runat="server" controlname="txtPassword"></dnn:label>
		</td>
		<td>
			<asp:TextBox id="txtPassword" CssClass="NormalTextBox" runat="server" Width="150px" MaxLength="50"></asp:TextBox>
		</td>
	</tr>
	<tr>
		<td class="SubHead" style="width:200px">
			<dnn:label id="lblCaptureType" runat="server" controlname="ddlCapture"></dnn:label>
		</td>
		<td>
			<asp:DropDownList id="ddlCapture" runat="server" CssClass="NormalTextBox">
				<asp:ListItem resourcekey="ddlCaptureAC" Value="AUTH_CAPTURE" Selected="True">Auth and Capture</asp:ListItem>
				<asp:ListItem resourcekey="ddlCaptureAO" Value="AUTH_ONLY">Auth Only</asp:ListItem>
				<asp:ListItem resourcekey="ddlCaptureCO" Value="CAPTURE_ONLY">Capture Only</asp:ListItem>
			</asp:DropDownList>
		</td>
	</tr>
	<tr>
		<td class="SubHead" style="width:200px">
			<dnn:label id="lblTestMode" runat="server" controlname="cbTest"></dnn:label>
		</td>
		<td>
			<asp:CheckBox id="cbTest" runat="server" CssClass="NormalTextBox"></asp:CheckBox>
		</td>
	</tr>
</table>
