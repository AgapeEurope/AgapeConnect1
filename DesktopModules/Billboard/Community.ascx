<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Community.ascx.vb" Inherits="DotNetNuke.Modules.Billboard.Community" %>
<%@ Register src="~/DesktopModules/Billboard/controls/Community.ascx" tagname="billComm" tagprefix="uc1" %>
<link rel="stylesheet" type="text/css" href="/DesktopModules/Billboard/BillTheme/BillStyle.css" />
<div style="text-align:left">
<div class="Bill_Comm_Top">&nbsp;</div>
<div class="Bill_Side_Middle">
<div style="width:160px; padding-left:20px;">
<%--    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>--%>
<uc1:billComm ID="billComm" runat="server" />
<%--</ContentTemplate>
</asp:UpdatePanel>--%>
</div>
</div>
<div class="Bill_Side_Bottom">&nbsp;</div>
</div>
<br />