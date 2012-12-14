<%@ Control Language="c#" AutoEventWireup="True" Codebehind="MiniCart.ascx.cs" Inherits="DotNetNuke.Modules.Store.WebControls.MiniCart" targetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register Src="CartDetail.ascx" TagName="CartDetail" TagPrefix="store" %>
<div id="divControls" runat="server" class="StoreMiniCartWrapper">
    <store:CartDetail id="cartControl" runat="server"></store:CartDetail>
    <p id="phlViewCart" runat="server">
        <asp:linkbutton id="btnViewCart" runat="server" cssclass="CommandButton StoreMiniCartViewCart" resourcekey="btnViewCart" OnClick="btnViewCart_Click">View Cart Details</asp:linkbutton>
    </p>
</div>