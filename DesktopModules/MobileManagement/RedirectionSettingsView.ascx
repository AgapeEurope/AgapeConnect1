<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RedirectionSettingsView.ascx.cs"
	Inherits="DotNetNuke.Modules.MobileManagement.RedirectionSettingsView" EnableViewState="true" %>
<%@ Register TagPrefix="dnn" TagName="label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>
<div class="dnnForm  dnnClear" id="dnnMobileManagement">
	<h2 id="dnnRedirectionSettings" class="dnnFormSectionHead">
		<%=LocalizeString("RedirectionSettings")%></h2>
	<fieldset>
		<div class="dnnFormItem dnnEditSection">
			<dnn:label id="lblRedirectName" runat="server" controlname="txtRedirectName" resourcekey="lblRedirectName"
				suffix=":" />
			<asp:TextBox ID="txtRedirectName" runat="server" class="dnnFormRequired dnnFormInput" />
			<asp:RequiredFieldValidator ID="valTrackingId" runat="server" CssClass="dnnFormMessage dnnFormError"
				ControlToValidate="txtRedirectName" Display="Dynamic" resourcekey="valRedirectName"
				ValidationGroup="Form" />
			<div class="dnnRedirectionEnabled">
				<asp:CheckBox ID="chkEnable" runat="server" Style="width: 200px;" resourcekey="lblEnable"
					Checked="true" /></div>
		</div>
		<div class="dnnFormItem dnnEditSection">
			<dnn:label id="lblRedirect" runat="server" controlname="rblRedirectSource" resourcekey="lblRedirect" />
			<asp:RadioButtonList ID="optRedirectSource" CssClass="dnnFormRadioButtons" runat="server"
				RepeatDirection="Horizontal">
				<asp:ListItem Value="Tab" resourcekey="optPage" name="optSource" Selected="true" />
				<asp:ListItem Value="Portal" resourcekey="optPortal" name="optSource" />
			</asp:RadioButtonList>
			<br />
			<div id="dvSourcePage" runat="server" class="dnnEditItem">
				<asp:DropDownList ID="cboSourcePage" runat="server" CssClass="dnnDropDown" />
				<div class="dnnChildPages">
					<asp:CheckBox ID="chkChildPages" runat="server" Checked="false" resourcekey="chkChildPages"
						TextAlign="Right" /></div>
			</div>
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
				<asp:DropDownList ID="cboPortal" runat="server" CssClass="dnnDropDown" />
			</div>
			<div id="dvTargetPage" runat="server" class="dnnEditItem">
				<asp:DropDownList ID="cboTargetPage" runat="server" CssClass="dnnDropDown" />
			</div>
			<div id="dvTargetUrl" runat="server" class="dvTargetUrl">
				<dnn:label id="lblTargetUrl" runat="server" controlname="txtTargetUrl" resourcekey="lblTargetUrl" />
				<asp:TextBox ID="txtTargetUrl" runat="server" class="dnnFormInput" Text="http://" />
			</div>
		</div>
		<div class="dnnFormItem dnnEditSection">
			<dnn:label id="lblRedirectType" runat="server" controlname="optRedirectType" resourcekey="lblRedirectType" />
			<asp:RadioButtonList ID="optRedirectType" CssClass="dnnFormRadioButtons" runat="server"
				RepeatDirection="Horizontal">
				<asp:ListItem Value="MobilePhone" resourcekey="optPhone" name="optType" Selected="true" />
				<asp:ListItem Value="Tablet" resourcekey="optTablet" name="optType" />
				<asp:ListItem Value="AllMobile" resourcekey="optBoth" name="optType" />
				<asp:ListItem Value="Other" resourcekey="optOther" name="optType" />
			</asp:RadioButtonList>
			<div id="dvOtherTypeSection" runat="server">
				<div id="dvOtherTypeInfo" class="dnnFormItem dnnEditItem dnnFormInfo dnnOtherTypeInfo">
					<%=LocalizeString("OtherType.Text")%></div>
				<div id="dvCapabilityList" runat="server" class="dnnFormItem dnnEditItem dnnCapabilityList">
					<asp:Label ID="lblCapability" runat="server" class="dnnCapabilityName" resourcekey="lblCapability" />
					<asp:Label ID="lblCapabilityValue" runat="server" class="dnnCapabilityValue" resourcekey="lblCapabilityValue" />
					<br />
					<dnn:DnnComboBox ID="cboCapabilityName" runat="server" Width="250px" class="dnnCapabilityName"
						OnClientSelectedIndexChanged="GetCapabilityValues" ShowDropDownOnTextboxClick="true"
						Filter="Contains" AllowCustomText="false" MarkFirstMatch="true" />
					<dnn:DnnComboBox ID="cboCapabilityValue" runat="server" Width="250px" class="dnnCapabilityValue"
						OnItemsRequested="LoadCapabilityValues" OnClientItemsRequested="ItemsLoaded"
						ShowDropDownOnTextboxClick="true" AllowCustomText="false" MarkFirstMatch="true"
						OnSelectedIndexChanged="SetCapabilityValue" />
					<asp:ImageButton ID="imgAddCapabililty" runat="server" CssClass="dnnAddCapabilityImage" resourcekey="addCapability"
						OnClick="AddCapability" ImageUrl="~/images/add.gif" />
				</div>
				<asp:DataGrid ID="dgCapabilityList" AutoGenerateColumns="false" CellPadding="2" GridLines="None"
					CssClass="dnnEditItem dnnFormItem dnnCapabilityGrid" ShowHeader="false" ShowFooter="false"
					AllowPaging="false" runat="server">
					<HeaderStyle VerticalAlign="Top" HorizontalAlign="Left" />
					<ItemStyle CssClass="dnnGridItem " HorizontalAlign="Left" Height="20" />
					<AlternatingItemStyle CssClass="dnnGridAltItem" />
					<Columns>
						<asp:TemplateColumn>
							<ItemTemplate>
								<itemstyle>
									<asp:LinkButton ID="btnDel" runat="server" CssClass="dnnCapabilityDelete" CausesValidation="false" CommandArgument='<%#Eval("Capability") %>' CommandName="delete"></asp:LinkButton>
                                </itemstyle>
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<ItemStyle CssClass="dnnCapabilityName" />
							<ItemTemplate>
								<asp:Label ID="lblCapability" runat="server" Text='<%#Eval("Capability") %>' />
							</ItemTemplate>
						</asp:TemplateColumn>
						<asp:TemplateColumn>
							<ItemStyle CssClass="dnnCapabilityValue" />
							<ItemTemplate>
								<asp:Label ID="lblExpression" runat="server" Text='<%#Eval("Expression") %>' />
							</ItemTemplate>
						</asp:TemplateColumn>
					</Columns>
				</asp:DataGrid>
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
        	$(document).ready(function () {
        		var source = $('#<%= optRedirectSource.ClientID %> input:checked').val();
        		if (source !== "Tab") { $('#<%= dvSourcePage.ClientID %>').hide(); }

        		var type = $('#<%= optRedirectType.ClientID %> input:checked').val();
        		if (type !== "Other") { $('#<%= dvOtherTypeSection.ClientID %>').hide(); }

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
        		$("[name=optSource]").change(function () {
        			var value = $('#<%= optRedirectSource.ClientID %> input:checked').val();
        			if (value !== "Tab") {
        				$('#<%= dvSourcePage.ClientID %>').hide();
        				$('#<%= optRedirectTarget.ClientID %> input[value=Tab]').attr("disabled", true);

        				if ($('#<%= optRedirectTarget.ClientID %> input[value=Tab]').is(":checked")) {
        					if (!$('#<%= optRedirectTarget.ClientID %> input[value=Portal]').attr("disabled")) {
        						$('#<%= optRedirectTarget.ClientID %> input[value=Portal]').click().trigger('change');
        					}
        					else {
        						$('#<%= optRedirectTarget.ClientID %> input[value=Url]').click().trigger('change');
        					}
        				}
        			}
        			else {
        				$('#<%= dvSourcePage.ClientID %>').show();
        				$('#<%= optRedirectTarget.ClientID %> input[value=Tab]').attr("disabled", false);
        			}
        		});

        		/* Toggle source page drop down whenever radio buttons are checked */
        		$("[name=optType]").change(function () {
        			var value = $('#<%= optRedirectType.ClientID %> input:checked').val();
        			if (value !== "Other") {
        				$('#<%= dvOtherTypeSection.ClientID %>').hide();
        			}
        			else {
        				//Populate Page Dropdown list
        				$('#<%= dvOtherTypeSection.ClientID %>').show();
        			}
        		});

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
        			for (var i = 0; i < options.length; i++) {
        				options[i].disabled = options[i].value == sourcePage;        				
        			}        			
        		};

        		filterTargetList();

        		$("#<%=cboSourcePage.ClientID %>").change(function (e) {
        			filterTargetList();
        		});
        	});
        } (jQuery));
    }

    function GetCapabilityValues(combo, eventArqs) {
        var capabilityValuesCombo = $find('<%= cboCapabilityValue.ClientID %>');
        if (combo.get_selectedIndex() > 0) {
            var item = eventArqs.get_item();
            capabilityValuesCombo.requestItems(item.get_value(), false);
        }
        else {
            capabilityValuesCombo.set_text(" ");
            capabilityValuesCombo.clearItems();
        }
    }

    function ItemsLoaded(combo, eventArqs) {
        if (combo.get_items().get_count() > 0) {
            // pre-select the first item
            combo.set_text(combo.get_items().getItem(0).get_text());
            combo.get_items().getItem(0).highlight();
        }
    }

</script>
