<%@ Control language="c#" CodeBehind="ProductAdmin.ascx.cs" Inherits="DotNetNuke.Modules.Store.WebControls.ProductAdmin" AutoEventWireup="True" %>
<%@ Register TagPrefix="dnn" TagName="label" Src="~/controls/LabelControl.ascx" %>
<table cellspacing="0" cellpadding="0" width="100%" border="0" id="panelList" runat="server" visible="true">
    <tbody>
        <tr>
            <td valign="top" align="center">
                <table cellspacing="3" cellpadding="0" border="0">
                    <tr>
                        <td style="width:150px;">
                            <dnn:label id="lblCategory" controlname="lblCategory" runat="server" cssclass="SubHead"></dnn:label>
                        </td>
                        <td>
                            <asp:DropDownList id="cmbCategory" runat="server" CssClass="NormalTextBox" AutoPostBack="true" DataTextField="CategoryPathName" DataValueField="CategoryID"></asp:DropDownList>
                        </td>
                    </tr>
                </table>
                <br />
                <asp:datagrid id="grdProducts" runat="server" showheader="true" showfooter="false" autogeneratecolumns="false" width="100%" AllowPaging="True" cellpadding="5" PageSize="20">
                    <columns>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <asp:Label id="lblModelNumber" runat="server" resourcekey="lblModelNumber" cssclass="NormalBold">Model Number</asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:label id="labelModelNumber" runat="server" cssclass="Normal"> <%# DataBinder.Eval(Container.DataItem, "ModelNumber") %> </asp:label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <asp:Label id="lblProductName" runat="server" resourcekey="lblProductName" cssclass="NormalBold">Product Name</asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:label id="labelProductName" runat="server" cssclass="Normal"> <%# DataBinder.Eval(Container.DataItem, "ModelName") %> </asp:label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <asp:Label id="lblQuantity" runat="server" resourcekey="lblQuantity" cssclass="NormalBold">Quantity</asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:label id="labelQuantity" runat="server" cssclass="Normal"> <%# DataBinder.Eval(Container.DataItem, "StockQuantity")%> </asp:label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <asp:Label id="lblArchived" runat="server" CssClass="NormalBold" resourcekey="lblArchived">Archived</asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label id="labelArchived" runat="server" CssClass="Normal"> </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <asp:Label id="lblFeatured" runat="server" resourcekey="lblFeatured" cssclass="NormalBold">Featured</asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:label id="labelFeatured" runat="server" cssclass="Normal"> </asp:label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <asp:Label id="lblPrice" runat="server" resourcekey="lblPrice" cssclass="NormalBold">Price</asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:label id="labelPrice" runat="server" cssclass="Normal"> </asp:label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <ItemTemplate>
                                <asp:HyperLink id="linkEdit" resourcekey="linkEdit" runat="server" cssclass="CommandButton"></asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </columns>
                    <PagerStyle mode="NumericPages" horizontalalign="center" cssclass="NormalBold"></PagerStyle>
                </asp:datagrid>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td align="center">
                <asp:linkbutton id="linkAddImage" runat="server" cssclass="Normal">
                    <asp:Image id="imageAdd" runat="server" ImageUrl="~/images/edit.gif" AlternateText="Add" resourcekey="Add" />
                </asp:linkbutton>
                <asp:linkbutton id="linkAddNew" runat="server" resourcekey="linkAddNew" cssclass="CommandButton">Add Product</asp:linkbutton>
            </td>
        </tr>
    </tbody>
</table>
<div  id="panelEdit" runat="server" visible="false">
    <asp:PlaceHolder id="editControl" runat="server"></asp:PlaceHolder>
</div>