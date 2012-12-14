<%@ Control Language="VB" AutoEventWireup="false" CodeFile="BillboardAlerts.ascx.vb" Inherits="DotNetNuke.Modules.Billboard.BillboardAlerts" %>
<link rel="stylesheet" type="text/css" href="/DesktopModules/Billboard/BillTheme/BillStyle.css" />
<div class="Bill_Rem_Top">&nbsp;</div>
<div class="Bill_Side_Middle">
<div style="width:160px; text-align:center; padding-left:20px; font-size:7pt;" class="Bill_Text_Side">
<asp:PlaceHolder ID="phMain" runat="server"></asp:PlaceHolder><br />
<asp:Label ID="lblError" runat="server" visible="false" ForeColor="Red"></asp:Label>
</div>
</div>
<div class="Bill_Side_Bottom">&nbsp;</div>
<br />