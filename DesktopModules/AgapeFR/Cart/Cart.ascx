<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Cart.ascx.vb" Inherits="DotNetNuke.Modules.AgapeFR.Cart.Cart" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<%@ Register TagPrefix="dnn2" TagName="CartBreadcrumb" Src="~/DesktopModules/AgapeFR/Cart/CartBreadcrumb.ascx" %>
<script type="text/javascript">

    (function ($, Sys) {
        function setUpMyObjects() {

            $('.aButton').button();

            // Turn off autocompletion on textboxes
            $('.tbModifiable').attr('autocomplete', 'off');

            $('.tbModifiable').change(function () {
                updateTbModifiableLinksAndValue($(this), "change");
            });

            $('.tbModifiable').blur(function () {
                updateTbModifiableLinksAndValue($(this), "blur");
            });

            $('.tbModifiable').keyup(function () {
                updateTbModifiableLinksAndValue($(this), "keyup");
            });

        }

        function updateTbModifiableLinksAndValue(theTextbox, eventName) {
            // Display "Update" or "Delete" link under "Quantity" and "Amount" textboxes when value changed.
            // Display no link if value changed back to original value.
            // Set textbox value back to original value if changed to empty.

            // Get CartContentID and old value : css class of textbox contains "tbModifiable_[CartContentID]_[OldValue]" as first class
            var firstClass = theTextbox.attr("class").split(" ")[0];
            var cartContentID = firstClass.split("_")[1];
            var oldValue = firstClass.split("_")[2];

            // Get new changed value
            var newValue = theTextbox.val();

            if ((newValue === undefined) || (newValue == "")) {
                // New value is empty : Hide links and set textbox back to old value if "change" or "blur" events
                $('.btnModifiable_update_' + cartContentID).css('display', 'none');
                $('.btnModifiable_delete_' + cartContentID).css('display', 'none');
                if ((eventName == "change") || (eventName == "blur")) {
                    theTextbox.val(oldValue);
                }
            } else if (parseInt(newValue, 10) == 0) {
                // New value is zero: Display "Delete" link
                $('.btnModifiable_update_' + cartContentID).css('display', 'none');
                $('.btnModifiable_delete_' + cartContentID).css('display', '');
            } else {
                if (parseInt(newValue, 10) == parseInt(oldValue, 10)) {
                    // Textbox value (converted to integer) is back to old value: Hide links
                    $('.btnModifiable_update_' + cartContentID).css('display', 'none');
                    $('.btnModifiable_delete_' + cartContentID).css('display', 'none');
                } else {
                    // New value different from old value and not empty and not zero: Display "Update" link
                    $('.btnModifiable_update_' + cartContentID).css('display', '');
                    $('.btnModifiable_delete_' + cartContentID).css('display', 'none');
                }

                // On "change" event, remove leading zeros if needed
                newValueTrimmed = newValue.replace(/^0+/, '');
                if ((eventName == "change") && (newValue != newValueTrimmed)) {
                    theTextbox.val(newValueTrimmed);
                }
            }
        }


        $(document).ready(function () {
            setUpMyObjects();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpMyObjects();

            });
        });
    } (jQuery, window.Sys));
</script>
<style type="text/css">
    .gridHeader
    {
        font-weight: bold;
        border-bottom: 1px solid #BBBBBB;
        text-align: center;
    }
    .gridHeader th
    {
        padding-bottom: 5px;
    }
    .gridRow
    {
        border-bottom: 1px solid #EEEEEE;
        height: 60px;
    }
    .imgColumn
    {
        width: 60px;
    }
    .itemNameColumn
    {
        /*width: 300px;*/
    }
    .numbersColumn
    {
        width: 100px;
        text-align: center;
    }
    .tbModifiable
    {
        width: 40px;
        margin-bottom: 5px;
        text-align: center;
    }
    .deleteLink
    {
        font-size: 8pt;
        margin-top: 5px;
    }
    .total
    {
        font-weight: bold;
    }
    .amount
    {
        color: #900;
    }
    .inclVAT
    {
        color: #888888;
    }
    .totalsTbl
    {
        margin-top: 0.8em;
    }
    .totalTd
    {
        padding-top: 5px;
        text-align: right;
    }
    .grandTotal
    {
        float: right;
        padding-top: 10px;
    }
    .grandTotalBox
    {
        border: 1px solid #BBBBBB;
        padding: 3px;
        background-color: #5EB6E4;
        display: inline;
    }
    .grandTotalVAT {
        margin-left: 3px;
    }
    .btnTd
    {
        text-align: right;
        padding-top: 1.5em;
    }
    .clear {
        clear: both;
    }

</style>
<dnn2:CartBreadcrumb ID="CartBreadcrumb1" runat="server" ShowBreadcrumb="False" />
<asp:Panel ID="PnlEmptyCart" runat="server" Visible="False">
    <br />
    <asp:Label ID="LblEmptyCart" runat="server" ResourceKey="LblEmptyCart" Text=''></asp:Label>  
    <br />
    <br />
</asp:Panel>
<asp:Panel ID="PnlNotEmptyCart" runat="server" Visible="False">
    <asp:Repeater ID="DrCart" runat="server">
        <ItemTemplate>
            <asp:HiddenField ID="HfItemType" Value='<%# eval("ItemType") %>' runat="server" />
            <asp:Label ID="LblCartSectionTitle" runat="server" Text='<%# LocalizeString(ItemType.GetName(Eval("ItemType")) & "SectionTitle")%>'
                CssClass="AgapeH4"></asp:Label>
            <asp:GridView ID="GvCartSection" runat="server" AutoGenerateColumns="False" DataSource='<%# eval("Group") %>'
                GridLines="None" CellPadding="5" HeaderStyle-HorizontalAlign="Left" RowStyle-HorizontalAlign="Left"
                OnRowCommand="UpdateSection" Width="100%">
                <Columns>
                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="imgColumn">
                        <ItemTemplate>
                            <a href='<%# CartFunctions.GetCartItemLink(eval("ItemRef"), eval("ItemType")) %>'><asp:Image ID="ImgItemPicture" runat="server" Width="50px" EnableViewState="False"
                                ImageUrl='<%# CartFunctions.GetCartItemPictureURL(eval("ItemRef"), eval("ItemType")) %>' /></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="" ItemStyle-CssClass="itemNameColumn">
                        <ItemTemplate>
                            <asp:HiddenField ID="hfCartContentId" Value='<%# eval("CartContentId") %>' runat="server" />
                            <a href='<%# CartFunctions.GetCartItemLink(eval("ItemRef"), eval("ItemType")) %>'><asp:Label ID="LblItemName" runat="server" Text='<%# eval("ItemName") %>' CssClass="AgapeH5"></asp:Label></a>
                            <br />
                            <asp:LinkButton ID="BtnDelete" CssClass="deleteLink" runat="server" CommandName="DeleteContent" resourcekey="Delete"
                                CommandArgument='<%# Container.DataItemIndex %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-CssClass="numbersColumn">
                        <HeaderTemplate>
                            <asp:Label ID="LblUnitPriceHeader" runat="server" ResourceKey="LblUnitPriceHeader"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LblUnitPrice" runat="server" Text='<%# StaffBrokerFunctions.GetFormattedCurrency(PortalId, (CDbl(eval("Cost"))+CDbl(eval("Tax"))).ToString(StrCurrencyAmountsPattern)) %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-CssClass="numbersColumn">
                        <HeaderTemplate>
                            <dnn:Label ID="LblDiscountHeader" runat="server" ResourceKey="LblDiscountHeader"
                                Text=''></dnn:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LblDiscountAmt" runat="server" Text='<%# StaffBrokerFunctions.GetFormattedCurrency(PortalId, (CDbl(eval("DiscountAmt"))).ToString(StrCurrencyAmountsPattern)) %>'
                                Visible='<%# eval("DiscountAmt")<>0 %>'></asp:Label>
                            <asp:Label ID="LblDiscountPercent" runat="server" Text='<%# Bind("DiscountPercent", "{0:p0}") %>'
                                Visible='<%# eval("DiscountPercent")<>0 %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-CssClass="numbersColumn">
                        <HeaderTemplate>
                            <asp:Label ID="LblQuantityHeader" runat="server" ResourceKey="LblQuantityHeader"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox ID="TbQuantity" runat="server" Text='<%# Bind("Quantity") %>' CssClass='<%# "tbModifiable_" & eval("CartContentID") & "_" & eval("Quantity") & " tbModifiable" %>'
                                ViewStateMode="Disabled"></asp:TextBox>
                            <ajax:FilteredTextBoxExtender ID="FiltTbExtQuantity" runat="server" TargetControlID="TbQuantity"
                                FilterType="Numbers">
                            </ajax:FilteredTextBoxExtender>
                            <br />
                            <asp:LinkButton ID="BtnUpdateQuantity" runat="server" CssClass='<%# "btnModifiable_update_" & eval("CartContentID")%>'
                                 resourcekey="Update" Style="display: none" CommandName="UpdateQuantity" CommandArgument='<%# Container.DataItemIndex %>'></asp:LinkButton>
                            <asp:LinkButton ID="BtnUpdateQuantityToZero" runat="server" CssClass='<%# "btnModifiable_delete_" & eval("CartContentID")%>'
                                 resourcekey="Delete" Style="display: none" CommandName="UpdateQuantity" CommandArgument='<%# Container.DataItemIndex %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-CssClass="numbersColumn">
                        <HeaderTemplate>
                            <asp:Label ID="LblAmountHeader1" runat="server" ResourceKey="LblAmountHeader"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LblAmount" runat="server" Text='<%# StaffBrokerFunctions.GetFormattedCurrency(PortalId, ((CDbl(eval("Cost"))+CDbl(eval("Tax")))*CDbl(eval("Quantity"))).ToString(StrCurrencyAmountsPattern)) %>'
                                CssClass="amount"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-CssClass="numbersColumn">
                        <HeaderTemplate>
                            <asp:Label ID="LblAmountHeader2" runat="server" ResourceKey="LblAmountHeader"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LblCurrencyLeft" runat="server" Text='<%# StaffBrokerFunctions.GetSetting("Currency", PortalId) %>'
                                Visible='<%# StaffBrokerFunctions.GetSetting("CurrencyLocation", PortalId) <> "Right" %>'
                                CssClass="amount"></asp:Label>
                            <asp:TextBox ID="TbDonationAmount" runat="server" Text='<%# Bind("Cost", "{0:n0}") %>' ViewStateMode="Disabled"
                                CssClass='<%# "tbModifiable_" & eval("CartContentID") & "_" & eval("Cost", "{0:n0}") & " tbModifiable amount" %>'></asp:TextBox>
                            <asp:Label ID="LblCurrencyRight" runat="server" Text='<%# StaffBrokerFunctions.GetSetting("Currency", PortalId) %>'
                                Visible='<%# StaffBrokerFunctions.GetSetting("CurrencyLocation", PortalId) = "Right" %>'
                                CssClass="amount"></asp:Label>
                            <ajax:FilteredTextBoxExtender ID="FiltTbExtDonationAmount" runat="server" TargetControlID="TbDonationAmount"
                                FilterType="Numbers">
                            </ajax:FilteredTextBoxExtender>
                            <br />
                            <asp:LinkButton ID="BtnUpdateDonationAmount" runat="server" CssClass='<%# "btnModifiable_update_" & eval("CartContentID")%>'
                                resourcekey="Update" Style="display: none" CommandName="UpdateDonationAmount" CommandArgument='<%# Container.DataItemIndex %>'></asp:LinkButton>
                            <asp:LinkButton ID="BtnUpdateDonationAmountToZero" runat="server" CssClass='<%# "btnModifiable_delete_" & eval("CartContentID")%>'
                                resourcekey="Delete" Style="display: none" CommandName="UpdateDonationAmount" CommandArgument='<%# Container.DataItemIndex %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="gridHeader" />
                <RowStyle CssClass="gridRow" />
            </asp:GridView>
            <table cellpadding="5" width="100%" runat="server" ID="TblSectionTotals">
                <tr>
                    <td class="totalTd">
                        <asp:Label ID="LblTotalSectionGrossTitle" runat="server" Text="" CssClass="total"></asp:Label>
                        <asp:Label ID="LblTotalSectionGrossAmount" runat="server" Text="" CssClass="total amount"></asp:Label>
                        <asp:Label ID="LblTotalSectionVAT" runat="server" Text="" CssClass="inclVAT"></asp:Label>
                    </td>
                </tr>
            </table>
        </ItemTemplate>
        <SeparatorTemplate>
        </SeparatorTemplate>
    </asp:Repeater>
    <table cellpadding="5" width="100%" class="totalsTbl">
        <tr ID="TrDeliveryCost" runat="server">
            <td class="totalTd">
                    <asp:Label ID="LblDeliveryGrossTitle" runat="server" ResourceKey="LblDeliveryGrossTitle" Text='' CssClass="total"></asp:Label>
                    <asp:Label ID="LblDeliveryGrossAmount" runat="server" Text="" CssClass="total amount"></asp:Label><asp:Label
                        ID="LblDeliveryVAT" runat="server" Text="" CssClass="inclVAT"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="totalTd">
                <div class="grandTotal">
                    <div class="grandTotalBox">
                        <asp:Label ID="LblGrandTotalTitle" runat="server" ResourceKey="LblGrandTotalTitle" Text='' CssClass="total"></asp:Label>
                        <asp:Label ID="LblGrandTotalAmount" runat="server" Text="" CssClass="total amount"></asp:Label>
                    </div>
                    <asp:Label ID="LblGrandTotalVAT" runat="server" Text="" CssClass="inclVAT grandTotalVAT"></asp:Label>
                </div>
                <div class="clear" />
            </td>
        </tr>
        <tr>
            <td class="btnTd">
                <asp:Button ID="BtnFinalize" runat="server" ResourceKey="BtnFinalize" CssClass="aButton" />
            </td>
        </tr>
    </table>
</asp:Panel>
<br />
<asp:LinkButton ID="btnSettings" runat="server">Settings</asp:LinkButton>
<br />
