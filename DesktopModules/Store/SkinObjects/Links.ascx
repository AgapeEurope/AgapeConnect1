<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="Links.ascx.cs" Inherits="DotNetNuke.Modules.Store.SkinObjects.Links" %>
<asp:PlaceHolder ID="phControls" runat="server">
    <span id="spanStoreLinks" class="StoreLinks">
        <asp:ImageButton ID="btnImage" runat="server" />
        <asp:LinkButton ID="lnkAction" runat="server">LinkAction</asp:LinkButton>
    </span>
</asp:PlaceHolder>
