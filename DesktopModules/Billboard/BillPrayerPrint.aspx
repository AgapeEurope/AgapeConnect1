<%@ Page Language="VB" AutoEventWireup="false" CodeFile="BillPrayerPrint.aspx.vb" Inherits="DesktopModules_Billboard_BillPrayerPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../Portals/0/AgapeStyles.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="BillTheme/BillStyle.css" />
</head>
<body>
    <form id="form1" runat="server">
    <div style="width:800px">
    <div style="text-align:left;">
    <img src="http://france.myagape.co.uk/DesktopModules/Billboard/Images/BillPrayer.gif" alt="Prayer Requests" />
    </div>
        <div style="text-align:right">
        <asp:Label ID="lblDate" runat="server" CssClass="Agape_SubTitle"></asp:Label>
        </div>
        <div class="Bill_dashed">&nbsp;</div>
        <asp:Label ID="lblMainOutput" runat="server" visible="false"></asp:Label>
        <div style="padding-left:5px;">
        <asp:PlaceHolder ID="phMain" runat="server"></asp:PlaceHolder>
        </div>
    </div>
    </form>
</body>
</html>
