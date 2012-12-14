<%@ Control language="c#" CodeBehind="ReviewAdmin.ascx.cs" Inherits="DotNetNuke.Modules.Store.WebControls.ReviewAdmin" AutoEventWireup="True" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<asp:placeholder id="panelList" Visible="true" runat="server">
    <table cellspacing="0" cellpadding="0" border="0" width="100%">
        <tbody>
            <tr>
                <td align="center">
                    <table cellspacing="3" cellpadding="0" border="0">
                        <tr>
                            <td style="width:100px" class="SubHead">
                                <dnn:label id="lblStatus" runat="server" controlname="cmbStatus"></dnn:label>
                            </td>
                            <td>
                                <asp:DropDownList id="cmbStatus" runat="server" CssClass="NormalTextBox" Width="200" AutoPostBack="true" DataTextField="StatusName" DataValueField="StatusID" onselectedindexchanged="cmbStatus_SelectedIndexChanged"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:100px" class="SubHead">
                                <dnn:label id="lblCategory" runat="server" controlname="cmbCategory"></dnn:label>
                            </td>
                            <td>
                                <asp:DropDownList id="cmbCategory" runat="server" CssClass="NormalTextBox" AutoPostBack="true" DataTextField="CategoryPathName" DataValueField="CategoryID" onselectedindexchanged="cmbCategory_SelectedIndexChanged"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:100px" class="SubHead">
                                <dnn:label id="lblProduct" runat="server" controlname="cmbProduct"></dnn:label>
                            </td>
                            <td>
                                <asp:DropDownList id="cmbProduct" runat="server" CssClass="NormalTextBox" AutoPostBack="true" DataTextField="ProductTitle" DataValueField="ProductID" onselectedindexchanged="cmbProduct_SelectedIndexChanged"></asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:datagrid id="grdReviews" runat="server" showheader="true" showfooter="false" autogeneratecolumns="false" width="100%" AllowPaging="True" PageSize="20">
                        <columns>
                            <asp:TemplateColumn>
                                <HeaderTemplate>
                                    <asp:Label id="lblSubmitter" Runat="server" resourcekey="lblSubmitter" cssclass="NormalBold">Submitter</asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:label id="labelUserName" runat="server" cssclass="Normal"> <%# DataBinder.Eval(Container.DataItem, "UserName") %> </asp:label>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn>
                                <HeaderTemplate>
                                    <asp:Label id="lblProduct" Runat="server" resourcekey="lblProduct" cssclass="NormalBold">Product</asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:label id="lblProduct2" runat="server" cssclass="Normal"> <%# DataBinder.Eval(Container.DataItem, "ModelName") %> </asp:label>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn>
                                <HeaderTemplate>
                                    <asp:Label id="lblRating" Runat="server" resourcekey="lblRating" cssclass="NormalBold">Rating</asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:PlaceHolder id="phRating" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn>
                                <HeaderTemplate>
                                    <asp:Label id="lblComments" Runat="server" resourcekey="lblComments" cssclass="NormalBold">Comments</asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:label id="labelComments" runat="server" cssclass="Normal"> <%# DataBinder.Eval(Container.DataItem, "Comments") %> </asp:label>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:TemplateColumn>
                                <ItemTemplate>
                                    <asp:HyperLink id="linkEdit" Text="Edit" runat="server" cssclass="CommandButton" resourcekey="linkEdit"></asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                        </columns>
                        <PagerStyle Mode="NumericPages" HorizontalAlign="center" CssClass="NormalBold"></PagerStyle>
                    </asp:datagrid>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td align="center">
                    <asp:linkbutton id="linkAddImage" runat="server" cssclass="Normal" Visible="False">
                        <asp:Image id="imageAdd" Runat="server" ImageUrl="~/images/edit.gif" AlternateText="Edit" resourcekey="Edit" />
                    </asp:linkbutton>
                    <asp:linkbutton id="linkAddNew" runat="server" cssclass="CommandButton" Visible="False" resourcekey="linkAddNew">Add Review</asp:linkbutton>
                </td>
            </tr>
        </tbody>
    </table>
</asp:placeholder>
<asp:placeholder id="panelEdit" Visible="false" runat="server">
    <table cellspacing="0" cellpadding="0" border="0" width="100%">
        <tbody>
            <tr>
                <td>
                    <asp:PlaceHolder id="editControl" runat="server"></asp:PlaceHolder>
                </td>
            </tr>
        </tbody>
    </table>
</asp:placeholder>
