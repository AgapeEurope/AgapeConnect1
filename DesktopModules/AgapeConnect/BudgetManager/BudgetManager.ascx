<%@ Control Language="VB" AutoEventWireup="false" CodeFile="BudgetManager.ascx.vb" Inherits="DotNetNuke.Modules.Budget.BudgetManager" %>
<script src="/js/jquery.numeric.js"></script>
<script type="text/javascript">
    
    (function ($, Sys) {

        function setUpMyTabs() {
          
            $('.aButton').button();

            //$('.dropdown-toggle').dropdown();
           
            $('.numeric').numeric();
           
            $('.insertPeriod').keyup(function () {
             
                var total = parseFloat($('#<%= tbP1new.ClientID%>').val())
                    + parseFloat($('#<%= tbP2new.ClientID%>').val())
                    + parseFloat($('#<%= tbP3new.ClientID%>').val())
                    + parseFloat($('#<%= tbP4new.ClientID%>').val())
                    + parseFloat($('#<%= tbP5new.ClientID%>').val())
                    + parseFloat($('#<%= tbP6new.ClientID%>').val())
                    + parseFloat($('#<%= tbP7new.ClientID%>').val())
                    + parseFloat($('#<%= tbP8new.ClientID%>').val())
                    + parseFloat($('#<%= tbP9new.ClientID%>').val())
                    + parseFloat($('#<%= tbP10new.ClientID%>').val())
                    + parseFloat($('#<%= tbP11new.ClientID%>').val())
                    + parseFloat($('#<%= tbP12new.ClientID%>').val()) ;
              
                $('#<%= lblTotalNew.ClientID %>').text( total.toString());
                
                
                });
           

        }

        $(document).ready(function () {
            setUpMyTabs();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpMyTabs();
            });
        });
    }(jQuery, window.Sys));





</script>

<table>
    <tr>
        <td>Fiscal Year: 
        </td>
        <td>
            <asp:DropDownList ID="ddlFiscalYear" runat="server" AutoPostBack="true">
                <asp:ListItem Text="2010-2011" Value="2010" />
                <asp:ListItem Text="2011-2012" Value="2011" />
                <asp:ListItem Text="2012-2013" Value="2012" />
                <asp:ListItem Text="2013-2014" Value="2013" />
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td>Filter by R/C:</td>
        <td>
            <asp:DropDownList ID="ddlRC" runat="server" DataTextField="Name" DataValueField="CostCentreCode" AutoPostBack="true" AppendDataBoundItems="true">
                <asp:ListItem Text="All R/C's" Value="All" />
                <asp:ListItem Text="All Staff" Value="AllStaff" />
            </asp:DropDownList>

        </td>
    </tr>
</table>


<asp:HiddenField ID="hfPortalId" runat="server" Value="0" />

<asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical" AutoGenerateColumns="False" DataKeyNames="BudgetSummaryId" DataSourceID="dsBudgetSummaries" ShowFooter="True">
    <AlternatingRowStyle BackColor="White" />
    <Columns>
        <asp:TemplateField HeaderText="Account" SortExpression="Account">
            <EditItemTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# Eval("Account") %>'></asp:Label>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label14" runat="server" ToolTip='<%# Eval("AP_StaffBroker_AccountCode.AccountCodeName") %>' Text='<%# Bind("Account") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="RC" SortExpression="RC">
            <EditItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Eval("RC")%>'></asp:Label>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" ToolTip='<%# Eval("AP_StaffBroker_CostCenter.CostCentreName") %>' Text='<%# Eval("RC")%>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                Total:
            </FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="P1" SortExpression="P1">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("P1", "{0:0.00}") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# Bind("P1", "{0:0.00}") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# GetColumnTotal(1).ToString("0.00") %>'></asp:Label>
            </FooterTemplate>
            <ControlStyle Width="60px" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="P2" SortExpression="P2">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("P2", "{0:0.00}") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label3" runat="server" Text='<%# Bind("P2", "{0:0.00}") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# GetColumnTotal(2).ToString("0.00") %>'></asp:Label>
            </FooterTemplate>
            <ControlStyle Width="60px" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="P3" SortExpression="P3">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("P3", "{0:0.00}") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label4" runat="server" Text='<%# Bind("P3", "{0:0.00}") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# GetColumnTotal(3).ToString("0.00") %>'></asp:Label>
            </FooterTemplate>
            <ControlStyle Width="60px" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="P4" SortExpression="P4">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("P4", "{0:0.00}") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label5" runat="server" Text='<%# Bind("P4", "{0:0.00}") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# GetColumnTotal(4).ToString("0.00") %>'></asp:Label>
            </FooterTemplate>
            <ControlStyle Width="60px" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="P5" SortExpression="P5">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("P5", "{0:0.00}") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label6" runat="server" Text='<%# Bind("P5", "{0:0.00}") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# GetColumnTotal(5).ToString("0.00") %>'></asp:Label>
            </FooterTemplate>
            <ControlStyle Width="60px" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="P6" SortExpression="P6">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("P6", "{0:0.00}") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label7" runat="server" Text='<%# Bind("P6", "{0:0.00}") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# GetColumnTotal(6).ToString("0.00") %>'></asp:Label>
            </FooterTemplate>
            <ControlStyle Width="60px" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="P7" SortExpression="P7">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("P7", "{0:0.00}") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label8" runat="server" Text='<%# Bind("P7", "{0:0.00}") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# GetColumnTotal(7).ToString("0.00") %>'></asp:Label>
            </FooterTemplate>
            <ControlStyle Width="60px" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="P8" SortExpression="P8">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("P8", "{0:0.00}") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label9" runat="server" Text='<%# Bind("P8", "{0:0.00}") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# GetColumnTotal(8).ToString("0.00") %>'></asp:Label>
            </FooterTemplate>
            <ControlStyle Width="60px" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="P9" SortExpression="P9">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("P9", "{0:0.00}") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label10" runat="server" Text='<%# Bind("P9", "{0:0.00}") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# GetColumnTotal(9).ToString("0.00") %>'></asp:Label>
            </FooterTemplate>
            <ControlStyle Width="60px" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="P10" SortExpression="P10">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("P10", "{0:0.00}") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label11" runat="server" Text='<%# Bind("P10", "{0:0.00}") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# GetColumnTotal(10).ToString("0.00") %>'></asp:Label>
            </FooterTemplate>
            <ControlStyle Width="60px" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="P11" SortExpression="P11">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("P11", "{0:0.00}") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label12" runat="server" Text='<%# Bind("P11", "{0:0.00}") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# GetColumnTotal(11).ToString("0.00") %>'></asp:Label>
            </FooterTemplate>
            <ControlStyle Width="60px" />
        </asp:TemplateField>
        <asp:TemplateField HeaderText="P12" SortExpression="P12">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox12" runat="server" Text='<%# Bind("P12", "{0:0.00}") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label13" runat="server" Text='<%# Bind("P12", "{0:0.00}") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# GetColumnTotal(12).ToString("0.00") %>'></asp:Label>
            </FooterTemplate>
            <ControlStyle Width="60px" />
        </asp:TemplateField>


        <asp:TemplateField HeaderText="Total">
            <ItemTemplate>

                <asp:Label runat="server" Font-Bold="true" Text='<%# CDbl(Eval("P1") + Eval("P2") +Eval("P3") +Eval("P4") +Eval("P5") +Eval("P6") +Eval("P7") +Eval("P8") +Eval("P9") +Eval("P10") +Eval("P11") +Eval("P12")).ToString("0.00") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# GetColumnTotal(-1).ToString("0.00") %>'></asp:Label>
            </FooterTemplate>
        </asp:TemplateField>


        <asp:CommandField ShowEditButton="True" />


    </Columns>
    <FooterStyle BackColor="#CCCC99" Font-Bold="True" />
    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
    <RowStyle BackColor="#F7F7DE" />
    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
    <SortedAscendingCellStyle BackColor="#FBFBF2" />
    <SortedAscendingHeaderStyle BackColor="#848384" />
    <SortedDescendingCellStyle BackColor="#EAEAD3" />
    <SortedDescendingHeaderStyle BackColor="#575357" />

</asp:GridView>
<asp:LinqDataSource ID="dsBudgetSummaries" runat="server" EntityTypeName="" ContextTypeName="Budget.BudgetDataContext" TableName="AP_Budget_Summaries" Where="Portalid == @Portalid &amp;&amp; FiscalYear == @FiscalYear &amp;&amp;  ( (RC == @RC) || (@RC==&quot;All&quot;) || (@RC==&quot;AllStaff&quot; &amp;&amp; AP_StaffBroker_CostCenter.Type==1))" EnableInsert="True" EnableUpdate="True" OrderBy="Account">
    <WhereParameters>
        <asp:ControlParameter ControlID="hfPortalId" Name="Portalid" PropertyName="Value" Type="Int32" />
        <asp:ControlParameter ControlID="ddlRC" Name="RC" PropertyName="SelectedValue" Type="String" />
        <asp:ControlParameter ControlID="ddlFiscalYear" Name="FiscalYear" PropertyName="SelectedValue" Type="Int32" />
    </WhereParameters>
</asp:LinqDataSource>


<table>
    <tr>
        <td>Fiscal Year</td>
        <td>Account</td>
        <td>R/C</td>
        <td>P1</td>
        <td>P2</td>
        <td>P3</td>
        <td>P4</td>
        <td>P5</td>
        <td>P6</td>
        <td>P7</td>
        <td>P8</td>
        <td>P9</td>
        <td>P10</td>
        <td>P11</td>
        <td>P12</td>
        <td>Total</td>
        <td></td>

    </tr>
    <tr>
        <td>
            <asp:DropDownList ID="ddlFiscalYearNew" runat="server">
                <asp:ListItem Text="2010-2011" Value="2010" />
                <asp:ListItem Text="2011-2012" Value="2011" />
                <asp:ListItem Text="2012-2013" Value="2012" />
                <asp:ListItem Text="2013-2014" Value="2013" />
            </asp:DropDownList>
        </td>
        <td>
             <asp:DropDownList ID="ddlAccountNew" runat="server" DataTextField="AccountCode" DataValueField="AccountCode" DataSourceID="dsAccounts"></asp:DropDownList>
             <asp:LinqDataSource ID="dsAccounts" runat="server" ContextTypeName="Budget.BudgetDataContext" EntityTypeName="" OrderBy="AccountCode" TableName="AP_StaffBroker_AccountCodes" Where="PortalId == @PortalId">
                 <WhereParameters>
                     <asp:ControlParameter ControlID="hfPortalId" Name="PortalId" PropertyName="Value" Type="Int32" />
                 </WhereParameters>
             </asp:LinqDataSource>
        </td>
        <td>
            <asp:DropDownList ID="ddlRCNew" runat="server" DataTextField="CostCentreCode" DataValueField="CostCentreCode"></asp:DropDownList>
        </td>
        <td>
            <asp:TextBox ID="tbP1new" runat="server" Width="60px" CssClass="insertPeriod numeric">0</asp:TextBox></td>
        <td>
            <asp:TextBox ID="tbP2new" runat="server" Width="60px" CssClass="insertPeriod numeric">0</asp:TextBox></td>
        <td>
            <asp:TextBox ID="tbP3new" runat="server" Width="60px" CssClass="insertPeriod numeric">0</asp:TextBox></td>
        <td>
            <asp:TextBox ID="tbP4new" runat="server" Width="60px" CssClass="insertPeriod numeric">0</asp:TextBox></td>
        <td>
            <asp:TextBox ID="tbP5new" runat="server" Width="60px" CssClass="insertPeriod numeric">0</asp:TextBox></td>
        <td>
            <asp:TextBox ID="tbP6new" runat="server" Width="60px" CssClass="insertPeriod numeric">0</asp:TextBox></td>
        <td>
            <asp:TextBox ID="tbP7new" runat="server" Width="60px" CssClass="insertPeriod numeric">0</asp:TextBox></td>
        <td>
            <asp:TextBox ID="tbP8new" runat="server" Width="60px" CssClass="insertPeriod numeric">0</asp:TextBox></td>
        <td>
            <asp:TextBox ID="tbP9new" runat="server" Width="60px" CssClass="insertPeriod numeric">0</asp:TextBox></td>
        <td>
            <asp:TextBox ID="tbP10new" runat="server" Width="60px" CssClass="insertPeriod numeric">0</asp:TextBox></td>
        <td>
            <asp:TextBox ID="tbP11new" runat="server" Width="60px" CssClass="insertPeriod numeric">0</asp:TextBox></td>
        <td>
            <asp:TextBox ID="tbP12new" runat="server" Width="60px" CssClass="insertPeriod numeric">0</asp:TextBox></td>
        <td><asp:Label ID="lblTotalNew" runat="server" Text="0"></asp:Label></td>
        <td>
            <asp:LinkButton ID="btnInsertRow" runat="server">Insert</asp:LinkButton>
        </td>
    </tr>
</table>

