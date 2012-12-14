<%@ Control language="c#" CodeBehind="ProductDetail.ascx.cs" Inherits="DotNetNuke.Modules.Store.WebControls.ProductDetail" AutoEventWireup="True" %>
<asp:placeholder id="plhDetails" runat="server"></asp:placeholder>
<asp:Label ID="lblError" runat="server" CssClass="NormalRed StoreDetailError" Visible="false"></asp:Label>
<asp:Panel ID="pnlReturn" runat="server" CssClass="StoreDetailReturnWrapper">
    <asp:HyperLink ID="lnkReturn" runat="server" CssClass="CommandButton StoreDetailReturnButton" resourcekey="lnkReturn">Return To Category</asp:hyperlink>
</asp:Panel>
<asp:Panel id="pnlReviews" runat="server" CssClass="StoreDetailReviewsWrapper">
    <p class="StoreReviews-Title"><asp:Label id="labelReviews" runat="server" resourcekey="labelReviews">Reviews</asp:Label></p>
    <asp:PlaceHolder id="plhReviews" runat="server"></asp:PlaceHolder>
</asp:Panel>
