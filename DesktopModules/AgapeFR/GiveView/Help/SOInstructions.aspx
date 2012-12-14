<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SOInstructions.aspx.vb" Inherits="DesktopModules_Give_SOInstructions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
 <style type="text/css">
 .Agape_Red_H3{color: #660000;font-size: 18pt; font-family:  Verdana, Geneva, sans-serif; font-weight: bold ;}

 </style>

</head>
<body>
    <form id="form1" runat="server" style="font-family: Verdana ; font-size: 9pt;">
    <div>
    <fieldset  style="height: 230px;">
    <legend class="Agape_Red_H3">Online Banking</asp:Label>
</legend>
<asp:Label ID="lblOnlineBankingText" runat="server" resourcekey="lblOnlineBankingText"></asp:Label>
    <ol>
        <li>Login to your online banking. </li>
        <li>Go to the page to set up a new standing order.</li>
        <li>Input our bank details and the payment details as follows:
            <div align="center" style="font-size: 10pt">
                <table class="Agape_Body_Text">
                <tr><td>Pay to:</td><td><b>Agape Ministries Ltd</b></td></tr>
                    <tr><td align="left">A/C Number:</td><td><b>80240354</b></td></tr>
                    <tr><td align="left">Sort Code:</td><td><b>20-07-71</b></td></tr>
                    <tr><td align="left">Amount:</td><td><b>£<asp:Label ID="lblAmount" runat="server" /> <asp:Label ID="lblFreq" runat="server" /></b></td></tr>
                    <tr><td align="left">Reference*:</td><td>
                        <b><asp:Label ID="lblReference" runat="server" ></asp:Label></b></td></tr>
                </table>
            </div>
        </li>
    </ol>
    <div class="Agape_SubTitle">* The payee reference is essential as it allows us to recognise your donation when it reaches our bank account, and allocate it to the correct person/ministry.
    </div>
    </fieldset>
    </div>
    </form>
</body>
</html>
