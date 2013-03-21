<%@ Control Language="VB" AutoEventWireup="false" CodeFile="GiveView.ascx.vb" Inherits="DotNetNuke.Modules.AgapeFR.GiveView.GiveView" %>
<%@ Register Src="../GiveInfo/GiveInfo.ascx" TagName="frGiveInfo" TagPrefix="uc1" %>
<%@ Register Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" TagPrefix="cc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn1" TagName="Address" Src="~/controls/Address.ascx" %>
<%@ Register TagPrefix="wc" Namespace="DotNetNuke.UI.WebControls" Assembly="CountryListBox" %>
<%@ Register TagPrefix="dnn2" TagName="Login" Src="~/DesktopModules/AgapeFR/Authentication/AgapeAuth.ascx" %>
<script>
    //Page_ClientValidate("Bank")
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

    .giveformitem input[type="text"], .giveformitem textarea {
        min-width: 255px;
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
<asp:HiddenField ID="ShowProject" runat="server" Value="0" ViewStateMode="Enabled" />
<asp:HiddenField ID="DonationType" runat="server" />
<asp:HiddenField ID="hfUserId1" runat="server" Value="-1" />
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
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="Don" HeaderText="There Be Errors!" />
            <asp:ValidationSummary ID="ValidationSummary2" runat="server" ValidationGroup="Bank" HeaderText="Bank Errors!" />
        </div>
        <div id="freqchoose" class="freqchoose bubble" runat="server">
            <asp:Label ID="lblFrequency" Text="" runat="server" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="you forgot the frequency!" ValidationGroup="Don" ControlToValidate="rblFrequency" Text="*"></asp:RequiredFieldValidator>
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
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="you need an amount!" Text="*" ControlToValidate="tbAmount" ValidationGroup="Don"></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="You can't enter that amount!" ControlToValidate="tbAmount" MinimumValue="1" MaximumValue="99999999" Text="*" ValidationGroup="Don"></asp:RangeValidator>
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
                    <asp:RequiredFieldValidator ID="ValFirstName" runat="server" CssClass="giveFormMessage" ControlToValidate="TxtFirstName" Display="Dynamic" ValidationGroup="Don" ErrorMessage="You need a first name!" Text="*" />
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="LblLastName" runat="server" ControlName="TxtLastName" />
                    <asp:TextBox ID="TxtLastName" runat="server" MaxLength="50" CssClass="virementform TxtLastName contactfill" />
                    <asp:RequiredFieldValidator ID="ValLastName" runat="server" CssClass="giveFormMessage" ControlToValidate="TxtLastName" Display="Dynamic" Text="*" ErrorMessage="you need a last name!" ValidationGroup="Don" />
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="LblEmail" runat="server" ControlName="TxtEmail" />
                    <asp:TextBox ID="TxtEmail" runat="server" MaxLength="50" CssClass="virementform TxtEmail contactfill" />
                    <asp:RequiredFieldValidator ID="ValEmail" runat="server" CssClass="giveFormMessage" ControlToValidate="TxtEmail" Display="Dynamic" ValidationGroup="Don" Text="*" ErrorMessage="you need an email!" />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="that is not an email address!" Text="*" ControlToValidate="TxtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="Don" CssClass="auto-style1"></asp:RegularExpressionValidator>
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="LblConfEmail" runat="server" ControlName="TxtConfEmail" />
                    <asp:TextBox ID="TxtConfEmail" runat="server" MaxLength="50" CssClass="virementform TxtConfEmail contactfill" />
                    <asp:RequiredFieldValidator ID="ValConfEmail" runat="server" CssClass="giveFormMessage" ControlToValidate="TxtConfEmail" ValidationGroup="Don" Display="Dynamic" ErrorMessage="gotta fill email2!" Text="*" />
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="TxtEmail" ControlToValidate="TxtConfEmail" ValidationGroup="Don" ErrorMessage="emails don't match!" Text="*"></asp:CompareValidator>
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="LblMobile" runat="server" ControlName="TxtMobile" />
                    <asp:TextBox ID="TxtMobile" runat="server" MaxLength="50" CssClass="virementform TxtMobile contactfill" />
                    <asp:RegularExpressionValidator ErrorMessage="that is not a moblie number!" ControlToValidate="TxtMobile" runat="server" ValidationExpression="^\d+$" Text="*" ValidationGroup="Don" />
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="LblTelephone" runat="server" ControlName="TxtTelephone" />
                    <asp:TextBox ID="TxtTelephone" runat="server" MaxLength="50" CssClass="virementform TxtTelephone contactfill" />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ErrorMessage="that is not a phone number!" ControlToValidate="TxtTelephone" runat="server" ValidationExpression="^\d+$" Text="*" ValidationGroup="Don" />
                </div>
            </div>
            <div style="float: right">
                <div class="giveformitem">
                    <dnn:Label ID="LblStreet1" runat="server" ControlName="TxtStreet1" />
                    <asp:TextBox ID="TxtStreet1" runat="server" MaxLength="50" CssClass="virementform TxtStreet1 contactfill" />
                    <asp:RequiredFieldValidator ErrorMessage="the address is needed!" ControlToValidate="TxtStreet1" runat="server" Text="*" ValidationGroup="Don" />
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="LblStreet2" runat="server" ControlName="TxtStreet2" />
                    <asp:TextBox ID="TxtStreet2" runat="server" MaxLength="50" CssClass="virementform TxtStreet2  contactfill" />
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="LlbCountry" runat="server" ControlName="TxtCountry" />
                    <div class="dnnLeft">
                        <wc:CountryListBox TestIP="" LocalhostCountryCode="France" ID="cboCountry" DataValueField="Value" DataTextField="Text" AutoPostBack="True" runat="server" />
                    </div>
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="LblPostCode" runat="server" ControlName="TxtPostCode" />
                    <asp:TextBox ID="TxtPostCode" runat="server" MaxLength="50" CssClass="virementform TxtPostCode contactfill" />
                    <asp:RequiredFieldValidator ErrorMessage="the post code is needed!" ControlToValidate="TxtPostCode" runat="server" ValidationGroup="Don" Text="*" />
                    <asp:RegularExpressionValidator ErrorMessage="that is not a post code!" ControlToValidate="TxtPostCode" runat="server" ValidationGroup="Don" ValidationExpression="^\d+$" Visible="True" Text="*" />
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="LblCity" runat="server" ControlName="TxtCity" />
                    <asp:TextBox ID="TxtCity" runat="server" MaxLength="50" CssClass="virementform TxtCity contactfill" />
                    <asp:RequiredFieldValidator ErrorMessage="you need a city!" ControlToValidate="TxtCity" runat="server" Text="*" ValidationGroup="Don" />
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
                <asp:RequiredFieldValidator ErrorMessage="you need a giving method!" ControlToValidate="rblMethod" runat="server" Text="*" ValidationGroup="Don" />
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
                    <asp:RequiredFieldValidator ErrorMessage="need the bank name!" ControlToValidate="tbBank" runat="server" Text="*" ValidationGroup="Bank" />
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="lblBankStreet1" runat="server" ControlName="TxtBankStreet1" />
                    <asp:TextBox ID="tbBankStreet1" ValidationGroup="Bank" runat="server" MaxLength="50" CssClass="TxtBankStreet1 bankfill" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ErrorMessage="need the bank address!" ControlToValidate="tbBankStreet1" runat="server" Text="*" ValidationGroup="Bank" />
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="lblBankStreet2" runat="server" ControlName="TxtBankStreet2" />
                    <asp:TextBox ID="tbBankStreet2" ValidationGroup="Bank" runat="server" MaxLength="50" CssClass="TxtBankStreet2 bankfill" />
                </div>
            </div>
            <div class="bankinforight">
                <div class="giveformitem">
                    <dnn:Label ID="lblBankPostal" runat="server" ControlName="TxtBankPostal" />
                    <asp:TextBox ID="tbBankPostal" ValidationGroup="Bank" runat="server" MaxLength="50" CssClass="TxtBankPostal bankfill" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ErrorMessage="need the bank post code!" ControlToValidate="tbBankPostal" runat="server" Text="*" ValidationGroup="Bank" />
                    <asp:RegularExpressionValidator ErrorMessage="bad bank post code!" ControlToValidate="tbBankPostal" runat="server" ValidationGroup="Bank" ValidationExpression="^\d+$" Text="*" />
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="lblBankCity" runat="server" ControlName="TxtBankCity" />
                    <asp:TextBox ID="tbBankCity" ValidationGroup="Bank" runat="server" MaxLength="50" CssClass="TxtBankCity bankfill" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ErrorMessage="need the bank city!" ControlToValidate="tbBankCity" runat="server" Text="*" ValidationGroup="Bank" />
                </div>
                <div class="giveformitem">
                    <dnn:Label ID="lblIBAN" runat="server" ControlName="TxtIBAN" />
                    <asp:TextBox ID="tbIBAN" ValidationGroup="Bank" runat="server" MaxLength="50" CssClass="TxtBankIBAN bankfill" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ErrorMessage="need your IBAN!" ControlToValidate="tbIBAN" runat="server" Text="*" ValidationGroup="Bank" />
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
        <asp:Button ID="btnBio" runat="server" Text="See Bio" CssClass="aButton" />
        <br />
        <div>
            <uc1:frGiveInfo ID="frGiveInfo" runat="server" />
        </div>
    </div>
</div>
