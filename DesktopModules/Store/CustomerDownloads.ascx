<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomerDownloads.ascx.cs" Inherits="DotNetNuke.Modules.Store.WebControls.CustomerDownloads" %>
<asp:Panel id="pnlDownloadsError" runat="server">
    <asp:label id="lblError" runat="server" CssClass="NormalRed StoreAccountDownloadsError"></asp:label>
</asp:Panel>
<asp:Panel ID="pnlDownloads" runat="server" CssClass="StoreAccountDownloadsWrapper">
    <p>
        <asp:Label ID="lblWarning" runat="server" CssClass="NormalRed" resourcekey="lblWarning">Popup Blockers Warning!</asp:Label>
    </p>
    <asp:datagrid id="grdDownloads" runat="server" showheader="true" showfooter="false" autogeneratecolumns="false" CssClass="StoreAccountDownloads" OnItemDataBound="grdDownloads_ItemDataBound">
        <HeaderStyle CssClass="StoreAccountDownloadsHeader" />
        <ItemStyle CssClass="StoreAccountDownloadsItem" />
        <AlternatingItemStyle CssClass="StoreAccountDownloadsAlternatingItem" />
        <columns>
            <asp:TemplateColumn>
                <HeaderTemplate>
                    <asp:Label id="lblOrderNumberHeader" Runat="server" resourcekey="lblOrderNumberHeader">Order</asp:Label>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:label id="lblOrderNumber" runat="server"><%# DataBinder.Eval(Container.DataItem, "OrderID").ToString() %></asp:label>
                </ItemTemplate>
                <HeaderStyle CssClass="StoreAccountDownloadsOrderNumberHeader" />
                <ItemStyle CssClass="StoreAccountDownloadsOrderNumber" />
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderTemplate>
                    <asp:Label id="lblProductTitleHeader" Runat="server" resourcekey="lblProductTitleHeader">Product</asp:Label>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:label id="lblProductTitle" runat="server"></asp:label>
                </ItemTemplate>
                <HeaderStyle CssClass="StoreAccountDownloadsProductTitleHeader" />
                <ItemStyle CssClass="StoreAccountDownloadsProductTitle" />
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderTemplate>
                    <asp:Label id="lblAllowedHeader" Runat="server" resourcekey="lblAllowedHeader">Allowed</asp:Label>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:label id="lblAllowed" runat="server"></asp:label>
                </ItemTemplate>
                <HeaderStyle CssClass="StoreAccountDownloadsAllowedHeader" />
                <ItemStyle CssClass="StoreAccountDownloadsAllowed" />
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderTemplate>
                    <asp:Label id="lblDownloadedHeader" runat="server" resourcekey="lblDownloadedHeader">Downloaded</asp:Label>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:label id="lblDownloaded" runat="server"></asp:label>
                </ItemTemplate>
                <HeaderStyle CssClass="StoreAccountDownloadsDownloadedHeader" />
                <ItemStyle CssClass="StoreAccountDownloadsDownloaded" />
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderTemplate>
                    <span>&nbsp;</span>
                </HeaderTemplate>
                <ItemTemplate>
                    <a id="lnkDownload" runat="server" class="CommandButton StoreAccountDownloadsDownloadButton">Download</a>
                </ItemTemplate>
                <HeaderStyle CssClass="StoreAccountDownloadsDownloadHeader" />
                <ItemStyle CssClass="StoreAccountDownloadsDownload" />
            </asp:TemplateColumn>
        </columns>
    </asp:datagrid>
</asp:Panel>
