<%@ Control Language="c#" CodeBehind="ReviewList.ascx.cs" AutoEventWireup="True" Inherits="DotNetNuke.Modules.Store.WebControls.ReviewList" targetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<p class="StoreAddReview"><asp:linkbutton id="btnAddReview" CssClass="CommandButton" Text="Add Review" resourcekey="AddReview" runat="server" onclick="btnAddReview_Click"></asp:linkbutton></p>
<asp:datalist id="lstReviews" runat="server" cssclass="StoreReviews">
    <ItemTemplate>
        <p class="StoreUserReview">
            <asp:Label cssclass="NormalBold" Text='<%# DataBinder.Eval(Container.DataItem, "Username") %>' runat="server" id="lblUserName" />
            <asp:Label id="lblSays" Runat="server" resourcekey="lblSays" cssclass="Normal">says... </asp:Label>
        </p>
        <asp:PlaceHolder id="plhRating" Runat="server"></asp:PlaceHolder>
        <p class="StoreUserReviewComment">
            <asp:Label cssclass="Normal" Text='<%# DataBinder.Eval(Container.DataItem, "Comments") %>' runat="server" id="lblUserComment" />
        </p>
    </ItemTemplate>
    <SeparatorTemplate>
        <hr  />
    </SeparatorTemplate>
</asp:datalist>