<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Currency.ascx.vb" Inherits="DesktopModules_AgapeConnect_StaffRmb_Controls_Currency" %>
<table>
    <tr>
        <td>
        <asp:HyperLink ID="btnCurrency" runat="server" CssClass="hlCur" ResourceKey="btnConvertCurrency">Convert Currency</asp:HyperLink>
        </td>
        <td> <div id="dCurrency" runat="server" class="divCur" style="display: none">
<fieldset>
<legend class="AgapeH5"><asp:Label ID="Label1" runat="server" ResourceKey="lblTitle"></asp:Label></legend>
<asp:TextBox ID="tbCurrency" runat="server" class="numeric currency" Width="90px"></asp:TextBox>
                <asp:DropDownList ID="ddlCurrencies" runat="server" class="ddlCur">
                    <asp:ListItem Value="AED">United Arab Emirates Dirham (AED)</asp:ListItem>
<asp:ListItem Value="ANG">Netherlands Antillean Guilder (ANG)</asp:ListItem>
<asp:ListItem Value="ARS">Argentine Peso (ARS)</asp:ListItem>
<asp:ListItem Value="AUD">Australian Dollar (AUD)</asp:ListItem>
<asp:ListItem Value="BDT">Bangladeshi Taka (BDT)</asp:ListItem>
<asp:ListItem Value="BGN">Bulgarian Lev (BGN)</asp:ListItem>
<asp:ListItem Value="BHD">Bahraini Dinar (BHD)</asp:ListItem>
<asp:ListItem Value="BND">Brunei Dollar (BND)</asp:ListItem>
<asp:ListItem Value="BOB">Bolivian Boliviano (BOB)</asp:ListItem>
<asp:ListItem Value="BRL">Brazilian Real (BRL)</asp:ListItem>
<asp:ListItem Value="BWP">Botswanan Pula (BWP)</asp:ListItem>
<asp:ListItem Value="CAD">Canadian Dollar (CAD)</asp:ListItem>
<asp:ListItem Value="CHF">Swiss Franc (CHF)</asp:ListItem>
<asp:ListItem Value="CLP">Chilean Peso (CLP)</asp:ListItem>
<asp:ListItem Value="CNY">Chinese Yuan (CNY)</asp:ListItem>
<asp:ListItem Value="COP">Colombian Peso (COP)</asp:ListItem>
<asp:ListItem Value="CRC">Costa Rican Colón (CRC)</asp:ListItem>
<asp:ListItem Value="CZK">Czech Republic Koruna (CZK)</asp:ListItem>
<asp:ListItem Value="DKK">Danish Krone (DKK)</asp:ListItem>
<asp:ListItem Value="DOP">Dominican Peso (DOP)</asp:ListItem>
<asp:ListItem Value="DZD">Algerian Dinar (DZD)</asp:ListItem>
<asp:ListItem Value="EEK">Estonian Kroon (EEK)</asp:ListItem>
<asp:ListItem Value="EGP">Egyptian Pound (EGP)</asp:ListItem>
<asp:ListItem Value="EUR">Euro (EUR)</asp:ListItem>
<asp:ListItem Value="FJD">Fijian Dollar (FJD)</asp:ListItem>
<asp:ListItem Value="GBP">British Pound Sterling (GBP)</asp:ListItem>
<asp:ListItem Value="HKD">Hong Kong Dollar (HKD)</asp:ListItem>
<asp:ListItem Value="HNL">Honduran Lempira (HNL)</asp:ListItem>
<asp:ListItem Value="HRK">Croatian Kuna (HRK)</asp:ListItem>
<asp:ListItem Value="HUF">Hungarian Forint (HUF)</asp:ListItem>
<asp:ListItem Value="IDR">Indonesian Rupiah (IDR)</asp:ListItem>
<asp:ListItem Value="ILS">Israeli New Sheqel (ILS)</asp:ListItem>
<asp:ListItem Value="INR">Indian Rupee (INR)</asp:ListItem>
<asp:ListItem Value="JMD">Jamaican Dollar (JMD)</asp:ListItem>
<asp:ListItem Value="JOD">Jordanian Dinar (JOD)</asp:ListItem>
<asp:ListItem Value="JPY">Japanese Yen (JPY)</asp:ListItem>
<asp:ListItem Value="KES">Kenyan Shilling (KES)</asp:ListItem>
<asp:ListItem Value="KRW">South Korean Won (KRW)</asp:ListItem>
<asp:ListItem Value="KWD">Kuwaiti Dinar (KWD)</asp:ListItem>
<asp:ListItem Value="KYD">Cayman Islands Dollar (KYD)</asp:ListItem>
<asp:ListItem Value="KZT">Kazakhstani Tenge (KZT)</asp:ListItem>
<asp:ListItem Value="LBP">Lebanese Pound (LBP)</asp:ListItem>
<asp:ListItem Value="LKR">Sri Lankan Rupee (LKR)</asp:ListItem>
<asp:ListItem Value="LTL">Lithuanian Litas (LTL)</asp:ListItem>
<asp:ListItem Value="LVL">Latvian Lats (LVL)</asp:ListItem>
<asp:ListItem Value="MAD">Moroccan Dirham (MAD)</asp:ListItem>
<asp:ListItem Value="MDL">Moldovan Leu (MDL)</asp:ListItem>
<asp:ListItem Value="MKD">Macedonian Denar (MKD)</asp:ListItem>
<asp:ListItem Value="MUR">Mauritian Rupee (MUR)</asp:ListItem>
<asp:ListItem Value="MVR">Maldivian Rufiyaa (MVR)</asp:ListItem>
<asp:ListItem Value="MXN">Mexican Peso (MXN)</asp:ListItem>
<asp:ListItem Value="MYR">Malaysian Ringgit (MYR)</asp:ListItem>
<asp:ListItem Value="NAD">Namibian Dollar (NAD)</asp:ListItem>
<asp:ListItem Value="NGN">Nigerian Naira (NGN)</asp:ListItem>
<asp:ListItem Value="NIO">Nicaraguan Córdoba (NIO)</asp:ListItem>
<asp:ListItem Value="NOK">Norwegian Krone (NOK)</asp:ListItem>
<asp:ListItem Value="NPR">Nepalese Rupee (NPR)</asp:ListItem>
<asp:ListItem Value="NZD">New Zealand Dollar (NZD)</asp:ListItem>
<asp:ListItem Value="OMR">Omani Rial (OMR)</asp:ListItem>
<asp:ListItem Value="PEN">Peruvian Nuevo Sol (PEN)</asp:ListItem>
<asp:ListItem Value="PGK">Papua New Guinean Kina (PGK)</asp:ListItem>
<asp:ListItem Value="PHP">Philippine Peso (PHP)</asp:ListItem>
<asp:ListItem Value="PKR">Pakistani Rupee (PKR)</asp:ListItem>
<asp:ListItem Value="PLN">Polish Zloty (PLN)</asp:ListItem>
<asp:ListItem Value="PYG">Paraguayan Guarani (PYG)</asp:ListItem>
<asp:ListItem Value="QAR">Qatari Rial (QAR)</asp:ListItem>
<asp:ListItem Value="RON">Romanian Leu (RON)</asp:ListItem>
<asp:ListItem Value="RSD">Serbian Dinar (RSD)</asp:ListItem>
<asp:ListItem Value="RUB">Russian Ruble (RUB)</asp:ListItem>
<asp:ListItem Value="SAR">Saudi Riyal (SAR)</asp:ListItem>
<asp:ListItem Value="SCR">Seychellois Rupee (SCR)</asp:ListItem>
<asp:ListItem Value="SEK">Swedish Krona (SEK)</asp:ListItem>
<asp:ListItem Value="SGD">Singapore Dollar (SGD)</asp:ListItem>
<asp:ListItem Value="SKK">Slovak Koruna (SKK)</asp:ListItem>
<asp:ListItem Value="SLL">Sierra Leonean Leone (SLL)</asp:ListItem>
<asp:ListItem Value="SVC">Salvadoran Colón (SVC)</asp:ListItem>
<asp:ListItem Value="THB">Thai Baht (THB)</asp:ListItem>
<asp:ListItem Value="TND">Tunisian Dinar (TND)</asp:ListItem>
<asp:ListItem Value="TRY">Turkish Lira (TRY)</asp:ListItem>
<asp:ListItem Value="TTD">Trinidad and Tobago Dollar (TTD)</asp:ListItem>
<asp:ListItem Value="TWD">New Taiwan Dollar (TWD)</asp:ListItem>
<asp:ListItem Value="TZS">Tanzanian Shilling (TZS)</asp:ListItem>
<asp:ListItem Value="UAH">Ukrainian Hryvnia (UAH)</asp:ListItem>
<asp:ListItem Value="UGX">Ugandan Shilling (UGX)</asp:ListItem>
<asp:ListItem Value="USD">US Dollar (USD)</asp:ListItem>
<asp:ListItem Value="UYU">Uruguayan Peso (UYU)</asp:ListItem>
<asp:ListItem Value="UZS">Uzbekistan Som (UZS)</asp:ListItem>
<asp:ListItem Value="VEF">Venezuelan Bolívar (VEF)</asp:ListItem>
<asp:ListItem Value="VND">Vietnamese Dong (VND)</asp:ListItem>
<asp:ListItem Value="YER">Yemeni Rial (YER)</asp:ListItem>
<asp:ListItem Value="ZAR">South African Rand (ZAR)</asp:ListItem>
<asp:ListItem Value="ZMK">Zambian Kwacha (ZMK)</asp:ListItem>
                
                </asp:DropDownList>

          
            </fieldset>   </div> 
        
        </td>
    </tr>
</table>

