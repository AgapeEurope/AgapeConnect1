<%@ Control language="c#" CodeBehind="DefaultAddressProfile.ascx.cs" Inherits="DotNetNuke.Modules.Store.Providers.Address.DefaultAddressProvider.DefaultAddressProfile" AutoEventWireup="True" %>
<%@ Register TagPrefix="dnnstore" TagName="address" Src="~/DesktopModules/Store/Providers/AddressProviders/DefaultAddressProvider/StoreAddress.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="wc" Namespace="DotNetNuke.UI.WebControls" Assembly="CountryListBox" %>
<asp:placeholder id="plhGrid" runat="server">
	<asp:datagrid id="grdAddresses" runat="server" autogeneratecolumns="false" showfooter="false" showheader="true" CssClass="StoreAccountAddresses">
	    <HeaderStyle CssClass="StoreAccountAddressesHeader" />
	    <ItemStyle CssClass="StoreAccountAddressesItem" />
	    <AlternatingItemStyle CssClass="StoreAccountAddressesAlternatingItem" />
		<columns>
			<asp:templatecolumn HeaderStyle-CssClass="StoreAccountAddressesDescriptionHeader" ItemStyle-CssClass="StoreAccountAddressesDescription">
				<headertemplate>
					<asp:label id="hdrDescription" runat="server" resourcekey="hdrDescription">Description</asp:label>
				</headertemplate>
				<itemtemplate>
					<asp:label id="lblDescription" runat="server"><%# DataBinder.Eval(Container.DataItem, "Description") %></asp:label>
				</itemtemplate>
			</asp:templatecolumn>
			<asp:templatecolumn HeaderStyle-CssClass="StoreAccountAddressesPrimaryHeader" ItemStyle-CssClass="StoreAccountAddressesPrimary">
				<headertemplate>
					<asp:label id="hdrPrimary" runat="server" resourcekey="hdrPrimary">Primary</asp:label>
				</headertemplate>
				<itemtemplate>
					<asp:image id="imgPrimary" runat="server" ImageUrl="~/images/checked.gif"></asp:image>
				</itemtemplate>
			</asp:templatecolumn>
			<asp:templatecolumn HeaderStyle-CssClass="StoreAccountAddressesEditHeader" ItemStyle-CssClass="StoreAccountAddressesEdit">
				<headertemplate>
					<span>&nbsp;</span>
				</headertemplate>
				<itemtemplate>
					<asp:hyperlink id="lnkEdit" runat="server" resourcekey="lnkEdit" CssClass="CommandButton StoreAccountAddressesEditButton">Edit</asp:hyperlink>
				</itemtemplate>
			</asp:templatecolumn>
		</columns>
	</asp:datagrid>
	<asp:linkbutton id="btnAdd" cssclass="CommandButton StoreAccountAddressesAddButton" runat="server" resourcekey="btnAdd" onclick="btnAdd_Click">Add Address</asp:linkbutton>
</asp:placeholder>
<asp:placeholder id="plhEditAddress" runat="server" visible="False">
    <dnnstore:address id="addressEdit" runat="server" StartTabIndex="2"></dnnstore:address>
	<table class="StoreAccountAddressCmd">
		<tr>
			<td  class="StoreAddressCommand" colspan="2">
				<asp:linkbutton id="cmdUpdate" tabIndex="21" cssclass="CommandButton StoreAccountAddressUpdateButton" runat="server" resourcekey="cmdUpdate" onclick="cmdUpdate_Click">Update</asp:linkbutton>&nbsp;
				<asp:linkbutton id="cmdCancel" tabIndex="22" cssclass="CommandButton StoreAccountAddressCancelButton" runat="server" resourcekey="cmdCancel" causesvalidation="False" onclick="cmdCancel_Click">Cancel</asp:linkbutton>&nbsp;
				<asp:linkbutton id="cmdDelete" tabIndex="23" cssclass="CommandButton StoreAccountAddressDeleteButton" runat="server" resourcekey="cmdDelete" visible="False" causesvalidation="False" onclick="cmdDelete_Click">Delete</asp:linkbutton>
			</td>
		</tr>
	</table>
</asp:placeholder>
