﻿<%@ Control Language="VB" AutoEventWireup="False" CodeFile="gr_mapping.ascx.vb" Inherits="DotNetNuke.Modules.AgapeConnect.gr_mapping_mod" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<style type="text/css">
    .LocalType {
        font-size: small;
        color: lightgray;
        font-style: italic;
        text-align: right;
        width: 90px;
        float: left;
        margin-right: 5px;
    }

    .mappingTitle {
        font-weight: bold;
    }

    .left_box {
        width: 220px;
        float: left;
        margin-right: 40px;
    }
</style>

<div class="left_box">
    <fieldset>
        <legend>
            <h5>GR - Entity Types</h5>
        </legend>
        <div style="max-width: 220px; overflow-x: auto;">

            <asp:TreeView ID="tv_gr_types" runat="server" ShowLines="true" ExpandDepth="0"></asp:TreeView>
        </div>
    </fieldset>
</div>

<p>
    Global Registry API Key :
    <asp:TextBox ID="tbApiKey" runat="server" Width="400px"></asp:TextBox>
    <asp:LinkButton ID="btnSaveKey" runat="server">Save</asp:LinkButton>
</p>


<p>
     Country/Ministry :
    <asp:DropDownList ID="ddlMinistries" runat="server" AppendDataBoundItems="true">
        <asp:ListItem Text="none" Value="" />
    </asp:DropDownList>
     <asp:LinkButton ID="btnSaveMinistry" runat="server">Save</asp:LinkButton>
</p>
<asp:Panel ID="pnlMain" runat="server">
    <fieldset>
        <legend>
            <h3>Field Mappings</h3>
        </legend>

        <p>
            This section allows you to configure how fields on this webportal map to fields in the Global Registry.
        Once a day, user information from this website is pumped into the Global Registry using the following mappings.
        </p>


        <asp:GridView ID="gvMappings" runat="server" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical" AutoGenerateColumns="False">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField HeaderText="Local Field" ItemStyle-Width="300px">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("LocalName") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <div class="LocalType">
                            <asp:Label ID="Label2" runat="server" Text='<%# getLocalTypeName( Eval("LocalSource")) %>'></asp:Label>
                        </div>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("LocalName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        -->
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="gr_dot_notated_name" HeaderText="Global Registry Field" ItemStyle-Width="300px" />
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="myDelete" Text="Delete" CommandArgument='<%# Eval("ID") %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#CCCC99" />
            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
            <RowStyle BackColor="#F7F7DE" />
            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#FBFBF2" />
            <SortedAscendingHeaderStyle BackColor="#848384" />
            <SortedDescendingCellStyle BackColor="#EAEAD3" />
            <SortedDescendingHeaderStyle BackColor="#575357" />
        </asp:GridView>
        <div class="mappingTitle">Add new mapping:</div>
        <table cellspacing="2px">

            <tr>
                <td width="310px">
                    <asp:DropDownList ID="ddlProfileMap" runat="server" Width="100%"></asp:DropDownList></td>
                <td>--></td>
                <td width="310px">
                    <asp:DropDownList ID="gr_entity_types" runat="server" Width="100%"></asp:DropDownList></td>
                <td>
                    <asp:LinkButton ID="btnAdd" runat="server">add</asp:LinkButton></td>
            </tr>
        </table>





    </fieldset>


  

       
</asp:Panel>



