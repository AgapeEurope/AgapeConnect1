<%@ Control Language="vb" AutoEventWireup="false" CodeFile="CartSettings.ascx.vb" Inherits="DotNetNuke.Modules.AgapeFR.Cart.CartSettings" %>

<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<table>
   
    <tr>
        <td><dnn:Label ID="Label3" runat="server" ResourceKey="lblEnableVAT" Text="Enable VAT" /></td>
        <td>
           
               <asp:CheckBox ID="cbEnableVAT" runat="server" />
           
            
        </td>
    </tr>
</table>





<asp:LinkButton ID="SaveBtn" runat="server" ResourceKey="btnSave">Save</asp:LinkButton> &nbsp; <asp:LinkButton ID="CancelBtn" runat="server" ResourceKey="btnCancel">Cancel</asp:LinkButton>