<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TestEmail.aspx.vb" Inherits="DesktopModules_Billboard_TestEmail" ClassName="DesktopModules_Billboard_TestEmail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="/DesktopModules/Billboard/BillTheme/BillStyle.css" />
</head>
<body>
    <form id="form1" runat="server">
    <fieldset>
    <legend>How the Email Should Look:</legend>
    <div>
        <asp:Label ID="lblTestRun" runat="server"></asp:Label>
        <asp:PlaceHolder ID="phMain" runat="server"></asp:PlaceHolder>
    </div>
    </fieldset>
    <br />
    <fieldset>
    <legend>HTML code:</legend>
    <asp:TextBox ID="tbOutHtml" runat="server" TextMode="MultiLine" Width="100%" Rows="6"></asp:TextBox>
    </fieldset>
    </form>
</body>
</html>
