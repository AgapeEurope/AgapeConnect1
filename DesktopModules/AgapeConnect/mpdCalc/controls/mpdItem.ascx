<%@ Control Language="VB" AutoEventWireup="false" CodeFile="mpdItem.ascx.vb"
    Inherits="DotNetNuke.Modules.AgapeConnect.mpdItem" %>


<div class="control-group">
    <asp:Label ID="lblItemId" runat="server" class="version-number"></asp:Label>

     <asp:Label ID="lblItemName" runat="server" class="control-label" ></asp:Label>
    <asp:TextBox ID="tbEventName" runat="server" placeholder="Event Name"  class="control-label conf" Visible="false"></asp:TextBox>
    <div class="controls">
         

        <div  class="span2 mpdColumn">
            <div class="input-prepend">
                <asp:Label ID="lblCur" runat="server" class="add-on"></asp:Label>
                <asp:TextBox ID="tbMonthly" runat="server" placeholder="Monthly" class="mpdInput numeric monthly" Enabled="false"></asp:TextBox>
                 <asp:Panel  ID="pnlNetTax" runat="server"  class="net-tax" Visible="False">(+<asp:Label ID="lblNetTax" runat="server" CssClass="net-tax-month">0</asp:Label> tax)</asp:Panel>

                <asp:HiddenField ID="hfFormula" runat="server" Value="" />
            </div>

        </div>

        <div class="span2 mpdColumn">
            <div class="input-prepend">
                <asp:Label ID="lblCur2" runat="server" class="add-on" ></asp:Label>
                <asp:TextBox ID="tbYearly" runat="server" placeholder="Yearly" class="mpdInput numeric yearly" Enabled="false"></asp:TextBox>
                <asp:Panel  ID="pnlNetTax2" runat="server"  class="net-tax" Visible="False">(+<asp:Label ID="lblNetTax2" runat="server"  CssClass="net-tax-year">0</asp:Label> tax)</asp:Panel>
            </div>
        </div>

             <asp:Label ID="lblHelp" runat="server" class="help-inline mpd-help span5"></asp:Label>

    <asp:HyperLink ID="btnEdit" runat="server" CssClass="btn-edit" Visible="false">Edit</asp:HyperLink>

 
    </div>
    <div style="clear: both;" ></div>
    <asp:Panel ID="pnlEditItem" runat="server" class="alert alert-info mpd-edit" style="display: none;">
    This is a section

</asp:Panel>

</div>
