<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Controls.StaffLinks" CodeFile="StaffLinks.ascx.vb" %>
<script type="text/javascript">
    (function ($, Sys) {
        function setUpScroller() {
            var thisLeft = '0px';
            $('#scrollBtn').addClass('scroller');
            $('#staffShortcuts').addClass('scrollPanel');
            var ultLeft = ((parseInt($('#outerContainer').width()) - parseInt($('#innerContainer').width())) / 2) - parseInt($('#scrollBtn').width());
            thisLeft = String(ultLeft) + 'px';
            panelLeft = ultLeft + parseInt($('#scrollBtn').width());
            $('#scrollBtn').css('left', thisLeft);
            $('#staffShortcuts').css('left', panelLeft);
            $('#staffShortcuts').hide();
            $('#scrollBtn').click(function () {
                var fullHeight = document.body.scrollHeight;
                $('#staffShortcuts').fadeIn()
                $('#outerContainer').append('<div id="modeBGrnd" class="ui-widget-overlay" style="z-index: 1001; height:' + fullHeight + 'px;"></div>');
            });
        }

        $(document).ready(function () {
            setUpScroller();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpScroller();
            });
        });
    }(jQuery, window.Sys));
    function closeStaffBox() {
        $('#staffShortcuts').hide();
        $('#modeBGrnd').remove();
    }
</script>
<div id="scrollBtn">
    S<br />
    T<br />
    A<br />
    F<br />
    F
</div>
<div id="staffShortcuts" style="min-width: 100px;">
    <div style="text-align: right; width: 100%;">
        <img style="cursor: pointer; width: 20px;" src="../../../images/cancel.gif" onclick="closeStaffBox(); return false;" />
    </div>
    <div style="padding: 10px; text-align:left;">
        <asp:Repeater ID="dRepeatLinks" runat="server" DataSourceID="dsLinks">
            <ItemTemplate>
                <div class="Agape_Orange_H4">
                    <a target='<%# whatTarget(Eval("NewWindow")) %>' href='<%# Eval("LinkURL")%>'>
                        <asp:Label ID="lblLinkText" runat="server" Text='<%# Eval("LinkName") %>'></asp:Label>
                    </a>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <asp:LinqDataSource ID="dsLinks" runat="server" ContextTypeName="UK.StaffLink.StaffLinkDataContext" EntityTypeName="" OrderBy="SortOrder" Select="new (NewWindow, LinkURL, LinkName, SortOrder, StaffLinkId)" TableName="Agape_Staff_Links">
    </asp:LinqDataSource>

</div>

