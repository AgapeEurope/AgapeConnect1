<%@ Control Language="C#" AutoEventWireup="false" Inherits="DotNetNuke.Modules.Groups.ListSettings" Codebehind="ListSettings.ascx.cs" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<div class="dnnFormItem">
    <dnn:label controlname="drpRoleGroup" resourcekey="DefaultRoleGroup" Text="Default Role Group" Suffix=":" runat="server" />
    <asp:DropDownList ID="drpRoleGroup" runat="server" />
</div>
<div class="dnnFormItem">
    <dnn:label controlname="drpViewMode" resourcekey="ViewMode" Text="View Mode" Suffix=":" runat="server" />
    <asp:DropDownList ID="drpViewMode" runat="server">
        <asp:ListItem Value="List" resourcekey="List">List</asp:ListItem>
        <asp:ListItem Value="View" resourcekey="View">View</asp:ListItem>
    </asp:DropDownList>
</div>
<div class="dnnFormItem">
    <dnn:label controlname="drpGroupViewPage" resourcekey="GroupViewPage" Text="Group View Page" Suffix=":" runat="server" />
    <asp:DropDownList ID="drpGroupViewPage" runat="server" />
</div>
<div class="dnnFormItem" id="trListTemplate" style="display:none;">
    <dnn:label controlname="txtListTemplate" resourcekey="GroupListTemplateText" Text="Group List Template" Suffix=":" runat="server" />
    <asp:TextBox ID="txtListTemplate" runat="server" TextMode="MultiLine" />
</div>
<div class="dnnFormItem" style="display:none;" id="trViewTemplate">
    <dnn:label controlname="txtViewTemplate" resourcekey="GroupViewTemplateText" Text="Group View Template" Suffix=":" runat="server" />
    <asp:TextBox ID="txtViewTemplate" runat="server" TextMode="MultiLine" />
</div>
<div class="dnnFormItem">
    <dnn:label controlname="chkGroupModeration" resourcekey="GroupModeration" Text="Groups Require Approval" Suffix=":" runat="server" />
    <asp:CheckBox ID="chkGroupModeration" runat="server" />
</div>
<script type="text/javascript">

    jQuery(document).ready(function ($) {
        var drpView = $('#<%=drpViewMode.ClientID %>');
        if (drpView.val() == 'List') {
            $('#trListTemplate').show();
            $('#trViewTemplate').hide();
        } else {
            $('#trListTemplate').hide();
            $('#trViewTemplate').show();
        }
        $('#<%=drpViewMode.ClientID %>').change(function () {
            if ($(this).val() == 'List') {
                $('#trListTemplate').show();
                $('#trViewTemplate').hide();
            } else {
                $('#trListTemplate').hide();
                $('#trViewTemplate').show();
            }
        });

    });
</script>