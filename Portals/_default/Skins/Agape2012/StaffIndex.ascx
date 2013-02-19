<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>
<%@ Register TagPrefix="dnn" TagName="SEARCH" Src="~/Admin/Skins/Search.ascx" %>
<%@ Register TagPrefix="dnn" TagName="USER" Src="~/Admin/Skins/User.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGIN" Src="~/Admin/Skins/Login.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGO" Src="~/Admin/Skins/Logo.ascx" %>
<%@ Register TagPrefix="dnn" TagName="PRIVACY" Src="~/Admin/Skins/Privacy.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TERMS" Src="~/Admin/Skins/Terms.ascx" %>
<%@ Register TagPrefix="dnn" TagName="COPYRIGHT" Src="~/Admin/Skins/Copyright.ascx" %>
<%@ Register TagPrefix="dnn" TagName="NAV" Src="~/Admin/Skins/Nav.ascx" %>

<script src="/js/jquery.watermarkinput.js" type="text/javascript"></script>
<script type="text/javascript">
    (function ($, Sys) {
        function setUpWatermark() {
            $('#searchContainer input[type=text]').Watermark('Search');
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
            //$('#staffShortcuts').dialog({
            //    modal:true,
            //    autoOpen: false,
            //    title: 'Staff Shortcuts',
            //    show: 'fade',
            //    hide: 'fade'
            //});
            $('#scrollBtn').click(function () {
                $('#staffShortcuts').show("fold");
                $('outerContainer').append('<div class="ui-widget-overlay" style="width: 1423px; height: 1193px; z-index: 1001;"></div>');
            });
        }

        $(document).ready(function () {
            setUpWatermark();
            setUpScroller();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpWatermark();
                setUpScroller();
            });
        });
    }(jQuery, window.Sys));
</script>
<style type="text/css">
    .scroller {
        position: fixed !important;
        top: 50%;
        width: 30px;
        z-index: 9999;
        color:#fff;
        font-weight:700;
        font-size:12pt;
        background-color:#0180AB;
        padding-top:5px;
        padding-bottom:5px;
        cursor:pointer;
    }
    .scrollPanel {
        position: fixed !important;
        top: 50%;
        z-index: 9999;
        background-color:#fff;
        border:2px solid black;
    }
</style>
<div id="fb-root">
</div>
<script>        (function (d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s); js.id = id;
            js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));</script>
<div id="outerContainer" style="width: 100%; margin-left: 0px; margin-right: 0px;"
    align="center">
    <div id="scrollBtn">S<br />T<br />A<br />F<br />F</div>
    <div id="staffShortcuts">Hello World</div>
    <div id="innerContainer" style="width: 975px;">
        <!-- The Control Panel -->
        <div id="controlPanelContainer">
            <div id="ControlPanel" runat="server" />
        </div>
        <div style="text-align: right; height: 20px;">
            <span id="top_wrap">
                <div id="searchContainer">
                    <dnn:SEARCH runat="server" ID="dnnSEARCH" ShowSite="false" ShowWeb="false" CssClass="AgapeSearchBox" UseDropDownList="false" Submit="<img src=&quot;images/Search.gif&quot; border=&quot;0px&quot; alt=&quot;Search&quot; /&gt;" />
                </div>
                <dnn:USER runat="server" ID="dnnUSER" />
                &nbsp;|&nbsp;<dnn:LOGIN runat="server" ID="dnnLOGIN" />
                &nbsp;&nbsp;
                        <div class="fb-like" data-href="http://www.facebook.com/agapeuk" data-send="false"
                            data-layout="button_count" data-width="50" data-show-faces="false" data-font="verdana"
                            style="height: 100%; vertical-align: middle;">
                        </div>

            </span>
        </div>
        <br />
        <div style="text-align: left;">
            <dnn:LOGO runat="server" ID="dnnLOGO" />
        </div>
        <br />
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td align="right" valign="bottom">
                    <div id="menu">
                        <dnn:NAV runat="server" ID="dnnNAV" ProviderName="DDRMenuNavigationProvider" IndicateChildren="false" ControlOrientation="Horizontal" CSSControl="mainMenu" />
                    </div>
                </td>
            </tr>
        </table>
        <div class="mainContentContainer">
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="mainContentContainer">
                <tr valign="top">
                    <td class="ContentPane" id="ContentPane" runat="server" valign="top" align="center"></td>
                    <td class="RightPane" id="RightPane" runat="server" valign="top" align="center"></td>
                </tr>
            </table>
        </div>
        <div class="footer">
            <table width="100%" style="padding: 20px;">
                <tr>
                    <td width="65%" align="left">
                        <div class="Agape_White_Bold">
                            Contact Us
                        </div>
                        <br />
                        <table>
                            <tr>
                                <td valign="middle">
                                    <img alt="" src="/portals/_default/skins/agape2012/images/mailIcon.png" width="20px" />
                                </td>
                                <td valign="middle" class="Agape_White_Normal">3 Temple Row West, Birmingham, B2 5NY
                                </td>
                            </tr>
                            <tr>
                                <td valign="middle">
                                    <img alt="" src="/portals/_default/skins/agape2012/images/phoneIcon.png" width="20px" />
                                </td>
                                <td valign="middle" class="Agape_White_Normal">0121 765 4404
                                </td>
                            </tr>
                            <tr>
                                <td valign="middle">
                                    <img alt="" src="/portals/_default/skins/agape2012/images/EmailIcon.png" width="20px" />
                                </td>
                                <td valign="middle" class="Agape_White_Normal">info@agape.org.uk
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td valign="top" class="Agape_White_Normal" align="left">Agap&eacute; is a Christian charity dedicated to addressing the spiritual needs
                            of the UK by helping people to see, hear, understand and be forever changed by the person and claims of Jesus.
                    </td>
                </tr>
                <tr>
                    <td width="65%" class="Agape_White_Bold" style="font-size: 9pt;" align="left">
                        <br />
                        Agap&eacute; is a registered charity in England & Wales (no. 258421) and Scotland
                            (no. SC042332).
                    </td>
                    <td valign="bottom" class="Agape_White_Bold" align="right" style="font-size: 7pt !important;">
                        <dnn:PRIVACY runat="server" ID="dnnPRIVACY" />
                        &nbsp;&nbsp;|&nbsp;&nbsp;<dnn:TERMS runat="server" ID="dnnTERMS" />
                        &nbsp;&nbsp;|&nbsp;&nbsp;<a href="/Default.aspx?tabID=580"
                            target="_self" class="footer">Panel of Reference</a>
                    </td>
                </tr>
            </table>
            <div style="text-align: left; position: relative; bottom: 2px; left: 2px;" class="Agape_White_Normal">
                <dnn:COPYRIGHT runat="server" ID="dnnCOPYRIGHT" />
            </div>
        </div>

    </div>
</div>

