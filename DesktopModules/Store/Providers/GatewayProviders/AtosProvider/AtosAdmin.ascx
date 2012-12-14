<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Control language="vb" CodeBehind="AtosAdmin.ascx.vb" Inherits="DotNetNuke.Modules.Store.Cart.AtosAdmin" AutoEventWireup="false" %>
<table style="text-align:left;">
	<tr>
		<td class="SubHead" style="width:200px">
			<dnn:label id="plMerchantId" runat="server" controlname="plMerchantId" suffix=":"></dnn:label>
		</td>
		<td>
		    <asp:textbox id="txtMerchantIdValue" Runat="server"></asp:textbox><br />
            <asp:RequiredFieldValidator ID="reqMerchantIdValue" runat="server" ErrorMessage="reqMerchantIdValue" resourcekey="reqMerchantIdValue" ControlToValidate="txtMerchantIdValue" Display="Dynamic"></asp:RequiredFieldValidator>
        </td>
	</tr>
	<tr>
		<td class="SubHead" style="width:200px">
			<dnn:label id="plPathFileDirectory" runat="server" controlname="plPathFileDirectory" suffix=":"></dnn:label>
		</td>
		<td>
			<asp:DropDownList ID="cbofolders" Runat="server" AutoPostBack="True"></asp:DropDownList><br/>
            <asp:RequiredFieldValidator ID="reqcbofolders" runat="server" ErrorMessage="RequiredFieldValidator" resourcekey="reqcbofolders" ControlToValidate="cbofolders"></asp:RequiredFieldValidator>
        </td>
	</tr>
	<tr>
	    <td colspan="2">
			<asp:LinkButton ID="cmdLoadPathFile" Runat="server" resourcekey="cmdLoadPathFile"></asp:LinkButton>
	    </td>
	</tr>
	<tr>
		<td colspan="2">
			<asp:Label ID="lblPathFileTitle" Runat="server" CssClass="normal" resourcekey="lblPathFileTitle"></asp:Label>
			<asp:Label ID="lblPathFileValue" Runat="server" CssClass="normal"></asp:Label>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<asp:TextBox ID="txtPathFile" Runat="server" CssClass="normaltextbox" TextMode="MultiLine" Rows="10" Columns="70" Wrap="False"></asp:TextBox>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<asp:LinkButton ID="cmdPathfile" Runat="server" CssClass="commandbutton" resourcekey="cmdPathfile"></asp:LinkButton>
		</td>
	</tr>
	<tr>
		<td class="SubHead" style="width:200px">
			<dnn:label id="plBankImage" runat="server" controlname="cboFolderFiles" suffix=":"></dnn:label>
		</td>
		<td>
			<asp:DropDownList ID="cboFolderFiles" Runat="server"></asp:DropDownList>
        </td>
	</tr>
</table>
