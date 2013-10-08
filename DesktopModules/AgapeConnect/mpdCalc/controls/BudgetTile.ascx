<%@ Control Language="VB" AutoEventWireup="false" CodeFile="BudgetTile.ascx.vb" Inherits="DesktopModules_AgapeConnect_mpdCalc_controls_BudgetTile" %>
<style type="text/css">
    .tile {
        width:83%;
       
    }

</style>
<asp:HyperLink ID="hlTile" runat="server" Target="_self">
<asp:Panel ID="pnlTile" runat="server" class="alert tile">
<h4>
    <asp:Label ID="lblStaffName" runat="server" Font-Size="Medium" Text=""></asp:Label>

</h4>
  
    <table style="font-weight: bold; font-size: small;">
        <tr valign="middle" >
            <td width="60px" >From:</td>
            <td style="font-size: medium;">
                <asp:Label ID="lblStart" runat="server"></asp:Label>

            </td>
        </tr>
         <tr valign="middle">
            <td>Status:</td>
            <td style="font-size: medium;">
                 <asp:Label ID="lblStatus" runat="server" ></asp:Label>

            </td>
        </tr>
    </table>
    <asp:Label ID="lblNote" runat="server" ></asp:Label>

</asp:Panel>
</asp:HyperLink>


        