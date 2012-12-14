<%@ Control Language="c#"  AutoEventWireup="True" Codebehind="ProductEdit.ascx.cs" Inherits="DotNetNuke.Modules.Store.WebControls.ProductEdit" targetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" TagPrefix="dnnWC" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx"%>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="URL" Src="~/controls/URLControl.ascx" %>
<asp:Panel ID="pnlCategoriesRequired" runat="server">
    <p>
        <asp:label ID="lblCategoriesRequired" runat="server" CssClass="NormalRed" ResourceKey="CategoriesRequired"></asp:label>
    </p>
</asp:Panel>
<table id="tblProductForm" runat="server" style="text-align:left" width="100%" border="0" cellspacing="5">
    <tbody>
        <tr>
            <td class="SubHead">
                <dnn:label id="lblCategory" runat="server" controlname="cmbCategory"></dnn:label>
            </td>
            <td>
                <asp:DropDownList id="cmbCategory" Runat="server" CssClass="NormalTextBox" Width="300" DataTextField="CategoryPathName" DataValueField="CategoryID"></asp:DropDownList>
                <asp:RequiredFieldValidator id="valRequireCategory" runat="server" ControlToValidate="cmbCategory" resourcekey="valRequireCategory" ErrorMessage="* Category is required." InitialValue="-1" SetFocusOnError="True"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="SubHead">
                <dnn:label id="lblManufacturer" runat="server" controlname="txtManufacturer"></dnn:label>
            </td>
            <td>
                <asp:TextBox id="txtManufacturer" Runat="server" Width="300" MaxLength="50" CssClass="NormalTextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="SubHead">
                <dnn:label id="lblModelNumber" runat="server" controlname="txtModelNumber"></dnn:label>
            </td>
            <td>
                <asp:TextBox id="txtModelNumber" Runat="server" Width="300" MaxLength="50" CssClass="NormalTextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="SubHead">
                <dnn:label id="lblModelName" runat="server" controlname="txtModelName"></dnn:label>
            </td>
            <td>
                <asp:TextBox id="txtModelName" Runat="server" Width="300" MaxLength="50" CssClass="NormalTextBox"></asp:TextBox>
                <asp:RequiredFieldValidator ID="valRequireModelName" runat="server" ControlToValidate="txtModelName" ErrorMessage="* Model name is required!" resourcekey="valRequireModelName" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr id="trSEOName" runat="server" valign="top">
            <td class="SubHead">
                <dnn:label id="lblSEOName" runat="server" controlname="txtSEOName"></dnn:label>
            </td>
            <td>
                <asp:TextBox id="txtSEOName" Runat="server" Width="300" MaxLength="50" CssClass="NormalTextBox"></asp:TextBox>
                <asp:RegularExpressionValidator ID="valRegExSEOName" runat="server" ErrorMessage="Invalid character(s)!" ControlToValidate="txtSEOName" SetFocusOnError="True" ValidationExpression="[_a-zA-Z0-9-]*" Display="Dynamic"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr id="trKeywords" runat="server" valign="top">
            <td class="SubHead">
                <dnn:label id="lblKeywords" runat="server" controlname="txtKeywords"></dnn:label>
            </td>
            <td>
                <asp:TextBox id="txtKeywords" Runat="server" Width="300" Height="50" MaxLength="1000" TextMode="MultiLine" CssClass="NormalTextBox"></asp:TextBox>
            </td>
        </tr>
        <tr valign="top">
            <td class="SubHead">
                <dnn:label id="lblSummary" runat="server" controlname="txtSummary"></dnn:label>
            </td>
            <td>
                <asp:TextBox id="txtSummary" Runat="server" Width="300" Height="50" MaxLength="1000" TextMode="MultiLine" CssClass="NormalTextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="SubHead">
                <dnn:label id="lblUnitPrice" runat="server" controlname="txtUnitPrice"></dnn:label>
            </td>
            <td>
                <asp:TextBox id="txtUnitPrice" Runat="server" Width="100" MaxLength="25" CssClass="NormalTextBox"></asp:TextBox>
                <asp:RequiredFieldValidator id="valRequireUnitPrice" runat="server" ControlToValidate="txtUnitPrice" ErrorMessage="* Price is required." resourcekey="valRequireUnitPrice" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                <asp:CompareValidator id="valUnitPrice" runat="server" ErrorMessage="Error! Please enter a valid price." resourcekey="valUnitPrice" Type="Currency" ControlToValidate="txtUnitPrice" Operator="DataTypeCheck" Display="Dynamic" SetFocusOnError="True"></asp:CompareValidator>
            </td>
        </tr>
        <tr id="trVirtualProduct" runat="server">
            <td class="SubHead">
                <dnn:label id="lblVirtualProduct" runat="server" controlname="chkVirtualProduct"></dnn:label>
            </td>
            <td>
                <asp:CheckBox id="chkVirtualProduct" Runat="server" CssClass="NormalTextBox" AutoPostBack="True" OnCheckedChanged="chkVirtualProduct_CheckedChanged"></asp:CheckBox>
            </td>
        </tr>
        <tr id="trVirtualProductSection" runat="server">
            <td colspan="2">
                <dnn:sectionhead id="dshDownloadInfos" runat="server" resourcekey="dshDownloadInfos" cssclass="Head" text="Download Informations" section="tblDownloadInfos" includerule="false" isexpanded="true"></dnn:sectionhead>
                <table border="0" style="text-align:left;" cellspacing="5" id="tblDownloadInfos" runat="server" >
                    <tr valign="top">
                        <td class="SubHead">
                            <dnn:label id="lblProductFile" runat="server" controlname="urlProductFile"></dnn:label>
                        </td>
                        <td>
                            <dnn:URL id="urlProductFile" runat="server" EnableViewState="true" width="300" ShowDatabase="false" ShowFiles="true" ShowLog="false" ShowNewWindow="false" ShowNone="true" ShowSecure="false" ShowTabs="false" ShowTrack="false" ShowUpLoad="true" ShowUrls="false" ShowUsers="false" UrlType="N" />
                        </td>
                    </tr>
                    <tr id="trErrorProductFile" runat="server" visible="false">
                        <td colspan="2">
                            <asp:Label ID="lblErrorProductFile" runat="server" resourcekey="lblErrorProductFile" CssClass="NormalRed"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="SubHead">
                            <dnn:label id="lblAllowedDownloads" runat="server" ControlName="txtAllowedDownloads"></dnn:label>
                        </td>
                        <td>
                            <asp:TextBox id="txtAllowedDownloads" Runat="server" Width="100" MaxLength="25" CssClass="NormalTextBox"></asp:TextBox>
                            <asp:RequiredFieldValidator id="valRequireAllowedDownloads" runat="server" ControlToValidate="txtAllowedDownloads" ErrorMessage="* Allowed Downloads is required." resourcekey="valRequireAllowedDownloads" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:CompareValidator id="valAllowedDownloads" runat="server" ErrorMessage="Error! Please enter a valid number." Type="Integer" ControlToValidate="txtAllowedDownloads" Operator="DataTypeCheck" resourcekey="valAllowedDownloads" Display="Dynamic" SetFocusOnError="True"></asp:CompareValidator>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="trProductDimensions" runat="server">
            <td colspan="2">
                <dnn:sectionhead id="dshProductDimensions" runat="server" resourcekey="dshProductDimensions" cssclass="Head" text="Product Dimensions" section="tblProductDimensions" includerule="false" isexpanded="true"></dnn:sectionhead>
                <table border="0" style="text-align:left;" cellspacing="5" id="tblProductDimensions" runat="server" >
                    <tr>
                        <td class="SubHead">
                            <dnn:label id="lblUnitWeight" runat="server" ControlName="txtUnitWeight"></dnn:label>
                        </td>
                        <td>
                            <asp:TextBox id="txtUnitWeight" Runat="server" Width="100" MaxLength="25" CssClass="NormalTextBox"></asp:TextBox>
                            <asp:RequiredFieldValidator id="valRequireUnitWeight" runat="server" ControlToValidate="txtUnitWeight" ErrorMessage="* Weight is required." resourcekey="valRequireUnitWeight" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:CompareValidator id="valUnitWeight" runat="server" ErrorMessage="Error! Please enter a valid weight." Type="Double" ControlToValidate="txtUnitWeight" Operator="DataTypeCheck" resourcekey="valUnitWeight" Display="Dynamic" SetFocusOnError="True"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="SubHead">
                            <dnn:label id="lblUnitHeight" runat="server" ControlName="txtUnitHeight"></dnn:label>
                        </td>
                        <td>
                            <asp:TextBox id="txtUnitHeight" Runat="server" Width="100" MaxLength="25" CssClass="NormalTextBox"></asp:TextBox>
                            <asp:RequiredFieldValidator id="valRequireUnitHeight" runat="server" ControlToValidate="txtUnitHeight" ErrorMessage="* Height is required." resourcekey="valRequireUnitHeight" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:CompareValidator id="valUnitHeight" runat="server" ErrorMessage="Error! Please enter a valid height." Type="Double" ControlToValidate="txtUnitHeight" Operator="DataTypeCheck" resourcekey="valUnitHeight" Display="Dynamic" SetFocusOnError="True"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="SubHead">
                            <dnn:label id="lblUnitLength" runat="server" ControlName="txtUnitLength"></dnn:label>
                        </td>
                        <td>
                            <asp:TextBox id="txtUnitLength" Runat="server" Width="100" MaxLength="25" CssClass="NormalTextBox"></asp:TextBox>
                            <asp:RequiredFieldValidator id="valRequireUnitLength" runat="server" ControlToValidate="txtUnitLength" ErrorMessage="* Length is required." resourcekey="valRequireUnitLength" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:CompareValidator id="valUnitLength" runat="server" ErrorMessage="Error! Please enter a valid length." Type="Double" ControlToValidate="txtUnitLength" Operator="DataTypeCheck" resourcekey="valUnitLength" Display="Dynamic" SetFocusOnError="True"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="SubHead">
                            <dnn:label id="lblUnitWidth" runat="server" ControlName="txtUnitWidth"></dnn:label>
                        </td>
                        <td>
                            <asp:TextBox id="txtUnitWidth" Runat="server" Width="100" MaxLength="25" CssClass="NormalTextBox"></asp:TextBox>
                            <asp:RequiredFieldValidator id="valRequireUnitWidth" runat="server" ControlToValidate="txtUnitWidth" ErrorMessage="* Width is required." resourcekey="valRequireUnitWidth" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:CompareValidator id="valUnitWidth" runat="server" ErrorMessage="Error! Please enter a valid width." Type="Double" ControlToValidate="txtUnitWidth" Operator="DataTypeCheck" resourcekey="valUnitWidth" Display="Dynamic" SetFocusOnError="True"></asp:CompareValidator>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="trStockManagement" runat="server">
            <td colspan="2">
                <dnn:sectionhead id="dshStockManagement" runat="server" resourcekey="dshStockManagement" cssclass="Head" text="Stock Management" section="tblStockManagement" includerule="false" isexpanded="true"></dnn:sectionhead>
                <table border="0" style="text-align:left;" cellspacing="5" id="tblStockManagement" runat="server" >
                    <tr>
                        <td class="SubHead">
                            <dnn:label id="lblStockQuantity" runat="server" ControlName="txtStockQuantity"></dnn:label>
                        </td>
                        <td>
                            <asp:TextBox id="txtStockQuantity" Runat="server" Width="100px" MaxLength="25" CssClass="NormalTextBox"></asp:TextBox>
                            <asp:RequiredFieldValidator id="valRequireStockQuantity" runat="server" ControlToValidate="txtStockQuantity" ErrorMessage="* Quantity is required." resourcekey="valRequireStockQuantity" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:CompareValidator id="valStockQuantity" runat="server" ErrorMessage="Error! Please enter a valid quantity." Type="Integer" ControlToValidate="txtStockQuantity" Operator="DataTypeCheck" resourcekey="valStockQuantity" Display="Dynamic" SetFocusOnError="True"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="SubHead">
                            <dnn:label id="lblLowThreshold" runat="server" controlname="txtLowThreshold"></dnn:label>
                        </td>
                        <td>
                            <asp:TextBox id="txtLowThreshold" Runat="server" Width="100px" MaxLength="25" CssClass="NormalTextBox"></asp:TextBox>
                            <asp:RequiredFieldValidator id="valRequireLowThreshold" runat="server" ControlToValidate="txtLowThreshold" ErrorMessage="* Low threshold quantity is required." resourcekey="valRequireLowThreshold" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
            		        <asp:CompareValidator id="valLowThreshold" runat="server" ErrorMessage="Error! Please enter a valid quantity." Type="Integer" ControlToValidate="txtLowThreshold" Operator="DataTypeCheck" resourcekey="valLowThreshold" Display="Dynamic" SetFocusOnError="True"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="SubHead">
                            <dnn:label id="lblHighThreshold" runat="server" controlname="txtHighThreshold"></dnn:label>
                        </td>
                        <td>
                            <asp:TextBox id="txtHighThreshold" Runat="server" Width="100px" MaxLength="25" CssClass="NormalTextBox"></asp:TextBox>
                            <asp:RequiredFieldValidator id="valRequireHighThreshold" runat="server" ControlToValidate="txtHighThreshold" ErrorMessage="* High threshold quantity is required." resourcekey="valRequireHighThreshold" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
            		        <asp:CompareValidator id="valHighThreshold" runat="server" ErrorMessage="Error! Please enter a valid quantity." Type="Integer" ControlToValidate="txtHighThreshold" Operator="DataTypeCheck" resourcekey="valHighThreshold" Display="Dynamic" SetFocusOnError="True"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="SubHead">
                            <dnn:label id="lblDeliveryTime" runat="server" controlname="txtDeliveryTime"></dnn:label>
                        </td>
                        <td>
                            <asp:TextBox id="txtDeliveryTime" Runat="server" Width="100px" MaxLength="25" CssClass="NormalTextBox"></asp:TextBox>
                            <asp:RequiredFieldValidator id="valRequireDeliveryTime" runat="server" ControlToValidate="txtDeliveryTime" ErrorMessage="* Delivery Time is required." resourcekey="valRequireDeliveryTime" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
            		        <asp:CompareValidator id="valDeliveryTime" runat="server" ErrorMessage="Error! Please enter a valid number of days." Type="Integer" ControlToValidate="txtDeliveryTime" Operator="DataTypeCheck" resourcekey="valDeliveryTime" Display="Dynamic" SetFocusOnError="True"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="SubHead">
                            <dnn:label id="lblPurchasePrice" runat="server" controlname="txtPurchasePrice"></dnn:label>
                        </td>
                        <td>
                            <asp:TextBox id="txtPurchasePrice" Runat="server" Width="100px" MaxLength="25" CssClass="NormalTextBox"></asp:TextBox>
                            <asp:RequiredFieldValidator id="valRequirePurchasePrice" runat="server" ControlToValidate="txtPurchasePrice" ErrorMessage="* Purchase price is required." resourcekey="valRequirePurchasePrice" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:CompareValidator id="valPurchasePrice" runat="server" ErrorMessage="Error! Please enter a valid price." resourcekey="valPurchasePrice" Type="Currency" ControlToValidate="txtPurchasePrice" Operator="DataTypeCheck" Display="Dynamic" SetFocusOnError="True"></asp:CompareValidator>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="SubHead">
                <dnn:label id="lblArchived" runat="server" controlname="chkArchived"></dnn:label>
            </td>
            <td>
                <asp:CheckBox id="chkArchived" Runat="server" CssClass="NormalTextBox"></asp:CheckBox>
            </td>
        </tr>
        <tr id="trProductRole" runat="server">
            <td class="SubHead">
                <dnn:label id="lblRole" runat="server" controlname="lstRole"></dnn:label>
            </td>
            <td>
                <asp:dropdownlist id="lstRole" runat="server" CssClass="NormalTextBox" autopostback="False"></asp:dropdownlist>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <hr />
            </td>
        </tr>
        <tr>
            <td class="SubHead">
                <dnn:label id="lblFeatured" runat="server" controlname="chkFeatured"></dnn:label>
            </td>
            <td>
                <asp:CheckBox id="chkFeatured" Runat="server" CssClass="NormalTextBox" OnCheckedChanged="chkFeatured_CheckedChanged" AutoPostBack="True"></asp:CheckBox>
            </td>
        </tr>
        <tr id="trFeatured" runat="server">
            <td colspan="2">
                <dnn:sectionhead id="dshSpecialOffer" runat="server" resourcekey="dshSpecialOffer" cssclass="Head" text="Special Offer Pricing" section="tblSpecialOffer" includerule="false"></dnn:sectionhead>
                <table border="0" style="text-align:left;" cellspacing="5" id="tblSpecialOffer" runat="server" >
                    <tr>
                        <td class="SubHead">
                            <dnn:label id="lblSalePrice" runat="server" controlname="txtSalePrice"></dnn:label>
                        </td>
                        <td>
                            <asp:TextBox id="txtSalePrice" Runat="server" Width="100px" MaxLength="25" CssClass="NormalTextBox"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="valRequireSalePrice" runat="server" ControlToValidate="txtSalePrice" ErrorMessage="* Sale price is required." resourcekey="valRequireSalePrice" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:CompareValidator id="valSalePrice" runat="server" ErrorMessage="Error! Please enter a valid price." resourcekey="valSalePrice" Type="Currency" ControlToValidate="txtSalePrice" Operator="DataTypeCheck" Display="Dynamic" SetFocusOnError="true"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td class="SubHead">
                            <dnn:label id="lblSaleStartDate" runat="server" controlname="deSaleStartDate"></dnn:label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSaleStartDate" runat="server" CssClass="NormalTextBox"></asp:TextBox>
                            <asp:HyperLink ID="cmdSaleStartDate" runat="server" CssClass="CommandButton"></asp:HyperLink>
                            <br />
                            <asp:RequiredFieldValidator ID="valRequireSaleStartDate" runat="server" ControlToValidate="txtSaleStartDate" ErrorMessage="* Sale start date is required." resourcekey="valRequireSaleStartDate" Display="Dynamic" SetFocusOnError="true" cssclass="NormalRed"></asp:RequiredFieldValidator>
                            <asp:comparevalidator id="valSaleStartDate" cssclass="NormalRed" runat="server" resourcekey="valSaleStartDate" display="Dynamic" type="Date" operator="DataTypeCheck" errormessage="Error! Please enter a valid date." controltovalidate="txtSaleStartDate"></asp:comparevalidator>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td class="SubHead">
                            <dnn:label id="lblSaleEndDate" runat="server" controlname="deSaleEndDate"></dnn:label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSaleEndDate" runat="server" CssClass="NormalTextBox"></asp:TextBox>
                            <asp:HyperLink ID="cmdSaleEndDate" runat="server" CssClass="CommandButton"></asp:HyperLink>
                            <br />
                            <asp:RequiredFieldValidator ID="valRequireSaleEndDate" runat="server" ControlToValidate="txtSaleEndDate" ErrorMessage="* Sale end date is required." resourcekey="valRequireSaleEndDate" Display="Dynamic" SetFocusOnError="true" cssclass="NormalRed"></asp:RequiredFieldValidator>
                            <asp:comparevalidator id="valSaleEndDate" cssclass="NormalRed" runat="server" resourcekey="valSaleEndDate" display="Dynamic" type="Date" operator="DataTypeCheck" errormessage="Error! Please enter a valid date." controltovalidate="txtSaleEndDate"></asp:comparevalidator>
                            <asp:comparevalidator id="valSaleDates" cssclass="NormalRed" runat="server" resourcekey="valSaleDates" display="Dynamic" type="Date" operator="GreaterThan" errormessage="* Sale end date must be greater than sale start date!" controltovalidate="txtSaleEndDate" controltocompare="txtSaleStartDate"></asp:comparevalidator>                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <hr />
            </td>
        </tr>
        <tr valign="top">
            <td class="SubHead">
                <dnn:label id="lblImage" runat="server" controlname="imgProduct"></dnn:label>
            </td>
            <td class="Normal">
                <dnn:URL id="imgProduct" runat="server" EnableViewState="true" width="300" ShowDatabase="false" ShowFiles="true" ShowLog="false" ShowNewWindow="false" ShowNone="true" ShowSecure="false" ShowTabs="false" ShowTrack="false" ShowUpLoad="true" ShowUrls="true" ShowUsers="false" UrlType="N" />
            </td>
        </tr>
        <tr id="trWarningTrustLevel" runat="server" visible="false">
            <td colspan="2">
                <asp:Label ID="lblWarningTrustLevel" runat="server" Text="Warning Trust Level" CssClass="NormalRed"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="SubHead" colspan="2">
                <hr />
                <dnn:label id="lblDescription" runat="server" controlname="txtDescription"></dnn:label>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <dnn:TextEditor id="txtDescription" runat="server" width="500" height="500"></dnn:TextEditor>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <asp:linkbutton id="cmdUpdate" CssClass="CommandButton" runat="server" BorderStyle="None" resourcekey="cmdUpdate">Update</asp:linkbutton>
                <asp:linkbutton id="cmdCancel" CssClass="CommandButton" runat="server" CausesValidation="False" BorderStyle="None" resourcekey="cmdCancel">Cancel</asp:linkbutton>
                <asp:linkbutton id="cmdDelete" CssClass="CommandButton" runat="server" CausesValidation="False" BorderStyle="None" Visible="False" resourcekey="cmdDelete">Delete</asp:linkbutton>
            </td>
        </tr>
    </tbody>
</table>
