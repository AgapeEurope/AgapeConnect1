<%@ Control Language="VB" AutoEventWireup="False" CodeFile="SiteSetup.ascx.vb" Inherits="DotNetNuke.Modules.AgapeConnect.SiteSetup" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<script type="text/javascript">
    (function ($, Sys) {
        function setUpMyTabs() {
            var stop = false;




            $("#accordion h3").click(function (event) {
                if (stop) {
                    event.stopImmediatePropagation();
                    event.preventDefault();
                    stop = false;
                }
            });
            $("#accordion").accordion({
                header: "> div > h3",
                icons: null,

                navigate: false
            });
            var progress1 = (($('#<%= cbSiteName.ClientID%>').attr('checked') ? 1 : 0) + ($('#<%= cbCustomLogo.ClientID%>').attr('checked') ? 1 : 0)) * 50;
            $("#progressbar1").progressbar({ value: progress1 });
            $("#progresslabel1").text($("#progressbar1").progressbar("value") + "%");
            var progress2 = (($('#<%= cbAcDatalinks.ClientID%>').attr('checked') ? 1 : 0)
                    + ($('#<%= cbAccountCodes.ClientID%>').attr('checked') ? 1 : 0)
                + ($('#<%= cbCurSymbol.ClientID%>').attr('checked') ? 1 : 0)
                + ($('#<%= cbAccountingCurrency.ClientID%>').attr('checked') ? 1 : 0)
                + ($('#<%= cbLocalCurrency.ClientID%>').attr('checked') ? 1 : 0)
                ) * (100 / 5);
            $("#progressbar2").progressbar({ value: progress2 });
            $("#progresslabel2").text($("#progressbar2").progressbar("value") + "%");
            var progress3 = (($('#<%= cbStaff.ClientID%>').attr('checked') ? 1 : 0)
                  + ($('#<%= cbLeadership.ClientID%>').attr('checked') ? 1 : 0)
                + ($('#<%= cbDepartments.ClientID%>').attr('checked') ? 1 : 0)
                ) * (100 / 3.0);
            $("#progressbar3").progressbar({ value: Math.round(progress3) });
            $("#progresslabel3").text($("#progressbar3").progressbar("value") + "%");

            $("#progressbar4").progressbar({ value: 22 });
            $("#progresslabel4").text($("#progressbar4").progressbar("value") + "%");

            $("#progressbar5").progressbar({ value: 15 });
            $("#progresslabel5").text($("#progressbar5").progressbar("value") + "%");

            $('.progress-box1').click(function () {
                var progress1 = (($('#<%= cbSiteName.ClientID%>').attr('checked') ? 1 : 0) + ($('#<%= cbCustomLogo.ClientID%>').attr('checked') ? 1 : 0)) * 50;
                $("#progressbar1").progressbar({ value: progress1 });
                $("#progresslabel1").text($("#progressbar1").progressbar("value") + "%");
            });
            $('.progress-box2').click(function () {
                var progress2 = (($('#<%= cbAcDatalinks.ClientID%>').attr('checked') ? 1 : 0)
                    + ($('#<%= cbAccountCodes.ClientID%>').attr('checked') ? 1 : 0)
                + ($('#<%= cbCurSymbol.ClientID%>').attr('checked') ? 1 : 0)
                + ($('#<%= cbAccountingCurrency.ClientID%>').attr('checked') ? 1 : 0)
                + ($('#<%= cbLocalCurrency.ClientID%>').attr('checked') ? 1 : 0)
                ) * (100 / 5);



                $("#progressbar2").progressbar({ value: progress2 });
                $("#progresslabel2").text($("#progressbar2").progressbar("value") + "%");
            });
            $('.progress-box3').click(function () {
                var progress3 = (($('#<%= cbStaff.ClientID%>').attr('checked') ? 1 : 0)
                    + ($('#<%= cbLeadership.ClientID%>').attr('checked') ? 1 : 0)
                + ($('#<%= cbDepartments.ClientID%>').attr('checked') ? 1 : 0)
                ) * (100 / 3.0);



                $("#progressbar3").progressbar({ value: Math.round(progress3) });
                $("#progresslabel3").text($("#progressbar3").progressbar("value") + "%");
            });

        }









        $(document).ready(function () {
            setUpMyTabs();


            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpMyTabs();



            });
        });








    }(jQuery, window.Sys));
</script>

<style type="text/css">
    #accordion .AcHdr {
        font-size: x-large;
        font-weight: bold;
    }

    .AcPane {
        height: 380px;
        padding: 20px !important;
    }

    .progressbar {
        float: right;
        width: 25%;
        height: 25px !important;
        position: relative;
    }

    .progress-label {
        position: absolute;
        left: 50%;
        top: 4px;
        font-size: medium;
        font-weight: bold;
        text-shadow: 1px 1px 0 #fff;
    }

    .complete-box {
        float: right;
    }

        .complete-box input {
            width: 40px;
            height: 40px;
        }

    .intro {
        font-style: italic;
        color: darkgrey;
    }

    .LabelTitle {
        font-weight: bold;
        color: darkgray;
        font-size: large;
    }
</style>


<h1>Site Setup Checklist</h1>
<div id="accordion">
    <div>
        <h3><a href="#" id="Tab0" class="AcHdr">Site Configuration
            <div id="progressbar1" class="progressbar">
                <div id="progresslabel1" class="progress-label">Loading...</div>
            </div>
        </a></h3>
        <div id="SiteConfigPane" class="AcPane">
            <p class="intro">
                These settings can be changes on the <a href="/Admin/SiteSettings.aspx">Site Settings page</a> (Admin->Site Settings)
            </p>
            <table cellpadding="10px" width="100%">

                <tr>
                    <td>
                        <dnn:Label ID="lblNoReceipt" runat="server" CssClass="LabelTitle" Text="Site Name" HelpText="You should set the site name to the name of your organisation (in your native language)." />
                    </td>
                    <td>
                        <asp:Label ID="lblSiteName" runat="server" Text=""></asp:Label>
                        <asp:CheckBox ID="cbSiteName" runat="server" CssClass="complete-box progress-box1" />

                    </td>

                </tr>
                <tr>
                    <td>
                        <dnn:Label ID="Label1" runat="server" CssClass="LabelTitle" Text="Custom Logo" HelpText="You are welcome to use our AgapeConnect logo. But if possible, we suggest that you use your own company logo." />
                    </td>
                    <td>
                        <asp:Label ID="lblCustomLogo" runat="server" Text="You have not configured a custom logo."></asp:Label>
                        <asp:CheckBox ID="cbCustomLogo" runat="server" CssClass="complete-box progress-box1" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div>
        <h3><a href="#" id="Tab1" class="AcHdr">AgapeConnect Settings<div id="progressbar2" class="progressbar">
            <div id="progresslabel2" class="progress-label">Loading...</div>
        </div>
        </a></h3>
        <div id="acSettingsPane" class="AcPane">
            <table cellpadding="10px" width="100%">
                <tr>
                    <td>
                        <dnn:Label ID="Label2" runat="server" CssClass="LabelTitle" Text="Automatic Datapump" HelpText="The Automatic Datapump links this website to Dynamics - and automatically configures the site with information about your accounts." />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbAcDatalinks" runat="server" CssClass="complete-box progress-box2" />
                        <h5>
                            <asp:Label ID="lblAcDatalinks" runat="server" Text="The Automatic Datapump has never connected with this site"></asp:Label></h5>

                        <asp:CheckBox ID="cbDynamics" runat="server" Text="We are not using Dynamics." />
                    </td>
                </tr>
                <tr>
                    <td>
                        <dnn:Label ID="Label3" runat="server" CssClass="LabelTitle" Text="Account Codes & R/C's" HelpText="The automatic datapump configures the website with a list of your account codes and R/C's. Many of the tasks on this page require this do be done first!" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbAccountCodes" runat="server" CssClass="complete-box progress-box2" />
                        <h5>

                            <asp:Label ID="lblAccountCodes" runat="server" Text="Account Codes and R/C have not yet been setup"></asp:Label></h5>

                    </td>
                </tr>
                <tr>
                    <td>
                        <dnn:Label ID="Label6" runat="server" CssClass="LabelTitle" Text="Currency Symbol" HelpText="Currency Symbol for your Accounting Currency" />
                    </td>
                    <td>

                        <asp:CheckBox ID="cbCurSymbol" runat="server" Text="Click to confirm" CssClass="complete-box progress-box2" />
                        <h5>
                            <asp:TextBox ID="tbCurrencySymbol" runat="server" Text="Account Codes and R/C have not yet been setup" Width="30px"></asp:TextBox></h5>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dnn:Label ID="Label4" runat="server" CssClass="LabelTitle" Text="Accounting currency" HelpText="The currency of your accounts" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbAccountingCurrency" runat="server" Text="Click to confirm" CssClass="complete-box progress-box2" />

                        <asp:DropDownList ID="ddlAccountingCurrency" runat="server" class="ddlCur">
                            <asp:ListItem Value="ALL">Albanian Lek</asp:ListItem>
                            <asp:ListItem Value="DZD">Algerian Dinar</asp:ListItem>
                            <asp:ListItem Value="ARS">Argentine Peso</asp:ListItem>
                            <asp:ListItem Value="AWG">Aruba Florin</asp:ListItem>
                            <asp:ListItem Value="AUD">Australian Dollar</asp:ListItem>
                            <asp:ListItem Value="BSD">Bahamian Dollar</asp:ListItem>
                            <asp:ListItem Value="BHD">Bahraini Dinar</asp:ListItem>
                            <asp:ListItem Value="BDT">Bangladesh Taka</asp:ListItem>
                            <asp:ListItem Value="BBD">Barbados Dollar</asp:ListItem>
                            <asp:ListItem Value="BYR">Belarus Ruble</asp:ListItem>
                            <asp:ListItem Value="BZD">Belize Dollar</asp:ListItem>
                            <asp:ListItem Value="BMD">Bermuda Dollar</asp:ListItem>
                            <asp:ListItem Value="BTN">Bhutan Ngultrum</asp:ListItem>
                            <asp:ListItem Value="BOB">Bolivian Boliviano</asp:ListItem>
                            <asp:ListItem Value="BWP">Botswana Pula</asp:ListItem>
                            <asp:ListItem Value="BRL">Brazilian Real</asp:ListItem>
                            <asp:ListItem Value="GBP">British Pound</asp:ListItem>
                            <asp:ListItem Value="BND">Brunei Dollar</asp:ListItem>
                            <asp:ListItem Value="BGN">Bulgarian Lev</asp:ListItem>
                            <asp:ListItem Value="BIF">Burundi Franc</asp:ListItem>
                            <asp:ListItem Value="KHR">Cambodia Riel</asp:ListItem>
                            <asp:ListItem Value="CAD">Canadian Dollar</asp:ListItem>
                            <asp:ListItem Value="CVE">Cape Verde Escudo</asp:ListItem>
                            <asp:ListItem Value="KYD">Cayman Islands Dollar</asp:ListItem>
                            <asp:ListItem Value="XOF">CFA Franc (BCEAO)</asp:ListItem>
                            <asp:ListItem Value="XAF">CFA Franc (BEAC)</asp:ListItem>
                            <asp:ListItem Value="CLP">Chilean Peso</asp:ListItem>
                            <asp:ListItem Value="CNY">Chinese Yuan</asp:ListItem>
                            <asp:ListItem Value="COP">Colombian Peso</asp:ListItem>
                            <asp:ListItem Value="KMF">Comoros Franc</asp:ListItem>
                            <asp:ListItem Value="CRC">Costa Rica Colon</asp:ListItem>
                            <asp:ListItem Value="HRK">Croatian Kuna</asp:ListItem>
                            <asp:ListItem Value="CUP">Cuban Peso</asp:ListItem>
                            <asp:ListItem Value="CZK">Czech Koruna</asp:ListItem>
                            <asp:ListItem Value="DKK">Danish Krone</asp:ListItem>
                            <asp:ListItem Value="DJF">Dijibouti Franc</asp:ListItem>
                            <asp:ListItem Value="DOP">Dominican Peso</asp:ListItem>
                            <asp:ListItem Value="XCD">East Caribbean Dollar</asp:ListItem>
                            <asp:ListItem Value="ECS">Ecuador Sucre</asp:ListItem>
                            <asp:ListItem Value="EGP">Egyptian Pound</asp:ListItem>
                            <asp:ListItem Value="SVC">El Salvador Colon</asp:ListItem>
                            <asp:ListItem Value="ERN">Eritrea Nakfa</asp:ListItem>
                            <asp:ListItem Value="EEK">Estonian Kroon</asp:ListItem>
                            <asp:ListItem Value="ETB">Ethiopian Birr</asp:ListItem>
                            <asp:ListItem Value="EUR">Euro</asp:ListItem>
                            <asp:ListItem Value="FKP">Falkland Islands Pound</asp:ListItem>
                            <asp:ListItem Value="FJD">Fiji Dollar</asp:ListItem>
                            <asp:ListItem Value="GMD">Gambian Dalasi</asp:ListItem>
                            <asp:ListItem Value="GHC">Ghanian Cedi</asp:ListItem>
                            <asp:ListItem Value="GIP">Gibraltar Pound</asp:ListItem>
                            <asp:ListItem Value="GTQ">Guatemala Quetzal</asp:ListItem>
                            <asp:ListItem Value="GNF">Guinea Franc</asp:ListItem>
                            <asp:ListItem Value="GYD">Guyana Dollar</asp:ListItem>
                            <asp:ListItem Value="HTG">Haiti Gourde</asp:ListItem>
                            <asp:ListItem Value="HNL">Honduras Lempira</asp:ListItem>
                            <asp:ListItem Value="HKD">Hong Kong Dollar</asp:ListItem>
                            <asp:ListItem Value="HUF">Hungarian Forint</asp:ListItem>
                            <asp:ListItem Value="ISK">Iceland Krona</asp:ListItem>
                            <asp:ListItem Value="INR">Indian Rupee</asp:ListItem>
                            <asp:ListItem Value="IDR">Indonesian Rupiah</asp:ListItem>
                            <asp:ListItem Value="IRR">Iran Rial</asp:ListItem>
                            <asp:ListItem Value="IQD">Iraqi Dinar</asp:ListItem>
                            <asp:ListItem Value="ILS">Israeli Shekel</asp:ListItem>
                            <asp:ListItem Value="JMD">Jamaican Dollar</asp:ListItem>
                            <asp:ListItem Value="JPY">Japanese Yen</asp:ListItem>
                            <asp:ListItem Value="JOD">Jordanian Dinar</asp:ListItem>
                            <asp:ListItem Value="KZT">Kazakhstan Tenge</asp:ListItem>
                            <asp:ListItem Value="KES">Kenyan Shilling</asp:ListItem>
                            <asp:ListItem Value="KWD">Kuwaiti Dinar</asp:ListItem>
                            <asp:ListItem Value="LAK">Lao Kip</asp:ListItem>
                            <asp:ListItem Value="LVL">Latvian Lat</asp:ListItem>
                            <asp:ListItem Value="LBP">Lebanese Pound</asp:ListItem>
                            <asp:ListItem Value="LSL">Lesotho Loti</asp:ListItem>
                            <asp:ListItem Value="LRD">Liberian Dollar</asp:ListItem>
                            <asp:ListItem Value="LYD">Libyan Dinar</asp:ListItem>
                            <asp:ListItem Value="LTL">Lithuanian Lita</asp:ListItem>
                            <asp:ListItem Value="MOP">Macau Pataca</asp:ListItem>
                            <asp:ListItem Value="MKD">Macedonian Denar</asp:ListItem>
                            <asp:ListItem Value="MWK">Malawi Kwacha</asp:ListItem>
                            <asp:ListItem Value="MYR">Malaysian Ringgit</asp:ListItem>
                            <asp:ListItem Value="MVR">Maldives Rufiyaa</asp:ListItem>
                            <asp:ListItem Value="MTL">Maltese Lira</asp:ListItem>
                            <asp:ListItem Value="MRO">Mauritania Ougulya</asp:ListItem>
                            <asp:ListItem Value="MUR">Mauritius Rupee</asp:ListItem>
                            <asp:ListItem Value="MXN">Mexican Peso</asp:ListItem>
                            <asp:ListItem Value="MDL">Moldovan Leu</asp:ListItem>
                            <asp:ListItem Value="MNT">Mongolian Tugrik</asp:ListItem>
                            <asp:ListItem Value="MAD">Moroccan Dirham</asp:ListItem>
                            <asp:ListItem Value="MMK">Myanmar Kyat</asp:ListItem>
                            <asp:ListItem Value="NAD">Namibian Dollar</asp:ListItem>
                            <asp:ListItem Value="NPR">Nepalese Rupee</asp:ListItem>
                            <asp:ListItem Value="ANG">Neth Antilles Guilder</asp:ListItem>
                            <asp:ListItem Value="NZD">New Zealand Dollar</asp:ListItem>
                            <asp:ListItem Value="NIO">Nicaragua Cordoba</asp:ListItem>
                            <asp:ListItem Value="NGN">Nigerian Naira</asp:ListItem>
                            <asp:ListItem Value="KPW">North Korean Won</asp:ListItem>
                            <asp:ListItem Value="NOK">Norwegian Krone</asp:ListItem>
                            <asp:ListItem Value="OMR">Omani Rial</asp:ListItem>
                            <asp:ListItem Value="PKR">Pakistani Rupee</asp:ListItem>
                            <asp:ListItem Value="PAB">Panama Balboa</asp:ListItem>
                            <asp:ListItem Value="PGK">Papua New Guinea Kina</asp:ListItem>
                            <asp:ListItem Value="PYG">Paraguayan Guarani</asp:ListItem>
                            <asp:ListItem Value="PEN">Peruvian Nuevo Sol</asp:ListItem>
                            <asp:ListItem Value="PHP">Philippine Peso</asp:ListItem>
                            <asp:ListItem Value="PLN">Polish Zloty</asp:ListItem>
                            <asp:ListItem Value="QAR">Qatar Rial</asp:ListItem>
                            <asp:ListItem Value="RON">Romanian New Leu</asp:ListItem>
                            <asp:ListItem Value="RUB">Russian Rouble</asp:ListItem>
                            <asp:ListItem Value="RWF">Rwanda Franc</asp:ListItem>
                            <asp:ListItem Value="WST">Samoa Tala</asp:ListItem>
                            <asp:ListItem Value="STD">Sao Tome Dobra</asp:ListItem>
                            <asp:ListItem Value="SAR">Saudi Arabian Riyal</asp:ListItem>
                            <asp:ListItem Value="SCR">Seychelles Rupee</asp:ListItem>
                            <asp:ListItem Value="SLL">Sierra Leone Leone</asp:ListItem>
                            <asp:ListItem Value="SGD">Singapore Dollar</asp:ListItem>
                            <asp:ListItem Value="SKK">Slovak Koruna</asp:ListItem>
                            <asp:ListItem Value="SIT">Slovenian Tolar</asp:ListItem>
                            <asp:ListItem Value="SBD">Solomon Islands Dollar</asp:ListItem>
                            <asp:ListItem Value="SOS">Somali Shilling</asp:ListItem>
                            <asp:ListItem Value="ZAR">South African Rand</asp:ListItem>
                            <asp:ListItem Value="KRW">South Korean Won</asp:ListItem>
                            <asp:ListItem Value="LKR">Sri Lanka Rupee</asp:ListItem>
                            <asp:ListItem Value="SHP">St Helena Pound</asp:ListItem>
                            <asp:ListItem Value="SDG">Sudanese Pound</asp:ListItem>
                            <asp:ListItem Value="SZL">Swaziland Lilageni</asp:ListItem>
                            <asp:ListItem Value="SEK">Swedish Krona</asp:ListItem>
                            <asp:ListItem Value="CHF">Swiss Franc</asp:ListItem>
                            <asp:ListItem Value="SYP">Syrian Pound</asp:ListItem>
                            <asp:ListItem Value="TWD">Taiwan Dollar</asp:ListItem>
                            <asp:ListItem Value="TZS">Tanzanian Shilling</asp:ListItem>
                            <asp:ListItem Value="THB">Thai Baht</asp:ListItem>
                            <asp:ListItem Value="TOP">Tonga Pa'ang</asp:ListItem>
                            <asp:ListItem Value="TTD">Trinidad Tobago Dollar</asp:ListItem>
                            <asp:ListItem Value="TND">Tunisian Dinar</asp:ListItem>
                            <asp:ListItem Value="TRY">Turkish Lira</asp:ListItem>
                            <asp:ListItem Value="AED">UAE Dirham</asp:ListItem>
                            <asp:ListItem Value="UGX">Ugandan Shilling</asp:ListItem>
                            <asp:ListItem Value="UAH">Ukraine Hryvnia</asp:ListItem>
                            <asp:ListItem Value="USD">United States Dollar</asp:ListItem>
                            <asp:ListItem Value="UYU">Uruguayan New Peso</asp:ListItem>
                            <asp:ListItem Value="VUV">Vanuatu Vatu</asp:ListItem>
                            <asp:ListItem Value="VEF">Venezuelan Bolivar Fuerte</asp:ListItem>
                            <asp:ListItem Value="VND">Vietnam Dong</asp:ListItem>
                            <asp:ListItem Value="YER">Yemen Riyal</asp:ListItem>
                            <asp:ListItem Value="ZMK">Zambian Kwacha</asp:ListItem>
                            <asp:ListItem Value="ZWD">Zimbabwe Dollar</asp:ListItem>

                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dnn:Label ID="Label5" runat="server" CssClass="LabelTitle" Text="Local currency" HelpText="The currency your staff usually use (for expenses). This is usually the same as your Accounting Currency" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbLocalCurrency" runat="server" Text="Click to confirm" CssClass="complete-box progress-box2" />
                        <asp:DropDownList ID="ddlLocalCurrency" runat="server" class="ddlCur">
                            <asp:ListItem Value="ALL">Albanian Lek</asp:ListItem>
                            <asp:ListItem Value="DZD">Algerian Dinar</asp:ListItem>
                            <asp:ListItem Value="ARS">Argentine Peso</asp:ListItem>
                            <asp:ListItem Value="AWG">Aruba Florin</asp:ListItem>
                            <asp:ListItem Value="AUD">Australian Dollar</asp:ListItem>
                            <asp:ListItem Value="BSD">Bahamian Dollar</asp:ListItem>
                            <asp:ListItem Value="BHD">Bahraini Dinar</asp:ListItem>
                            <asp:ListItem Value="BDT">Bangladesh Taka</asp:ListItem>
                            <asp:ListItem Value="BBD">Barbados Dollar</asp:ListItem>
                            <asp:ListItem Value="BYR">Belarus Ruble</asp:ListItem>
                            <asp:ListItem Value="BZD">Belize Dollar</asp:ListItem>
                            <asp:ListItem Value="BMD">Bermuda Dollar</asp:ListItem>
                            <asp:ListItem Value="BTN">Bhutan Ngultrum</asp:ListItem>
                            <asp:ListItem Value="BOB">Bolivian Boliviano</asp:ListItem>
                            <asp:ListItem Value="BWP">Botswana Pula</asp:ListItem>
                            <asp:ListItem Value="BRL">Brazilian Real</asp:ListItem>
                            <asp:ListItem Value="GBP">British Pound</asp:ListItem>
                            <asp:ListItem Value="BND">Brunei Dollar</asp:ListItem>
                            <asp:ListItem Value="BGN">Bulgarian Lev</asp:ListItem>
                            <asp:ListItem Value="BIF">Burundi Franc</asp:ListItem>
                            <asp:ListItem Value="KHR">Cambodia Riel</asp:ListItem>
                            <asp:ListItem Value="CAD">Canadian Dollar</asp:ListItem>
                            <asp:ListItem Value="CVE">Cape Verde Escudo</asp:ListItem>
                            <asp:ListItem Value="KYD">Cayman Islands Dollar</asp:ListItem>
                            <asp:ListItem Value="XOF">CFA Franc (BCEAO)</asp:ListItem>
                            <asp:ListItem Value="XAF">CFA Franc (BEAC)</asp:ListItem>
                            <asp:ListItem Value="CLP">Chilean Peso</asp:ListItem>
                            <asp:ListItem Value="CNY">Chinese Yuan</asp:ListItem>
                            <asp:ListItem Value="COP">Colombian Peso</asp:ListItem>
                            <asp:ListItem Value="KMF">Comoros Franc</asp:ListItem>
                            <asp:ListItem Value="CRC">Costa Rica Colon</asp:ListItem>
                            <asp:ListItem Value="HRK">Croatian Kuna</asp:ListItem>
                            <asp:ListItem Value="CUP">Cuban Peso</asp:ListItem>
                            <asp:ListItem Value="CZK">Czech Koruna</asp:ListItem>
                            <asp:ListItem Value="DKK">Danish Krone</asp:ListItem>
                            <asp:ListItem Value="DJF">Dijibouti Franc</asp:ListItem>
                            <asp:ListItem Value="DOP">Dominican Peso</asp:ListItem>
                            <asp:ListItem Value="XCD">East Caribbean Dollar</asp:ListItem>
                            <asp:ListItem Value="ECS">Ecuador Sucre</asp:ListItem>
                            <asp:ListItem Value="EGP">Egyptian Pound</asp:ListItem>
                            <asp:ListItem Value="SVC">El Salvador Colon</asp:ListItem>
                            <asp:ListItem Value="ERN">Eritrea Nakfa</asp:ListItem>
                            <asp:ListItem Value="EEK">Estonian Kroon</asp:ListItem>
                            <asp:ListItem Value="ETB">Ethiopian Birr</asp:ListItem>
                            <asp:ListItem Value="EUR">Euro</asp:ListItem>
                            <asp:ListItem Value="FKP">Falkland Islands Pound</asp:ListItem>
                            <asp:ListItem Value="FJD">Fiji Dollar</asp:ListItem>
                            <asp:ListItem Value="GMD">Gambian Dalasi</asp:ListItem>
                            <asp:ListItem Value="GHC">Ghanian Cedi</asp:ListItem>
                            <asp:ListItem Value="GIP">Gibraltar Pound</asp:ListItem>
                            <asp:ListItem Value="GTQ">Guatemala Quetzal</asp:ListItem>
                            <asp:ListItem Value="GNF">Guinea Franc</asp:ListItem>
                            <asp:ListItem Value="GYD">Guyana Dollar</asp:ListItem>
                            <asp:ListItem Value="HTG">Haiti Gourde</asp:ListItem>
                            <asp:ListItem Value="HNL">Honduras Lempira</asp:ListItem>
                            <asp:ListItem Value="HKD">Hong Kong Dollar</asp:ListItem>
                            <asp:ListItem Value="HUF">Hungarian Forint</asp:ListItem>
                            <asp:ListItem Value="ISK">Iceland Krona</asp:ListItem>
                            <asp:ListItem Value="INR">Indian Rupee</asp:ListItem>
                            <asp:ListItem Value="IDR">Indonesian Rupiah</asp:ListItem>
                            <asp:ListItem Value="IRR">Iran Rial</asp:ListItem>
                            <asp:ListItem Value="IQD">Iraqi Dinar</asp:ListItem>
                            <asp:ListItem Value="ILS">Israeli Shekel</asp:ListItem>
                            <asp:ListItem Value="JMD">Jamaican Dollar</asp:ListItem>
                            <asp:ListItem Value="JPY">Japanese Yen</asp:ListItem>
                            <asp:ListItem Value="JOD">Jordanian Dinar</asp:ListItem>
                            <asp:ListItem Value="KZT">Kazakhstan Tenge</asp:ListItem>
                            <asp:ListItem Value="KES">Kenyan Shilling</asp:ListItem>
                            <asp:ListItem Value="KWD">Kuwaiti Dinar</asp:ListItem>
                            <asp:ListItem Value="LAK">Lao Kip</asp:ListItem>
                            <asp:ListItem Value="LVL">Latvian Lat</asp:ListItem>
                            <asp:ListItem Value="LBP">Lebanese Pound</asp:ListItem>
                            <asp:ListItem Value="LSL">Lesotho Loti</asp:ListItem>
                            <asp:ListItem Value="LRD">Liberian Dollar</asp:ListItem>
                            <asp:ListItem Value="LYD">Libyan Dinar</asp:ListItem>
                            <asp:ListItem Value="LTL">Lithuanian Lita</asp:ListItem>
                            <asp:ListItem Value="MOP">Macau Pataca</asp:ListItem>
                            <asp:ListItem Value="MKD">Macedonian Denar</asp:ListItem>
                            <asp:ListItem Value="MWK">Malawi Kwacha</asp:ListItem>
                            <asp:ListItem Value="MYR">Malaysian Ringgit</asp:ListItem>
                            <asp:ListItem Value="MVR">Maldives Rufiyaa</asp:ListItem>
                            <asp:ListItem Value="MTL">Maltese Lira</asp:ListItem>
                            <asp:ListItem Value="MRO">Mauritania Ougulya</asp:ListItem>
                            <asp:ListItem Value="MUR">Mauritius Rupee</asp:ListItem>
                            <asp:ListItem Value="MXN">Mexican Peso</asp:ListItem>
                            <asp:ListItem Value="MDL">Moldovan Leu</asp:ListItem>
                            <asp:ListItem Value="MNT">Mongolian Tugrik</asp:ListItem>
                            <asp:ListItem Value="MAD">Moroccan Dirham</asp:ListItem>
                            <asp:ListItem Value="MMK">Myanmar Kyat</asp:ListItem>
                            <asp:ListItem Value="NAD">Namibian Dollar</asp:ListItem>
                            <asp:ListItem Value="NPR">Nepalese Rupee</asp:ListItem>
                            <asp:ListItem Value="ANG">Neth Antilles Guilder</asp:ListItem>
                            <asp:ListItem Value="NZD">New Zealand Dollar</asp:ListItem>
                            <asp:ListItem Value="NIO">Nicaragua Cordoba</asp:ListItem>
                            <asp:ListItem Value="NGN">Nigerian Naira</asp:ListItem>
                            <asp:ListItem Value="KPW">North Korean Won</asp:ListItem>
                            <asp:ListItem Value="NOK">Norwegian Krone</asp:ListItem>
                            <asp:ListItem Value="OMR">Omani Rial</asp:ListItem>
                            <asp:ListItem Value="PKR">Pakistani Rupee</asp:ListItem>
                            <asp:ListItem Value="PAB">Panama Balboa</asp:ListItem>
                            <asp:ListItem Value="PGK">Papua New Guinea Kina</asp:ListItem>
                            <asp:ListItem Value="PYG">Paraguayan Guarani</asp:ListItem>
                            <asp:ListItem Value="PEN">Peruvian Nuevo Sol</asp:ListItem>
                            <asp:ListItem Value="PHP">Philippine Peso</asp:ListItem>
                            <asp:ListItem Value="PLN">Polish Zloty</asp:ListItem>
                            <asp:ListItem Value="QAR">Qatar Rial</asp:ListItem>
                            <asp:ListItem Value="RON">Romanian New Leu</asp:ListItem>
                            <asp:ListItem Value="RUB">Russian Rouble</asp:ListItem>
                            <asp:ListItem Value="RWF">Rwanda Franc</asp:ListItem>
                            <asp:ListItem Value="WST">Samoa Tala</asp:ListItem>
                            <asp:ListItem Value="STD">Sao Tome Dobra</asp:ListItem>
                            <asp:ListItem Value="SAR">Saudi Arabian Riyal</asp:ListItem>
                            <asp:ListItem Value="SCR">Seychelles Rupee</asp:ListItem>
                            <asp:ListItem Value="SLL">Sierra Leone Leone</asp:ListItem>
                            <asp:ListItem Value="SGD">Singapore Dollar</asp:ListItem>
                            <asp:ListItem Value="SKK">Slovak Koruna</asp:ListItem>
                            <asp:ListItem Value="SIT">Slovenian Tolar</asp:ListItem>
                            <asp:ListItem Value="SBD">Solomon Islands Dollar</asp:ListItem>
                            <asp:ListItem Value="SOS">Somali Shilling</asp:ListItem>
                            <asp:ListItem Value="ZAR">South African Rand</asp:ListItem>
                            <asp:ListItem Value="KRW">South Korean Won</asp:ListItem>
                            <asp:ListItem Value="LKR">Sri Lanka Rupee</asp:ListItem>
                            <asp:ListItem Value="SHP">St Helena Pound</asp:ListItem>
                            <asp:ListItem Value="SDG">Sudanese Pound</asp:ListItem>
                            <asp:ListItem Value="SZL">Swaziland Lilageni</asp:ListItem>
                            <asp:ListItem Value="SEK">Swedish Krona</asp:ListItem>
                            <asp:ListItem Value="CHF">Swiss Franc</asp:ListItem>
                            <asp:ListItem Value="SYP">Syrian Pound</asp:ListItem>
                            <asp:ListItem Value="TWD">Taiwan Dollar</asp:ListItem>
                            <asp:ListItem Value="TZS">Tanzanian Shilling</asp:ListItem>
                            <asp:ListItem Value="THB">Thai Baht</asp:ListItem>
                            <asp:ListItem Value="TOP">Tonga Pa'ang</asp:ListItem>
                            <asp:ListItem Value="TTD">Trinidad Tobago Dollar</asp:ListItem>
                            <asp:ListItem Value="TND">Tunisian Dinar</asp:ListItem>
                            <asp:ListItem Value="TRY">Turkish Lira</asp:ListItem>
                            <asp:ListItem Value="AED">UAE Dirham</asp:ListItem>
                            <asp:ListItem Value="UGX">Ugandan Shilling</asp:ListItem>
                            <asp:ListItem Value="UAH">Ukraine Hryvnia</asp:ListItem>
                            <asp:ListItem Value="USD">United States Dollar</asp:ListItem>
                            <asp:ListItem Value="UYU">Uruguayan New Peso</asp:ListItem>
                            <asp:ListItem Value="VUV">Vanuatu Vatu</asp:ListItem>
                            <asp:ListItem Value="VEF">Venezuelan Bolivar Fuerte</asp:ListItem>
                            <asp:ListItem Value="VND">Vietnam Dong</asp:ListItem>
                            <asp:ListItem Value="YER">Yemen Riyal</asp:ListItem>
                            <asp:ListItem Value="ZMK">Zambian Kwacha</asp:ListItem>
                            <asp:ListItem Value="ZWD">Zimbabwe Dollar</asp:ListItem>

                        </asp:DropDownList>

                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div>
        <h3><a href="#" id="Tab2" class="AcHdr">Staff Accounts &amp; Departments<div id="progressbar3" class="progressbar">
            <div id="progresslabel3" class="progress-label">Loading...</div>
        </div>
        </a></h3>
        <div id="AccountsPane" class="AcPane">
            <p class="intro">
                Next you need to setup accounts for all of your staff, ensure that they have valid R/C's and reporting relationships (so we know 
                who will approve their expenses) and configure any Departments (Ministry R/C's). 
            </p>
            <table>
                <tr>
                    <td>
                        <dnn:Label ID="Label7" runat="server" CssClass="LabelTitle" Text="Staff Accounts" HelpText="Access to this site will be restricted to your staff. You need set setup Accounts for each of your staff members. " />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbStaff" runat="server" Text="Mark as done" CssClass="complete-box progress-box3" />
                        <h5>

                            <asp:Label ID="lblStaff" runat="server" Text="It does not appear that your staff accounts have been setup yet"></asp:Label></h5>
                        
                       
                    </td>
                </tr>
                <tr>
                    <td>
                        <dnn:Label ID="Label8" runat="server" CssClass="LabelTitle" Text="Leadership Relationships" HelpText="Leadership relationships define who approves personal reimbursments/advances" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbLeadership" runat="server" Text="Mark as done" CssClass="complete-box progress-box3" />
                        <h5>

                            <asp:Label ID="lblLeadership" runat="server" Text="You do not appear to have setup your leadership relationships yet"></asp:Label></h5>
                        
                       
                    </td>
                </tr>
                <tr>
                    <td>
                        <dnn:Label ID="Label10" runat="server" CssClass="LabelTitle" Text="Departments" HelpText="Departments are ministry R/C's that you would like Staff Member's to be able to reimburse against. Each Department needs and R/C and a Manager" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbDepartments" runat="server" Text="Mark as done" CssClass="complete-box progress-box3" />
                        <h5>

                            <asp:Label ID="lblDepartments" runat="server" Text="It does not appear that your departments have been setup yet"></asp:Label></h5>
                        
                       
                    </td>
                </tr>

            </table>
        </div>
    </div>
    <div>
        <h3><a href="#" id="Tab3" class="AcHdr">Expense Module<div id="progressbar4" class="progressbar">
            <div id="progresslabel4" class="progress-label">Loading...</div>
        </div>
        </a></h3>
        <div id="ExpensesPane" class="AcPane">
            <table>
                <tr>
                    <td>Account Codes</td>
                    <td></td>
                </tr>
                <tr>
                    <td>Auth Users</td>
                    <td></td>
                </tr>
                <tr>
                    <td>Expense Types</td>
                    <td></td>
                </tr>

            </table>
        </div>
    </div>
    <div>
        <h3><a href="#" id="Tab3" class="AcHdr">Translation<div id="progressbar5" class="progressbar">
            <div id="progresslabel5" class="progress-label">Loading...</div>
        </div>
        </a></h3>
        <div id="TranslationPane" class="AcPane">
            <table>
                <tr>
                    <td>Add/Edit Languages</td>
                    <td></td>
                </tr>
                <tr>
                    <td>Translations</td>
                    <td></td>
                </tr>
                <tr>
                    <td>Templates</td>
                    <td></td>
                </tr>

            </table>
        </div>
    </div>
</div>
