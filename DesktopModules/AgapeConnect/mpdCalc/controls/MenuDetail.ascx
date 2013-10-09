<%@ Control Language="VB" AutoEventWireup="false" CodeFile="MenuDetail.ascx.vb" Inherits="DesktopModules_AgapeConnect_mpdCalc_controls_MenuDetail" %>
<%@ Register Src="~/DesktopModules/AgapeConnect/mpdCalc/controls/BudgetTile.ascx" TagPrefix="uc1" TagName="BudgetTile" %>

<style type="text/css">
  

</style>
<asp:HiddenField ID="hfStaffId" runat="server" />
<asp:HiddenField ID="hfMpdDefId" runat="server" />
<asp:HiddenField ID="hfEditUrl" runat="server" />
<asp:HiddenField ID="hfPortalId" runat="server" />
<asp:HiddenField ID="hfCurrentBudgetId" runat="server"  Value ="-1"/>
<h2>
    <asp:Label ID="lblDisplayName" runat="server" Text="Label"></asp:Label></h2>

<div class="row-fluid">
    <div class="span7">
       
        <asp:Repeater ID="rpMyBudgets" runat="server">
            <ItemTemplate>
        
                <uc1:budgettile runat="server" id="BudgetTile" MpdGoal='<%#Eval("TotalBudget")%>' staffid='<%#Eval("StaffId")%>' from='<%#Eval("BudgetPeriodStart")%>' status='<%#Eval("Status")%>' navigateurl='<%# EditURL & "?sb=" & Eval("StaffBudgetId")%>' expired='<%# getExpired(Eval("Status"), Eval("StaffBudgetId"))%>'  />
            </ItemTemplate>

        </asp:Repeater>

    </div>
    <div class="span5"   >   
        <table style="font-size: large;" cellpadding="5px">
            <tr style="font-weight: bold;">
                <td align="right">Support Level:</td>
                <td>
                    <asp:Label ID="lblSupportLevel" runat="server" Font-Size="X-Large" CssClass="sLevel"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right">Current MPD Goal:</td>
                <td>
                    <asp:Label ID="lblMPDGoal" runat="server"  ></asp:Label>
                </td>
            </tr>
             <tr>
                <td align="right">Account Balance:</td>
                <td>
                    <asp:Label ID="lblAccountBalance" runat="server" ></asp:Label>
                </td>
            </tr>
        </table>
        <div style="width:90%; padding: 10px;">
        <asp:Button ID="btnViewCurrentBudget" runat="server" width="100%" class="btn detail-button" Text="View Current Budget" Visible="False" />
        <asp:Button ID="btnViewReport" runat="server" width="100%" class="btn  detail-button" Text="View Detailed Report" />
        <asp:Button ID="btnCreateNewBudget" runat="server" width="100%" class="btn btn-primary detail-button" Text="Start New Budget" Visible="false" /></div>
    </div>
</div>
