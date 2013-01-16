<%@ Control language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>
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

            $(document).ready(function () {
                setUpWatermark();
                Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                    setUpWatermark();
                });
            });
        }(jQuery, window.Sys));
    </script>
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
        <div id="innerContainer" style="width: 975px;">
            <!-- The Control Panel -->
            <div id="controlPanelContainer">
                <div id="ControlPanel" runat="server" />
            </div>
            <div style="text-align: right; height: 20px;">
                <span id="top_wrap">
                    <div id="searchContainer">
                        <dnn:SEARCH runat="server" id="dnnSEARCH" ShowSite="false" ShowWeb="false" CssClass="AgapeSearchBox" UseDropDownList="false" submit="<img src=&quot;images/Search.gif&quot; border=&quot;0px&quot; alt=&quot;Search&quot; /&gt;"/>
                    </div>
                    <dnn:USER runat="server" id="dnnUSER" />&nbsp;|&nbsp;<dnn:LOGIN runat="server" id="dnnLOGIN" />&nbsp;&nbsp;
                        <div class="fb-like" data-href="http://www.facebook.com/agapeuk" data-send="false"
                            data-layout="button_count" data-width="50" data-show-faces="false" data-font="verdana"
                            style="height: 100%; vertical-align: middle;">
                        </div>

                </span>
            </div>
            <br />
            <div style="text-align: left;">
                <dnn:LOGO runat="server" id="dnnLOGO" />
            </div>
            <br />
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="right" valign="bottom">
                        <div id="menu">
                            <dnn:NAV runat="server" id="dnnNAV"  ProviderName="DDRMenuNavigationProvider" IndicateChildren="false" ControlOrientation="Horizontal" CSSControl="mainMenu" />
                        </div>
                    </td>
                </tr>
            </table>
            <div class="mainContentContainer">
                <table cellspacing="0" cellpadding="0" border="0" width="100%" class="mainContentContainer">
                    <tr valign="top">
                        <td class="ContentPane" id="TopContentPane" runat="server" valign="top" align="center"></td>
                        <td class="RightPane" id="TopRightPane" runat="server" valign="top" align="center"></td>
                    </tr>
                    <tr valign="top">
                        <td colspan="2" valign="top" align="center">
                            <table width="100%" cellspacing="0" cellpadding="0" border="0">
                                <tr>
                                    <td class="LeftPane" id="LeftPane" runat="server" valign="top" align="center"></td>
                                    <td class="ContentPane" id="ContentPane" runat="server" valign="top" align="center"></td>
                                    <td class="RightPane" id="RightPane" runat="server" valign="top" align="center"></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="ContentPane" id="BottomContentPane" runat="server" valign="top" align="center"></td>
                        <td class="RightPane" id="BottomRightPane" runat="server" valign="top" align="center"></td>
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
                        <td valign="bottom" class="Agape_White_Bold" align="right" style="font-size: 7pt;"><dnn:PRIVACY runat="server" id="dnnPRIVACY" />&nbsp;&nbsp;|&nbsp;&nbsp;<dnn:TERMS runat="server" id="dnnTERMS" />&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/Default.aspx?tabID=580"
                            target="_self" class="footer">Panel of Reference</a>
                        </td>
                    </tr>
                </table>
                <div style="text-align: left; position: relative; bottom: 2px; left: 2px;" class="Agape_White_Normal">
                    <dnn:COPYRIGHT runat="server" id="dnnCOPYRIGHT" />
                </div>
            </div>

        </div>
    </div>

