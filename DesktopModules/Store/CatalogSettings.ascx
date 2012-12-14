<%@ Control language="c#" CodeBehind="CatalogSettings.ascx.cs" Inherits="DotNetNuke.Modules.Store.WebControls.CatalogSettings" AutoEventWireup="True" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<dnn:sectionhead id="dshGenSettings" runat="server" cssclass="Head" text="General Settings" section="tblGenSettings" includerule="true" isexpanded="true" resourcekey="dshGenSettings"></dnn:sectionhead>
<table id="tblGenSettings" runat="server" style="text-align:left;" cellspacing="5" cellpadding="0" border="0">
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblCatTemplate" runat="server" ResourceKey="lblCatTemplate" ControlName="lstTemplate" Text="Catalog Template:" />
        </td>
        <td>
            <asp:dropdownlist id="lstTemplate" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblUseDefaultCategory" runat="server" ResourceKey="lblUseDefaultCategory" ControlName="lstTemplate" Text="Use Default Category:" />
        </td>
        <td>
            <asp:checkbox id="chkUseDefaultCategory" runat="server" CssClass="NormalTextBox" AutoPostBack="True" OnCheckedChanged="chkUseDefaultCategory_CheckedChanged"></asp:checkbox>
        </td>
    </tr>
    <tr id="trDefaultCategory" runat="server">
        <td class="SubHead">
            <dnn:Label ID="lblDefaultCategory" runat="server" ResourceKey="lblDefaultCategory" ControlName="lstDefaultCategory" Text="Default Category:" />
        </td>
        <td>
            <asp:dropdownlist id="lstDefaultCategory" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblShowCategoryMsg" runat="server" ResourceKey="lblShowCategoryMsg" ControlName="chkShowMessage" Text="Show Category Message:" />
        </td>
        <td>
            <asp:checkbox id="chkShowMessage" runat="server" CssClass="NormalTextBox"></asp:checkbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblShowCategoryProducts" runat="server" ResourceKey="lblShowCategoryProducts" ControlName="chkShowCategory" Text="Show Category Products:" />
        </td>
        <td>
            <asp:checkbox id="chkShowCategory" runat="server" CssClass="NormalTextBox" AutoPostBack="True" OnCheckedChanged="chkShowCategory_CheckedChanged"></asp:checkbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblShowProductDetail" runat="server" ResourceKey="lblShowProductDetail" ControlName="chkShowDetail" Text="Show Product Detail:" />
        </td>
        <td>
            <asp:checkbox id="chkShowDetail" runat="server" CssClass="NormalTextBox" AutoPostBack="True" OnCheckedChanged="chkShowDetail_CheckedChanged"></asp:checkbox>
        </td>
    </tr>
    <tr id="trShowAlsoBoughtProducts" runat="server">
        <td class="SubHead">
            <dnn:Label ID="lblShowAlsoBoughtProducts" runat="server" ResourceKey="lblShowAlsoBoughtProducts" ControlName="chkShowAlsoBought" Text="Show Also Bought Products:" />
        </td>
        <td>
            <asp:checkbox id="chkShowAlsoBought" runat="server" CssClass="NormalTextBox" AutoPostBack="True" OnCheckedChanged="chkShowAlsoBought_CheckedChanged"></asp:checkbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblShowNewProducts" runat="server" ResourceKey="lblShowNewProducts" ControlName="chkShowNew" Text="Show New Products:" />
        </td>
        <td>
            <asp:checkbox id="chkShowNew" runat="server" CssClass="NormalTextBox" AutoPostBack="True" OnCheckedChanged="chkShowNew_CheckedChanged"></asp:checkbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblShowFeaturedProducts" runat="server" ResourceKey="lblShowFeaturedProducts" ControlName="chkShowFeatured" Text="Show Featured Products:" />
        </td>
        <td>
            <asp:checkbox id="chkShowFeatured" runat="server" CssClass="NormalTextBox" AutoPostBack="True" OnCheckedChanged="chkShowFeatured_CheckedChanged"></asp:checkbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblShowPopularProducts" runat="server" ResourceKey="lblShowPopularProducts" ControlName="chkShowPopular" Text="Show Popular Products:" />
        </td>
        <td>
            <asp:checkbox id="chkShowPopular" runat="server" CssClass="NormalTextBox" AutoPostBack="True" OnCheckedChanged="chkShowPopular_CheckedChanged"></asp:checkbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblAllowPrint" runat="server" ResourceKey="lblAllowPrint" ControlName="chkAllowPrint" Text="Allow Print?:" />
        </td>
        <td>
            <asp:checkbox id="chkAllowPrint" runat="server" CssClass="NormalTextBox"></asp:checkbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblEnableContentIndexing" runat="server" ResourceKey="lblEnableContentIndexing" ControlName="chkEnableContentIndexing" Text="Enable Content Indexing:" />
        </td>
        <td>
            <asp:checkbox id="chkEnableContentIndexing" runat="server" CssClass="NormalTextBox"></asp:checkbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblEnableImageCaching" runat="server" ResourceKey="lblEnableImageCaching" ControlName="chkEnableImageCaching" Text="Enable Image Caching:" />
        </td>
        <td>
            <asp:checkbox id="chkEnableImageCaching" runat="server" CssClass="NormalTextBox"></asp:checkbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblCacheDuration" runat="server" ResourceKey="lblCacheDuration" ControlName="txtCacheDuration" Text="Cache Duration:" />
        </td>
        <td>
            <asp:textbox id="txtCacheDuration" runat="server" width="80" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
</table>
<br />
<dnn:sectionhead id="dshCategoryProductList" runat="server" cssclass="Head" text="Category Settings" section="tblCategoryProductList" includerule="true" isexpanded="false" resourcekey="dshCategoryProductList"></dnn:sectionhead>
<table id="tblCategoryProductList" runat="server" style="text-align:left;" cellspacing="5" cellpadding="0" border="0">
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblCSContainerTemplate" runat="server" ResourceKey="lblCSContainerTemplate" ControlName="lstCPLContainerTemplate" Text="Container Template:" />
        </td>
        <td>
            <asp:dropdownlist id="lstCPLContainerTemplate" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblCSListTemplate" runat="server" ResourceKey="lblCSListTemplate" ControlName="lstCPLTemplate" Text="List Template:" />
        </td>
        <td>
            <asp:dropdownlist id="lstCPLTemplate" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblCSRows" runat="server" ResourceKey="lblCSRows" ControlName="txtCPLRowCount" Text="Rows:" />
        </td>
        <td>
            <asp:textbox id="txtCPLRowCount" runat="server" width="50" MaxLength="3" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblCSColumns" runat="server" ResourceKey="lblCSColumns" ControlName="txtCPLColumnCount" Text="Columns:" />
        </td>
        <td>
            <asp:textbox id="txtCPLColumnCount" runat="server" width="50" MaxLength="3" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblCSColumnWidth" runat="server" ResourceKey="lblCSColumnWidth" ControlName="txtCPLColumnWidth" Text="Column Width:" />
        </td>
        <td>
            <asp:textbox id="txtCPLColumnWidth" runat="server" width="50" MaxLength="4" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblCSRepeatDirection" runat="server" ResourceKey="lblCSRepeatDirection" ControlName="lstCPLRepeatDirection" Text="Repeat Direction:" />
        </td>
        <td>
            <asp:dropdownlist id="lstCPLRepeatDirection" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblCSShowThumbnail" runat="server" ResourceKey="lblCSShowThumbnail" ControlName="chkCPLShowThumbnail" Text="Show Thumbnail:" />
        </td>
        <td>
            <asp:checkbox id="chkCPLShowThumbnail" runat="server" CssClass="NormalTextBox"></asp:checkbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblCSThumbnailWidth" runat="server" ResourceKey="lblCSThumbnailWidth" ControlName="txtCPLThumbnailWidth" Text="Thumbnail Width:" />
        </td>
        <td>
            <asp:textbox id="txtCPLThumbnailWidth" runat="server" width="50" MaxLength="4" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblCPSGIFBgColor" runat="server" ResourceKey="lblCPSGIFBgColor" ControlName="txtCPLGIFBgColor" Text="GIF Background:" />
        </td>
        <td>
            <asp:textbox id="txtCPLGIFBgColor" runat="server" width="80" MaxLength="7" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblCSDetailPage" runat="server" ResourceKey="lblCSDetailPage" ControlName="lstCPLDetailPage" Text="Detail Page:" />
        </td>
        <td>
            <asp:dropdownlist id="lstCPLDetailPage" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblCSSubCategories" runat="server" ResourceKey="lblCSSubCategories" ControlName="chkCPLSubCategories" Text="Sub-Categories:" />
        </td>
        <td>
            <asp:checkbox id="chkCPLSubCategories" runat="server" CssClass="NormalTextBox"></asp:checkbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblCSRepositioning" runat="server" ResourceKey="lblCSRepositioning" ControlName="chkCPLRepositioning" Text="Repositioning:" />
        </td>
        <td>
            <asp:checkbox id="chkCPLRepositioning" runat="server" CssClass="NormalTextBox"></asp:checkbox>
        </td>
    </tr>
</table>
<br />
<dnn:sectionhead id="dshSearchProduct" runat="server" cssclass="Head" text="Search Settings" section="tblSearchProduct" includerule="false" isexpanded="false" resourcekey="dshSearchProduct"></dnn:sectionhead>
<table id="tblSearchProduct" runat="server" style="text-align:left;" cellspacing="5" cellpadding="0" border="0">
    <tr>
        <td class="SubHead" valign="top">
            <dnn:Label ID="lblCSSearchColumns" runat="server" ResourceKey="lblCSSearchColumns" ControlName="chkSearchManufacturer" Text="Search Columns:" />
        </td>
        <td>
            <asp:CheckBox ID="chkSearchManufacturer" runat="server" CssClass="NormalTextBox" ResourceKey="chkSearchManufacturer" AutoPostBack="True" OnCheckedChanged="chkSearchManufacturer_CheckedChanged" /><br />
            <asp:CheckBox ID="chkSearchModelNumber" runat="server" CssClass="NormalTextBox" ResourceKey="chkSearchModelNumber" AutoPostBack="True" OnCheckedChanged="chkSearchModelNumber_CheckedChanged" /><br />
            <asp:CheckBox ID="chkSearchModelName" runat="server" CssClass="NormalTextBox" ResourceKey="chkSearchModelName" AutoPostBack="True" OnCheckedChanged="chkSearchModelName_CheckedChanged" /><br />
            <asp:CheckBox ID="chkSearchSummary" runat="server" CssClass="NormalTextBox" ResourceKey="chkSearchSummary" AutoPostBack="True" OnCheckedChanged="chkSearchSummary_CheckedChanged" /><br />
            <asp:CheckBox ID="chkSearchDescription" runat="server" CssClass="NormalTextBox" ResourceKey="chkSearchDescription" AutoPostBack="True" OnCheckedChanged="chkSearchDescription_CheckedChanged" />
        </td>
    </tr>
    <tr id="trSearchColumn" runat="server">
        <td class="SubHead">
            <dnn:Label ID="lblSSSearchColumn" runat="server" ResourceKey="lblSSSearchColumn" ControlName="lstSPLSearchColumn" Text="Search Column:" />
        </td>
        <td>
            <asp:dropdownlist id="lstSPLSearchColumn" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
    <tr id="trSearchTemplate" runat="server">
        <td class="SubHead">
            <dnn:Label ID="lblSSListTemplate" runat="server" ResourceKey="lblSSListTemplate" ControlName="lstSPLTemplate" Text="Search Template:" />
        </td>
        <td>
            <asp:dropdownlist id="lstSPLTemplate" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
</table>
<br />
<dnn:sectionhead id="dshSortProduct" runat="server" cssclass="Head" text="Sort Settings" section="tblSortProduct" includerule="false" isexpanded="false" resourcekey="dshSortProduct"></dnn:sectionhead>
<table id="tblSortProduct" runat="server" style="text-align:left;" cellspacing="5" cellpadding="0" border="0">
    <tr>
        <td class="SubHead" valign="top">
            <dnn:Label ID="lblCSSortColumns" runat="server" ResourceKey="lblCSSortColumns" ControlName="chkSortManufacturer" Text="Sort Columns:" />
        </td>
        <td>
            <asp:CheckBox ID="chkSortManufacturer" runat="server" CssClass="NormalTextBox" ResourceKey="chkSortManufacturer" AutoPostBack="True" OnCheckedChanged="chkSortManufacturer_CheckedChanged" /><br />
            <asp:CheckBox ID="chkSortModelNumber" runat="server" CssClass="NormalTextBox" ResourceKey="chkSortModelNumber" AutoPostBack="True" OnCheckedChanged="chkSortModelNumber_CheckedChanged" /><br />
            <asp:CheckBox ID="chkSortModelName" runat="server" CssClass="NormalTextBox" ResourceKey="chkSortModelName" AutoPostBack="True" OnCheckedChanged="chkSortModelName_CheckedChanged" /><br />
            <asp:CheckBox ID="chkSortUnitPrice" runat="server" CssClass="NormalTextBox" ResourceKey="chkSortUnitPrice" AutoPostBack="True" OnCheckedChanged="chkSortUnitPrice_CheckedChanged" /><br />
            <asp:CheckBox ID="chkSortCreatedDate" runat="server" CssClass="NormalTextBox" ResourceKey="chkSortCreatedDate" AutoPostBack="True" OnCheckedChanged="chkSortCreatedDate_CheckedChanged" />
        </td>
    </tr>
    <tr id="trSortBy" runat="server">
        <td class="SubHead">
            <dnn:Label ID="lblCSSortBy" runat="server" ResourceKey="lblCSSortBy" ControlName="lstCPLSortBy" Text="Sort By:" />
        </td>
        <td>
            <asp:dropdownlist id="lstCPLSortBy" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
    <tr id="trSortDir" runat="server">
        <td class="SubHead">
            <dnn:Label ID="lblCSSortDir" runat="server" ResourceKey="lblCSSortDir" ControlName="lstCPLSortDir" Text="Direction:" />
        </td>
        <td>
            <asp:dropdownlist id="lstCPLSortDir" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
</table>
<br />
<dnn:sectionhead id="dshProductDetails" runat="server" cssclass="Head" text="Product Detail Settings" section="tblProductDetails" includerule="true" isexpanded="false" resourcekey="dshProductDetails"></dnn:sectionhead>
<table id="tblProductDetails" runat="server" style="text-align:left;" cellspacing="5" cellpadding="0" border="0">
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblDetailTemplate" runat="server" ResourceKey="lblDetailTemplate" ControlName="lstDetailTemplate" Text="Detail Template:" />
        </td>
        <td>
            <asp:dropdownlist id="lstDetailTemplate" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblPDSCartWarning" runat="server" ResourceKey="lblPDSCartWarning" ControlName="chkDetailCartWarning" Text="Cart Warning:" />
        </td>
        <td>
            <asp:checkbox id="chkDetailCartWarning" runat="server" CssClass="NormalTextBox"></asp:checkbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblPDSShowThumbnail" runat="server" ResourceKey="lblPDSShowThumbnail" ControlName="chkDetailShowThumbnail" Text="Show Thumbnail:" />
        </td>
        <td>
            <asp:checkbox id="chkDetailShowThumbnail" runat="server" CssClass="NormalTextBox"></asp:checkbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblPDSThumbnailWidth" runat="server" ResourceKey="lblPDSThumbnailWidth" ControlName="txtDetailThumbnailWidth" Text="Thumbnail Width:" />
        </td>
        <td>
            <asp:textbox id="txtDetailThumbnailWidth" runat="server" width="50" MaxLength="4" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblPDSGIFBgColor" runat="server" ResourceKey="lblPDSGIFBgColor" ControlName="txtDetailGIFBgColor" Text="GIF Background:" />
        </td>
        <td>
            <asp:textbox id="txtDetailGIFBgColor" runat="server" width="80" MaxLength="7" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblPDSShowReviews" runat="server" ResourceKey="lblPDSShowReviews" ControlName="chkDetailShowReviews" Text="Show Reviews:" />
        </td>
        <td>
            <asp:CheckBox id="chkDetailShowReviews" runat="server" CssClass="NormalTextBox" />
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblPDSReturnPage" runat="server" ResourceKey="lblPDSReturnPage" ControlName="lstPDSReturnPage" Text="Return To" />
        </td>
        <td>
            <asp:dropdownlist id="lstPDSReturnPage" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
</table>
<br />
<dnn:sectionhead id="dshAlsoBoughtProductList" runat="server" cssclass="Head" text="Also Bought Product Settings" section="tblAlsoBoughtProductList" includerule="false" isexpanded="false" resourcekey="dshAlsoBoughtProductList"></dnn:sectionhead>
<table id="tblAlsoBoughtProductList" runat="server" style="text-align:left;" cellspacing="5" cellpadding="0" border="0">
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblABPSContainerTemplate" runat="server" ResourceKey="lblABPSContainerTemplate" ControlName="lstABPLContainerTemplate" Text="Container Template:" />
        </td>
        <td>
            <asp:dropdownlist id="lstABPLContainerTemplate" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblABPSListTemplate" runat="server" ResourceKey="lblABPSListTemplate" ControlName="lstABPLTemplate" Text="List Template:" />
        </td>
        <td>
            <asp:dropdownlist id="lstABPLTemplate" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblABPSRows" runat="server" ResourceKey="lblABPSRows" ControlName="txtABPLRowCount" Text="Rows:" />
        </td>
        <td>
            <asp:textbox id="txtABPLRowCount" runat="server" width="50" MaxLength="3" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblABPSColumns" runat="server" ResourceKey="lblABPSColumns" ControlName="txtABPLColumnCount" Text="Columns:" />
        </td>
        <td>
            <asp:textbox id="txtABPLColumnCount" runat="server" width="50" MaxLength="3" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblABPSColumnWidth" runat="server" ResourceKey="lblABPSColumnWidth" ControlName="txtABPLColumnWidth" Text="Column Width:" />
        </td>
        <td>
            <asp:textbox id="txtABPLColumnWidth" runat="server" width="50" MaxLength="4" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblABPSRepeatDirection" runat="server" ResourceKey="lblABPSRepeatDirection" ControlName="lstABPLRepeatDirection" Text="Repeat Direction:" />
        </td>
        <td>
            <asp:dropdownlist id="lstABPLRepeatDirection" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblABPSShowThumbnail" runat="server" ResourceKey="lblABPSShowThumbnail" ControlName="chkABPLShowThumbnail" Text="Show Thumbnail:" />
        </td>
        <td>
            <asp:checkbox id="chkABPLShowThumbnail" runat="server" CssClass="NormalTextBox"></asp:checkbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblABPSThumbnailWidth" runat="server" ResourceKey="lblABPSThumbnailWidth" ControlName="txtABPLThumbnailWidth" Text="Thumbnail Width:" />
        </td>
        <td>
            <asp:textbox id="txtABPLThumbnailWidth" runat="server" width="50" MaxLength="4" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblABPSGIFBgColor" runat="server" ResourceKey="lblABPSGIFBgColor" ControlName="txtABPLGIFBgColor" Text="GIF Background:" />
        </td>
        <td>
            <asp:textbox id="txtABPLGIFBgColor" runat="server" width="80" MaxLength="7" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblABPSDetailPage" runat="server" ResourceKey="lblABPSDetailPage" ControlName="lstABPLDetailPage" Text="Detail Page:" />
        </td>
        <td>
            <asp:dropdownlist id="lstABPLDetailPage" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
</table>
<br />
<dnn:sectionhead id="dshNewProductList" runat="server" cssclass="Head" text="New Product Settings" section="tblNewProductList" includerule="true" isexpanded="false" resourcekey="dshNewProductList"></dnn:sectionhead>
<table id="tblNewProductList" runat="server" style="text-align:left;" cellspacing="5" cellpadding="0" border="0">
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblNPSContainerTemplate" runat="server" ResourceKey="lblNPSContainerTemplate" ControlName="lstNPLContainerTemplate" Text="Container Template:" />
        </td>
        <td>
            <asp:dropdownlist id="lstNPLContainerTemplate" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblNPSListTemplate" runat="server" ResourceKey="lblNPSListTemplate" ControlName="lstNPLTemplate" Text="List Template:" />
        </td>
        <td>
            <asp:dropdownlist id="lstNPLTemplate" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblNPSRows" runat="server" ResourceKey="lblNPSRows" ControlName="txtNPLRowCount" Text="Rows:" />
        </td>
        <td>
            <asp:textbox id="txtNPLRowCount" runat="server" width="50" MaxLength="3" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblNPSColumns" runat="server" ResourceKey="lblNPSColumns" ControlName="txtNPLColumnCount" Text="Columns:" />
        </td>
        <td>
            <asp:textbox id="txtNPLColumnCount" runat="server" width="50" MaxLength="3" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblNPSColumnWidth" runat="server" ResourceKey="lblNPSColumnWidth" ControlName="txtNPLColumnWidth" Text="Column Width:" />
        </td>
        <td>
            <asp:textbox id="txtNPLColumnWidth" runat="server" width="50" MaxLength="4" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblNPSRepeatDirection" runat="server" ResourceKey="lblNPSRepeatDirection" ControlName="lstNPLRepeatDirection" Text="Repeat Direction:" />
        </td>
        <td>
            <asp:dropdownlist id="lstNPLRepeatDirection" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblNPSShowThumbnail" runat="server" ResourceKey="lblNPSShowThumbnail" ControlName="chkNPLShowThumbnail" Text="Show Thumbnail:" />
        </td>
        <td>
            <asp:checkbox id="chkNPLShowThumbnail" runat="server" CssClass="NormalTextBox"></asp:checkbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblNPSThumbnailWidth" runat="server" ResourceKey="lblNPSThumbnailWidth" ControlName="txtNPLThumbnailWidth" Text="Thumbnail Width:" />
        </td>
        <td>
            <asp:textbox id="txtNPLThumbnailWidth" runat="server" width="50" MaxLength="4" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblNPSGIFBgColor" runat="server" ResourceKey="lblNPSGIFBgColor" ControlName="txtNPLGIFBgColor" Text="GIF Background:" />
        </td>
        <td>
            <asp:textbox id="txtNPLGIFBgColor" runat="server" width="80" MaxLength="7" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblNPSDetailPage" runat="server" ResourceKey="lblNPSDetailPage" ControlName="lstNPLDetailPage" Text="Detail Page:" />
        </td>
        <td>
            <asp:dropdownlist id="lstNPLDetailPage" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
</table>
<br />
<dnn:sectionhead id="dshFeaturedProductList" runat="server" cssclass="Head" text="Featured Product Settings" section="tblFeaturedProductList" includerule="true" isexpanded="false" resourcekey="dshFeaturedProductList"></dnn:sectionhead>
<table id="tblFeaturedProductList" runat="server" style="text-align:left;" cellspacing="5" cellpadding="0" border="0">
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblFPSContainerTemplate" runat="server" ResourceKey="lblFPSContainerTemplate" ControlName="lstFPLContainerTemplate" Text="Container Template:" />
        </td>
        <td>
            <asp:dropdownlist id="lstFPLContainerTemplate" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblFPSListTemplate" runat="server" ResourceKey="lblFPSListTemplate" ControlName="lstFPLTemplate" Text="List Template:" />
        </td>
        <td>
            <asp:dropdownlist id="lstFPLTemplate" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblFPSRows" runat="server" ResourceKey="lblFPSRows" ControlName="txtFPLRowCount" Text="Rows:" />
        </td>
        <td>
            <asp:textbox id="txtFPLRowCount" runat="server" width="50" MaxLength="3" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblFPSColumns" runat="server" ResourceKey="lblFPSColumns" ControlName="txtFPLColumnCount" Text="Columns:" />
        </td>
        <td>
            <asp:textbox id="txtFPLColumnCount" runat="server" width="50" MaxLength="3" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblFPSColumnWidth" runat="server" ResourceKey="lblFPSColumnWidth" ControlName="txtFPLColumnWidth" Text="Column Width:" />
        </td>
        <td>
            <asp:textbox id="txtFPLColumnWidth" runat="server" width="50" MaxLength="4" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblFPSRepeatDirection" runat="server" ResourceKey="lblFPSRepeatDirection" ControlName="lstFPLRepeatDirection" Text="Repeat Direction:" />
        </td>
        <td>
            <asp:dropdownlist id="lstFPLRepeatDirection" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblFPSShowThumbnail" runat="server" ResourceKey="lblFPSShowThumbnail" ControlName="chkFPLShowThumbnail" Text="Show Thumbnail:" />
        </td>
        <td>
            <asp:checkbox id="chkFPLShowThumbnail" runat="server" CssClass="NormalTextBox"></asp:checkbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblFPSThumbnailWidth" runat="server" ResourceKey="lblFPSThumbnailWidth" ControlName="txtFPLThumbnailWidth" Text="Thumbnail Width:" />
        </td>
        <td>
            <asp:textbox id="txtFPLThumbnailWidth" runat="server" width="50" MaxLength="4" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblFPSGIFBgColor" runat="server" ResourceKey="lblFPSGIFBgColor" ControlName="txtFPLGIFBgColor" Text="GIF Background:" />
        </td>
        <td>
            <asp:textbox id="txtFPLGIFBgColor" runat="server" width="80" MaxLength="7" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblFPSDetailPage" runat="server" ResourceKey="lblFPSDetailPage" ControlName="lstFPLDetailPage" Text="Detail Page:" />
        </td>
        <td>
            <asp:dropdownlist id="lstFPLDetailPage" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
</table>
<br />
<dnn:sectionhead id="dshPopularProductList" runat="server" cssclass="Head" text="Popular Product Settings" section="tblPopularProductList" includerule="true" isexpanded="false" resourcekey="dshPopularProductList"></dnn:sectionhead>
<table id="tblPopularProductList" runat="server" style="text-align:left;" cellspacing="5" cellpadding="0" border="0">
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblPPSContainerTemplate" runat="server" ResourceKey="lblPPSContainerTemplate" ControlName="lstPPLContainerTemplate" Text="Container Template:" />
        </td>
        <td>
            <asp:dropdownlist id="lstPPLContainerTemplate" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblPPSListTemplate" runat="server" ResourceKey="lblPPSListTemplate" ControlName="lstPPLTemplate" Text="List Template:" />
        </td>
        <td>
            <asp:dropdownlist id="lstPPLTemplate" CssClass="NormalTextBox" runat="server" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblPPSRows" runat="server" ResourceKey="lblPPSRows" ControlName="txtPPLRowCount" Text="Rows:" />
        </td>
        <td>
            <asp:textbox id="txtPPLRowCount" runat="server" width="50" MaxLength="3" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblPPSColumns" runat="server" ResourceKey="lblPPSColumns" ControlName="txtPPLColumnCount" Text="Columns:" />
        </td>
        <td>
            <asp:textbox id="txtPPLColumnCount" runat="server" width="50" MaxLength="3" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblPPSColumnWidth" runat="server" ResourceKey="lblPPSColumnWidth" ControlName="txtPPLColumnWidth" Text="Repeat Direction:" />
        </td>
        <td>
            <asp:textbox id="txtPPLColumnWidth" runat="server" width="50" MaxLength="4" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblPPSRepeatDirection" runat="server" ResourceKey="lblPPSRepeatDirection" ControlName="lstPPLRepeatDirection" Text="Repeat Direction:" />
        </td>
        <td>
            <asp:dropdownlist id="lstPPLRepeatDirection" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblPPSShowThumbnail" runat="server" ResourceKey="lblPPSShowThumbnail" ControlName="chkPPLShowThumbnail" Text="Show Thumbnail:" />
        </td>
        <td>
            <asp:checkbox id="chkPPLShowThumbnail" runat="server" CssClass="NormalTextBox"></asp:checkbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblPPSThumbnailWidth" runat="server" ResourceKey="lblPPSThumbnailWidth" ControlName="txtPPLThumbnailWidth" Text="Thumbnail Width:" />
        </td>
        <td>
            <asp:textbox id="txtPPLThumbnailWidth" runat="server" width="50" MaxLength="4" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblPPSGIFBgColor" runat="server" ResourceKey="lblPPSGIFBgColor" ControlName="txtPPLGIFBgColor" Text="GIF Background:" />
        </td>
        <td>
            <asp:textbox id="txtPPLGIFBgColor" runat="server" width="80" MaxLength="7" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:Label ID="lblPPSDetailPage" runat="server" ResourceKey="lblPPSDetailPage" ControlName="lstPPLDetailPage" Text="Detail Page:" />
        </td>
        <td>
            <asp:dropdownlist id="lstPPLDetailPage" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="False"></asp:dropdownlist>
        </td>
    </tr>
</table>
