<%@ Control Language="vb" AutoEventWireup="false" CodeFile="RmbSettings.ascx.vb"
    Inherits="DotNetNuke.Modules.StaffRmb.RmbSettings" %>
<%@ Register Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" TagPrefix="cc1" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<script src="/js/engage.itoggle/engage.itoggle.js"></script>
<script src="/js/engage.itoggle/jquery.easing.1.3.js"></script>

<link href="/js/engage.itoggle/engage.itoggle.css" rel="stylesheet" />
<script src="/js/jquery.watermarkinput.js" type="text/javascript"></script>
<script src="/js/jquery.numeric.js" type="text/javascript"></script>
<script type="text/javascript">

    (function ($, Sys) {
        function setUpMyTabs() {
            var selectedTabIndex = $('#<%= theHiddenTabIndex.ClientID  %>').attr('value');
            $('#tabs').tabs({
                show: function () {
                    var newIdx = $('#tabs').tabs('option', 'selected');
                    $('#<%= theHiddenTabIndex.ClientID  %>').val(newIdx);
                },
                selected: selectedTabIndex
            });

            $('.numeric').numeric();
            $('.pdName').Watermark('Rate Name');
            $('.pdValue').Watermark('Rate Value');
            $('.aButton').button();

            $('input.iPhoneSwitch:checkbox').iToggle({
                easing: 'easeOutExpo',
               keepLabel: true,
                easing: 'easeInExpo',
                speed: 300,
                onClick: function () {
                    //Function here
                },
                onClickOn: function () {
                    //Function here
                    alert('On');
                },
                onClickOff: function () {
                    //Function here
                },
                onSlide: function () {
                    //Function here
                },
                onSlideOn: function () {
                    //Function here
                },
                onSlideOff: function () {
                    //Function here
                }
            });
            


        }

        $(document).ready(function () {
            setUpMyTabs();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpMyTabs();
            });
        });
    } (jQuery, window.Sys));

   
</script>
<div id="tabs" style="width: 90%; text-align: Left;">
    <ul>
        <li><a href='#Tab1-tab'>Settings</a></li>
        <li><a href='#Tab2-tab'>Rates</a></li>
        <li><a href='#Tab3-tab'>Roles</a></li>
        <li><a href='#Tab4-tab'>Expense Types</a></li>
        <li><a href='#Tab5-tab'>Help</a></li>
    </ul>
    <div style="width: 100%; min-height: 350px; background-color: #FFFFFF;">
        <div id='Tab1-tab'>

            <table>
                <tr style="vertical-align: top;">
                    <td>
            <table style="font-size: 9pt;">
                <tr>
                    <td>
                        <b>
                            <dnn:Label ID="lblNoReceipt" runat="server" ControlName="tbNoReceipt" ResourceKey="lblNoReceipt" />
                        </b>
                    </td>
                    <td>
                        <asp:TextBox ID="tbNoReceipt" runat="server" Width="80px"></asp:TextBox>
                    </td>
                </tr>
                <tr style="opacity: 0.4; filter: alpha(opacity=40);">
                    <td>
                        <b>
                            <dnn:Label ID="lblVAT" runat="server" ControlName="cbVAT" ResourceKey="lblVAT" />
                        </b>
                    </td>
                    <td>
                        <asp:CheckBox ID="cbVAT" runat="server" Enabled="false" />
                        *Not yet Implemented (Coming soon!)
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>
                            <dnn:Label ID="lblExpire" runat="server" ControlName="tbExpire" ResourceKey="lblExpire" />
                        </b>
                    </td>
                    <td>
                        <asp:TextBox ID="tbExpire" runat="server" Width="80px"></asp:TextBox>
                        <asp:Label ID="Label21" runat="server" resourcekey="Months"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>
                            <dnn:Label ID="lblTeamLeaderLimit" runat="server" ControlName="tbTeamLeaderLimit"
                                ResourceKey="lblTeamLeaderLimit" />
                        </b>
                    </td>
                    <td>
                        <asp:TextBox ID="tbTeamLeaderLimit" runat="server" Width="80px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label9" runat="server" resourcekey="lblDistanceUnit"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlDistance" runat="server">
                            <asp:ListItem Text="Miles" Value="miles" />
                            <asp:ListItem Text="Kilometers" Value="km" />
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>
                            <dnn:Label ID="lblMenuSize" runat="server" ControlName="tbMenuSize" ResourceKey="lblMenuSize" />
                        </b>
                    </td>
                    <td>
                        <asp:TextBox ID="tbMenuSize" runat="server" Width="80px"></asp:TextBox>
                    </td>
                </tr>
               <tr>
                    <td>
                        <b>
                            <dnn:Label ID="Label30" runat="server" ControlName="cbRemBal" ResourceKey="lblShowRemBal" />
                        </b>
                    </td>
                    <td>
                        <asp:CheckBox ID="cbRemBal" runat="server"   />
                    </td>
                </tr>
                  </tr>
               <tr>
                    <td>
                        <b>
                            <dnn:Label ID="Label31" runat="server" ControlName="cbRemBal" ResourceKey="lblWarnIfNegative" />
                        </b>
                    </td>
                    <td>
                        <asp:CheckBox ID="cbWarnIfNegative" runat="server"   />
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>
                            <dnn:Label ID="Label8" runat="server" ControlName="cbCurConverter" ResourceKey="lblCurConverter" />
                        </b>
                    </td>
                    <td>
                        <asp:CheckBox ID="cbCurConverter" runat="server"   />
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>
                            <dnn:Label ID="Label5" runat="server" ControlName="ddlDownloadFormat" ResourceKey="lblDownloadFormat" />
                        </b>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlDownloadFormat" runat="server">
                            <asp:ListItem Text="Solomon: Desc, Debit, Credit" Value="DDC" />
                            <asp:ListItem Text="Solomon: Debit, Credit, Description" Value="DCD" />
                            <asp:ListItem Text="Solomon: Company, Desc, Debit, Credit" Value="CDDC" />
                            <asp:ListItem Text="Solomon: Company, Debit, Credit, Description" Value="CDCD" />
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>
                            <dnn:Label ID="lblControlAccount" runat="server" ControlName="ddlControlAccount"
                                ResourceKey="lblControlAccount" />
                        </b>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlControlAccount" runat="server" DataSourceID="dsCostCenters"
                            DataTextField="DisplayName" DataValueField="CostCentreCode" AppendDataBoundItems="true">
                            <asp:ListItem Text="" Value="" />
                        </asp:DropDownList>
                        <asp:Label ID="oopsControlAccount" runat="server" Text="" ForeColor="Red"></asp:Label>
                        <asp:LinqDataSource ID="dsCostCenters" runat="server" ContextTypeName="StaffBroker.StaffBrokerDataContext"
                            EntityTypeName="" OrderBy="CostCentreCode" Select="new (CostCentreCode,CostCentreCode + ' ' + '-' + ' ' + CostCentreName as DisplayName)"
                            TableName="AP_StaffBroker_CostCenters" Where="PortalId == @PortalId">
                            <WhereParameters>
                                <asp:ControlParameter ControlID="hfPortalId" DefaultValue="-1" Name="PortalId" PropertyName="Value"
                                    Type="Int32" />
                            </WhereParameters>
                        </asp:LinqDataSource>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>
                            <dnn:Label ID="lblAccountsReceivable" runat="server" ControlName="ddlAccountsReceivable"
                                ResourceKey="lblAcctRec" />
                        </b>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlAccountsReceivable" runat="server" Width="60px" DataSourceID="dsAccountCodes2"
                            DataTextField="DisplayName" DataValueField="AccountCode">
                        </asp:DropDownList>
                        <asp:Label ID="oopsAccountsReceivable" runat="server" Text="" ForeColor="Red"></asp:Label>
                        <asp:LinqDataSource ID="dsAccountCodes2" runat="server" ContextTypeName="StaffRmb.StaffRmbDataContext"
                            EntityTypeName="" Select="new (AccountCode,  AccountCode + ' ' + '-' + ' ' + AccountCodeName  as DisplayName )"
                            TableName="AP_StaffBroker_AccountCodes" OrderBy="AccountCode" Where="PortalId == @PortalId &amp;&amp; AccountCodeType == @AccountCodeType">
                            <WhereParameters>
                                <asp:ControlParameter ControlID="hfPortalId" DefaultValue="-1" Name="PortalId" PropertyName="Value"
                                    Type="Int32" />
                                <asp:Parameter DefaultValue="1" Name="AccountCodeType" Type="Byte" />
                            </WhereParameters>
                        </asp:LinqDataSource>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>
                            <dnn:Label ID="lblTaxAccountsReceivable" runat="server" ControlName="ddlTaxAccountsReceivable"
                                ResourceKey="lblTaxAccRec" />
                        </b>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlTaxAccountsReceivable" runat="server" Width="60px" DataSourceID="dsAccountCodes2"
                            DataTextField="DisplayName" DataValueField="AccountCode">
                        </asp:DropDownList>
                        <asp:Label ID="oopsTaxAccountsReceivable" runat="server" Text="" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>
                            <dnn:Label ID="Label4" runat="server" ControlName="ddlAccountsPayable" ResourceKey="lblAccPay" />
                        </b>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlAccountsPayable" runat="server" Width="60px" DataSourceID="dsAccountCodes3"
                            DataTextField="DisplayName" DataValueField="AccountCode">
                        </asp:DropDownList>
                        <asp:Label ID="oopsAccountsPayable" runat="server" Text="" ForeColor="Red"></asp:Label>
                        <asp:LinqDataSource ID="dsAccountCodes3" runat="server" ContextTypeName="StaffRmb.StaffRmbDataContext"
                            EntityTypeName="" Select="new (AccountCode,  AccountCode + ' ' + '-' + ' ' + AccountCodeName  as DisplayName )"
                            TableName="AP_StaffBroker_AccountCodes" OrderBy="AccountCode" Where="PortalId == @PortalId &amp;&amp; AccountCodeType == @AccountCodeType">
                            <WhereParameters>
                                <asp:ControlParameter ControlID="hfPortalId" DefaultValue="-1" Name="PortalId" PropertyName="Value"
                                    Type="Int32" />
                                <asp:Parameter DefaultValue="2" Name="AccountCodeType" Type="Byte" />
                            </WhereParameters>
                        </asp:LinqDataSource>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>
                            <dnn:Label ID="Label7" runat="server" ControlName="ddlPayrollPayable" ResourceKey="lblPayroll" />
                        </b>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlPayrollPayable" runat="server" Width="60px" DataSourceID="dsAccountCodes3"
                            DataTextField="DisplayName" DataValueField="AccountCode">
                        </asp:DropDownList>
                        <asp:Label ID="lblOopsPayroll" runat="server" Text="" ForeColor="Red"></asp:Label>
                        
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>
                            <dnn:Label ID="Label25" runat="server" ControlName="ddlSalaryAccount" ResourceKey="lblSalary" />
                        </b>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlSalaryAccount" runat="server" Width="60px" DataSourceID="dsAccountCodes"
                            DataTextField="DisplayName" DataValueField="AccountCode">
                        </asp:DropDownList>
                        <asp:Label ID="lblOopsSalary" runat="server" Text="" ForeColor="Red"></asp:Label>
                        
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>
                            <dnn:Label ID="Label26" runat="server" ControlName="ddlBankAccount" ResourceKey="lblBankAccount" />
                        </b>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlBankAccount" runat="server" Width="60px" DataSourceID="dsAccountCodes2"
                            DataTextField="DisplayName" DataValueField="AccountCode">
                        </asp:DropDownList>
                        <asp:Label ID="lblOopsBank" runat="server" Text="" ForeColor="Red"></asp:Label>
                        
                    </td>
                </tr>
            </table>
                        </td>
                    <td>
                        <!-- Datapump Manager -->
                        <fieldset>
                                <legend class="AgapeH5">Datapump Manager</legend>


                            <table>
                                <tr>
                                    <td>
                        <b>
                            <dnn:Label ID="Label28" runat="server" ControlName="cbDatapump" Text="Autopump Enabled:" HelpText="When checked (recommended), the datapump will automatically insert your reimbursements (as unreleased batches). The datapump runs every 5 minutes (or so)" />
                        </b>
                    </td>
                    <td>
                         <asp:CheckBox ID="cbDatapump" runat="server" class="iPhoneSwitch"  />
                    </td>
                                </tr>
                                <tr ID="pnlSingle" runat="server">
                                    <td><dnn:Label ID="Label29" runat="server"  Text="Download Once:"  HelpText="If the datapump is disabled, can have the datapump donwload pending transactins (just once) the next time it runs" /></td>
                                    <td>
                                        <asp:Button ID="btnDownload" runat="server" Text="Button" Font-Size="x-small" CssClass="aButton" />
                                        <asp:Label ID="lblDownloading" runat="server" Visible="false" Font-Size="X-Small" Font-Italic="true" ForeColor="Gray"  Text="Pending expenses will download within 5 minutes."></asp:Label>
                                    </td>
                                </tr>
                            </table>
                           


                        </fieldset>

                    </td>
                </tr>
            </table>
        </div>
        <div id='Tab2-tab'>
            <table style="font-size: 9pt;">
                <tr valign="top">
                    <td>
                        <b>
                            <dnn:Label ID="lblMileage" runat="server" ControlName="tbTeamLeaderLimit" ResourceKey="lblMileage" />
                        </b>
                    </td>
                    <td>
                        <table style="font-size: 9pt">
                            <tr>
                                <td>
                                    <asp:Label ID="Label22" runat="server" resourcekey="lblRate1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbMRate1Name" runat="server" Width="80px" CssClass="pdName"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbMRate1" runat="server" Width="80px" CssClass="numeric pdValue"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label6" runat="server" resourcekey="lblRate2"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbMRate2Name" runat="server" Width="80px" CssClass="pdName"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbMRate2" runat="server" Width="80px" CssClass="numeric pdValue"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label23" runat="server" resourcekey="lblRate3"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbMRate3Name" runat="server" Width="80px" CssClass="pdName"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbMRate3" runat="server" Width="80px" CssClass="numeric pdValue"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label24" runat="server" resourcekey="lblRate4"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbMRate4Name" runat="server" Width="80px" CssClass="pdName"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbMRate4" runat="server" Width="80px" CssClass="numeric pdValue"></asp:TextBox>
                                </td>
                            </tr>
                            
                        </table>
                    </td>
                </tr>
                <tr valign="top">
                    <td>
                        <b>
                            <dnn:Label ID="Label1" runat="server" ControlName="tbSubBreakfast" ResourceKey="lblPerDiem" />
                        </b>
                    </td>
                    <td>
                        <table style="font-size: 9pt">
                            <tr>
                                <td>
                                    <asp:Label ID="Label10" runat="server" resourcekey="lblRate1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbPD1Name" runat="server" Width="80px" CssClass="pdName"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbPD1Value" runat="server" Width="80px" CssClass="numeric pdValue"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label11" runat="server" resourcekey="lblRate2"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbPD2Name" runat="server" Width="80px" CssClass="pdName"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbPD2Value" runat="server" Width="80px" CssClass="numeric pdValue"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label12" runat="server" resourcekey="lblRate3"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbPD3Name" runat="server" Width="80px" CssClass="pdName"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbPD3Value" runat="server" Width="80px" CssClass="numeric pdValue"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label13" runat="server" resourcekey="lblRate4"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbPD4Name" runat="server" Width="80px" CssClass="pdName"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbPD4Value" runat="server" Width="80px" CssClass="numeric pdValue"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label14" runat="server" resourcekey="lblRate5"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbPD5Name" runat="server" Width="80px" CssClass="pdName"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbPD5Value" runat="server" Width="80px" CssClass="numeric pdValue"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label15" runat="server" resourcekey="lblRate6"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbPD6Name" runat="server" Width="80px" CssClass="pdName"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbPD6Value" runat="server" Width="80px" CssClass="numeric pdValue"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr valign="top">
                    <td>
                        <b>
                            <dnn:Label ID="Label27" runat="server" ResourceKey="lblPerDiemMulti" Text="PerDiem (Multi)" />
                        </b>
                    </td>
                    <td>
                        <asp:GridView ID="gvPerDiemMulti" runat="server" AutoGenerateColumns="False" DataKeyNames="PerDiemTypeId" DataSourceID="dsPerdiemMulti" ShowFooter="True"
                            CellPadding="4" ForeColor="#333333" GridLines="None"  CssClass="dnnGrid" ShowHeaderWhenEmpty="True" >
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:TemplateField HeaderText="Name" SortExpression="Name">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                          <asp:TextBox ID="tbNameI" runat="server"></asp:TextBox>
                                   
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Value" SortExpression="Value">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox2" runat="server"  class="numeric" Text='<%# Bind("Value", "{0:0.00}") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("Value", "{0:0.00}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                         <asp:TextBox ID="tbAmountI" runat="server" ></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Currency" SortExpression="Currency">
                                    <EditItemTemplate>
                                        
                                     <asp:DropDownList ID="ddlCurrenciesI" runat="server" class="ddlCur" SelectedValue='<%# Bind("Currency") %>' >
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
                                    
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Currency") %>' ></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                         <asp:DropDownList ID="ddlCurrenciesI" runat="server" class="ddlCur"  >
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
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False">
                                    <EditItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete"></asp:LinkButton>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="myInsert" Text="Insert"  ForeColor="white"></asp:LinkButton>
                                       
                                    </FooterTemplate>



                                </asp:TemplateField>
                                
                            </Columns>
                            <EmptyDataTemplate>
                                <table>
                                   

                                    <tr>
                                        <td>
                                            <asp:TextBox ID="tbNameE" runat="server" Width="80px" MaxLength="50"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="tbValueE" runat="server" class="numeric" Width="60"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlCurrenciesE" runat="server" class="ddlCur"  >
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

                                        </td>
                                        <td>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="myEInsert" Text="Insert" ForeColor="white"></asp:LinkButton>
                                       
                                        </td>
                                    </tr>
                                </table>

                            </EmptyDataTemplate>
                            <FooterStyle CssClass="ui-widget-header dnnGridFooter" />
                   <HeaderStyle CssClass="ui-widget-header dnnGridHeader"    />
                   
                    <EmptyDataRowStyle CssClass="ui-widget-header dnnGridHeader" />
                    <PagerStyle CssClass="dnnGridPager" />
                    <RowStyle CssClass="dnnGridItem" />
                    <SelectedRowStyle CssClass="dnnFormError" />
                    <SortedAscendingCellStyle BackColor="#FDF5AC" />
                    <SortedAscendingHeaderStyle BackColor="#4D0000" />
                    <SortedDescendingCellStyle BackColor="#FCF6C0" />
                    <SortedDescendingHeaderStyle BackColor="#820000" />
                        </asp:GridView>
                        <asp:LinqDataSource ID="dsPerdiemMulti" runat="server" ContextTypeName="StaffRmb.StaffRmbDataContext" EnableDelete="True" EnableInsert="True" EnableUpdate="True" EntityTypeName="" OrderBy="Name" TableName="AP_Staff_Rmb_PerDeimMuliTypes" Where="PortalId == @PortalId">
                            <WhereParameters>
                                <asp:ControlParameter ControlID="hfPortalId" DefaultValue="-1" Name="PortalId" PropertyName="Value" Type="Int32" />
                            </WhereParameters>
                        </asp:LinqDataSource>
                    </td>
                </tr>
               
                <tr valign="top">
                    <td>
                        <b>
                            <dnn:Label ID="Label2" runat="server" ControlName="tbEntBreakfast" ResourceKey="lblEntertaining" />
                        </b>
                    </td>
                    <td>
                        <table style="font-size: 9pt">
                            <tr>
                                <td>
                                    <asp:Label ID="Label16" runat="server" resourcekey="lblBreakfast"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbEntBreakfast" runat="server" Width="80px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label17" runat="server" resourcekey="lblLunch"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbEntLunch" runat="server" Width="80px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label18" runat="server" resourcekey="lblDinner"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbEntDinner" runat="server" Width="80px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label19" runat="server" resourcekey="lblOvernight"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbEntOvernight" runat="server" Width="80px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label20" runat="server" resourcekey="lblDay"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="tbEntDay" runat="server" Width="80px"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <div id='Tab3-tab'>
            <table style="font-size: 9pt;">
                <tr>
                    <td>
                        <b>
                            <dnn:Label ID="lblAccountsRole" runat="server" ControlName="rsgAccountsRoles" ResourceKey="lblAccountsRole" />
                        </b>
                    </td>
                    <td>
                        <cc1:RolesSelectionGrid ID="rsgAccountsRoles" runat="server">
                        </cc1:RolesSelectionGrid>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>
                            <dnn:Label ID="lblAccountsName" runat="server" ControlName="tbAccountsName" ResourceKey="lblAccountsName" />
                        </b>
                    </td>
                    <td>
                        <asp:TextBox ID="tbAccountsName" runat="server" Width="200px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>
                            <dnn:Label ID="lblAccountsEmail" runat="server" ControlName="tbAccountsEmail" ResourceKey="lblAccountsEmail" />
                        </b>
                    </td>
                    <td>
                        <asp:TextBox ID="tbAccountsEmail" runat="server" Width="200px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>
                            <dnn:Label ID="lblAuthUser" runat="server" ControlName="ddlAuthUser" ResourceKey="lblAuthUser" />
                        </b>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlAuthUser" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>
                            <dnn:Label ID="lblAuthAuthUser" runat="server" ControlName="ddlAuthAuthAuthUser"
                                ResourceKey="lblAuthAuthUser" />
                        </b>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlAuthAuthUser" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
        </div>
        <div id='Tab4-tab'>
            <table style="font-size: 9pt;">
    <%--            <tr>
                    <td>
                        <b>
                            <dnn:Label ID="lblUseDCode" runat="server" ControlName="cbUserDCode" ResourceKey="lblUseDCode" />
                        </b>
                    </td>
                    <td>
                        <asp:CheckBox ID="cbUseDCode" runat="server" AutoPostBack="true"  Enabled ="false" />
                    </td>
                </tr>--%>
                <tr valign="top">
                    <td>
                        <b>
                            <dnn:Label ID="Label3" runat="server" ControlName="cblExpenseTypes" ResourceKey="lblExpenseTypes" />
                        </b>
                    </td>
                    <td>
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="LineTypeId"
                            DataSourceID="dsLineTypes">
                            <Columns>
                                <asp:BoundField DataField="TypeName" HeaderText="TypeName" SortExpression="TypeName" />
                                <asp:TemplateField HeaderText="Enable">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hfLineTypeId" runat="server" Value='<%# Eval("LineTypeId") %>' />
                                        <asp:CheckBox ID="cbEnable" runat="server" Checked='<%# IsEnabled(Eval("LineTypeId")) %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Display Name">
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" ID="tbDisplayName" Text='<%# GetDisplayName(Eval("LineTypeId"), Eval("TypeName")) %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PCode">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlPCode" runat="server" Width="60px" DataSourceID="dsAccountCodes"
                                            DataTextField="DisplayName" SelectedValue='<%#  GetPCode(Eval("LineTypeId")) %>'
                                            DataValueField="AccountCode" AppendDataBoundItems="true">
                                            <asp:ListItem Text="" Value="" />
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="DCode">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlDCode" runat="server" Width="60px" DataSourceID="dsAccountCodes"
                                            DataTextField="DisplayName" SelectedValue='<%# GetDCode(Eval("LineTypeId")) %>'
                                            DataValueField="AccountCode" AppendDataBoundItems="true">
                                            <asp:ListItem Text="" Value="" />
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:LinqDataSource ID="dsLineTypes" runat="server" ContextTypeName="StaffRmb.StaffRmbDataContext"
                            EntityTypeName="" TableName="AP_Staff_RmbLineTypes" OrderBy="TypeName">
                        </asp:LinqDataSource>
                        <asp:LinqDataSource ID="dsAccountCodes" runat="server" ContextTypeName="StaffRmb.StaffRmbDataContext"
                            EntityTypeName="" Select="new (AccountCode,  AccountCode + ' ' + '-' + ' ' + AccountCodeName  as DisplayName )"
                            TableName="AP_StaffBroker_AccountCodes" OrderBy="AccountCode" Where="PortalId == @PortalId &amp;&amp; AccountCodeType == @AccountCodeType">
                            <WhereParameters>
                                <asp:ControlParameter ControlID="hfPortalId" DefaultValue="-1" Name="PortalId" PropertyName="Value"
                                    Type="Int32" />
                                <asp:Parameter DefaultValue="4" Name="AccountCodeType" Type="Byte" />
                            </WhereParameters>
                        </asp:LinqDataSource>
                    </td>
                </tr>
            </table>
        </div>
          <div id='Tab5-tab'>
           <iframe width="853" height="480" src="https://www.youtube.com/embed/7h1HFWFuCLk?rel=0&wmode=transparent" frameborder="0" allowfullscreen></iframe>
        </div>
    </div>
</div>
<asp:HiddenField ID="hfPortalId" runat="server" Value="-1" />
<asp:HiddenField ID="theHiddenTabIndex" runat="server" Value="0" ViewStateMode="Enabled" />
<asp:LinkButton ID="SaveBtn" runat="server" ResourceKey="btnSave"></asp:LinkButton>
&nbsp;
<asp:LinkButton ID="CancelBtn" runat="server" ResourceKey="btnCancel"></asp:LinkButton>