<%@ Control CodeBehind="EditMessage.ascx.cs" Language="C#" AutoEventWireup="True" Inherits="DotNetNuke.Modules.Messaging.Views.EditMessage" %>
<%@ Register Src="~/controls/texteditor.ascx" TagName="texteditor" TagPrefix="dnn" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<div class="dnnForm dnnEditMessage dnnClear">
	<div class="dnnFormItem">
        <dnn:DnnFieldLabel ID="dnnlblTo" runat="server" Text="EmailTo.Text" ToolTip="EmailFrom.ToolTip" />
		<asp:TextBox ID="txtTo" runat="server" />
		<asp:LinkButton ID="validateUserButton" Runat="server" CssClass="dnnSecondaryAction" resourceKey="Validate" CausesValidation="false" />
		<asp:RequiredFieldValidator ID="toValidator" ControlToValidate="txtTo" runat="server" ResourceKey="EmailTo.Required" Display="Dynamic" CssClass="dnnFormMessage dnnFormError" SetFocusOnError="true" />
	</div>
	<div class="dnnFormItem">
        <dnn:DnnFieldLabel ID="dnnlblSubject" runat="server" Text="Subject.Text" />
		<asp:TextBox ID="txtSubject" runat="server" MaxLength="100" />
		<asp:RequiredFieldValidator ID="subjectValidator" ControlToValidate="txtSubject" runat="server" ResourceKey="Subject.Required" Display="Dynamic" CssClass="dnnFormMessage dnnFormError" SetFocusOnError="true" />
	</div>
	<div class="dnnFormItem">
        <dnn:DnnFieldLabel ID="dnnlblMsg" runat="server" Text="Message.Text" ToolTip="Message.ToolTip" />
        <div class="dnnLeft"><dnn:texteditor ID="messageEditor" runat="server" Width="550" TextRenderMode="Raw" HtmlEncode="False" defaultmode="Rich" height="300" choosemode="False" chooserender="False" /></div>
	</div>
	<ul class="dnnActions dnnClear">
		<li><asp:LinkButton ID="sendMessageButton" runat="server" resourceKey="SendMessage" CssClass="dnnPrimaryAction" /></li>
		<li><asp:LinkButton ID="saveDraftButton" runat="server" resourceKey="SaveDraft" CssClass="dnnSecondaryAction" /></li>
		<li id="liDelete" runat="server"><asp:LinkButton ID="deleteMessage" runat="server" resourceKey="DeleteMessage" CausesValidation="false" CssClass="dnnSecondaryAction" /></li>
		<li><asp:HyperLink ID="cancelEdit" runat="server" resourceKey="CancelEdit" CssClass="dnnSecondaryAction" /></li>
	</ul>
</div>
<script language="javascript" type="text/javascript">
/*globals jQuery, window, Sys */
(function ($, Sys) {
    function setUpEditMessage() {
        $('#<%= deleteMessage.ClientID %>').dnnConfirm({
            text: '<%= Localization.GetString("DeleteItem.Text", Localization.SharedResourceFile) %>',
            yesText: '<%= Localization.GetString("Yes.Text", Localization.SharedResourceFile) %>',
            noText: '<%= Localization.GetString("No.Text", Localization.SharedResourceFile) %>',
            title: '<%= Localization.GetString("Confirm.Text", Localization.SharedResourceFile) %>'
        });
    }
    $(document).ready(function () {
        setUpEditMessage();
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            setUpEditMessage();
        });
    });
} (jQuery, window.Sys));
</script>