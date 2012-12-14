<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CategoryMenu.ascx.cs" Inherits="DotNetNuke.Modules.Store.WebControls.CategoryMenu" targetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<div id="divStoreMenu" class="StoreMenuWrapper" runat="server">
    <asp:datalist id="MyList" runat="server" cellpadding="3" cellspacing="0" width="100%" datakeyfield="CategoryID" repeatcolumns="1">
        <SelectedItemTemplate>
            <asp:linkbutton id="linkEdit1" CommandName="Edit" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "CategoryID") %>' runat="server">
                <asp:Image id="imageEdit1" Runat="server" ImageUrl="~/images/edit.gif" AlternateText="Edit" Visible="<%# IsEditable %>" resourcekey="Edit" />
            </asp:linkbutton>
            <asp:HyperLink id="linkCategory" CssClass="StoreMenuCategoryItem" Runat="server"><%# DataBinder.Eval(Container.DataItem, "Name") %></asp:HyperLink>
        </SelectedItemTemplate>
        <ItemTemplate>
            <asp:linkbutton id="linkEdit2" CommandName="Edit" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "CategoryID") %>' runat="server">
                <asp:Image id="imageEdit2" Runat="server" ImageUrl="~/images/edit.gif" AlternateText="Edit" Visible="<%# IsEditable %>" resourcekey="Edit" />
            </asp:linkbutton>
            <asp:HyperLink id="linkCategory" CssClass="StoreMenuCategoryItem" Runat="server"><%# DataBinder.Eval(Container.DataItem, "Name") %></asp:HyperLink>
        </ItemTemplate>
    </asp:datalist>
</div>
