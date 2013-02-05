<%@ Control Language="VB" AutoEventWireup="false" CodeFile="GiveView.ascx.vb" Inherits="DotNetNuke.Modules.AgapeFR.GiveView.GiveView" %>
<%@ Register Src="../GiveInfo/GiveInfo.ascx" TagName="frGiveInfo" TagPrefix="uc1" %>
<%@ Register Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" TagPrefix="cc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn1" TagName="Address" Src="~/controls/Address.ascx" %>
<%@ Register TagPrefix="wc" Namespace="DotNetNuke.UI.WebControls" Assembly="CountryListBox" %>
<script type="text/javascript">

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
            $('.tbAmt').attr('autocomplete', 'off');
            $('.tbAmt').keyup(function () {
                amt_enter();
            }); $('.tbAmt').change(function () {
                amt_trim();
                amt_enter();
            });
            $('.rblMeth').click(function () {
                rblMeth_click();
            });
            $('.rbFreq').click(function () {
                rbFreq_click();
            });
            $('.rblLog').click(function () {
                rblLog_click();
            });
            if (!$('#login').is(':hidden')) {
                $('#contact').hide();
            }

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
    function rblMeth_click() {
        if ($('.rblMeth input:radio:checked').val() == 'm1') {
            $('#cheque').slideUp(1000);
            $('#virement').slideUp(1000);
            $('#creditcard').slideDown(1000);
            $('html, body').animate({
                scrollTop: $("#creditcard").offset().top
            }, 1000);
        }
        else if ($('.rblMeth input:radio:checked').val() == 'm2') {
            $('#creditcard').slideUp(1000);
            $('#cheque').slideUp(1000);
            $('#virement').slideDown(1000);
            $('html, body').animate({
                scrollTop: $("#virement").offset().top
            }, 1000);
        }
        else if ($('.rblMeth input:radio:checked').val() == 'm3') {
            $('#creditcard').slideUp(1000);
            $('#virement').slideUp(1000);
            $('#cheque').slideDown(1000);
            $('html, body').animate({
                scrollTop: $("#cheque").offset().top
            }, 1000);
        }
    }
    function rbFreq_click() {
        if ($('.rbFreq input:radio:checked').val() != 99) {
            $('[value=m1]').parent().fadeOut(500);
            $('[value=m3]').parent().fadeOut(500);
            if ($('#creditcard').is(":visible") || $('#cheque').is(":visible")) {
                jQuery('[value=m2]').attr('checked', 'checked');
                rblMeth_click();
            }
        }
        else if ($('.rbFreq input:radio:checked').val() == 99) {
            $('[value=m1]').parent().fadeIn(500);
            $('[value=m3]').parent().fadeIn(500);
        }
        $('#amtchoose').slideDown(500);
    }
    function rblLog_click() {
        if ($('.rblLog input:radio:checked').val() == 1) {
            $('#userlogin').slideUp(1000);
            $('#stafflogin').slideUp(1000);
            $('#contact').slideDown(1000);
            $('#methchoose').slideDown(1000);
            rbFreq_click();
        }
        else if ($('.rblLog input:radio:checked').val() == 2) {
            $('#userlogin').slideDown(1000);
            $('#stafflogin').slideUp(1000);
            $('#contact').slideUp(1000);
            $('#methchoose').slideUp(1000);
        }
        else if ($('.rblLog input:radio:checked').val() == 3) {
            $('#userlogin').slideUp(1000);
            $('#stafflogin').slideDown(1000);
            $('#contact').slideUp(1000);
            $('#methchoose').slideUp(1000);
        }
    }
    function amt_trim() {
        var inp = $(".tbAmt").val();
        while (inp.substr(0, 1) == '0') inp = inp.substr(1);
        $(".tbAmt").val(inp);
    }
    function amt_enter() {
        var inp = $(".tbAmt").val();
        if (inp.length > 0 && inp > 0) {
            $('#login').slideDown(1000);
            var logged = $('#hfLoggedIn').val();
            if (logged == "False") {
                $('.notlogged').slideDown(1000);
            }
            else {
                $('#contact').slideDown(1000);
                $('#methchoose').slideDown(1000);
            }
            rbFreq_click();

        }
        else {
            //hidedivs();
            //$('#amtchoose').show();
            $('#login').slideUp(1000);
            $('#contact').slideUp(1000);
            $('#methchoose').slideUp(1000);
            $('#creditcard').slideUp(1000);
            $('#cheque').slideUp(1000);
            $('#virement').slideUp(1000);
        }
    }
    function hidedivs() {
        $('#amtchoose').hide();
        $('#login').hide();
        $('#contact').hide();
        $('.notlogged').hide();
        $('#stafflogin').hide();
        $('#userlogin').hide();
        $('#methchoose').hide();
        $('#creditcard').hide();
        $('#cheque').hide();
        $('#virement').hide();

    }
    function transClient() {
        $('#btnAmount').val('<%= Translate("GoButton") %>');
    }
</script>
<style type="text/css">
    .tbAmt {
        width: 60px;
        border-radius: 3px;
        background: #FFFFF5;
        border-color:#BCB691;
        border-width:1px;
        padding:5px;
    }
    .dnnForm {
        min-width: 0 !important;
    }

        .dnnForm input.dnnFormRequired {
            margin-left: -5px;
        }

    #btnTheKey {
        margin-top: 100px;
    }

    #leftlogin {
        float: left;
    }

    #rightlogin {
        float: right;
    }

    .bankinforight {
        float: right;
    }

    .bankinfoleft {
        float: left;
    }

    .dnnFormItem {
        width: 300px;
    }

    .virementform {
        width: 250px;
    }

    .input {
        width: 250px !important;
    }

    .bubble {
        border:1px solid #6495ed;
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
    <asp:HiddenField ID="hfLoggedIn" runat="server" Value="False" ClientIDMode="Static" />
</div>
<div id="pauseWrap">
    <asp:HiddenField ID="hfDonBasket" runat="server" Value="-1" />
</div>
<asp:HiddenField ID="hfUniqueRef" runat="server" Value="-1" />
<div align="left" style="font-size: 10pt;">
    <div style="width: 700px; float: left;">
        <div id="GiveTitle" runat="server" class="H2" style="margin-bottom: 12px;">
            <asp:Label ID="Title" runat="server"></asp:Label>
        </div>
        <asp:Label ID="lblOOError" Visible="False" runat="server"></asp:Label>
        <div id="freqchoose" class="bubble">
            This is the frequency div.<br />
            <asp:RadioButtonList ID="rblFrequency" runat="server">
                <asp:ListItem Value="1"></asp:ListItem>
                <asp:ListItem Value="3"></asp:ListItem>
                <asp:ListItem Value="6"></asp:ListItem>
                <asp:ListItem Value="12"></asp:ListItem>
                <asp:ListItem Value="99"></asp:ListItem>
            </asp:RadioButtonList>
        </div>
        <div id="amtchoose" class="bubble">
            <asp:Label ID="lblWantGive" runat="server" Text="Label"></asp:Label>
            <asp:TextBox ID="tbAmount" runat="server"></asp:TextBox>
            <asp:Label ID="lblTo" runat="server" Text="Label"></asp:Label>
        </div>
        <div id="login" runat="server" style="overflow: auto" class="bubble notlogged">
            This is the login div.<br />
            <div id="leftlogin">
                <asp:RadioButtonList ID="rblLogType" runat="server">
                    <asp:ListItem Value="1"></asp:ListItem>
                    <asp:ListItem Value="2"></asp:ListItem>
                    <asp:ListItem Value="3"></asp:ListItem>
                </asp:RadioButtonList>

            </div>
            <div class="rightlogin">
                <div id="stafflogin">
                    This is the staff login div. Clicking here should go to The Key and come back here with the previous options stored.<br />
                </div>
                <div id="userlogin">
                    This is the user login div. Clicking the button below should log the user in and return to this page with the previous options stored.<br />
                    <div class="dnnForm dnnAddress dnnClear">
                        <div class="dnnFormItem">
                            <dnn:Label ID="lblUserName" runat="server" ControlName="TxtUserName" />
                            <asp:TextBox ID="tbUserName" runat="server" MaxLength="50" CssClass="dnnFormRequired virementform" />
                        </div>
                    </div>
                    <div class="dnnForm dnnAddress dnnClear">
                        <div class="dnnFormItem">
                            <dnn:Label ID="lblPassword" runat="server" ControlName="TxtPassword" />
                            <asp:TextBox ID="tbPassword" runat="server" TextMode="Password" MaxLength="50" CssClass="dnnFormRequired virementform" />
                        </div>
                    </div>
                    <div>
                        <asp:Button ID="btnUserLogin" runat="server" CausesValidation="false" CssClass="aButton" />
                    </div>
                </div>
            </div>
        </div>
        <div id="contact" class="bubble">
            <div style="float: left">
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
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="LblConfEmail" runat="server" ControlName="TxtConfEmail" />
                        <asp:TextBox ID="TxtConfEmail" ValidationGroup="OneOffVirement" runat="server" MaxLength="50" CssClass="dnnFormRequired virementform" />
                        <asp:RequiredFieldValidator ID="ValConfEmail" runat="server" CssClass="dnnFormMessage dnnFormError" ControlToValidate="TxtConfEmail" Display="Dynamic" />
                    </div>
                </div>
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="LblMobile" runat="server" ControlName="TxtMobile" />
                        <asp:TextBox ID="TxtMobile" ValidationGroup="OneOffVirement" runat="server" MaxLength="50" CssClass="virementform" />
                    </div>
                </div>
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="LblTelephone" runat="server" ControlName="TxtTelephone" />
                        <asp:TextBox ID="TxtTelephone" ValidationGroup="OneOffVirement" runat="server" MaxLength="50" CssClass="virementform" />
                    </div>
                </div>
            </div>
            <div style="float: right">
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="LblStreet1" runat="server" ControlName="TxtStreet1" />
                        <asp:TextBox ID="TxtStreet1" runat="server" MaxLength="50" CssClass="virementform" />
                    </div>
                </div>
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="LblStreet2" runat="server" ControlName="TxtStreet2" />
                        <asp:TextBox ID="TxtStreet2" ValidationGroup="OneOffVirement" runat="server" MaxLength="50" CssClass="virementform" />
                    </div>
                </div>
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="LblCity" runat="server" ControlName="TxtCity" />
                        <asp:TextBox ID="TxtCity" ValidationGroup="OneOffVirement" runat="server" MaxLength="50" CssClass="virementform" />
                    </div>
                </div>
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="LlbCountry" runat="server" ControlName="TxtCountry" />
                        <div class="dnnLeft">
                            <wc:CountryListBox TestIP="" LocalhostCountryCode="France" ID="cboCountry" DataValueField="Value" DataTextField="Text" AutoPostBack="True" runat="server" />
                        </div>
                    </div>
                </div>
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="LblRegion" runat="server" ControlName="TxtRegion" />
                        <asp:TextBox ID="TxtRegion" ValidationGroup="OneOffVirement" runat="server" MaxLength="50" CssClass="virementform" />
                    </div>
                </div>
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="LblPostCode" runat="server" ControlName="TxtPostCode" />
                        <asp:TextBox ID="TxtPostCode" ValidationGroup="OneOffVirement" runat="server" MaxLength="50" CssClass="virementform" />
                    </div>
                </div>
            </div>
            <div style="clear: both"></div>

        </div>
        <div id="methchoose" class="bubble">
            <asp:Label ID="lblOneOffChoose" runat="server" Text="Label"></asp:Label>
            <img id="imgTip" src="/images/about.gif" width="15px" title="Try this" />
            <asp:RadioButtonList ID="rblMethod" runat="server">
                <asp:ListItem Value="m1"></asp:ListItem>
                <asp:ListItem Value="m2"></asp:ListItem>
                <asp:ListItem Value="m3"></asp:ListItem>
            </asp:RadioButtonList>
        </div>
        <div id="virement" class="bubble">
            This is the virement form div.<br />
            <asp:Label ID="lblBankInfo" runat="server" Text="Label"></asp:Label>
            <div style="clear: both"></div>
            <div class="bankinfoleft">
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="lblAccName" runat="server" ControlName="TxtAccName" />
                        <asp:TextBox ID="tbAccName" ValidationGroup="OneOffVirement" runat="server" MaxLength="50" CssClass="dnnFormRequired" />
                    </div>
                </div>
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
            </div>
            <div class="bankinforight">
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
            <div style="clear: both"></div>
            <asp:Button ID="btnGoBank" CssClass="aButton" ValidationGroup="OneOffVirement" runat="server" Text="GoBank" />
        </div>
        <div id="creditcard" class="bubble">
            This is the Credit Card div.<br />
            <asp:TextBox ID="theDonationComment" runat="server" Font-Size="12pt" Width="360px"
                Height="48px" Rows="10" TextMode="MultiLine"></asp:TextBox><br />
            <asp:Button ID="btnCarte" ValidationGroup="OneOffCC" runat="server" Text="" CssClass="aButton" />&nbsp;
                <asp:Button ID="btnCheckout" ValidationGroup="OneOffCC" runat="server" Text="" CssClass="aButton" />
        </div>
        <div id="cheque" class="bubble">
            This is the cheque giving div.<br />
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
            <uc1:frGiveInfo ID="frGiveInfo" runat="server" />
        </div>
    </div>
</div>
