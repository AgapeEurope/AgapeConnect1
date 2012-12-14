<%@ Control Language="C#" AutoEventWireup="false" Explicit="true" Inherits="DotNetNuke.Modules.Admin.MobilePreview.Preview"
	CodeFile="Preview.ascx.cs" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<div class="dnnForm dnnMobilePreview dnnClear">
	<fieldset>
		<div class="dnnFormItem">
			<dnn:Label ID="lblProfile" runat="server" ControlName="ddlProfileList" />
			<asp:DropDownList ID="ddlProfileList" runat="server" Width="300" AutoPostBack="true" />
		</div>
		<div class="dnnFormItem">
			<dnn:Label ID="lblOrientation" runat="server" ControlName="rblOrientation" />
			<asp:RadioButtonList ID="rblOrientation" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" AutoPostBack="true">
				<asp:ListItem Value="vertical" resourcekey="Vertical" Selected="true"></asp:ListItem>
				<asp:ListItem Value="horizontal" resourcekey="Horizontal"></asp:ListItem>			
			</asp:RadioButtonList>
		</div>
		<div class="dnnFormItem">
			<dnn:Label ID="lblSendAgent" runat="server" ControlName="cbSendAgent" />
			<asp:CheckBox ID="cbSendAgent" runat="server" Checked="true" AutoPostBack="true"/>
		</div>
		<div class="dnnFormItem">
			<dnn:Label ID="lblDimensions" runat="server" ControlName="ddlProfileList" />
			<asp:CheckBox ID="cbShowDimensions" runat="server" Checked="true" />
		</div>
        <div class="dnnFormMessage dnnFormInfo">
            <dnn:Label ID="lblPreviewInfo" runat="server" />
        </div>
		<div class="dnnFormItem">
			<label></label>
			<div id="emulator">               
				<div class="emulator_addr"></div>
				<div class="dimension_h"></div>
				<div class="dimension_v"></div>
				<div class="emulator_c"><iframe id="emulator_viewer" name="emulator_viewer" scrolling="no" frameborder="0" src="about:blank"></iframe></div>
				
			</div>
		</div>
	</fieldset>
</div>
<script type="text/javascript">
(function ($) {
	$(document).ready(function () {
		var emulator = $("#emulator").previewEmulator();
		var deviceListId = "#<%=ddlProfileList.ClientID %>";
		var showDimensionId = "#<%=cbShowDimensions.ClientID %>";
		var previewWithAgentId = "#<%=cbSendAgent.ClientID %>";
		var orientationFilter = "input[type=radio][name$=rblOrientation]";
		$(deviceListId).change(function () {		    
			changeView();
		});

		var changeView = function () {
			var sizeValue = eval("({" + $(deviceListId).val() + "})");
			var orientation = $(orientationFilter + ":checked").val();
			if (orientation == "vertical") {
			    if (!($(previewWithAgentId)[0].checked)) {
			        emulator.setPreview(sizeValue.width, sizeValue.height);
			    } 
			    else {
			        emulator.setPreview(sizeValue.width, sizeValue.height, sizeValue.userAgent);
			    }
			}
			else {
			    if (!($(previewWithAgentId)[0].checked)) {
			        emulator.setPreview(sizeValue.height, sizeValue.width);
			    } 
			    else {
			        emulator.setPreview(sizeValue.height, sizeValue.width, sizeValue.userAgent);
			    }
			}
		};

		$(orientationFilter).click(function () {
			changeView();
		});

		$(showDimensionId).click(function () {
			emulator.showDimension(this.checked);
		});

		$(previewWithAgentId).click(function () {
			emulator.previewWithAgent(this.checked);
			changeView();
		});

		changeView();
	});
})(jQuery);
</script>