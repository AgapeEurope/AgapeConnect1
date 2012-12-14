<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProfileManagerView.ascx.cs"
	Inherits="DotNetNuke.Modules.PreviewProfileManagement.Views.ProfileManagerView" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.UI.WebControls" Assembly="DotNetNuke" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<div class="dnnForm dnnClear">
	<h2 class="dnnFormSectionHead">
		<%=LocalizeString("CreateNew")%><span><%=LocalizeString("RequiredFields")%></span></h2>
	<div id="AddProfile" runat="server" class="dnnForm dnnClear dnnAddProfile">
		<asp:ValidationSummary ID="valAddSummary" runat="server" CssClass="dnnFormMessage dnnFormValidationSummary"
			DisplayMode="List" ShowSummary="true" ValidationGroup="AddProfile" />
		<div class="dnnFormItem">
			<asp:Label ID="lblName" runat="server" resourcekey="lblName" AssociatedControlID="cbName"></asp:Label>
			<dnn:DnnComboBox ID="cbName" runat="server" AllowCustomText="true" ShowToggleImage="false"
				MarkFirstMatch="true" ShowDropDownOnTextboxClick="true" Width="250" CssClass="dnnFormCombo"
				CloseDropDownOnBlur="true" CollapseDelay="0" Filter="Contains" MaxHeight="300" DropDownWidth="263"
				OnClientSelectedIndexChanged="OnClientSelectedIndexChanged" />
			<asp:CustomValidator runat="server" ValidateEmptyText="true" ClientValidationFunction="notEmpty"
				OnServerValidate="ValidateName" ControlToValidate="cbName" Display="None" resourcekey="valName"
				ValidationGroup="AddProfile" />
		</div>
		<div class="dnnFormItem">
			<asp:Label ID="lblWidth" runat="server" resourcekey="lblWidth" AssociatedControlID="txtWidth"></asp:Label>
			<asp:TextBox ID="txtWidth" runat="server" MaxLength="4" Width="50" CssClass="dnnFormRequired" />
			<asp:CustomValidator runat="server" ValidateEmptyText="true" ClientValidationFunction="isNumeric"
				ControlToValidate="txtWidth" Display="None" resourcekey="valWidth" ValidationGroup="AddProfile" />
		</div>
		<div class="dnnFormItem">
			<asp:Label ID="lblHeight" runat="server" resourcekey="lblHeight" AssociatedControlID="txtHeight"></asp:Label>
			<asp:TextBox ID="txtHeight" runat="server" MaxLength="4" Width="50" CssClass="dnnFormRequired" />
			<asp:CustomValidator runat="server" ValidateEmptyText="true" ClientValidationFunction="isNumeric"
				ControlToValidate="txtHeight" Display="None" resourcekey="valHeight" ValidationGroup="AddProfile" />
		</div>
		<div class="dnnFormItem">
			<asp:Label ID="lblUserAgent" runat="server" resourcekey="lblUserAgent" AssociatedControlID="txtUserAgent"></asp:Label>
			<asp:TextBox ID="txtUserAgent" runat="server" MaxLength="255" Width="200" CssClass="dnnFormRequired" />
			<asp:CustomValidator runat="server" ValidateEmptyText="true" ClientValidationFunction="notEmpty"
				ControlToValidate="txtUserAgent" Display="None" resourcekey="valUserAgent" ValidationGroup="AddProfile" />
		</div>
		<div class="dnnFormItem">
			<asp:LinkButton ID="btnSave" runat="server" resourcekey="Save" CssClass="dnnPrimaryAction"
				ValidationGroup="AddProfile" />
		</div>
	</div>
	<fieldset>
		<asp:ValidationSummary ID="valEditSummary" runat="server" CssClass="dnnFormMessage dnnFormValidationSummary"
			DisplayMode="List" ShowSummary="true" ValidationGroup="EditProfile" />
		<asp:DataGrid ID="ProfilesList" AutoGenerateColumns="false" Width="100%" CellPadding="2"
			GridLines="None" CssClass="dnnGrid" runat="server">
			<HeaderStyle CssClass="dnnGridHeader" VerticalAlign="Top" HorizontalAlign="Center" />
			<ItemStyle CssClass="dnnGridItem" HorizontalAlign="Center" Height="30" />
			<AlternatingItemStyle CssClass="dnnGridAltItem" />
			<EditItemStyle CssClass="dnnFormEditItem" />
			<SelectedItemStyle CssClass="dnnFormError" />
			<FooterStyle CssClass="dnnGridFooter" />
			<PagerStyle CssClass="dnnGridPager" />
			<Columns>
				<asp:TemplateColumn HeaderText="">
					<ItemTemplate>
						<asp:Image runat="server" ImageUrl="~/Icons/Sigma/DragDrop_15x15_Standard.png" AlternateText="" />
					</ItemTemplate>
				</asp:TemplateColumn>
				<asp:TemplateColumn HeaderText="">
					<ItemTemplate>
						<dnn:DnnImageButton ID="lnkEdit" runat="server" IconKey="Edit" CommandName="Edit" />
					</ItemTemplate>
					<EditItemTemplate>
						<dnn:DnnImageButton runat="server" ID="lnkSave" resourcekey="saveRule" CommandName="Save"
							CommandArgument='<%#Eval("Id") %>' IconKey="Save" ValidationGroup="EditProfile"
							CausesValidation="true" />
						<dnn:DnnImageButton runat="server" ID="lnkCancelEdit" resourcekey="cmdCancel" CommandName="Cancel"
							IconKey="Cancel" />
					</EditItemTemplate>
				</asp:TemplateColumn>
				<asp:TemplateColumn HeaderText="">
					<ItemTemplate>
						<asp:LinkButton ID="btnDel" runat="server" CssClass="delete" CausesValidation="false"
							CommandArgument='<%#Eval("Id") %>' CommandName="Delete"></asp:LinkButton>
					</ItemTemplate>
				</asp:TemplateColumn>
				<asp:TemplateColumn HeaderText="Device Name">
					<ItemTemplate>
						<%#Eval("Name") %>
					</ItemTemplate>
					<EditItemTemplate>
						<div class="dnnFormItem">
							<asp:TextBox ID="txtEditName" runat="server" MaxLength="50" CssClass="dnnFormRequired"
								Text='<%#Eval("Name") %>' />
							<asp:CustomValidator runat="server" ValidateEmptyText="true" ClientValidationFunction="notEmpty"
								OnServerValidate="ValidateName" ControlToValidate="txtEditName" Display="None"
								resourcekey="valName" ValidationGroup="EditProfile" InitValue='<%#Eval("Name") %>' />
						</div>
					</EditItemTemplate>
				</asp:TemplateColumn>
				<asp:TemplateColumn HeaderText="Width">
					<ItemTemplate>
						<%#Eval("Width") %>
					</ItemTemplate>
					<EditItemTemplate>
						<div class="dnnFormItem">
							<asp:TextBox ID="txtEditWidth" runat="server" MaxLength="4" Width="50" CssClass="dnnFormRequired"
								Text='<%#Eval("Width") %>' />
							<asp:CustomValidator runat="server" ValidateEmptyText="true" ClientValidationFunction="isNumeric"
								ControlToValidate="txtEditWidth" Display="None" resourcekey="valWidth" ValidationGroup="EditProfile" />
						</div>
					</EditItemTemplate>
				</asp:TemplateColumn>
				<asp:TemplateColumn HeaderText="Height">
					<ItemTemplate>
						<%#Eval("Height") %>
					</ItemTemplate>
					<EditItemTemplate>
						<div class="dnnFormItem">
							<asp:TextBox ID="txtEditHeight" runat="server" MaxLength="4" Width="50" CssClass="dnnFormRequired"
								Text='<%#Eval("Height") %>' />
							<asp:CustomValidator runat="server" ValidateEmptyText="true" ClientValidationFunction="isNumeric"
								ControlToValidate="txtEditHeight" Display="None" resourcekey="valHeight" ValidationGroup="EditProfile" />
						</div>
					</EditItemTemplate>
				</asp:TemplateColumn>
				<asp:TemplateColumn HeaderText="USER AGENT">
					<ItemTemplate>
						<div class="userAgent"><%#Eval("UserAgent") %></div>
					</ItemTemplate>
					<EditItemTemplate>
						<div class="dnnFormItem">
							<asp:TextBox ID="txtUserAgent" runat="server" MaxLength="255" Width="200" CssClass="dnnFormRequired"
								Text='<%#Eval("UserAgent") %>' />
							<asp:CustomValidator runat="server" ValidateEmptyText="true" ClientValidationFunction="notEmpty"
								ControlToValidate="txtUserAgent" Display="None" resourcekey="valUserAgent" ValidationGroup="EditProfile" />
						</div>
					</EditItemTemplate>
				</asp:TemplateColumn>
			</Columns>
		</asp:DataGrid>
	</fieldset>
</div>
<script type="text/javascript">
	(function ($, Sys) {
		$().ready(function () {
			var setUp = function () {
				$('a.delete').dnnConfirm({
					text: '<%= Localization.GetSafeJSString(LocalizeString("DeleteItem")) %>',
					yesText: '<%= Localization.GetSafeJSString("Yes.Text", Localization.SharedResourceFile) %>',
					noText: '<%= Localization.GetSafeJSString("No.Text", Localization.SharedResourceFile) %>',
					title: '<%= Localization.GetSafeJSString("Confirm.Text", Localization.SharedResourceFile) %>'
				});

				var listContainer = $("#<%=ProfilesList.ClientID %> tbody");
				var itemFilter = ".dnnGridItem,.dnnGridAltItem,.dnnFormEditItem";

				if (listContainer.find(itemFilter).length == 0) {
					togglePreview(false);
				}
				else {
					togglePreview(true);
					listContainer.sortable({
						stop: function (event, ui) {
							var moveId = ui.item.attr("data");
							var nextId = "-1";
							if (ui.item.next().length > 0) {
								nextId = ui.item.next().attr("data");
							}
							var action = "\"action=sort&moveId=" + moveId + "&nextId=" + nextId + "\"";
							eval(dnn.getVar('ActionCallback').replace("[ACTIONTOKEN]", action));
						}
					, items: itemFilter
					, helper: function (event, ui) {
						var helper = ui.clone(false);
						helper.find("td").each(function (index) {
							$(this).width(ui.find("td").eq(index).width());
						});

						return helper;
					}
					, placeholder: "dnnGridItem"
					});
				}

			};

			var togglePreview = function (enabled) {
				var ddlViewMode = $(".dnnControlPanel").find("select[id$=ddlMode]")[0];
				var found = false;
				for (var i = 0; i < ddlViewMode.options.length; i++) {
					if (ddlViewMode.options[i].value === "PREVIEW") {
						found = true;

						if (!enabled) {
							ddlViewMode.options.remove(i);
						}

						break;
					}
				}

				if (!found && enabled) {
					ddlViewMode.options.add(new Option("Preview", "PREVIEW"));
				}
			};

			setUp();

			Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
				setUp();
			});
		});

		window.isNumeric = function (source, arg) {
			var val = arg.Value;
			var parseVal = parseInt(val);
			arg.IsValid = /^\d{1,}$/.test(val) && !isNaN(parseVal) && parseVal > 0;
		};

		window.notEmpty = function (source, arg) {
			var val = arg.Value;
			arg.IsValid = val != "";
		};

		window.success = function (result, ctx) {
			var listContainer = $("#<%=ProfilesList.ClientID %> tbody");
			var itemFilter = ".dnnGridItem,.dnnGridAltItem,.dnnFormEditItem";
			listContainer.find(itemFilter).each(function (index) {
				var rowNo = index + 2;
				if (rowNo < 10) {
					rowNo = "0" + rowNo;
				}
				var lnkEdit = $(this).find("input[name$=lnkEdit]");
				lnkEdit.attr("id", lnkEdit.attr("id").replace(/lnkEdit_\d+/, "lnkEdit_" + index));
				lnkEdit.attr("name", lnkEdit.attr("name").replace(/ctl\d+\$lnkEdit/, "ctl" + rowNo + "$lnkEdit"));

				var btnDel = $(this).find("a[id*=btnDel]");
				btnDel.attr("id", btnDel.attr("id").replace(/btnDel_\d+/, "btnDel_" + index));
				btnDel.attr("href", btnDel.attr("href").replace(/ctl\d+\$btnDel/, "ctl" + rowNo + "$btnDel"));

				if ($(this).attr("class").indexOf("dnnFormEditItem") == -1) {
					$(this).removeClass("dnnGridItem").removeClass("dnnGridAltItem").addClass(index % 2 == 0 ? "dnnGridItem" : "dnnGridAltItem");
				}
			});
		};

		window.error = function (result, ctx) {
			location.reload(true);
		};

		window.OnClientSelectedIndexChanged = function (sender, args) {
			var selectedItem = args.get_item();
			var txtWidth = $("#<%=txtWidth.ClientID %>");
			var txtHeight = $("#<%=txtHeight.ClientID %>");
			var txtUserAgent = $("#<%=txtUserAgent.ClientID %>");

			if (selectedItem != null) {
				var selectedValue = selectedItem.get_value();
				var size = eval("({" + selectedValue + "})");

				txtWidth.val(size.width);
				txtHeight.val(size.height);
				txtUserAgent.val(size.userAgent);
			}
		};
	})(jQuery, window.Sys);
</script>
