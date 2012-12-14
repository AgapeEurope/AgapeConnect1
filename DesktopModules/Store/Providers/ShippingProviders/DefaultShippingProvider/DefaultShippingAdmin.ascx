<%@ Control language="c#" CodeBehind="DefaultShippingAdmin.ascx.cs" Inherits="DotNetNuke.Modules.Store.Providers.Shipping.DefaultShippingProvider.DefaultShippingAdmin" AutoEventWireup="True" %>
<table style="text-align:left;">
	<tr>
	    <td>
	        <asp:datagrid id="grdShippingRates" runat="server" showheader="true" showfooter="true" autogeneratecolumns="false" width="100%" AllowPaging="False" CellPadding="5" HeaderStyle-CssClass="ShippingAndTaxHeaders" FooterStyle-CssClass="ShippingAndTaxHeaders" DataKeyField="ID" >
			    <columns>
				    <asp:TemplateColumn>
					    <HeaderTemplate>
						    <asp:Label ID="lblShippingRateDescriptionTitle" Runat="server" resourcekey="lblShippingRateDescriptionTitle" cssclass="NormalBold">Description</asp:Label>
                        </HeaderTemplate>
					    <ItemTemplate>
						    <asp:TextBox id="lblDescription" runat="server" cssclass="Normal" Text='<%# DataBinder.Eval(Container.DataItem, "Description") %>'></asp:TextBox>
					    </ItemTemplate>
					    <FooterTemplate>
					        <asp:TextBox id="txtNewDescription" runat="server" cssclass="NormalTextBox"></asp:TextBox>
                        </FooterTemplate>
				    </asp:TemplateColumn>
				    <asp:TemplateColumn>
					    <HeaderTemplate>
						    <asp:Label ID="lblMinWeightTitle" Runat="server" resourcekey="lblMinWeightTitle" cssclass="NormalBold">Min. Weight</asp:Label>
					    </HeaderTemplate>
					    <ItemTemplate>
						    <asp:TextBox id="lblMinWeight" runat="server" style="text-align:right;" cssclass="Normal" Text='<%# DataBinder.Eval(Container.DataItem, "MinWeight", "{0:N}")%>'></asp:TextBox>
					    </ItemTemplate>
					    <FooterTemplate>
					        <asp:TextBox id="txtNewMinWeight" runat="server" style="text-align:right;" cssclass="NormalTextBox"></asp:TextBox>
					    </FooterTemplate>
                        <ItemStyle HorizontalAlign="Right" />
				    </asp:TemplateColumn>
				    <asp:TemplateColumn>
					    <HeaderTemplate>
						    <asp:Label ID="lblMaxWeightTitle" Runat="server" resourcekey="lblMaxWeightTitle" cssclass="NormalBold">Max. Weight</asp:Label>
					    </HeaderTemplate>
					    <ItemTemplate>
						    <asp:TextBox id="lblMaxWeight" runat="server" style="text-align:right;" cssclass="Normal" Text='<%# DataBinder.Eval(Container.DataItem, "MaxWeight", "{0:N}")%>'></asp:TextBox>
					    </ItemTemplate>
					    <FooterTemplate>
					        <asp:TextBox id="txtNewMaxWeight" runat="server" style="text-align:right;" cssclass="NormalTextBox"></asp:TextBox>
					    </FooterTemplate>
                        <ItemStyle HorizontalAlign="Right" />
				    </asp:TemplateColumn>
				    <asp:TemplateColumn>
					    <HeaderTemplate>
						    <asp:Label ID="lblCostTitle" Runat="server" resourcekey="lblCostTitle" cssclass="NormalBold">Cost</asp:Label>
					    </HeaderTemplate>
					    <ItemTemplate>
						    <asp:TextBox id="lblCost" runat="server" style="text-align:right;" cssclass="Normal" Text='<%# DataBinder.Eval(Container.DataItem, "Cost", "{0:N}") %>'></asp:TextBox>
					    </ItemTemplate>
					    <FooterTemplate>
					        <asp:TextBox id="txtNewCost" runat="server" style="text-align:right;" cssclass="NormalTextBox"></asp:TextBox>
					    </FooterTemplate>
                        <ItemStyle HorizontalAlign="Right" />
				    </asp:TemplateColumn>
				    <asp:TemplateColumn>
                        <HeaderTemplate>
						    <asp:Label ID="lblDelete" Runat="server" resourcekey="lblDelete" cssclass="NormalBold">Delete</asp:Label>
					    </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox Runat="server" ID="chkDelete" cssclass="Normal"></asp:CheckBox>
                        </ItemTemplate>
                        <FooterTemplate>
					        <asp:LinkButton ID="lnkAddNew" runat="server" resourcekey="lnkAddNew" Text="Add" CssClass="CommandButton" CommandName="Add"></asp:LinkButton>
					    </FooterTemplate>
                        <FooterStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateColumn>
			    </columns>
				<PagerStyle Mode="NumericPages" HorizontalAlign="Center" CssClass="NormalBold"></PagerStyle>
                <FooterStyle CssClass="ShippingAndTaxHeaders" />
                <HeaderStyle CssClass="ShippingAndTaxHeaders" />
			</asp:datagrid>
			<asp:Label ID="lblError" runat="server" Visible="false" CssClass="NormalBold" ForeColor="red"></asp:Label>
	    </td>
	</tr>
	<tr>
		<td style="text-align:center;" class="Normal">
			<asp:linkbutton id="btnSaveShippingFee" runat="server" resourcekey="btnSaveShippingFee" CssClass="CommandButton">Update Shipping Rates</asp:linkbutton>
		</td>
	</tr>
</table>
