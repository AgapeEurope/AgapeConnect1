<%@ Control language="c#" CodeBehind="CustomerAdmin.ascx.cs" Inherits="DotNetNuke.Modules.Store.WebControls.CustomerAdmin" AutoEventWireup="True" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<table cellspacing="0" cellpadding="3" border="0" style="text-align:center;width:100%">
    <tr>
        <td>
            <table style="text-align:center">
                <tr>
                    <td class="SubHead" style="width:150px">
                        <dnn:label id="lblOrderNumber" runat="server" controlname="tbOrderNumber"></dnn:label>
                    </td>
                    <td>
                        <asp:TextBox id="tbOrderNumber" Width="100" runat="server" CssClass="NormalTextBox"></asp:TextBox>
                        <asp:Button id="btnSearch" CssClass="StandardButton" resourcekey="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                    </td>
                </tr>
                <tr>
                    <td class="SubHead" style="width:150px">
                        <dnn:label id="lblCustomers" runat="server" controlname="lstCustomers"></dnn:label>
                    </td>
                    <td>
                        <asp:DropDownList id="lstCustomers" Runat="server" CssClass="NormalTextBox" AutoPostBack="true"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="SubHead" style="width:150px">
                        <dnn:label id="lblOrderStatus" runat="server" controlname="lstOrderStatus"></dnn:label>
                    </td>
                    <td>
                        <asp:DropDownList id="lstOrderStatus" runat="server" CssClass="NormalTextBox" AutoPostBack="true"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align:center">
                        <asp:Label id="noOrdersFound" resourcekey="noOrdersFound" Text="No Order found for this criteria" CssClass="NormalRed" runat="server" Visible="false"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2">
            <asp:placeholder id="plhOrders" runat="server" Visible="False" />
        </td>
    </tr>
</table>
