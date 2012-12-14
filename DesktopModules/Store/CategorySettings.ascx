<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CategorySettings.ascx.cs" Inherits="DotNetNuke.Modules.Store.WebControls.CategorySettings" targetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="Portal" TagName="URL" Src="~/controls/URLControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<table cellspacing="5" style="text-align:left;" border="0">
    <tr>
        <td class="SubHead">
            <dnn:label id="labelDisplayMode" suffix=":" controlname="cmbDisplayMode" runat="server"></dnn:label>
        </td>
        <td>
            <asp:dropdownlist id="cmbDisplayMode" runat="server" CssClass="NormalTextBox" enableviewstate="True" autopostback="True"></asp:dropdownlist>
        </td>
    </tr>
    <tr id="trColumnCount" runat="server">
        <td class="SubHead">
            <dnn:label id="labelColumnCount" suffix=":" controlname="txtColumnCount" runat="server"></dnn:label>
        </td>
        <td>
            <asp:textbox id="txtColumnCount" Width="100" Runat="server" MaxLength="3" CssClass="NormalTextBox"></asp:textbox>
        </td>
    </tr>
    <tr>
        <td class="SubHead">
            <dnn:label id="labelCatalogPage" suffix=":" controlname="cmbCatalogPage" runat="server"></dnn:label>
        </td>
        <td>
            <asp:dropdownlist id="cmbCatalogPage" runat="server" CssClass="NormalTextBox" autopostback="False" enableviewstate="True"></asp:dropdownlist>
        </td>
    </tr>
</table>
