<%@ Control Language="VB" AutoEventWireup="false" CodeFile="GiveView.ascx.vb" Inherits="DotNetNuke.Modules.AgapeFR.GiveView.GiveView" %>
<%@ Register Src="../GiveInfo/GiveInfo.ascx" TagName="frGiveInfo" TagPrefix="uc1" %>
<%@ Register Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" TagPrefix="cc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn1" TagName="Address" Src="~/controls/Address.ascx" %>
<%@ Register TagPrefix="wc" Namespace="DotNetNuke.UI.WebControls" Assembly="CountryListBox" %>
<%@ Register TagPrefix="dnn2" TagName="Login" Src="~/DesktopModules/AgapeFR/Authentication/AgapeAuth.ascx" %>

<script type="text/javascript">
    (function ($, Sys) {
        function setUpMyPage() {
            hidedivs();
            $('.TxtPostCode').numeric({ decimal: false, negative: false });
            $('.TxtBankPostal').numeric({ decimal: false, negative: false });
            $('.TxtMobile').numeric({ decimal: false, negative: false });
            $('.TxtTelephone').numeric({ decimal: false, negative: false });
            $('.aButton').button();
            $('.tbAmt').numeric({ decimal: false, negative: false });
            $('.tbAmt').attr('autocomplete', 'off');
            $('.tbAmt').keyup(function () {
                amt_enter();
            });
            $('.tbAmt').change(function () {
                amt_trim();
                amt_enter();
            });
            $('.tbAmt').blur(function () {
                amt_trim();
                amt_enter();
            });
            $('.contactfill').keyup(function () {
                contactfill_enter();
            });
            $('.contactfill').change(function () {
                contactfill_enter();
            });
            $('.rblMeth').click(function () {
                rblMeth_click();
            });
            $('.rbFreq').click(function () {
                rbFreq_click();
            });
            $('.bankfill').keyup(function () {
                bankfill_enter();
            });
            $('.bankfill').change(function () {
                bankfill_enter();
            });
            $('.virement').keyup(function () {
                bankfill_enter();
            });
            $('.btnNext').click(function () {
                btnNext_click();
            });
            $('.btnEditVirement').click(function () {
                btnEditVirement_click();
            });
            $('.btnGoBank').click(function () {
                btnGoBank_click();
            });
            $('.btnFinishDon').click(function () {
                btnFinishDon_click();
            });
            //determine what step the page is on
            if ($('#stepCount input[type=hidden]').val() == -1) {
                //get session values
                sessfreq = sessionStorage.getItem('rbFreq');
                sessamt = sessionStorage.getItem('tbAmt');
                //fill field/radiobutton
                $('.rbFreq input:radio[value="' + sessfreq + '"]').click();
                $('.tbAmt').val(sessamt);
                //empty session storage
                sessionStorage.removeItem('rbFreq');
                sessionStorage.removeItem('tbAmt');
                rbFreq_click()
            }
            else if ($('#stepCount input[type=hidden]').val() != -1) {
                $('.freqchoose').hide();
                $('.confirmation').slideDown(1000);
            }
        }
        $(document).ready(function () {
            setUpMyPage();
            if ('<%= IsEditable  %>' == 'False') { $('.addressContainer input:checkbox').each(function () { $(this).hide(); }); }
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpMyPage();
            });
        });
    }(jQuery, window.Sys));
    function contactfill_enter() {
        if (Page_ClientValidate('Contact')) {
            $('.testlabel').text('contact info is valid');
            $('.methchoose').slideDown(1000);
            rblMeth_click();
        }
        else {
            $('.testlabel').text('contact info is not valid');
            $('.methchoose').slideUp(1000);
            $('.virement').slideUp(1000);
            $('.doncontinue').slideUp(1000);
        }
        
    }
    function bankfill_enter() {
        if (Page_ClientValidate('jBank')) {
            $('.doncontinue').slideDown(1000);
            $('html, body').animate({
                scrollTop: $(".doncontinue").offset().top
            }, 1000);
        }
        else {
            $('.doncontinue').slideUp(1000);
        }
    }
    function isControlValid(control) {
        var validators = $(control).Validators;
        var isValid = true;
        Array.forEach(validtors, function (item) {
            isValid = isValid && (item.isvalid === true);
        });
        return isValid;
    }
    function amt_trim() {
        var inp = $(".tbAmt").val();
        while (inp.substr(0, 1) == '0') inp = inp.substr(1);
        $(".tbAmt").val(inp);
    }
    function amt_enter() {
        var inp = $(".tbAmt").val();
        if (inp.length > 0 && inp > 0) {
            <% If Not (loggedin) Then%>
            $('.thelogincont').slideDown(1000);
            <% Else%>
            $('.contact').slideDown(1000);
            <% End If%>
            //only set set session storage if user is not logged in.
            <% If Not (loggedin) Then%>
            sessionStorage.setItem('tbAmt', inp);
            <% End If%>
            contactfill_enter();
        }
        else {
            $('.thelogincont').slideUp(1000);
            $('.contact').slideUp(1000);
            $('.methchoose').slideUp(1000);
            $('.doncontinue').slideUp(1000);
            $('.virement').slideUp(1000);
        }
    }


    function btnGoBank_click() {
        sessionStorage.removeItem('rbFreq');
        sessionStorage.removeItem('tbAmt');
    }
    function btnNext_click() {
        var str = '<%= Translate("WantGivePara1")%>';
        if ($('.rbFreq input:radio:checked').val() == 1) {
            str += '<%= Translate("FreqParaZero")%>';
        }
        else if ($('.rbFreq input:radio:checked').val() == 3) {
            str += '<%= Translate("FreqParaOne")%>';
        }
        else if ($('.rbFreq input:radio:checked').val() == 6) {
            str += '<%= Translate("FreqParaTwo")%>';
        }
        else if ($('.rbFreq input:radio:checked').val() == 12) {
            str += '<%= Translate("FreqParaThree")%>';
        }
        else if ($('.rbFreq input:radio:checked').val() == 99) {
            str += '<%= Translate("FreqParaFour")%>';
        }
    if ($('.rblMeth input:radio:checked').val() == 'm1') {
        $('#viretable').hide();
        $('#sumcc').show();
        $('#sumcheque').hide();
    }
    else if ($('.rblMeth input:radio:checked').val() == 'm2') {
        $('#viretable').show();
        $('#sumcc').hide();
        $('#sumcheque').hide();
    }
    else if ($('.rblMeth input:radio:checked').val() == 'm3') {
        $('#viretable').hide();
        $('#sumcc').hide();
        $('#sumcheque').show();
    }
    str += '<%= Translate("WantGivePara2")%>' + $('.tbAmt').val() + '€.';
    $('.lblSummaryInfo2').text(str);
    $('#lblSummaryFirstName').text($('.TxtFirstName').val());
    $('#lblSummaryLastName').text($('.TxtLastName').val());
    $('#lblSummaryStreet1').text($('.TxtStreet1').val());
    $('#lblSummaryStreet2').text($('.TxtStreet2').val());
    $('#lblSummaryCity').text($('.TxtCity').val());
    $('#lblSummaryCountry').text($('.TxtCountry').val());
    $('#lblSummaryRegion').text($('.TxtRegion').val());
    $('#lblSummaryPostal').text($('.TxtPostCode').val());
    $('#lblSummaryEmail').text($('.TxtEmail').val());
    $('#lblSummaryMobile').text($('.TxtMobile').val());
    $('#lblSummaryPhone').text($('.TxtTelephone').val());
    $('#lblSummaryBankName').text($('.TxtBank').val());
    $('#lblSummaryBankAddress1').text($('.TxtBankStreet1').val());
    $('#lblSummaryBankAddress2').text($('.TxtBankStreet2').val());
    $('#lblSummaryBankPostal').text($('.TxtBankPostal').val());
    $('#lblSummaryBankCity').text($('.TxtBankCity').val());
    $('#lblSummaryBankIBAN').text($('.TxtBankIBAN').val());
    $('#lblSummaryDonComment').text($('.theDonationComment').val());
    $('.freqchoose').slideUp(1000);
    $('.amtchoose').slideUp(1000);
    $('.contact').slideUp(1000);
    $('.methchoose').slideUp(1000);
    $('.virement').slideUp(1000);
    $('.doncontinue').slideUp(1000);
    $('.summaryDon').slideDown(1000);
    $('html, body').animate({
        scrollTop: $(".summaryDon").offset().top
    }, 1000);
}
function btnEditVirement_click() {
    $('.summaryDon').slideUp(1000);
    $('.freqchoose').slideDown(1000);
    rbFreq_click();
}
function rblMeth_click() {
    if ($('.rblMeth input:radio:checked').val() == 'm1') {
        $('.virement').slideUp(1000);
        $('.doncontinue').slideDown(1000);
        $('html, body').animate({
            scrollTop: $(".doncontinue").offset().top
        }, 1000);
    }
    else if ($('.rblMeth input:radio:checked').val() == 'm2') {
        $('.virement').slideDown(1000);
        bankfill_enter();
        $('html, body').animate({
            scrollTop: $(".virement").offset().top
        }, 1000);
    }
    else if ($('.rblMeth input:radio:checked').val() == 'm3') {
        $('.virement').slideUp(1000);
        $('.doncontinue').slideDown(1000);
        $('html, body').animate({
            scrollTop: $(".doncontinue").offset().top
        }, 1000);
    }
    else {
        $('.virement').slideUp(1000);
        $('.doncontinue').slideUp(1000);
    }
}
function rbFreq_click() {
    if ($('.rbFreq input:radio:checked').val() != null) {
        if ($('.rbFreq input:radio:checked').val() != 99) {
            var id = $('[value=m1]').attr("id");
            $('[value=m1]').attr('checked', false);
            $('[value=m1]').attr('disabled', true);
            $('label[for=' + id + ']').addClass('radiogray');
        }
        else if ($('.rbFreq input:radio:checked').val() == 99) {
            $('[value=m1]').attr('disabled', false);
            var id = $('[value=m1]').attr("id");
            $('label[for=' + id + ']').removeClass('radiogray');
        }
        //'Trent: Stop this slidedown after postback when showing confirmation
        $('.amtchoose').slideDown(500);
        amt_enter();
        //only set set session storage if user is not logged in.
        <% If Not (loggedin) Then%>
        sessionStorage.setItem('rbFreq', $('.rbFreq input:radio:checked').val())
            <% End If%>
    }
}
    function hidedivs() {
        $('.amtchoose').hide();
        $('.thelogincont').hide();
        $('.contact').hide();
        $('.methchoose').hide();
        $('.virement').hide();
        $('.doncontinue').hide();
        $('.summaryDon').hide();
        $('.confirmation').hide();
        $('.noscriptconf').hide();

    }
    function btnFinishDon_click() {
        $('.pleasewait').show();
        $('.summaryDon').slideUp(1000);
    }
</script>
<style type="text/css">
    .pleasewait {
        background-image: url(/DesktopModules/AgapeFR/GiveView/files/PleaseWait.gif);
        background-repeat: no-repeat;
        padding-left: 40px;
        height:32px;
        line-height:32px;
    }
    .tbAmt {
        width: 60px;
        border-radius: 3px;
        background: #FFFFF5;
        border-color: #BCB691;
        border-width: 1px;
        padding: 5px;
    }

    .radiogray {
        color: gray;
    }

    .bankinforight {
        float: right;
    }

    .bankinfoleft {
        float: left;
    }

    .giveformitem {
        width: 300px;
    }

    .virementform {
        width: 255px;
    }

    .input {
        width: 250px !important;
    }

    .bubble {
        border: 1px solid #6495ed;
        border-radius: 15px;
        padding: 10px;
    }

    .giveformitem input[type="text"], .giveformitem textarea {
        min-width: 200px;
    }

    .giveformitem label {
        text-align: left;
    }

    .dnnTooltip {
        width: 250px !important;
    }

    .giveformitem select {
        width: 260px;
    }

    .summaryleft {
        float: left;
        width: 48%;
    }

    .summaryright {
        float: right;
        width: 48%;
    }

    .auto-style1 {
        width: 100%;
    }

    #methchooseright {
        float: right;
        width: 65%;
    }

    #methchooseleft {
        float: left;
        width: 30%;
    }
</style>
<asp:HiddenField ID="RowId" runat="server" />
<asp:HiddenField ID="theHiddenTabIndex" runat="server" Value="0" ViewStateMode="Enabled" />
<asp:HiddenField ID="DonationType" runat="server" />
<asp:HiddenField ID="hfGiveToName" runat="server" Value="" />
<div id="stepCount">
    <asp:HiddenField ID="hfSONextStep" runat="server" Value="-1" />
</div>
<asp:HiddenField ID="hfUniqueRef" runat="server" Value="-1" />
<div style="font-size: 10pt;">
    <div style="width: 700px; float: left;">
        <div id="GiveTitle" runat="server" class="AgapeH2" style="margin-bottom: 12px;">
            <asp:Label ID="Title" runat="server"></asp:Label>
        </div>
        <div>
            <asp:ValidationSummary ID="ValSumDon" runat="server" ValidationGroup="Don" />
            <asp:ValidationSummary ID="ValSumBank" runat="server" ValidationGroup="Bank" />
        </div>
        <div id="freqchoose" class="freqchoose bubble" runat="server">
            <asp:Label ID="lblFrequency" Text="" runat="server" />
            <asp:RequiredFieldValidator ID="ValFreq" runat="server" ValidationGroup="Don" ControlToValidate="rblFrequency" Text="*"></asp:RequiredFieldValidator>
            <br />
            <asp:RadioButtonList CssClass="rblFrequency" ID="rblFrequency" runat="server" ValidationGroup="Don">
                <asp:ListItem Value="1"></asp:ListItem>
                <asp:ListItem Value="3"></asp:ListItem>
                <asp:ListItem Value="6"></asp:ListItem>
                <asp:ListItem Value="12"></asp:ListItem>
                <asp:ListItem Value="99"></asp:ListItem>
            </asp:RadioButtonList>
        </div>
        <div id="amtchoose" class="amtchoose bubble" runat="server">
            <asp:Label ID="lblWantGive" runat="server" Text="Label"></asp:Label>
            <asp:TextBox ID="tbAmount" runat="server" ValidationGroup="Don"></asp:TextBox>
            <asp:Label ID="lblTo" runat="server" Text="Label"></asp:Label>
            <asp:RequiredFieldValidator ID="ValAmt" runat="server" Text="*" ControlToValidate="tbAmount" ValidationGroup="Don"></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="ValAmtRange" runat="server" ControlToValidate="tbAmount" MinimumValue="1" MaximumValue="99999999" Text="*" ValidationGroup="Don"></asp:RangeValidator>
        </div>
        <div id="thelogincont" runat="server" class="bubble thelogincont">
            <asp:Label ID="lblTheLoginCont" Text="text" resourcekey="lblTheLoginCont" runat="server" />
            <dnn2:Login ID="login1" runat="server" />
        </div>
        <div id="contact" class="contact bubble" runat="server">
            <div style="float: left">
                <div class="giveformitem">
                    <dnn:Label ID="LblFirstName" runat="server" ControlName="TxtFirstName" />
                    <asp:TextBox ID="TxtFirstName" runat="server" MaxLength="50" CssClass="virementform TxtFirstName contactfill" />
                    <asp:RequiredFieldValidator ID="ValFirstName" runat="server" CssClass="giveFormMessage" ControlToValidate="TxtFirstName" Display="Dynamic" ValidationGroup="Don" Text="*" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" CssClass="giveFormMessage" ControlToValidate="TxtFirstName" Display="Dynamic" ValidationGroup="Contact" />
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="LblLastName" runat="server" ControlName="TxtLastName" />
                    <asp:TextBox ID="TxtLastName" runat="server" MaxLength="50" CssClass="virementform TxtLastName contactfill" />
                    <asp:RequiredFieldValidator ID="ValLastName" runat="server" CssClass="giveFormMessage" ControlToValidate="TxtLastName" Display="Dynamic" Text="*" ValidationGroup="Don" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" CssClass="giveFormMessage" ControlToValidate="TxtLastName" Display="Dynamic" ValidationGroup="Contact" />
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="LblEmail" runat="server" ControlName="TxtEmail" />
                    <asp:TextBox ID="TxtEmail" runat="server" MaxLength="50" CssClass="virementform TxtEmail contactfill" />
                    <asp:RequiredFieldValidator ID="ValEmail" runat="server" CssClass="giveFormMessage" ControlToValidate="TxtEmail" Display="Dynamic" ValidationGroup="Don" Text="*" />
                    <asp:RegularExpressionValidator ID="ValEmailExp" runat="server" Text="*" ControlToValidate="TxtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="Don" CssClass="auto-style1"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" CssClass="giveFormMessage" ControlToValidate="TxtEmail" Display="Dynamic" ValidationGroup="Contact" />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="TxtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="Contact" CssClass="auto-style1"></asp:RegularExpressionValidator>
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="LblConfEmail" runat="server" ControlName="TxtConfEmail" />
                    <asp:TextBox ID="TxtConfEmail" runat="server" MaxLength="50" CssClass="virementform TxtConfEmail contactfill" />
                    <asp:RequiredFieldValidator ID="ValConfEmail" runat="server" CssClass="giveFormMessage" ControlToValidate="TxtConfEmail" ValidationGroup="Don" Display="Dynamic" Text="*" />
                    <asp:CompareValidator ID="ValConfEmailComp" runat="server" ControlToCompare="TxtEmail" ControlToValidate="TxtConfEmail" ValidationGroup="Don" Text="*"></asp:CompareValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" CssClass="giveFormMessage" ControlToValidate="TxtConfEmail" ValidationGroup="Contact" Display="Dynamic" />
                    <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToCompare="TxtEmail" ControlToValidate="TxtConfEmail" ValidationGroup="Contact"></asp:CompareValidator>
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="LblMobile" runat="server" ControlName="TxtMobile" />
                    <asp:TextBox ID="TxtMobile" runat="server" MaxLength="50" CssClass="virementform TxtMobile contactfill" />
                    <asp:RegularExpressionValidator ID="ValMobileExp" ControlToValidate="TxtMobile" runat="server" ValidationExpression="^\d+$" Text="*" ValidationGroup="Don" />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" ControlToValidate="TxtMobile" runat="server" ValidationExpression="^\d+$" ValidationGroup="Contact" />
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="LblTelephone" runat="server" ControlName="TxtTelephone" />
                    <asp:TextBox ID="TxtTelephone" runat="server" MaxLength="50" CssClass="virementform TxtTelephone contactfill" />
                    <asp:RegularExpressionValidator ID="ValTelephoneExp" ControlToValidate="TxtTelephone" runat="server" ValidationExpression="^\d+$" Text="*" ValidationGroup="Don" />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator6" ControlToValidate="TxtTelephone" runat="server" ValidationExpression="^\d+$" ValidationGroup="Contact" />
                </div>
            </div>
            <div style="float: right">
                <div class="giveformitem">
                    <dnn:Label ID="LblStreet1" runat="server" ControlName="TxtStreet1" />
                    <asp:TextBox ID="TxtStreet1" runat="server" MaxLength="50" CssClass="virementform TxtStreet1 contactfill" />
                    <asp:RequiredFieldValidator ID="ValStreet1" ControlToValidate="TxtStreet1" runat="server" Text="*" ValidationGroup="Don" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ControlToValidate="TxtStreet1" runat="server" ValidationGroup="Contact" />
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="LblStreet2" runat="server" ControlName="TxtStreet2" />
                    <asp:TextBox ID="TxtStreet2" runat="server" MaxLength="50" CssClass="virementform TxtStreet2  contactfill" />
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="LlbCountry" runat="server" ControlName="TxtCountry" />
                    <div>

                        <wc:CountryListBox TestIP="" LocalhostCountryCode="US" ID="cboCountry" DataValueField="Value" DataTextField="Text" AutoPostBack="True" runat="server" />
                    </div>
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="LblPostCode" runat="server" ControlName="TxtPostCode" />
                    <asp:TextBox ID="TxtPostCode" runat="server" MaxLength="50" CssClass="virementform TxtPostCode contactfill" />
                    <asp:RequiredFieldValidator ID="ValPostCode" ControlToValidate="TxtPostCode" runat="server" ValidationGroup="Don" Text="*" />
                    <asp:RegularExpressionValidator ID="ValPostCodeExp" ControlToValidate="TxtPostCode" runat="server" ValidationGroup="Don" ValidationExpression="^\d+$" Visible="True" Text="*" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ControlToValidate="TxtPostCode" runat="server" ValidationGroup="Contact" />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator7" ControlToValidate="TxtPostCode" runat="server" ValidationGroup="Contact" ValidationExpression="^\d+$" Visible="True" />
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="LblCity" runat="server" ControlName="TxtCity" />
                    <asp:TextBox ID="TxtCity" runat="server" MaxLength="50" CssClass="virementform TxtCity contactfill" />
                    <asp:RequiredFieldValidator ID="ValCity" ControlToValidate="TxtCity" runat="server" Text="*" ValidationGroup="Don" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator13" ControlToValidate="TxtCity" runat="server" ValidationGroup="Contact" />
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="LblRegion" runat="server" ControlName="TxtRegion" />
                    <asp:TextBox ID="TxtRegion" runat="server" MaxLength="50" CssClass="virementform TxtRegion contactfill" />
                </div>
            </div>
            <div style="clear: both"></div>
        </div>
        <div id="methchoose" class="methchoose bubble" runat="server">
            <div id="methchooseleft">
                <asp:Label ID="lblOneOffChoose" runat="server" Text="Label"></asp:Label>
                <asp:RequiredFieldValidator ID="ValMethod" ControlToValidate="rblMethod" runat="server" Text="*" ValidationGroup="Don" />
                <asp:RadioButtonList ID="rblMethod" runat="server">
                    <asp:ListItem Value="m1"></asp:ListItem>
                    <asp:ListItem Value="m2"></asp:ListItem>
                    <asp:ListItem Value="m3"></asp:ListItem>
                </asp:RadioButtonList>
            </div>
            <div id="methchooseright">
                <asp:Label ID="lblDonComment" resourcekey="lblDonComment" runat="server" />
                <asp:TextBox ID="theDonationComment" CssClass="theDonationComment" runat="server" Font-Size="12pt" Width="95%" Height="48px" Rows="10" TextMode="MultiLine"></asp:TextBox><br />
            </div>
            <div style="clear: both"></div>
        </div>
        <div id="virement" class="virement bubble" runat="server">
            <asp:Label ID="lblBankInfo" runat="server" Text="Label"></asp:Label>
            <div style="clear: both"></div>
            <div class="bankinfoleft">
                <div class="giveformitem">
                    <dnn:Label ID="lblBank" runat="server" ControlName="TxtBank" />
                    <asp:TextBox ID="tbBank" ValidationGroup="Bank" runat="server" MaxLength="50" CssClass="TxtBank bankfill" />
                    <asp:RequiredFieldValidator ID="ValBank" ControlToValidate="tbBank" runat="server" Text="*" ValidationGroup="Bank" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator14" ControlToValidate="tbBank" runat="server" ValidationGroup="jBank" />
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="lblBankStreet1" runat="server" ControlName="TxtBankStreet1" />
                    <asp:TextBox ID="tbBankStreet1" ValidationGroup="Bank" runat="server" MaxLength="50" CssClass="TxtBankStreet1 bankfill" />
                    <asp:RequiredFieldValidator ID="ValBankStreet1" ControlToValidate="tbBankStreet1" runat="server" Text="*" ValidationGroup="Bank" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator15" ControlToValidate="tbBankStreet1" runat="server" ValidationGroup="jBank" />
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="lblBankStreet2" runat="server" ControlName="TxtBankStreet2" />
                    <asp:TextBox ID="tbBankStreet2" runat="server" MaxLength="50" CssClass="TxtBankStreet2 bankfill" />
                </div>
            </div>
            <div class="bankinforight">
                <div class="giveformitem">
                    <dnn:Label ID="lblBankPostal" runat="server" ControlName="TxtBankPostal" />
                    <asp:TextBox ID="tbBankPostal" ValidationGroup="Bank" runat="server" MaxLength="50" CssClass="TxtBankPostal bankfill" />
                    <asp:RequiredFieldValidator ID="ValBankPostal" ControlToValidate="tbBankPostal" runat="server" Text="*" ValidationGroup="Bank" />
                    <asp:RegularExpressionValidator ID="ValBankPostalExp" ControlToValidate="tbBankPostal" runat="server" ValidationGroup="Bank" ValidationExpression="^\d+$" Text="*" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator16" ControlToValidate="tbBankPostal" runat="server" ValidationGroup="jBank" />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator8" ControlToValidate="tbBankPostal" runat="server" ValidationGroup="jBank" ValidationExpression="^\d+$" />
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="lblBankCity" runat="server" ControlName="TxtBankCity" />
                    <asp:TextBox ID="tbBankCity" ValidationGroup="Bank" runat="server" MaxLength="50" CssClass="TxtBankCity bankfill" />
                    <asp:RequiredFieldValidator ID="ValBankCity" ControlToValidate="tbBankCity" runat="server" Text="*" ValidationGroup="Bank" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator17" ControlToValidate="tbBankCity" runat="server" ValidationGroup="jBank" />
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="lblIBAN" runat="server" ControlName="TxtIBAN" />
                    <asp:TextBox ID="tbIBAN" ValidationGroup="Bank" runat="server" MaxLength="50" CssClass="TxtBankIBAN bankfill" />
                    <asp:RequiredFieldValidator ID="ValIBAN" ControlToValidate="tbIBAN" runat="server" Text="*" ValidationGroup="Bank" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator18" ControlToValidate="tbIBAN" runat="server" ValidationGroup="jBank" />
                </div>
            </div>
            <div style="clear: both"></div>
        </div>
        <div id="doncontinue" class="bubble doncontinue" runat="server">
            <input id="btnNext" class="aButton btnNext" type="button" value="<%= Translate("btnNext")%>" />
        </div>
        <div id="summaryDon" class="summaryDon bubble" runat="server">
            <asp:Label ID="lblSummaryInfo1" Text="" runat="server" /><br />
            <br />
            <div class="summaryleft">
                <table class="auto-style1">
                    <tr>
                        <td colspan="2">
                            <asp:Label ID="lblSummaryLeft" CssClass="lblSummaryLeft" Text="text" runat="server" /></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSumTextFirst" CssClass="lblSumTextFirst" Text="text" runat="server" /></td>
                        <td>
                            <label id="lblSummaryFirstName"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSumTextLast" CssClass="lblSumTextLast" Text="text" runat="server" /></td>
                        <td>
                            <label id="lblSummaryLastName"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSumTextStreet1" CssClass="lblSumTextStreet1" Text="text" runat="server" /></td>
                        <td>
                            <label id="lblSummaryStreet1"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSumTextStreet2" CssClass="lblSumTextStreet2" Text="text" runat="server" /></td>
                        <td>
                            <label id="lblSummaryStreet2"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSumTextCity" CssClass="lblSumTextCity" Text="text" runat="server" /></td>
                        <td>
                            <label id="lblSummaryCity"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSumTextCountry" CssClass="lblSumTextCountry" Text="text" runat="server" /></td>
                        <td>
                            <label id="lblSummaryCountry"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSumTextRegion" CssClass="lblSumTextRegion" Text="text" runat="server" /></td>
                        <td>
                            <label id="lblSummaryRegion"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSumTextPostal" CssClass="lblSumTextPostal" Text="text" runat="server" /></td>
                        <td>
                            <label id="lblSummaryPostal"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSumTextEmail" CssClass="lblSumTextEmail" Text="text" runat="server" /></td>
                        <td>
                            <label id="lblSummaryEmail"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSumTextMobile" CssClass="lblSumTextMobile" Text="text" runat="server" /></td>
                        <td>
                            <label id="lblSummaryMobile"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSumTextPhone" CssClass="lblSumTextPhone" Text="text" runat="server" /></td>
                        <td>
                            <label id="lblSummaryPhone"></label>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="summaryright">
                <asp:Label ID="lblSummaryInfo2" CssClass="lblSummaryInfo2" Text="text" runat="server" /><br />
                <table id="viretable">
                    <tr>
                        <td colspan="2">
                            <asp:Label ID="lblSummaryRight" Text="" runat="server" /></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSumTextBankName" CssClass="lblSumTextBankName" Text="text" runat="server" /></td>
                        <td>
                            <label id="lblSummaryBankName"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSumTextBankAddress1" CssClass="lblSumTextBankAddress1" Text="text" runat="server" /></td>
                        <td>
                            <label id="lblSummaryBankAddress1"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSumTextBankAddress2" CssClass="lblSumTextBankAddress2" Text="text" runat="server" /></td>
                        <td>
                            <label id="lblSummaryBankAddress2"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSumTextBankPostal" CssClass="lblSumTextBankPostal" Text="text" runat="server" /></td>
                        <td>
                            <label id="lblSummaryBankPostal"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSumTextBankCity" CssClass="lblSumTextBankCity" Text="text" runat="server" /></td>
                        <td>
                            <label id="lblSummaryBankCity"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSumTextBankIBAN" CssClass="lblSumTextBankIBAN" Text="text" runat="server" /></td>
                        <td>
                            <label id="lblSummaryBankIBAN"></label>
                        </td>
                    </tr>
                </table>
                <div id="sumcc">
                    <asp:Label ID="lblCreditCard" Text="" runat="server" /><br />
                </div>
                <div id="sumcheque">
                    <asp:Label ID="lblSumCheque" resourcekey="lblSumCheque" runat="server" />
                </div>
                <asp:Label ID="lblSumDonComment" resourcekey="lblSumDonComment" runat="server" />
                <br />
                <label id="lblSummaryDonComment"></label>
            </div>
            <div style="clear: both"></div>
            <asp:Button ID="btnFinishDon" CssClass="aButton btnFinishDon" ValidationGroup="Don" runat="server" />
            <input id="Button1" class="aButton btnEditVirement" type="button" value="<%= Translate("btnEditVirement") %>" />
        </div>
        <div id="pleasewait" class="pleasewait" runat="server">
            <asp:Label ID="lblPleaseWait" resourcekey="lblPleaseWait" runat="server" />
        </div>
        <div id="confirmation" class="confirmation bubble" runat="server">
            <asp:Label ID="lblConfVirement" resourcekey="lblConfVirement" runat="server" />
            <asp:Label ID="lblConfCheque" resourcekey="lblConfCheque" runat="server" />
            <asp:HyperLink ID="HyperLink1" Target="_blank" runat="server">
                <asp:Label ID="lblLinkPDF" Text="text" runat="server" />
            </asp:HyperLink>
        </div>
        <div id="noscriptconf" class="noscriptconf bubble" runat="server">
            <asp:Button ID="btnNoScriptGo" CssClass="aButton" ValidationGroup="Don" runat="server" />
        </div>
    </div>
    <div style="float: right; font-size: 10pt;">
        <asp:Image ID="theImage1" runat="server" Width="300px" BorderColor="Black" BorderStyle="Solid"
            BorderWidth="2px" EnableViewState="False" />
        <br />
        <asp:Button ID="btnBio" runat="server" resourcekey="btnBio" CssClass="aButton" CausesValidation="False" />
        <br />
        <div>
            <uc1:frGiveInfo ID="frGiveInfo" runat="server" />
        </div>
    </div>
</div>
