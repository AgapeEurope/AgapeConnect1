<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="ViewMessage.ascx.cs" Inherits="DotNetNuke.Modules.Messaging.Views.ViewMessage" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<div class="dnnForm dnnViewMessage dnnClear">
    <div class="dnnFormItem">
        <dnn:DnnFieldLabel ID="fromFieldLabel" runat="server" Text="EmailFrom.Text" />
        <asp:Label ID="fromLabel" runat="server" />
    </div>
    <div class="dnnFormItem">
        <dnn:DnnFieldLabel ID="subjectFieldLabel" runat="server" Text="Subject.Text" />        
        <asp:Label ID="subjectLabel" runat="server" />        
    </div>
    <div class="dnnFormItem">
        <dnn:DnnFieldLabel ID="MessageFieldLabel" runat="server" resourcekey="Message"/>
        <div class="right" style="width:665px;">
            <asp:Label ID="messageLabel" runat="server"/>
        </div>
    </div>
    <ul class="dnnActions dnnClear">
        <li><asp:HyperLink ID="hlReplyMessage" runat="server" resourceKey="ReplyMessage" CausesValidation="false" CssClass="dnnPrimaryAction" /></li>
        <li><asp:LinkButton ID="deleteMessage" runat="server" resourceKey="DeleteMessage" CausesValidation="false" CssClass="dnnSecondaryAction" /></li>
        <li><asp:HyperLink ID="hlCancel" runat="server" resourceKey="CancelView" CausesValidation="false" CssClass="dnnSecondaryAction" /></li>
    </ul>
</div>
<script language="javascript" type="text/javascript">
/*globals jQuery, window, Sys */
(function ($, Sys) {
    function setUpViewMessage() {
        $('#<%= deleteMessage.ClientID %>').dnnConfirm({
            text: '<%= Localization.GetString("DeleteItem.Text", Localization.SharedResourceFile) %>',
            yesText: '<%= Localization.GetString("Yes.Text", Localization.SharedResourceFile) %>',
            noText: '<%= Localization.GetString("No.Text", Localization.SharedResourceFile) %>',
            title: '<%= Localization.GetString("Confirm.Text", Localization.SharedResourceFile) %>'
        });
    }

    $(document).ready(function () {
        setUpViewMessage();
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            setUpViewMessage();
        });
    });
} (jQuery, window.Sys));
</script>