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
            transClient();
            if ($('#stepCount input[type=hidden]').val() == 1) {
                $('#freqchoose').hide();
                $('#confirmation').slideDown(1000);
            }
            //$('#imgTip').tooltip();
            $('.aButton').button();
            $('.tbAmt').numeric({ decimal: false });
            $('.tbAmt').attr('autocomplete', 'off');
            $('.tbAmt').keyup(function () {
                amt_enter();
            });
            $('.tbAmt').change(function () {
                amt_trim();
                amt_enter();
            });
            $('.rblMeth').click(function () {
                rblMeth_click();
            });
            $('.rbFreq').click(function () {
                rbFreq_click();
            });
            $('#btnVirementNext').click(function () {
                btnVirementNext_click();
            });
            $('#btnEditVirement').click(function () {
                btnEditVirement_click();
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
    function btnVirementNext_click() {
        //var str = $('.TxtFirstName').val() + ' is my first name!';
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
    str += '<%= Translate("WantGivePara2")%>' + $('.tbAmt').val() + '€. ' + '<%= Translate("WantGivePara3")%>';
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
        $('#freqchoose').slideUp(1000);
        $('#amtchoose').slideUp(1000);
        $('#thelogincont').slideUp(1000);
        $('#contact').slideUp(1000);
        $('#methchoose').slideUp(1000);
        $('#virement').slideUp(1000);
        $('#summaryVirement').slideDown(1000);
        $('html, body').animate({
            scrollTop: $("#summaryVirement").offset().top
        }, 1000);
    }
    function btnEditVirement_click() {
        $('#freqchoose').slideDown(1000);
        $('#amtchoose').slideDown(1000);
        $('#thelogincont').slideDown(1000);
        $('#contact').slideDown(1000);
        $('#methchoose').slideDown(1000);
        $('#virement').slideDown(1000);
        $('#summaryVirement').slideUp(1000);
    }
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
    function amt_trim() {
        var inp = $(".tbAmt").val();
        while (inp.substr(0, 1) == '0') inp = inp.substr(1);
        $(".tbAmt").val(inp);
    }
    function amt_enter() {
        var inp = $(".tbAmt").val();
        if (inp.length > 0 && inp > 0) {
            $('#thelogincont').slideDown(1000);
            var logged = $('#hfLoggedIn').val();
            if (logged == "False") {
                $('#thelogincont').slideDown(1000);
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
            $('#thelogincont').slideUp(1000);
            $('#contact').slideUp(1000);
            $('#methchoose').slideUp(1000);
            $('#creditcard').slideUp(1000);
            $('#cheque').slideUp(1000);
            $('#virement').slideUp(1000);
        }
    }
    function hidedivs() {

        $('#amtchoose').hide();
        $('#thelogincont').hide();
        $('#contact').hide();
        $('#methchoose').hide();
        $('#virement').hide();
        $('#summaryVirement').hide();
        $('#confirmation').hide();
        $('#creditcard').hide();
        $('#cheque').hide();


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
        border-color: #BCB691;
        border-width: 1px;
        padding: 5px;
    }

    .dnnForm {
        min-width: 0 !important;
    }

        .dnnForm input.dnnFormRequired {
            margin-left: -5px;
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
        border: 1px solid #6495ed;
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
<div id="stepCount">
    <asp:HiddenField ID="hfSONextStep" runat="server" Value="-1" />
</div>
<asp:HiddenField ID="hfUniqueRef" runat="server" Value="-1" />
<div style="font-size: 10pt;">
    <div style="width: 700px; float: left;">
        <div id="GiveTitle" runat="server" class="h1" style="margin-bottom: 12px;">
            <asp:Label ID="Title" runat="server"></asp:Label>
        </div>
        <asp:Label ID="lblOOError" Visible="False" runat="server"></asp:Label>
        <div id="freqchoose" class="bubble">
            <asp:Label ID="lblFrequency" Text="" runat="server" /><br />
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
        <div id="thelogincont" runat="server" class="bubble">
            This is the thelogincont div.
            <dnn2:Login ID="Login1" runat="server" />
        </div>
        <div id="contact" class="bubble">
            <div style="float: left">
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="LblFirstName" runat="server" ControlName="TxtFirstName" />
                        <br />
                        <asp:TextBox ID="TxtFirstName" runat="server" MaxLength="50" CssClass="dnnFormRequired virementform TxtFirstName" />
                        <asp:RequiredFieldValidator ID="ValFirstName" runat="server" CssClass="dnnFormMessage dnnFormError" ControlToValidate="TxtFirstName" Display="Dynamic" />
                    </div>
                </div>
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="LblLastName" runat="server" ControlName="TxtLastName" />
                        <asp:TextBox ID="TxtLastName" runat="server" MaxLength="50" CssClass="dnnFormRequired virementform TxtLastName" />
                        <asp:RequiredFieldValidator ID="ValLastName" runat="server" CssClass="dnnFormMessage dnnFormError" ControlToValidate="TxtLastName" Display="Dynamic" />
                    </div>
                </div>
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="LblEmail" runat="server" ControlName="TxtEmail" />
                        <asp:TextBox ID="TxtEmail" runat="server" MaxLength="50" CssClass="dnnFormRequired virementform TxtEmail" />
                        <asp:RequiredFieldValidator ID="ValEmail" runat="server" CssClass="dnnFormMessage dnnFormError" ControlToValidate="TxtEmail" Display="Dynamic" />
                    </div>
                </div>
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="LblConfEmail" runat="server" ControlName="TxtConfEmail" />
                        <asp:TextBox ID="TxtConfEmail" runat="server" MaxLength="50" CssClass="dnnFormRequired virementform" />
                        <asp:RequiredFieldValidator ID="ValConfEmail" runat="server" CssClass="dnnFormMessage dnnFormError" ControlToValidate="TxtConfEmail" Display="Dynamic" />
                    </div>
                </div>
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="LblMobile" runat="server" ControlName="TxtMobile" />
                        <asp:TextBox ID="TxtMobile" runat="server" MaxLength="50" CssClass="virementform TxtMobile" />
                    </div>
                </div>
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="LblTelephone" runat="server" ControlName="TxtTelephone" />
                        <asp:TextBox ID="TxtTelephone" runat="server" MaxLength="50" CssClass="virementform TxtTelephone" />
                    </div>
                </div>
            </div>
            <div style="float: right">
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="LblStreet1" runat="server" ControlName="TxtStreet1" />
                        <asp:TextBox ID="TxtStreet1" runat="server" MaxLength="50" CssClass="virementform TxtStreet1" />
                    </div>
                </div>
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="LblStreet2" runat="server" ControlName="TxtStreet2" />
                        <asp:TextBox ID="TxtStreet2" runat="server" MaxLength="50" CssClass="virementform TxtStreet2" />
                    </div>
                </div>
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="LblCity" runat="server" ControlName="TxtCity" />
                        <asp:TextBox ID="TxtCity" runat="server" MaxLength="50" CssClass="virementform TxtCity" />
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
                        <asp:TextBox ID="TxtRegion" runat="server" MaxLength="50" CssClass="virementform TxtRegion" />
                    </div>
                </div>
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="LblPostCode" runat="server" ControlName="TxtPostCode" />
                        <asp:TextBox ID="TxtPostCode" runat="server" MaxLength="50" CssClass="virementform TxtPostCode" />
                    </div>
                </div>
            </div>
            <div style="clear: both"></div>

        </div>
        <div id="methchoose" class="bubble">
            <asp:Label ID="lblOneOffChoose" runat="server" Text="Label"></asp:Label>
            <asp:RadioButtonList ID="rblMethod" runat="server">
                <asp:ListItem Value="m1"></asp:ListItem>
                <asp:ListItem Value="m2"></asp:ListItem>
                <asp:ListItem Value="m3"></asp:ListItem>
            </asp:RadioButtonList>
        </div>
        <div id="virement" class="bubble">
            <asp:Label ID="lblBankInfo" runat="server" Text="Label"></asp:Label>
            <div style="clear: both"></div>
            <div class="bankinfoleft">
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="lblBank" runat="server" ControlName="TxtBank" />
                        <asp:TextBox ID="tbBank" ValidationGroup="OneOffVirement" runat="server" MaxLength="50" CssClass="dnnFormRequired TxtBank" />
                    </div>
                </div>
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="lblBankStreet1" runat="server" ControlName="TxtBankStreet1" />
                        <asp:TextBox ID="tbBankStreet1" ValidationGroup="OneOffVirement" runat="server" MaxLength="50" CssClass="dnnFormRequired TxtBankStreet1" />
                    </div>
                </div>
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="lblBankStreet2" runat="server" ControlName="TxtBankStreet2" />
                        <asp:TextBox ID="tbBankStreet2" ValidationGroup="OneOffVirement" runat="server" MaxLength="50" CssClass="dnnFormRequired TxtBankStreet2" />
                    </div>
                </div>
            </div>
            <div class="bankinforight">
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="lblBankPostal" runat="server" ControlName="TxtBankPostal" />
                        <asp:TextBox ID="tbBankPostal" ValidationGroup="OneOffVirement" runat="server" MaxLength="50" CssClass="dnnFormRequired TxtBankPostal" />
                    </div>
                </div>
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="lblBankCity" runat="server" ControlName="TxtBankCity" />
                        <asp:TextBox ID="tbBankCity" ValidationGroup="OneOffVirement" runat="server" MaxLength="50" CssClass="dnnFormRequired TxtBankCity" />
                    </div>
                </div>
                <div class="dnnForm dnnAddress dnnClear">
                    <div class="dnnFormItem">
                        <dnn:Label ID="lblIBAN" runat="server" ControlName="TxtIBAN" />
                        <asp:TextBox ID="tbIBAN" ValidationGroup="OneOffVirement" runat="server" MaxLength="50" CssClass="dnnFormRequired TxtBankIBAN" />
                    </div>
                </div>
            </div>
            <div style="clear: both"></div>
            <a id="btnVirementNext" class="aButton"><%= Translate("btnVirementNext") %></a>
        </div>
        <div id="summaryVirement" class="bubble">
            <asp:Label ID="lblSummaryInfo1" Text="" runat="server" /><br />
            <br />
            <asp:Label ID="lblSummaryInfo2" CssClass="lblSummaryInfo2" Text="text" runat="server" /><br />
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
                <table>
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
            </div>
            <div style="clear: both"></div>
            <asp:Button ID="btnGoBank" CssClass="aButton" ValidationGroup="OneOffVirement" runat="server" Text="GoBank" />
            <a id="btnEditVirement" class="aButton"><%= Translate("btnEditVirement") %></a>
        </div>
        <div id="confirmation" class="bubble">
            <asp:Label ID="lblConfText1" resourcekey="lblConfText1" runat="server" />
                        <asp:HyperLink ID="HyperLink1" Target="_blank" runat="server"><asp:label ID="lblLinkPDF" text="text" runat="server" /></asp:HyperLink>
        </div>
        <div id="creditcard" class="bubble">
            <asp:Label ID="lblCreditCard" Text="" runat="server" /><br />
            <asp:TextBox ID="theDonationComment" runat="server" Font-Size="12pt" Width="360px" Height="48px" Rows="10" TextMode="MultiLine"></asp:TextBox><br />
            <asp:Button ID="btnCarte" ValidationGroup="OneOffCC" runat="server" Text="" CssClass="aButton" />&nbsp;
                <asp:Button ID="btnCheckout" ValidationGroup="OneOffCC" runat="server" Text="" CssClass="aButton" />
        </div>
        <div id="cheque" class="bubble">
            <asp:Label ID="lblCheque" Text="" runat="server" /><br />
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
