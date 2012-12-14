<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="MessageList.ascx.cs" Inherits="DotNetNuke.Modules.Messaging.Views.MessageList" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<div class="dnnForm dnnMessageList dnnClear">
    <h3><asp:Label ID="titleLabel" runat="server" resourceKey="Title" /></h3>
    <dnn:DnnGrid ID="messagesGrid" runat="server" AutoGenerateColumns="false" Width="100%" DataSource="<%# Model.Messages %>" AllowPaging="true" AllowCustomPaging="true"  GridLines="None" CssClass="dnnMessageListGrid" ClientSettings-Selecting-AllowRowSelect="true" AllowMultiRowSelection="true" AllowSorting="true">
        <MasterTableView DataKeyNames="MessageID">
            <Columns>
                <dnn:DnnGridClientSelectColumn HeaderStyle-Width="0" />
                <dnn:DnnGridBoundColumn DataField="FromUserName" HeaderText="From" HeaderStyle-Width="100" ItemStyle-Wrap="false" />
                <dnn:DnnGridHyperlinkColumn HeaderText="Subject" />
                <dnn:DnnGridBoundColumn DataField="MessageDate" HeaderText="Date" HeaderStyle-Width="0" ItemStyle-Wrap="false" />
                <dnn:DnnGridBoundColumn DataField="Status" HeaderText="Status" HeaderStyle-Width="0" />
            </Columns>
        </MasterTableView>
    </dnn:DnnGrid>
    <ul class="dnnActions dnnClear">
        <li><asp:HyperLink ID="addMessageButton" runat="server" resourceKey="addMessage" CssClass="dnnPrimaryAction" /></li>
        <li><asp:LinkButton ID="markAsRead" runat="server" resourceKey="markAsRead" CssClass="dnnSecondaryAction" /></li>
        <li><asp:LinkButton ID="markAsUnread" runat="server" resourceKey="markAsUnread" CssClass="dnnSecondaryAction" /></li>
        <li><asp:LinkButton ID="delete" runat="server" resourceKey="markDeleted" CssClass="dnnSecondaryAction" /></li>
    </ul>
</div>
<script language="javascript" type="text/javascript">
/*globals jQuery, window, Sys */
(function ($, Sys) {
    function setUpMessageList() {
        $('#<%= delete.ClientID %>').dnnConfirm({
            text: '<%= Localization.GetString("DeleteItem.Text", Localization.SharedResourceFile) %>',
            yesText: '<%= Localization.GetString("Yes.Text", Localization.SharedResourceFile) %>',
            noText: '<%= Localization.GetString("No.Text", Localization.SharedResourceFile) %>',
            title: '<%= Localization.GetString("Confirm.Text", Localization.SharedResourceFile) %>'
        });
    }

    $(document).ready(function () {
        setUpMessageList();
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            setUpMessageList();
        });
    });
} (jQuery, window.Sys));
</script>