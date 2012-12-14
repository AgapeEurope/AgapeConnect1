<%@ Control Language="VB" AutoEventWireup="false" CodeFile="StaffSO.ascx.vb" Inherits="DotNetNuke.Modules.Give.StaffDonations" %>
<br />
<p>This is a list of all your current standing orders. A summary is included at the bottom of the page.</p><br />
<asp:HiddenField ID="hfUserId" runat="server"  />
<asp:HiddenField ID="hfUserId2" runat="server"  />
<asp:HiddenField ID="hfStaffFinanceId" runat="server"  />
<asp:GridView ID="gvSOOnline" runat="server" AutoGenerateColumns="False"  Font-Size="10pt"
    DataKeyNames="PPID" DataSourceID="OnlineSODS" CellPadding="4" 
    ForeColor="#333333" GridLines="None" AllowSorting="True" 
    EnableModelValidation="True">
    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
    <Columns>
        <asp:TemplateField HeaderText="Donor" SortExpression="DonorName" HeaderStyle-Font-Bold="true" HeaderStyle-ForeColor="White">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("DonorName") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Font-Bold="true" Text='<%# Eval("DonorName") %>'></asp:Label><br />
                 <asp:Label ID="Label3" runat="server" Font-Bold="true" Font-Size="7pt" ForeColor="Gray" Font-Italic="true" Text='<%# Eval("PVKEY") %>'></asp:Label>
            </ItemTemplate>

<HeaderStyle Font-Bold="True" ForeColor="White"></HeaderStyle>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Amount") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# Eval("Amount", "{0:c}") & " <i>" &  getFreq(Eval("Frequency")) & "</i>" %>'></asp:Label>
            </ItemTemplate>
            <HeaderStyle Font-Bold="True" ForeColor="White" />
        </asp:TemplateField>
        <asp:CheckBoxField DataField="GiftAid" HeaderText="GiftAid"  
            HeaderStyle-Font-Bold="true" HeaderStyle-ForeColor="White"
            SortExpression="GiftAid" >
<HeaderStyle Font-Bold="True" ForeColor="White"></HeaderStyle>
        </asp:CheckBoxField>
       

       
        <asp:BoundField DataField="StartDate" HeaderText="Start Date"  
            HeaderStyle-Font-Bold="true" HeaderStyle-ForeColor="White"
            SortExpression="StartDate" DataFormatString="{0:dd/MM/yyyy}" >
<HeaderStyle Font-Bold="True" ForeColor="White"></HeaderStyle>
        </asp:BoundField>
        <asp:BoundField DataField="LastPaymentDate" HeaderText="Last Gift"  
            HeaderStyle-Font-Bold="true" HeaderStyle-ForeColor="White"
            SortExpression="LastPaymentDate" DataFormatString="{0:dd/MM/yyyy}" >
<HeaderStyle Font-Bold="True" ForeColor="White"></HeaderStyle>
        </asp:BoundField>
        <asp:TemplateField HeaderText="Status" SortExpression="Status" ItemStyle-Width="60px" HeaderStyle-Font-Bold="true" HeaderStyle-ForeColor="White">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Status") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
               <asp:Label ID="Label1" runat="server" Text='<%# getStatus(Eval("Status")) %>' Font-Bold="true" ForeColor="Gray" Visible='<%# (Eval("Status")=0) %>'></asp:Label>
                <asp:Label ID="Label4" runat="server" Text='<%# getStatus(Eval("Status")) %>' Font-Bold="true" ForeColor="Orange" Visible='<%# (Eval("Status")=1) %>'></asp:Label>
                <asp:Label ID="Label5" runat="server" Text='<%# getStatus(Eval("Status")) %>' Font-Bold="true" ForeColor="Green"  Visible='<%# (Eval("Status")=2) %>'></asp:Label>
                <asp:Label ID="Label6" runat="server" Text='<%# getStatus(Eval("Status")) %>' Font-Bold="true" ForeColor="Red" Visible='<%# (Eval("Status")=3) %>'></asp:Label>
            </ItemTemplate>
            <HeaderStyle Font-Bold="True" ForeColor="White" />

<ItemStyle Width="60px"></ItemStyle>
        </asp:TemplateField>
    </Columns>
    <FooterStyle BackColor="#660000" Font-Bold="True" ForeColor="White" />
    <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
    <HeaderStyle BackColor="#660000" Font-Bold="True" ForeColor="White" />
    <AlternatingRowStyle BackColor="White" />
</asp:GridView>
<asp:LinqDataSource ID="OnlineSODS" runat="server" 
    ContextTypeName="AgapeStaff.AgapeStaffDataContext" OrderBy="Status, Amount" 
    TableName="Agape_Main_Give_PPlans" 
    
    
    Where="StaffFinanceId == @StaffFinanceId" >
    <WhereParameters>
        <asp:ControlParameter ControlID="hfStaffFinanceId" Name="StaffFinanceId" 
            PropertyName="Value" Type="Int32" />
    </WhereParameters>
</asp:LinqDataSource>
<br />
<div class="Agape_Red_H3">Summary Info</div>
<br />
<table style="font-size: 10pt">
<tr>
    <td><b>Number of Regular Donors:</b> </td>
    <td><asp:Label ID="lblDonorCount" runat="server" ></asp:Label></td>
    <td> (excluding Cancelled Standing Orders)</td>
</tr>
<tr>
    <td><b>Monthly Average:</b> </td>
    <td><asp:Label ID="lblActive" runat="server" ></asp:Label></td>
    <td> (including Gift Aid, excluding Cancelled Standing Orders)</td>
</tr>

</table>