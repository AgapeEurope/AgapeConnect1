<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Controls.StaffLinks" CodeFile="StaffLinks.ascx.vb" %>
<script src="/js/jquery.watermarkinput.js" type="text/javascript"></script>
<script type="text/javascript">
    (function ($, Sys) {
        function setUpWaterMark2() {
            $('#staffSearch input[type=text]').Watermark('Search');
        }
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
            $('#scrollBtn').click(function (e) {
                e.stopPropagation();
                if ($('#modeBGrnd').length > 0) {
                    $('#staffShortcuts').hide();
                    $('#modeBGrnd').remove();
                }
                else {
                    var fullHeight = document.body.scrollHeight;
                    $('#staffShortcuts').fadeIn()
                    $('#outerContainer').append('<div id="modeBGrnd" class="ui-widget-overlay" style="z-index: 1001; height:' + fullHeight + 'px;"></div>');
                }
            });
            $('#staffShortcuts').click(function (e) {
                e.stopPropagation();
            });
            $(document).click(function () {
                if ($('#modeBGrnd').length > 0) {
                    $('#staffShortcuts').hide();
                    $('#modeBGrnd').remove();
                }
            });
        }

        $(document).ready(function () {
            setUpScroller();
            setUpWaterMark2();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpScroller();
                setUpWaterMark2();
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
    F<br />
    <br />
    S<br />
    H<br />
    O<br />
    R<br />
    T<br />
    C<br />
    U<br />
    T<br />
    S
</div>
<div id="staffShortcuts" style="min-width: 100px; padding: 5px;">
    <div style="padding: 10px; text-align: left; border-right: 1px solid #EEE9E9; display: table-cell; width: 200px;">
        <div class="Links_Panel_Header">
            <asp:Label ID="lblQuickAccess" runat="server" Text="Quick Access" resourcekey="lblQuickAccess"></asp:Label>
        </div>
        <br />
        <asp:Repeater ID="dRepeatLinks" runat="server" DataSourceID="dsLinks">
            <ItemTemplate>
                <div class="Agape_lBlue_H5" style="padding-left: 5px; padding-right: 5px; margin-bottom:7px;">
                    <a target='<%# whatTarget(Eval("NewWindow")) %>' href='<%# Eval("LinkURL")%>'>
                        <asp:Label ID="lblLinkText" runat="server" Text='<%# Eval("LinkName") %>'></asp:Label>
                    </a>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:LinqDataSource ID="dsLinks" runat="server" ContextTypeName="UK.StaffLink.StaffLinkDataContext" EntityTypeName="" OrderBy="SortOrder" Select="new (NewWindow, LinkURL, LinkName, SortOrder, StaffLinkId)" TableName="Agape_Staff_Links">
        </asp:LinqDataSource>
        <br />
        <div style="padding-left: 5px; padding-right: 5px;">
            <asp:Label ID="lblNote" CssClass="Links_Subtitle" runat="server" Text="NB. All staff options are available in the Staff menu at the top of the page." resourcekey="lblNote"></asp:Label>
        </div>
    </div>
    <div style="display: table-cell; vertical-align: top; padding: 10px; width: 200px;">
        <div class="Links_Panel_Header">
            <asp:Label ID="lblStaffSearch" runat="server" Text="Search Staff Directory" resourcekey="lblStaffSearch"></asp:Label>
        </div>
        <br />
        <div id="staffSearch" class="Links_Search_Box" style="text-align: center;">
            <asp:TextBox ID="tbStaffSearch" runat="server" CssClass="NormalTextBox"></asp:TextBox>
            <asp:LinkButton ID="btnStaffSearch" runat="server" CssClass="AgapeSearchBox" CausesValidation="False">
                <img src="/Portals/_default/Skins/Agape2012/images/Search.gif" alt="" />
            </asp:LinkButton>
        </div>
        <br />
        <div class="Links_Panel_Header">
            <asp:Label ID="lblUpcomingEvents" runat="server" Text="Key Dates" resourcekey="lblUpcomingEvents"></asp:Label>
        </div>
        <br />
        <div style="text-align: left;">
            <asp:Repeater ID="rptDates" runat="server" DataSourceID="dsEvents">
                <ItemTemplate>
                    <asp:Label ID="lblEventName" runat="server" Text='<%# Eval("EventName") %>' CssClass="Agape_lBlue_H5"></asp:Label><br />
                    <asp:Label ID="lblEventDate" runat="server" Text='<%# addLine(Eval("EventDate"))%>'></asp:Label>
                    <asp:Label ID="lblEventLocation" runat="server" Text='<%# addLine(Eval("EventLocation")) %>' CssClass="Links_Event_Subtitle"></asp:Label>
                    <br />
                </ItemTemplate>
            </asp:Repeater>
            <asp:LinqDataSource ID="dsEvents" runat="server" ContextTypeName="UK.StaffLink.StaffLinkDataContext" EntityTypeName="" OrderBy="SortOrder" TableName="Agape_Staff_Events">
            </asp:LinqDataSource>
        </div>
    </div>
    <div style="display: block; text-align: right;" class="Agape_Blue_H5_Thin">
        <a href="" onclick="closeStaffBox(); return false;">Close</a>
    </div>
</div>

