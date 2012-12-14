<%@ Control Language="VB" AutoEventWireup="false" CodeFile="SOGetAdd.ascx.vb" Inherits="DotNetNuke.Modules.Give.SOGetAdd" %>

Please enter your address:
<table  style="font-size: 9pt;">
        <tr>
            <td>
                <b>Address 1:</b>
            </td>
            <td>
                <asp:TextBox ID="tbAddress1" runat="server"  Font-Size="9pt" Width="200px"></asp:TextBox> 
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="tbAddress1" ErrorMessage="Please enter your address" ValidationGroup="Register"  Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <b>Address 2:</b>
            </td>
            <td>
                <asp:TextBox ID="tbAddress2" runat="server" Font-Size="9pt"  Width="200px"></asp:TextBox> 
               
            </td>
        </tr>
        <tr>
            <td>
                <b>City:</b>
            </td>
            <td>
                <asp:TextBox ID="tbCity" runat="server" Font-Size="9pt" ></asp:TextBox>
               
            </td>
        </tr>
        <tr>
            <td>
                <b>County:</b>
               
            </td>
            <td>
                <asp:TextBox ID="tbCounty" runat="server" Font-Size="9pt" ></asp:TextBox>
            </td>
        </tr>
         <tr>
            <td>
                <b>Postcode:</b>
            </td>
            <td>
                <asp:TextBox ID="tbPostCode" runat="server" Font-Size="9pt" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="tbPostCode" ErrorMessage="Please enter your postcode" ValidationGroup="Register"  Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
       
</table>
 <asp:ValidationSummary ID="ValidationSummary1" runat="server"  ValidationGroup="Register"/>
 <asp:Label ID="lblRegisterError" runat="server" ForeColor="Red" Visible="false"></asp:Label><br />
  <asp:ImageButton ID="btnRegister" runat="server" ImageUrl="~/images/ButtonImages/ContinueS.gif"   
                            onmouseover = "this.src='/images/ButtonImages/ContinueS_f2.gif';"
                            onmouseout="this.src='/images/ButtonImages/ContinueS.gif';" AlternateText="Continue" ToolTip="Continue"    ValidationGroup="Register" />