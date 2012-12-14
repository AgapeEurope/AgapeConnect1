<%@ Control Inherits="DotNetNuke.Modules.Html.Settings" CodeBehind="Settings.ascx.cs" language="C#" AutoEventWireup="false" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<div class="dnnForm dnnHTMLSettings dnnClear">
	<div class="dnnFormItem">
		<dnn:label id="plReplaceTokens" controlname="chkReplaceTokens" runat="server" />
		<asp:CheckBox ID="chkReplaceTokens" runat="server" />
	</div>
	<div class="dnnFormItem">
		<dnn:label id="plWorkflow" controlname="cboWorkflow" runat="server" suffix=":" />
		<asp:DropDownList ID="cboWorkflow" runat="server" DataTextField="WorkflowName" DataValueField="WorkflowID" AutoPostBack="True" />
	</div>
	<div class="dnnFormMessage dnnFormInfo">
		<asp:Label ID="lblDescription" runat="server" />
	</div>
	<div class="dnnFormItem" id="divApplyTo" runat="server">
		<dnn:label id="plApplyTo" controlname="rblApplyTo" runat="server" />
		<asp:RadioButtonList ID="rblApplyTo" runat="server" RepeatDirection="Horizontal" CssClass="dnnFormRadioButtons">
			<asp:ListItem Value="Module" ResourceKey="Module" />
			<asp:ListItem Value="Page" ResourceKey="Page" />
			<asp:ListItem Value="Site" ResourceKey="Site" />
		</asp:RadioButtonList>
		<asp:CheckBox ID="chkReplace" runat="server" resourcekey="chkReplace" CssClass="inline" />
	</div>
</div>