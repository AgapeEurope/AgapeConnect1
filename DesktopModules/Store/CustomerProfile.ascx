<%@ Control language="c#" CodeBehind="CustomerProfile.ascx.cs" Inherits="DotNetNuke.Modules.Store.WebControls.CustomerProfile" AutoEventWireup="True" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<asp:Panel id="pnlLoginMessage" Runat="server">
    <asp:Label id="lblLoginMessage" Runat="server" CssClass="NormalRed StoreAccountAddressesLogin">Please login to view profile settings.</asp:Label>
</asp:Panel>
<asp:Panel id="pnlAddressProvider" Runat="server" Visible="False" CssClass="StoreAccountAddressesWrapper">
    <asp:placeholder id="plhAddressProvider" runat="server"></asp:placeholder>
</asp:Panel>
