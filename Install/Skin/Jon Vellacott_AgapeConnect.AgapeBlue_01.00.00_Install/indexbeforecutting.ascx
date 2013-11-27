<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>
<%@ Register TagPrefix="dnn" TagName="LANGUAGE" Src="~/Admin/Skins/Language.ascx" %>
<%@ Register TagPrefix="dnn" TagName="NAV" Src="~/Admin/Skins/Nav.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGO" Src="~/Admin/Skins/Logo.ascx" %>
<%@ Register TagPrefix="dnn" TagName="AGAPEICONS" Src="~/DesktopModules/AgapeConnect/AgapeIconAdmin/AgapeIcons.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TEXT" Src="~/Admin/Skins/Text.ascx" %>
<%@ Register TagPrefix="dnn" TagName="BREADCRUMB" Src="~/Admin/Skins/BreadCrumb.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SEARCH" Src="~/Admin/Skins/Search.ascx" %>
<%@ Register TagPrefix="dnn" TagName="USER" Src="~/Admin/Skins/User.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGIN" Src="~/Admin/Skins/Login.ascx" %>
<%@ Register TagPrefix="dnn" TagName="PRIVACY" Src="~/Admin/Skins/Privacy.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TERMS" Src="~/Admin/Skins/Terms.ascx" %>
<%@ Register TagPrefix="dnn" TagName="COPYRIGHT" Src="~/Admin/Skins/Copyright.ascx" %>

<div id="outerContainer" style="width: 100%; margin-left: 0px; margin-right: 0px;"
    align="center">
    <div id="innerContainer" style="width: 1100px;">
        <!-- The Control Panel -->
        <div id="controlPanelContainer">
            <div id="ControlPanel" runat="server" />
        </div>
        <div class="clearfloat" />
        <table cellpadding="0" cellspacing="0" style="width: 100%; background-color: #FFF; -moz-border-radius-bottomleft: 15px; -moz-border-radius-bottomright: 15px; -moz-border-radius-topleft: 3px; -moz-border-radius-topright: 3px;">
            <tr>
                <td class="mastheadLeft" style="width: 25px;">&nbsp;
                </td>
                <td>
                    <div>
                        <table width="100%">
                            <tr>
                                <td align="left">
                                    <dnn:LOGO runat="server" ID="dnnLOGO" />
                                </td>

                                <td width="100%">
                                    <div id="searchContainer">
                                        <dnn:SEARCH runat="server" ID="dnnSEARCH" CssClass="ServerSkinWidget" UseDropDownList="False" ShowWeb="False" ShowSite="False" Submit="<img src=&quot;images/search.gif&quot; border=&quot;0&quot; alt=&quot;Search&quot; /&gt;" />
                                    </div>
                                    <div id="loginContainer">
                                        <dnn:USER runat="server" ID="dnnUSER" CssClass="user" />
                                        &nbsp;&nbsp;|&nbsp;&nbsp;<dnn:LOGIN runat="server" ID="dnnLOGIN" CssClass="user" />
                                        &nbsp;&nbsp;|&nbsp;&nbsp;Search:
                                    </div>
                                    <div class="LanguageMenu" style="float: right;">
                                        <dnn:LANGUAGE runat="server" ID="dnnLANGUAGE" ShowMenu="False" ShowLinks="True" />
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
                <td class="mastheadRight">&nbsp
                </td>
            </tr>
            <tr>
                <td class="headerLeft"></td>
                <td class="headerRepeat">
                    <div style="text-align: center; color: #FFF;" class="theMenu">
                        <dnn:NAV runat="server" ID="dnnNAV" ProviderName="DNNMenuNavigationProvider" PopulateNodesFromClient="false" ExpandDepth="1" IndicateChildren="False" ControlOrientation="Horizontal" CSSNodeRoot="main_dnnmenu_rootitem" CSSNodeHoverRoot="main_dnnmenu_rootitem_hover" CSSNodeSelectedRoot="main_dnnmenu_rootitem_selected" CSSBreadCrumbRoot="main_dnnmenu_rootitem_selected" CSSContainerRoot="main_dnnmenu_container" CSSControl="main_dnnmenu_bar" CSSBreak="main_dnnmenu_break" />
                    </div>
                </td>
                <td class="headerRight"></td>
            </tr>
            <tr>
                <td class="breadcrumbLeft">&nbsp
                </td>
                <td class="breadcrumbCentre">
                    <div id="breadcrumbContainer">
                        <span><dnn:BREADCRUMB runat="server" ID="dnnBREADCRUMB" CssClass="Breadcrumb" RootLevel="1" Separator=" " />
                        </span>
                    </div>
                    <dnn:NAV runat="server" ID="NAV2" Level="Child" ProviderName="DNNMenuNavigationProvider" PopulateNodesFromClient ="false" ExpandDepth="1" IndicateChildren="False" ControlOrientation="Horizontal" CSSNodeRoot="main_dnnmenu_rootitem" CSSNodeHoverRoot="main_dnnmenu_rootitem_hover" CSSNodeSelectedRoot="main_dnnmenu_rootitem_selected" CSSBreadCrumbRoot="main_dnnmenu_rootitem_selected" CSSContainerRoot="main_dnnmenu_container" CSSControl="main_dnnmenu_bar" CSSBreak="main_dnnmenu_break" />
                </td>
                <td class="breadcrumbRight">&nbsp
                </td>
            </tr>
            <tr>
                <td class="mainLeft">&nbsp
                </td>
                <td class="mainContentContainer">
                    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="mainContentContainer">
                        <tr>
                            <td class="TopPane" colspan="3" id="TopPane" runat="server" valign="top">&nbsp;
                            </td>
                        </tr>
                        <tr valign="top">
                            <td class="LeftPane" id="LeftPane" runat="server" valign="top">&nbsp;
                            </td>
                            <td class="ContentPane" id="ContentPane" runat="server" valign="top">&nbsp;
                            </td>
                            <td class="RightPane" id="RightPane" runat="server" valign="top">&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="BottomPane" colspan="3" id="BottomPane" runat="server" valign="top">&nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="mainRight">&nbsp
                </td>
            </tr>
            <tr>
                <td class="footerLeft"></td>
                <td class="footerCentre">
                    <div style="float: right;">

                        <!-- AddThis Button BEGIN -->

                        <!--    <a class="addthis_button" href="https://s7.addthis.com/bookmark.php?v=250&amp;pub=xa-4b1a779754ae866e">
                                <img src="https://s7.addthis.com/static/btn/v2/lg-share-en.gif" width="125" height="16"
                                    alt="Bookmark and Share" style="border: 0" /></a><script type="text/javascript" src="https://s7.addthis.com/js/250/addthis_widget.js#pub=xa-4b1a779754ae866e"></script>
                       -->
                        <!-- AddThis Button END -->
                    </div>
                    <div style="text-align: Left; color: #FFF; margin-left: 15px;" class="footer">
                        <dnn:PRIVACY runat="server" ID="dnnPRIVACY" CssClass="footer" />
                        &nbsp;&nbsp;|&nbsp;&nbsp;<dnn:TERMS runat="server" ID="dnnTERMS" CssClass="footer" />
                        &nbsp;&nbsp;|&nbsp;&nbsp;<dnn:COPYRIGHT runat="server" ID="dnnCOPYRIGHT" CssClass="footer" />
                    </div>
                    <div style="clear: both;" />
                </td>
                <td class="footerRight"></td>
            </tr>
        </table>
    </div>
</div>

