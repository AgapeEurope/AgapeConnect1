<%@ Control Language="VB" AutoEventWireup="false" CodeFile="RmbMobile.ascx.vb" Inherits="controls_RmbLandline" ClassName="controls_RmbLandline"  %>
<%@ Register assembly="DotNetNuke" namespace="DotNetNuke.UI.WebControls" tagprefix="cc1" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register src="Currency.ascx" tagname="Currency" tagprefix="uc1" %>

<div class="Agape_SubTitle"> <asp:HiddenField ID="hfNoReceiptLimit" runat="server" Value="0" />
    <asp:Label ID="Label5" runat="server" Font-Italic="true" ForeColor="Gray" resourcekey="Explanation"></asp:Label> 
</div><br />

<table  style="font-size:9pt;">
<tr>
    <td><b><dnn:label id="Label4"  runat="server" controlname="tbDesc" ResourceKey="lblDesc"  /></b></td>
    <td><asp:TextBox ID="tbDesc" runat="server" Width="550px"></asp:TextBox></td>
</tr>
<tr>
     <td><b><dnn:label id="Label1"  runat="server" controlname="dtDate" ResourceKey="lblDate"  /></b></td>
    <td  colspan="2">
       <asp:TextBox ID="dtDate" runat="server" Width="90px" class="datepicker"></asp:TextBox>
       
    </td>
</tr>
<tr>
   <td><b><dnn:label id="Label2"  runat="server" controlname="tbAmount" ResourceKey="lblAmount"  /></b></td>
    <td><table>
                <tr>
                    <td>
                        <asp:TextBox ID="tbAmount" runat="server" Width="90px" class="numeric rmbAmount"></asp:TextBox>
                    </td>
                    <td>
                        <uc1:Currency ID="Currency1" runat="server" />
                    </td>
                </tr>
            </table></td>
</tr>
<tr  id="ReceiptLine" runat="server">
    <td><b><dnn:label id="Label3"  runat="server" controlname="ddlVATReceipt" ResourceKey="lblReceipt" /></b></td>
    <td>
        <asp:DropDownList ID="ddlVATReceipt" runat="server"  CssClass="ddlReceipt">
            <asp:ListItem ResourceKey="VAT" Value="0">VAT</asp:ListItem>
            <asp:ListItem ResourceKey="Standard" Value="1">Standard</asp:ListItem>
            <asp:ListItem  Value="2" ResourceKey="Electronic">Electronic Receipt</asp:ListItem>
            
        </asp:DropDownList>
        
        <br />
<asp:CheckBox ID="cbTaxable" runat="server" ResourceKey="notTaxable" Text="I have an itemized bill and have only reimbursed the ministry calls (as I have highlighted on the bill)"  />
    </td>
   
</tr>
</table>
 <asp:Label ID="ErrorLbl" runat="server" Font-Size="9pt" ForeColor="Red" />

