<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Control language="c#" CodeBehind="CategoryAdmin.ascx.cs" Inherits="DotNetNuke.Modules.Store.WebControls.CategoryAdmin" AutoEventWireup="True" %>
<asp:placeholder id="plhGrid" runat="server">
    <table cellspacing="0" cellpadding="0" border="0" width="100%">
        <tbody>
            <tr>
                <td align="center">
                    <asp:GridView ID="gvCategories" runat="server" AllowPaging="true" AllowSorting="true" AutoGenerateColumns="false" PageSize="10" CellPadding="5" OnSorting="gvCategories_Sorting" OnRowCreated="gvCategories_RowCreated" OnPageIndexChanging="gvCategories_PageIndexChanging" OnDataBinding="gvCategories_DataBinding">
                        <Columns>
                            <asp:BoundField DataField="Name" SortExpression="CategoryName" HeaderText="CategoryName" />
                            <asp:BoundField DataField="ParentCategoryName" SortExpression="ParentCategoryName" HeaderText="ParentCategoryName" />
                            <asp:BoundField DataField="OrderID" SortExpression="OrderID" HeaderText="OrderID" />
                            <asp:BoundField DataField="CreatedDate" SortExpression="CreatedDate" HeaderText="CreatedDate" DataFormatString="{0:g}" />
                            <asp:HyperLinkField DataNavigateUrlFields="CategoryID" Text="Edit" ControlStyle-CssClass="CommandButton" />
                        </Columns>
                        <PagerSettings Mode="NumericFirstLast" FirstPageText="<<" PreviousPageText="<" PageButtonCount="10" NextPageText=">" LastPageText=">>" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td align="center">
                    <asp:linkbutton id="linkAddImage" runat="server" cssclass="Normal">
                        <asp:Image id="imageAdd" Runat="server" ImageUrl="~/images/edit.gif" AlternateText="Edit" resourcekey="Edit" />
                    </asp:linkbutton>
                    <asp:linkbutton id="linkAddNew" runat="server" resourcekey="linkAddNew" cssclass="CommandButton">Add Category</asp:linkbutton>
                </td>
            </tr>
        </tbody>
    </table>
</asp:placeholder>
<asp:placeholder id="plhForm" runat="server" visible="false">
    <table cellspacing="0" cellpadding="0" border="0" width="100%">
        <tbody align="left">
            <tr>
                <td align="center">
                    <asp:label id="lblEditTitle" runat="server" cssclass="SubHead"></asp:label>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <asp:placeholder id="plhEditControl" runat="server"></asp:placeholder>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
        </tbody>
    </table>
</asp:placeholder>
