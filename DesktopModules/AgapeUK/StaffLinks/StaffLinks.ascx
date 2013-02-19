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
                $('#staffShortcuts').show().css({ 'height': '0px', 'width': '0px', 'opacity': '0.0' });
                $('#staffShortcuts').animate({ opacity: 1.0, height: "+=200", width: "+=500" }, 1000);
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
        $('#staffShortcuts').animate({opacity:0,height: 0, width: 0 }, 1000);
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
<div style="width: 500px; height: 200px;" id="staffShortcuts">
    <div style="text-align:right; width:100%;">
        <img style="cursor:pointer; width:20px;" src="../../../images/cancel.gif" onclick="closeStaffBox(); return false;" />
    </div>
</div>

