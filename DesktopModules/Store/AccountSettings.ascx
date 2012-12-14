<%@ Control language="c#" CodeBehind="AccountSettings.ascx.cs" Inherits="DotNetNuke.Modules.Store.WebControls.AccountSettings" AutoEventWireup="True" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<table cellspacing="5" style="text-align:left;" border="0">
    <tr>
        <td class="SubHead">
            <dnn:Label id="lblDefaultView" runat="server" controlname="lstDefaultView"></dnn:Label>
        </td>
        <td>
            <asp:DropDownList id="lstDefaultView" runat="server" CssClass="NormalTextBox" AutoPostBack="false"></asp:DropDownList>
        </td>
    </tr>
	<tr>
		<td class="SubHead">
			<dnn:label id="lblRequireSSL" controlname="chkRequireSSL" runat="server"></dnn:label>
		</td>
		<td>
			<asp:CheckBox id="chkRequireSSL" runat="server" CssClass="NormalTextBox"></asp:CheckBox>
		</td>
	</tr>
	<tr>
		<td class="SubHead" valign="top">
			<dnn:label id="lblSSLNote" controlname="lblSSLMessage" runat="server"></dnn:label>
		</td>
		<td class="Normal">
			<asp:Label id="lblSSLMessage" runat="server" resourcekey="SSLMessage"></asp:Label>
		</td>
	</tr>
	<tr>
	    <td colspan="2">
            <dnn:sectionhead id="dshMainCartSettings" CssClass="Head" ResourceKey="dshMainCartSettings" runat="server" text="Main Cart Settings" section="tblMainCartSettings" includerule="false" isexpanded="true"></dnn:sectionhead>
	    </td>
	</tr>
	<tr id="tblMainCartSettings" runat="server">
	    <td colspan="2">
            <table cellspacing="0" cellpadding="0" border="0" style="text-align:left;">
                <tr>
                    <td class="SubHead">
                        <dnn:Label id="lblShowThumbnail" runat="server" controlname="chkShowThumbnail"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox id="chkShowThumbnail" runat="server" CssClass="NormalTextBox" AutoPostBack="True" OnCheckedChanged="chkShowThumbnail_CheckedChanged" />
                    </td>
                </tr>
                <tr id="trThumbnailWidth" runat="server">
                    <td class="SubHead">
                        <dnn:Label id="lblThumbnailWidth" runat="server" controlname="txtThumbnailWidth"></dnn:Label>
                    </td>
                    <td>
                        <asp:TextBox id="txtThumbnailWidth" runat="server" MaxLength="3" Width="30" CssClass="NormalTextBox"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="valReqThumbnailWidth" runat="server" ErrorMessage="* Thumbnail Width is required!" resourcekey="valReqThumbnailWidth" ControlToValidate="txtThumbnailWidth" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="valCompThumbnailWidth" runat="server" ErrorMessage="* A numeric value is required!" resourcekey="valCompThumbnailWidth" ControlToValidate="txtThumbnailWidth" Display="Dynamic" Operator="DataTypeCheck" Type="Integer"></asp:CompareValidator>
                    </td>
                </tr>
                <tr id="trGIFBgColor" runat="server">
                    <td class="SubHead">
                        <dnn:Label ID="lblGIFBgColor" runat="server" ResourceKey="lblGIFBgColor" ControlName="txtGIFBgColor" Text="Thumbnail Width:" />
                    </td>
                    <td>
                        <asp:textbox id="txtGIFBgColor" runat="server" width="80" MaxLength="7" CssClass="NormalTextBox"></asp:textbox>
                        <asp:RequiredFieldValidator ID="valReqGIFBgColor" runat="server" ErrorMessage="* Background color for GIF images is required!" ControlToValidate="txtGIFBgColor" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="valRegExGIFBgColor" runat="server" ErrorMessage="* A valid HTML Color is required!" ControlToValidate="txtGIFBgColor" Display="Dynamic" SetFocusOnError="True" ValidationExpression="^#?([a-f]|[A-F]|[0-9]){3}(([a-f]|[A-F]|[0-9]){3})?$"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr id="trEnableImageCaching" runat="server">
                    <td class="SubHead">
                        <dnn:Label ID="lblEnableImageCaching" runat="server" ResourceKey="lblEnableImageCaching" ControlName="chkEnableImageCaching" Text="Enable Image Caching:" />
                    </td>
                    <td>
                        <asp:checkbox id="chkEnableImageCaching" runat="server" CssClass="NormalTextBox" AutoPostBack="True" OnCheckedChanged="chkEnableImageCaching_CheckedChanged"></asp:checkbox>
                    </td>
                </tr>
                <tr id="trCacheDuration" runat="server">
                    <td class="SubHead">
                        <dnn:Label ID="lblCacheDuration" runat="server" ResourceKey="lblCacheDuration" ControlName="txtCacheDuration" Text="Cache Duration:" />
                    </td>
                    <td>
                        <asp:textbox id="txtCacheDuration" runat="server" width="80" CssClass="NormalTextBox"></asp:textbox>
                        <asp:RequiredFieldValidator ID="valReqCacheDuration" runat="server" ErrorMessage="* Cache Duration is required!" ControlToValidate="txtCacheDuration" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="valCompCacheDuration" runat="server" ErrorMessage="* A numeric value is required!" ControlToValidate="txtCacheDuration" Display="Dynamic" Operator="DataTypeCheck" Type="Integer"></asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td class="SubHead">
                        <dnn:Label id="lblProductColumn" runat="server" controlname="lstProductColumn"></dnn:Label>
                    </td>
                    <td>
                        <asp:DropDownList id="lstProductColumn" runat="server" CssClass="NormalTextBox" AutoPostBack="false"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="SubHead">
                        <dnn:Label id="lblLinkToDetail" runat="server" controlname="chkLinkToDetail"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox id="chkLinkToDetail" runat="server" CssClass="NormalTextBox" />
                    </td>
                </tr>
                <tr>
                    <td class="SubHead">
                        <dnn:Label id="lblIncludeVAT" runat="server" controlname="chkIncludeVAT"></dnn:Label>
                    </td>
                    <td>
                        <asp:CheckBox id="chkIncludeVAT" runat="server" CssClass="NormalTextBox" />
                    </td>
                </tr>
            </table>
	    </td>
	</tr>
</table>
