<%@ Control Language="vb" AutoEventWireup="false" CodeFile="AccountSettings.ascx.vb" Inherits="DotNetNuke.Modules.Account.AccountSettings" %>
<%@ Register Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" TagPrefix="uc1" %>

<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx"%>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<asp:HiddenField ID="hfPortalId" runat="server" />
<table>
    <tr>
        <td><dnn:Label ID="Label2" runat="server" Text="Decimal Places" ResourceKey="lblDecimalPlaces"  /></td>
        <td>
           <asp:DropDownList ID="ddlNumberFormat" runat="server">
           <asp:ListItem Text="0 Decimal Places (eg. 1234)">  </asp:ListItem>
           <asp:ListItem Text="2 Decimal Places (eg. 1234.98)">  </asp:ListItem>
           <asp:ListItem Text="4 Decimal Places (eg. 1234.9876)">  </asp:ListItem>
           <asp:ListItem Text="Thousands with 0 Decimal Places (eg. 1K)">  </asp:ListItem>
           <asp:ListItem Text="Thousands with 1 Decimal Places (eg. 1.2K)">  </asp:ListItem>
           <asp:ListItem Text="Millions with 0 Decimal Places (eg. 1M)">  </asp:ListItem>
           <asp:ListItem Text="Millions with 1 Decimal Places (eg. 1.2M)">  </asp:ListItem>
           


        </asp:DropDownList>
        </td>
        
    </tr>

    
    <tr>
        <td><dnn:Label ID="lblPPP" runat="server" ResourceKey="lblPPP" Text="Personal Profile Properties"  /></td>
        <td>
            <fieldset>
                <asp:CheckBoxList ID="cblProfileProps" runat="server" RepeatColumns="2"></asp:CheckBoxList>
            </fieldset>
        </td>
    </tr>
    <tr>
        <td><dnn:Label ID="lblSPP" runat="server" ResourceKey="lblSPP" Text="Staff Profile Properties"  /></td>
        <td>
            <fieldset>
                <asp:CheckBoxList ID="cblStaffProps" runat="server" RepeatColumns="2"></asp:CheckBoxList>
            </fieldset>
        </td>
    </tr>
    <tr>
        <td><dnn:Label ID="Label3" runat="server" ResourceKey="lblReportsTo" Text="Display 'Reports To'" /></td>
        <td>
            <fieldset>
               <asp:CheckBox ID="cbReportsTo" runat="server" />
            </fieldset>
            
        </td>
    </tr>
</table>





<asp:LinkButton ID="SaveBtn" runat="server" ResourceKey="btnSave">Save</asp:LinkButton> &nbsp; <asp:LinkButton ID="CancelBtn" runat="server" ResourceKey="btnCancel">Cancel</asp:LinkButton>