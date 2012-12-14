<%@ Control Language="VB" AutoEventWireup="false" CodeFile="GiveView.ascx.vb" Inherits="DotNetNuke.Modules.AgapeFR.GiveView.GiveView" %>
<%@ Register Src="../GiveInfo/GiveInfo.ascx" TagName="frGiveInfo" TagPrefix="uc1" %>
<%@ Register Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" TagPrefix="cc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn1" TagName="Address" Src="~/controls/Address.ascx" %>
<script type="text/javascript" language="javascript">

    function Tab(currentField, nextField) {
        // Determine if the current field's max length has been reached.

        if (currentField.value.length == currentField.maxLength) {
            // Retreive the next field in the tab sequence, and give it the focus.

            document.getElementById(nextField).focus();
        }
    }
    (function ($, Sys) {
        function setUpMyPage() {
            hidedivs();
            transClient();
            //$('#imgTip').tooltip();
            $('.aButton').button();
            $('.tbAmt').numeric({ decimal: false });
            $('.rblOO').click(function () {
                rbl_click();
            });
            $('.ddlFreq').change(function () {
                ddl_change();
            });
            $('#addedToCart').dialog({
                autoOpen: false,
                height: 80,
                width: 400,
                modal: true,
                show: 'fade',
                hide: 'fade',
                title: '<%= Translate("ThankYou") %>',
                open: function (event, ui) {
                    window.setTimeout("$('#addedToCart').dialog('close');", 5000);
                }
            });
            $("#addedToCart").parent().appendTo($("form:first"));
        }

        $(document).ready(function () {
            setUpMyPage();
            if ($('#pauseWrap input[type=hidden]').val() == 1) {
                $('#addedToCart').dialog("open");
            }
            if ('<%= IsEditable  %>' == 'False') { $('.addressContainer input:checkbox').each(function () { $(this).hide(); }); }
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpMyPage();
            });
        });
    }(jQuery, window.Sys));
    function btnAmount_click() {
        if ($('.tbAmt').val() == '') {
            alert('Please enter an amount');
        }
        else if ($('.ddlFreq').val() == 0) {
            alert('Please Select Frequency');
        }
        else if ($('.ddlFreq').val() == 99) {
            hidedivs();
            hideoneoffdivs();
            $('#oneoff').show();
        }
        else if ($('.ddlFreq').val() == 1) {
            hidedivs();
            $('#regular').show();
        }
    }
    function rbl_click() {
        if ($('.rblOO input:radio:checked').val() == 1) {
            hideoneoffdivs();
            $('#creditcard').show();
        }
        else if ($('.rblOO input:radio:checked').val() == 2) {
            hideoneoffdivs();
            $('#virement').show();
        }
        else if ($('.rblOO input:radio:checked').val() == 3) {
            hideoneoffdivs();
            $('#cheque').show();
        }
    }
    function ddl_change() {
        if ($('#regular').is(":visible") || $('#oneoff').is("visible") && $('.ddlFreq').val() != 0) {
            btnAmount_click();
        }
    }

    function hidedivs() {
        $('#regular').hide();
        $('#oneoff').hide();
    }
    function hideoneoffdivs() {
        $('#virement').hide();
        $('#creditcard').hide();
        $('#cheque').hide();
    }
    function transClient() {
        $('#btnAmount').val('<%= Translate("GoButton") %>');
    }
</script>
<style type="text/css">
    .dnnForm {
        min-width: 0 !important;
    }

    .CasAuthModuleDiv {
        clear: both;
        height: 100px;
        width: 50%;
        float: right;
    }

    #btnTheKey {
        margin-top: 100px;
    }

    .userlogin {
        float: left;
    }

    .stafflogin {
        float: right;
    }

    .dnnFormItem {
        width: 300px;
        background-color: #6495ed;
    }

    .virementform {
        width: 250px;
    }

    .input {
        width: 250px !important;
    }
    .oochoose {
        background-color: #6495ed;
        border-radius: 15px;
        padding: 10px;
    }
    .dnnFormItem input[type="text"], .dnnFormItem textarea {
        min-width: 250px;
    }
    .dnnFormItem label {
        text-align: left;
    }
    .dnnTooltip {
        width: 250px !important;
    }
    .dnnFormItem select {
        width: 260px;
    }
</style>
<asp:HiddenField ID="RowId" runat="server" />
<asp:HiddenField ID="theHiddenTabIndex" runat="server" Value="0" ViewStateMode="Enabled" />
<asp:HiddenField ID="ShowProject" runat="server" Value="0" ViewStateMode="Enabled" />
<asp:HiddenField ID="DonationType" runat="server" />
<asp:HiddenField ID="hfUserId1" runat="server" Value="-1" />
<asp:HiddenField ID="hfGiveToName" runat="server" Value="" />
<div id="loggedWrap">
    <asp:HiddenField ID="hfLoggedIn" runat="server" Value="False" />
</div>
<div id="pauseWrap">
    <asp:HiddenField ID="hfDonBasket" runat="server" Value="-1" />
</div>
<asp:HiddenField ID="hfUniqueRef" runat="server" Value="-1" />
<div align="left" style="font-size: 10pt;">
    <div style="width: 700px; float: left;">
        <div id="GiveTitle" runat="server" class="AgapeH2" style="margin-bottom: 12px;">
            <asp:Label ID="Title" runat="server"></asp:Label>
        </div>
        <asp:Label ID="lblOOError" Visible="False" runat="server"></asp:Label>
        <div>
            <asp:DropDownList ID="ddlFrequency" runat="server">
                <asp:ListItem Value="0"></asp:ListItem>
                <asp:ListItem Value="1"></asp:ListItem>
                <asp:ListItem Value="3"></asp:ListItem>
                <asp:ListItem Value="6"></asp:ListItem>
                <asp:ListItem Value="12"></asp:ListItem>
                <asp:ListItem Value="99"></asp:ListItem>
            </asp:DropDownList>
            <asp:Label ID="lblWantGive" runat="server" Text="Label"></asp:Label>
            <asp:TextBox ID="tbAmount" runat="server"></asp:TextBox>
            <asp:Label ID="lblTo" runat="server" Text="Label"></asp:Label>
            <input id="btnAmount" type="button" value="button" class="aButton" onclick="btnAmount_click(); return false;" />
        </div>
        <div id="regular">
            This is the regular giving div.
        </div>
        <div id="oneoff">
            <div class="oochoose">
                <asp:Label ID="lblOneOffChoose" runat="server" Text="Label"></asp:Label>
                <img id="imgTip" src="/images/about.gif" width="15px" title="Try this" />
                <asp:RadioButtonList ID="rblOneOffMethod" runat="server">
                    <asp:ListItem Value="1"></asp:ListItem>
                    <asp:ListItem Value="2"></asp:ListItem>
                    <asp:ListItem Value="3"></asp:ListItem>
                </asp:RadioButtonList>
            </div>


            <div id="virement">
                This is the virement div.
                <div id="virementlogin" runat="server" style="overflow: auto">
                    You are not logged in. You may log in here if you have an account.
                    <div id="userlogin" style="float: left">
                        <div class="dnnForm dnnAddress dnnClear">
                            <div class="dnnFormItem">
                                <dnn:Label ID="lblUserName" runat="server" ControlName="TxtUserName" />
                                <asp:TextBox ID="tbUserName" runat="server" MaxLength="50" CssClass="dnnFormRequired virementform" />
                            </div>
                        </div>
                        <div class="dnnForm dnnAddress dnnClear">
                            <div class="dnnFormItem">
                                <dnn:Label ID="lblPassword" runat="server" ControlName="TxtPassword" />
                                <asp:TextBox ID="tbPassword" runat="server" MaxLength="50" CssClass="dnnFormRequired virementform" />
                            </div>
                        </div>
                    </div>
                    <div class="stafflogin" style="float: right">
                        <asp:Button ID="btnTheKey" runat="server" CausesValidation="false" ResourceKey="BtnTheKey" CssClass="aButton" ControlName="TxtTheKey" />
                    </div>
                </div>
                <div>
                    This is the virement form div.
                <table>
                    <tr>
                        <td style="vertical-align: top;">
                            <div class="dnnForm dnnAddress dnnClear">
                                <div class="dnnFormItem">
                                    <dnn:Label ID="LblFirstName" runat="server" ControlName="TxtFirstName" />
                                    <br />
                                    <asp:TextBox ID="TxtFirstName" ValidationGroup="OneOffVirement" runat="server" MaxLength="50" CssClass="dnnFormRequired virementform" />
                                    <asp:RequiredFieldValidator ID="ValFirstName" runat="server" CssClass="dnnFormMessage dnnFormError" ControlToValidate="TxtFirstName" Display="Dynamic" />
                                </div>
                            </div>
                            <div class="dnnForm dnnAddress dnnClear">
                                <div class="dnnFormItem">
                                    <dnn:Label ID="LblLastName" runat="server" ControlName="TxtLastName" />
                                    <asp:TextBox ID="TxtLastName" ValidationGroup="OneOffVirement" runat="server" MaxLength="50" CssClass="dnnFormRequired virementform" />
                                    <asp:RequiredFieldValidator ID="ValLastName" runat="server" CssClass="dnnFormMessage dnnFormError" ControlToValidate="TxtLastName" Display="Dynamic" />
                                </div>
                            </div>
                            <div class="dnnForm dnnAddress dnnClear">
                                <div class="dnnFormItem">
                                    <dnn:Label ID="LblEmail" runat="server" ControlName="TxtEmail" />
                                    <asp:TextBox ID="TxtEmail" ValidationGroup="OneOffVirement" runat="server" MaxLength="50" CssClass="dnnFormRequired virementform" />
                                    <asp:RequiredFieldValidator ID="ValEmail" runat="server" CssClass="dnnFormMessage dnnFormError" ControlToValidate="TxtEmail" Display="Dynamic" />
                                </div>
                            </div>
                        </td>
                        <td style="vertical-align: top;">
                            <div id="addressContainer" class="addressContainer">
                                <dnn1:Address ID="DnnAddress" ValidationGroup="OneOffVirement" runat="server" Country="France" CountryData="Text" ShowFax="False" />
                            </div>
                        </td>
                    </tr>
                </table>
                    <div class ="bankinfo">
                        <asp:Label ID="lblBankInfo" runat="server" Text="Label"></asp:Label>
                        <div class="dnnForm dnnAddress dnnClear">
                            <div class="dnnFormItem">
                                <dnn:Label ID="lblBank" runat="server" ControlName="TxtBank" />
                                <asp:TextBox ID="tbBank" ValidationGroup="OneOffVirement" runat="server" MaxLength="50" CssClass="dnnFormRequired" />
                            </div>
                        </div>
                        <div class="dnnForm dnnAddress dnnClear">
                            <div class="dnnFormItem">
                                <dnn:Label ID="lblBankStreet1" runat="server" ControlName="TxtBankStreet1" />
                                <asp:TextBox ID="tbBankStreet1" ValidationGroup="OneOffVirement" runat="server" MaxLength="50" CssClass="dnnFormRequired" />
                            </div>
                        </div>
                        <div class="dnnForm dnnAddress dnnClear">
                            <div class="dnnFormItem">
                                <dnn:Label ID="lblBankStreet2" runat="server" ControlName="TxtBankStreet2" />
                                <asp:TextBox ID="tbBankStreet2" ValidationGroup="OneOffVirement" runat="server" MaxLength="50" CssClass="dnnFormRequired" />
                            </div>
                        </div>
                        <div class="dnnForm dnnAddress dnnClear">
                            <div class="dnnFormItem">
                                <dnn:Label ID="lblBankPostal" runat="server" ControlName="TxtBankPostal" />
                                <asp:TextBox ID="tbBankPostal" ValidationGroup="OneOffVirement" runat="server" MaxLength="50" CssClass="dnnFormRequired" />
                            </div>
                        </div>
                        <div class="dnnForm dnnAddress dnnClear">
                            <div class="dnnFormItem">
                                <dnn:Label ID="lblBankCity" runat="server" ControlName="TxtBankCity" />
                                <asp:TextBox ID="tbBankCity" ValidationGroup="OneOffVirement" runat="server" MaxLength="50" CssClass="dnnFormRequired" />
                            </div>
                        </div>
                        <div class="dnnForm dnnAddress dnnClear">
                            <div class="dnnFormItem">
                                <dnn:Label ID="lblBankAcc" runat="server" ControlName="TxtBankAcc" />
                                <asp:TextBox ID="tbBankAcc" ValidationGroup="OneOffVirement" runat="server" MaxLength="50" CssClass="dnnFormRequired" />
                            </div>
                        </div>
                    </div>
                    <asp:Button ID="btnGoBank" class="aButton" ValidationGroup="OneOffVirement" runat="server" Text="Button" />
                    <asp:Button ID="btnGoUserBank" class="aButton" ValidationGroup="OneOffVirement" runat="server" Text="Button" />
                </div>
            </div>
            <div id="creditcard">
                <asp:TextBox ID="theDonationComment" runat="server" Font-Size="12pt" Width="360px"
                    Height="48px" Rows="10" TextMode="MultiLine"></asp:TextBox><br />
                <asp:Button ID="btnCarte" ValidationGroup="OneOffCC" runat="server" Text="" CssClass="aButton" />&nbsp;
                <asp:Button ID="btnCheckout" ValidationGroup="OneOffCC" runat="server" Text="" CssClass="aButton" />
            </div>
            <div id="cheque">
                This is the cheque giving div.
            </div>
        </div>

        <div id="addedToCart">
            <asp:Label ID="lblAddedToCart" runat="server" Text="Label"></asp:Label>
        </div>
    </div>
    <div style="float: right; font-size: 10pt;">
        <asp:Image ID="theImage1" runat="server" Width="300px" BorderColor="Black" BorderStyle="Solid"
            BorderWidth="2px" EnableViewState="False" />
        <br />
        <asp:Button ID="btnBio" runat="server" Text="See Bio" CausesValidation="false" CssClass="aButton" />
        <br />
        <div>
            <uc1:frGiveInfo ID="profileImage1" runat="server" />
        </div>
    </div>
</div>
