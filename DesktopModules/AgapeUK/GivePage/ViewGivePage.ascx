<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ViewGivePage.ascx.vb" Inherits="DotNetNuke.Modules.AgapeUK.GivePage.ViewGivePage" %>
<script type='text/javascript' src='../../../js/softdivscroll.js'></script>

<div style="width: 675px; text-align: left; border-bottom:2px solid #EEE9E9; margin-bottom: 10px;">
    <a id="lA" runat="server">
        <span>a</span>
    </a>
    <a id="lB" runat="server">
        <span>b</span>
    </a>
    <a id="lC" runat="server">
        <span>c</span>
    </a>
    <a id="lD" runat="server">
        <span>d</span>
    </a>
    <a id="lE" runat="server">
        <span>e</span>
    </a>
    <a id="lF" runat="server">
        <span>f</span>
    </a>
    <a id="lG" runat="server">
        <span>g</span>
    </a>
    <a id="lH" runat="server">
        <span>h</span>
    </a>
    <a id="lI" runat="server">
        <span>i</span>
    </a>
    <a id="lJ" runat="server">
        <span>j</span>
    </a>
    <a id="lK" runat="server">
        <span>k</span>
    </a>
    <a id="lL" runat="server">
        <span>l</span>
    </a>
    <a id="lM" runat="server">
        <span>m</span>
    </a>
    <a id="lN" runat="server">
        <span>n</span>
    </a>
    <a id="lO" runat="server">
        <span>o</span>
    </a>
    <a id="lP" runat="server">
        <span>p</span>
    </a>
    <a id="lQ" runat="server">
        <span>q</span>
    </a>
    <a id="lR" runat="server">
        <span>r</span>
    </a>
    <a id="lS" runat="server">
        <span>s</span>
    </a>
    <a id="lT" runat="server">
        <span>t</span>
    </a>
    <a id="lU" runat="server">
        <span>u</span>
    </a>
    <a id="lV" runat="server">
        <span>v</span>
    </a>
    <a id="lW" runat="server">
        <span>w</span>
    </a>
    <a id="lX" runat="server">
        <span>x</span>
    </a>
    <a id="lY" runat="server">
        <span>y</span>
    </a>
    <a id="lZ" runat="server">
        <span>z</span>
    </a>
</div>

<div id="thisMainSection" style="overflow-y: hidden; height: 500px !important; text-align: left;">
    <asp:Repeater ID="dlLetters" runat="server">
        <ItemTemplate>
            <asp:Literal ID="Literal1" runat="server" Text='<%# MakeMeAnchor(Container.DataItem) %>'></asp:Literal>
            <br />
            <asp:Repeater ID="DataList1" runat="server" DataSource='<%# GetLetterData(Container.DataItem) %>'>
                <ItemTemplate>
                    <a href='<%# GiveToLink(Eval("StaffId"))%>' style="text-decoration: none !important;">
                        <div style="display: inline-block; padding-right: 10px;">
                            <img style="display: table-row;" src='<%# StaffBrokerFunctions.GetStaffJointPhoto(Eval("StaffId")) %>' width="150px" />
                            <div class="imageTitle" style="width: 150px;">
                                <asp:Label ID="Label1" runat="server" Text='<%# CreateDisplay(Eval("StaffId"))%>'></asp:Label>
                            </div>
                        </div>
                    </a>
                </ItemTemplate>
            </asp:Repeater>
            <br />
            <br />
        </ItemTemplate>
    </asp:Repeater>
</div>

<script type="text/javascript">
    new SoftDivScroll('thisMainSection');
</script>
