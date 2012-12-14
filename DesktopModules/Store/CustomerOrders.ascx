<%@ Control language="c#" CodeBehind="CustomerOrders.ascx.cs" Inherits="DotNetNuke.Modules.Store.WebControls.CustomerOrders" AutoEventWireup="True" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<asp:Panel id="pnlOrdersError" runat="server">
    <asp:label id="lblError" runat="server" CssClass="NormalRed StoreAccountOrdersError"></asp:label>
</asp:Panel>
<asp:Panel ID="pnlOrders" runat="server" CssClass="StoreAccountOrdersWrapper">
    <asp:placeholder id="plhGrid" runat="server">
        <asp:datagrid id="grdOrders" runat="server" showheader="true" showfooter="false" autogeneratecolumns="false" CssClass="StoreAccountOrders">
            <HeaderStyle CssClass="StoreAccountOrdersHeader" />
            <ItemStyle CssClass="StoreAccountOrdersItem" />
            <AlternatingItemStyle CssClass="StoreAccountOrdersAlternatingItem" />
            <columns>
                <asp:TemplateColumn HeaderStyle-CssClass="StoreAccountOrdersNumberHeader" ItemStyle-CssClass="StoreAccountOrdersNumber">
                    <HeaderTemplate>
                        <asp:Label id="lblOrderNumberHeader" Runat="server" resourcekey="lblOrderNumberHeader">Order Number</asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:label id="lblName" runat="server"><%# DataBinder.Eval(Container.DataItem, "OrderID").ToString() %></asp:label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderStyle-CssClass="StoreAccountOrdersDateHeader" ItemStyle-CssClass="StoreAccountOrdersDate">
                    <HeaderTemplate>
                        <asp:Label id="lblOrderDateHeader" Runat="server" resourcekey="lblOrderDateHeader">Order Date</asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:label id="lblOrderDateText" runat="server"></asp:label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderStyle-CssClass="StoreAccountOrdersTotalHeader" ItemStyle-CssClass="StoreAccountOrdersTotal">
                    <HeaderTemplate>
                        <asp:Label id="lblOrderTotalHeader" Runat="server" resourcekey="lblOrderTotalHeader">Order Total</asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:label id="lblOrderTotalText" runat="server">Order Total</asp:label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderStyle-CssClass="StoreAccountOrdersStatusHeader" ItemStyle-CssClass="StoreAccountOrdersStatus">
                    <HeaderTemplate>
                        <asp:Label id="lblOrderStatusHeader" runat="server" resourcekey="lblOrderStatusHeader">Status</asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:label id="lblOrderStatusText" runat="server">Order Status</asp:label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderStyle-CssClass="StoreAccountOrdersStatusDateHeader" ItemStyle-CssClass="StoreAccountOrdersStatusDate">
                    <HeaderTemplate>
                        <asp:Label id="lblShipDateHeader" Runat="server" resourcekey="lblShipDateHeader">Ship Date</asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:label id="lblShipDateText" runat="server">Ship Date</asp:label>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderStyle-CssClass="StoreAccountOrdersEditHeader" ItemStyle-CssClass="StoreAccountOrdersEdit">
                    <HeaderTemplate>
                        <span>&nbsp;</span>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:hyperlink id="lnkEdit" runat="server" resourcekey="lnkEdit" CssClass="CommandButton StoreAccountOrdersEditButton">Details</asp:hyperlink>
                    </ItemTemplate>
                </asp:TemplateColumn>
                <asp:TemplateColumn HeaderStyle-CssClass="StoreAccountOrdersCancelHeader" ItemStyle-CssClass="StoreAccountOrdersCancel">
                    <HeaderTemplate>
                        <span>&nbsp;</span>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:LinkButton id="lnkCancel" runat="server" resourcekey="lnkCancel" CssClass="CommandButton StoreAccountOrdersCancelButton">Cancel</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateColumn>
            </columns>
        </asp:datagrid>
    </asp:placeholder>
    <asp:placeholder id="plhForm" runat="server" visible="false">
        <asp:label id="lblEditTitle" runat="server" resourcekey="lblEditTitle" class="StoreAccountOrderTitle">Order Details</asp:label>
        <asp:panel id="pnlOrderDetails" runat="server" visible="false">
            <table class="StoreAccountOrderHeader">
                <tr>
                    <td class="StoreAccountOrderHeaderHeader">
                        <asp:Label id="lblOrderNumberTag" Runat="server" resourcekey="lblOrderNumberTag">Order Number</asp:Label>
                    </td>
                    <td class="StoreAccountOrderHeaderHeader">
                        <asp:Label id="lblOrderDateTag" Runat="server" resourcekey="lblOrderDateTag">Order Date</asp:Label>
                    </td>
                    <td class="StoreAccountOrderHeaderHeader">
                        <asp:Label id="lblOrderStatusTag" Runat="server" resourcekey="lblOrderStatusTag">Order Status</asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="StoreAccountOrderHeaderOrderNumber">
                        <asp:label id="lblOrderNumber" runat="server" enableviewstate="false"></asp:label>
                    </td>
                    <td class="StoreAccountOrderHeaderOrderDate">
                        <asp:label id="lblOrderDate" runat="server" enableviewstate="false"></asp:label>
                    </td>
                    <td class="StoreAccountOrderHeaderOrderStatus">
                        <asp:label id="lblOrderStatus" runat="server" enableviewstate="false"></asp:label>
                    </td>
                </tr>
                <tr>
                    <td class="StoreAccountOrderHeaderHeader">
                        <asp:Label id="lblBillingAddressTag" Runat="server" resourcekey="lblBillingAddressTag">Billing Address</asp:Label>
                    </td>
                    <td class="StoreAccountOrderHeaderHeader">
                        <asp:Label id="lblShippingAddressTag" Runat="server" resourcekey="lblShippingAddressTag">Shipping Address</asp:Label>
                    </td>
                    <td class="StoreAccountOrderHeaderStatusButtons">
                        <asp:Button ID="btnPayNow" runat="server" resourcekey="btnPayNow" Text="Pay Now!" CssClass="StandardButton" />
                    </td>
                </tr>
                <tr>
                    <td class="StoreAccountOrderHeaderBillTo">
                        <asp:label id="lblBillTo" runat="server" enableviewstate="false"></asp:label>
                    </td>
                    <td class="StoreAccountOrderHeaderShipTo">
                        <asp:label id="lblShipTo" runat="server" enableviewstate="false"></asp:label>
                    </td>
                    <td>
                        <asp:Button id="btnCancel" runat="server" resourcekey="btnCancel" Text="Cancel Order" CssClass="StandardButton" />
                    </td>
                </tr>
            </table>
            <asp:datagrid id="grdOrderDetails" runat="server" showheader="true" showfooter="false" autogeneratecolumns="false" CssClass="StoreAccountOrderBody">
                <HeaderStyle CssClass="StoreAccountOrderBodyHeader" />
                <ItemStyle CssClass="StoreAccountOrderBodyItem" />
                <AlternatingItemStyle CssClass="StoreAccountOrderBodyAlternatingItem" />
                <columns>
                    <asp:templatecolumn HeaderStyle-CssClass="StoreAccountOrderBodyProductHeader" ItemStyle-CssClass="StoreAccountOrderBodyProduct">
                        <headertemplate>
                            <asp:Label id="lblModelName" Runat="server" resourcekey="lblModelName">Model Name</asp:Label>
                        </headertemplate>
                        <itemtemplate>
                            <asp:label id="Label1" runat="server"></asp:label>
                        </itemtemplate>
                    </asp:templatecolumn>
                    <asp:templatecolumn HeaderStyle-CssClass="StoreAccountOrderBodyQtyHeader" ItemStyle-CssClass="StoreAccountOrderBodyQty">
                        <headertemplate>
                            <asp:Label id="lblQty" Runat="server" resourcekey="lblQty">Qty</asp:Label>
                        </headertemplate>
                        <itemtemplate>
                            <asp:label id="Label3" runat="server"><%# DataBinder.Eval(Container.DataItem, "Quantity") %></asp:label>
                        </itemtemplate>
                    </asp:templatecolumn>
                    <asp:templatecolumn HeaderStyle-CssClass="StoreAccountOrderBodyPriceHeader" ItemStyle-CssClass="StoreAccountOrderBodyPrice">
                        <headertemplate>
                            <asp:Label id="lblODPrice" Runat="server" resourcekey="lblODPrice">Price</asp:Label>
                        </headertemplate>
                        <itemtemplate>
                            <asp:label id="lblODPriceText" runat="server"></asp:label>
                        </itemtemplate>
                    </asp:templatecolumn>
                    <asp:templatecolumn HeaderStyle-CssClass="StoreAccountOrderBodySubtotalHeader" ItemStyle-CssClass="StoreAccountOrderBodySubtotal">
                        <headertemplate>
                            <asp:Label id="lblODSubtotal" Runat="server" resourcekey="lblODSubtotal">Subtotal</asp:Label>
                        </headertemplate>
                        <itemtemplate>
                            <asp:label id="lblODSubtotalText" runat="server"></asp:label>
                        </itemtemplate>
                    </asp:templatecolumn>
                </columns>
            </asp:datagrid>
            <table class="StoreAccountOrderFooter">
                <tr id="trTotal" runat="server">
                    <td class="StoreAccountOrderFooterHeader">
                        <asp:Label id="lblTotalTag" Runat="server" resourcekey="lblTotalTag">Sub-total:</asp:Label>
                    </td>
                    <td class="StoreAccountOrderFooterTotal">
                        <asp:Label id="lblTotal" runat="server" EnableViewState="false"></asp:Label>
                    </td>
                </tr>
                <tr id="trShipping" runat="server">
                    <td class="StoreAccountOrderFooterHeader">
                        <asp:Label id="lblPostageTag" Runat="server" resourcekey="lblPostageTag">Shipping &amp; Handling:</asp:Label>
                    </td>
                    <td class="StoreAccountOrderFooterShipping">
                        <asp:Label id="lblPostage" runat="server" EnableViewState="false"></asp:Label>
                    </td>
                </tr>
                <tr id="trTax" runat="server">
                    <td class="StoreAccountOrderFooterHeader">
                        <asp:Label id="lblTaxTag" Runat="server" resourcekey="lblTaxTag">Tax:</asp:Label>
                    </td>
                    <td class="StoreAccountOrderFooterTax">
                        <asp:Label id="lblTax" runat="server" EnableViewState="false"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="StoreAccountOrderFooterHeader">
                        <asp:Label id="lblTotalIncPostageTag" Runat="server" resourcekey="lblTotalIncPostageTag">Total:</asp:Label>
                    </td>
                    <td class="StoreAccountOrderFooterGrandTotal">
                        <asp:Label id="lblTotalIncPostage" runat="server" EnableViewState="false"></asp:Label>
                    </td>
                </tr>
                <tr id="OrderStatusManagement" runat="server" visible="false">
                    <td colspan="2" align="left">
                        <fieldset class="StoreAccountOrderSatutsManagement">
	                        <legend>
	                            <asp:Label id="lblOrderStatusManagement" runat="server" resourcekey="lblOrderStatusManagement">Order Status Management</asp:Label>
	                        </legend>
                            <table width="100%">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCommentToCustomer" runat="server" resourcekey="lblCommentToCustomer">Comment to the customer (optional):</asp:Label><br />
                                        <asp:TextBox ID="txtCommentToCustomer" runat="server" TextMode="MultiLine" Width="100%" Height="60px" ></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblChangeStatus" runat="server" resourcekey="lblChangeStatus">Change Status:</asp:Label>&nbsp;
                                        <asp:DropDownList id="ddlOrderStatus" runat="server"></asp:DropDownList>&nbsp;
                                        <asp:CheckBox ID="chkSendEmailStatus" runat="server" resourcekey="chkSendEmailStatus" Checked="true" />&nbsp;
                                        <asp:LinkButton id="lnkbtnSave" runat="server" resourcekey="lnkbtnSave" CssClass="CommandButton StoreAccountOrderHeaderButtonSave">Save</asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td class="StoreAccountOrderFooterBack" colspan="2">
                        <asp:Button ID="btnBack" runat="server" resourcekey="btnBack" Text="&nbsp;&lt;&lt;&nbsp;" CssClass="StandardButton" />
                    </td>
                </tr>
            </table>
        </asp:panel>
    </asp:placeholder>
</asp:Panel>
