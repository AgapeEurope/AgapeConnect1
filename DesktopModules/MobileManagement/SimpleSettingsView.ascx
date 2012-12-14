<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SimpleSettingsView.ascx.cs"
	Inherits="DotNetNuke.Modules.MobileManagement.SimpleSettingsView" %>
<%@ Register TagPrefix="dnn" TagName="label" Src="~/controls/LabelControl.ascx" %>
<div class="dnnForm  dnnClear" id="dnnMobileManagement">
	<h2 id="dnnSimpleSettings" class="dnnFormSectionHead">
		<%=LocalizeString("SimpleSettings")%></h2>
	<fieldset>
		<div class="dnnFormItem dnnEditSection">
			<dnn:label id="lblRedirectName" runat="server" controlname="txtRedirectName" resourcekey="lblRedirectName"
				suffix=":" />
			<asp:TextBox ID="txtRedirectName" runat="server" class="dnnFormRequired dnnFormInput" />
			<asp:RequiredFieldValidator ID="valTrackingId" runat="server" CssClass="dnnFormMessage dnnFormError"
				ControlToValidate="txtRedirectName" Display="Dynamic" resourcekey="valRedirectName"
				ValidationGroup="Form" />
		</div>
		<div class="dnnFormItem dnnEditSection">
			<dnn:label id="lblRedirect" runat="server" resourcekey="lblRedirect" controlname="cboSourcePage" />
			<asp:Label ID="lblHomePage" runat="server" />
			<asp:DropDownList ID="cboSourcePage" runat="server" CssClass="dnnDropDown" />
		</div>
		<div class="dnnFormItem dnnEditSection">
			<dnn:label id="lblRedirectTarget" runat="server" controlname="optRedirectTarget"
				resourcekey="lblRedirectTarget" />
			<asp:RadioButtonList ID="optRedirectTarget" CssClass="dnnFormRadioButtons" runat="server"
				RepeatDirection="Horizontal">
				<asp:ListItem Value="Portal" resourcekey="optPortal" name="optTarget" Selected="true" />
				<asp:ListItem Value="Tab" resourcekey="optPage" name="optTarget" />
				<asp:ListItem Value="Url" resourcekey="optUrl" name="optTarget" />
			</asp:RadioButtonList>
			<div id="dvTargetPortal" runat="server" class="dnnEditItem">
				<br />
				<br />
				<asp:DropDownList ID="cboPortal" runat="server" CssClass="dnnDropDown" />
			</div>
			<div id="dvTargetPage" runat="server" class="dnnEditItem">
				<br />
				<br />
				<asp:DropDownList ID="cboTargetPage" runat="server" CssClass="dnnDropDown" />
			</div>
			<div id="dvTargetUrl" runat="server">
				<br />
				<br />
				<dnn:label id="lblTargetUrl" runat="server" controlname="txtTargetUrl" resourcekey="lblTargetUrl" />
				<asp:TextBox ID="txtTargetUrl" runat="server" class="dnnFormInput" Text="http://" />
			</div>
		</div>
	</fieldset>
	<ul class="dnnActions dnnClear">
		<li>
			<asp:LinkButton ID="lnkSave" runat="server" resourcekey="cmdSave" CssClass="dnnPrimaryAction"
				ValidationGroup="Form" /></li>
		<li>
			<asp:LinkButton ID="lnkCancel" runat="server" resourcekey="cmdCancel" CssClass="dnnSecondaryAction" /></li>
	</ul>
</div>
<script language="javascript" type="text/javascript">
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
    function EndRequestHandler(sender, args) {
        if (args.get_error() == undefined) {
            DisaplyUI();
        }
    }
    DisaplyUI();
    function DisaplyUI() {
        (function ($) {
            /* Hide optional upon inital page load sections */
            $(document).ready(
                function () {
                    var target = $('#<%= optRedirectTarget.ClientID %> input:checked').val();
                    if (target === "Portal") {
                        $('#<%= dvTargetPortal.ClientID %>').show();
                        $('#<%= dvTargetPage.ClientID %>').hide();
                        $('#<%= dvTargetUrl.ClientID %>').hide();
                    }
                    else if (target === "Tab") {
                        $('#<%= dvTargetPortal.ClientID %>').hide();
                        $('#<%= dvTargetPage.ClientID %>').show();
                        $('#<%= dvTargetUrl.ClientID %>').hide();
                    }
                    else if (target === "Url") {
                        $('#<%= dvTargetPortal.ClientID %>').hide();
                        $('#<%= dvTargetPage.ClientID %>').hide();
                        $('#<%= dvTargetUrl.ClientID %>').show();
                    }

                    /* Toggle source page drop down whenever radio buttons are checked */
                    $("[name=optTarget]").change(function () {
                        var value = $('#<%= optRedirectTarget.ClientID %> input:checked').val();
                        if (value === "Portal") {
                            $('#<%= dvTargetPortal.ClientID %>').show();
                            $('#<%= dvTargetPage.ClientID %>').hide();
                            $('#<%= dvTargetUrl.ClientID %>').hide();
                        }
                        else if (value === "Tab") {
                            $('#<%= dvTargetPortal.ClientID %>').hide();
                            $('#<%= dvTargetPage.ClientID %>').show();
                            $('#<%= dvTargetUrl.ClientID %>').hide();
                        }
                        else if (value === "Url") {
                            $('#<%= dvTargetPortal.ClientID %>').hide();
                            $('#<%= dvTargetPage.ClientID %>').hide();
                            $('#<%= dvTargetUrl.ClientID %>').show();
                        }
                    });

                    /*filter target page list to hide the select value of source page list*/
                    var filterTargetList = function () {
                        var sourceList = $("#<%=cboSourcePage.ClientID %>");
                        if (sourceList.length == 0) {
                            return;
                        }

                        var sourcePage = sourceList.val();
                        var targetList = $("#<%=cboTargetPage.ClientID %>")[0];
                        var options = targetList.options;
                        var initialSel = -1;
                        for (var i = 0; i < options.length; i++) {
                            options[i].disabled = options[i].value == sourcePage;

                            if (initialSel == -1 && !options[i].disabled) initialSel = i;
                        }

                        targetList.options[initialSel].selected = true;
                    };

                    filterTargetList();

                    $("#<%=cboSourcePage.ClientID %>").change(function (e) {
                        filterTargetList();
                    });
                });

        } (jQuery));
    }
</script>
