<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CartEditAddress.ascx.vb"
    Inherits="DotNetNuke.Modules.AgapeFR.Cart.CartEditAddress" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Address" Src="~/controls/Address.ascx" %>
<%@ Register TagPrefix="dnn2" TagName="CartBreadcrumb" Src="~/DesktopModules/AgapeFR/Cart/CartBreadcrumb.ascx" %>
<script type="text/javascript">

    (function ($, Sys) {
        function setUpMyObjects() {

            $('.aButton').button();

            // Hide checkboxes to set required fields in view mode
            if ('<%= IsEditable  %>' == 'False') { $('.addressContainer input:checkbox').each(function () { $(this).hide(); }); }
        }

        $(document).ready(function () {
            setUpMyObjects();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpMyObjects();

            });
        });
    }(jQuery, window.Sys));
</script>
<style type="text/css">
    .right {
        text-align: right;
    }

    .CbUpdateProfile input {
        margin-right: 10px;
    }

    .CbUpdateProfile {
        color: red;
    }

    .TdUpdateProfile {
        padding-bottom: 20px;
        padding-top: 20px;
    }

    .BtnCancel {
        margin-right: 30px;
    }

    .title {
        margin-bottom: 30px;
    }
</style>
<dnn2:CartBreadcrumb ID="CartBreadcrumb1" runat="server" CartCheckoutStep="Address" />
<div class="title">
    <asp:Label ID="LblTitle" runat="server" CssClass="AgapeH4"></asp:Label><br />
    <asp:Label ID="LblDescription" runat="server"></asp:Label>
</div>

<div class="dnnForm dnnAddress dnnClear">
    <div class="dnnFormItem">
        <dnn:Label ID="LblDisplayName" runat="server" ControlName="TxtDisplayName" />
        <asp:TextBox ID="TxtDisplayName" runat="server" MaxLength="50" CssClass="dnnFormRequired" />
        <asp:RequiredFieldValidator ID="ValDisplayName" runat="server" CssClass="dnnFormMessage dnnFormError" ControlToValidate="TxtDisplayName" Display="Dynamic" />
    </div>
</div>
<div class="addressContainer">
    <dnn:Address ID="DnnAddress" runat="server" CountryData="Text" EnableTheming="True" ShowFax="False" />
</div>
<table cellpadding="5" width="100%">
    <tr>
        <td class="right TdUpdateProfile">            
            <asp:CheckBox ID="CbUpdateProfile" runat="server" Checked="True" class="CbUpdateProfile" />
        </td>
    </tr>
    <tr>
        <td class="right">
            <asp:Button ID="BtnCancel" ResourceKey="BtnCancel" runat="server" CssClass="aButton BtnCancel" CausesValidation="False" />
            <asp:Button ID="BtnContinue" ResourceKey="BtnContinue" runat="server" CssClass="aButton" />
        </td>
    </tr>
</table>
