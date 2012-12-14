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
<%@ Register TagPrefix="dnn" TagName="MINICART" Src="~/DesktopModules/AgapeFR/Cart/SkinMinicart.ascx" %>

    <!-- The Control Panel -->
    <div id="controlPanelContainer">
        <div id="ControlPanel" runat="server" />
    </div>
    <div class="clearfloat" />
    <div id="firstbar">
        <div id="header">
        <table id="firstTable">
            <tr>
            <td>
            <dnn:LOGO runat="server" ID="dnnLOGO" />
            </td>
            <td>
                <div id="loginContainer">
                <dnn:USER runat="server" ID="dnnUSER" CssClass="user" />
                &nbsp;&nbsp;|&nbsp;&nbsp;<dnn:LOGIN runat="server" ID="dnnLOGIN" CssClass="user" />
                &nbsp;&nbsp;|&nbsp;&nbsp;Search:&nbsp;
            </div>
            </td>
            <td>
                <div id="searchContainer">
                    <dnn:SEARCH runat="server" ID="dnnSEARCH" CssClass="ServerSkinWidget" UseDropDownList="False" ShowWeb="False" ShowSite="False" Submit="<img src=&quot;images/search.gif&quot; border=&quot;0&quot; alt=&quot;Search&quot; /&gt;" />
                </div>
            </td>
            <td>
                <div class="LanguageMenu" style="float: right;">
                <dnn:LANGUAGE runat="server" ID="dnnLANGUAGE" ShowMenu="False" ShowLinks="True" />
            </div>
            </td>
           <td>
                <div class="minicartContainer">
                <dnn:MINICART runat="server" ID="dnnMINICART" />
            </div>
            </td>
            </tr>
        </table>
        </div>
        </div>
    <div id="secondbar">
        <div class="topMenu">
            <dnn:NAV runat="server" ID="dnnNAV" ProviderName="DNNMenuNavigationProvider" PopulateNodesFromClient="false" ExpandDepth="1" IndicateChildren="False" ControlOrientation="Horizontal" CSSNodeRoot="main_dnnmenu_rootitem" CSSNodeHoverRoot="main_dnnmenu_rootitem_hover" CSSNodeSelectedRoot="main_dnnmenu_rootitem_selected" CSSBreadCrumbRoot="main_dnnmenu_rootitem_selected" CSSContainerRoot="main_dnnmenu_container" CSSControl="main_dnnmenu_bar" CSSBreak="main_dnnmenu_break" />
        </div>
    </div>    
    <div id ="thirdbar">
        <div id="botMenu">
            <table id="breadcrumbTable">
                <tr>
                    <td>
                        <div id="siteBreadCrumb">
                            <dnn:BREADCRUMB runat="server" ID="dnnBREADCRUMB" CssClass="Breadcrumb" RootLevel="1" Separator="&nbsp;&nbsp;&nbsp;" />
                        </div>
                    </td>
                    <td>
                        <div id="thirdLevelMenu">
                            <dnn:NAV runat="server" ID="dnnNAV2" Level="child" ProviderName="DNNMenuNavigationProvider" PopulateNodesFromClient="false" ExpandDepth="1" IndicateChildren="False" ControlOrientation="Horizontal" CSSNodeRoot="main_dnnmenu_rootitem" CSSNodeHoverRoot="main_dnnmenu_rootitem_hover" CSSNodeSelectedRoot="main_dnnmenu_rootitem_selected" CSSBreadCrumbRoot="main_dnnmenu_rootitem_selected" CSSContainerRoot="main_dnnmenu_container" CSSControl="main_dnnmenu_bar" CSSBreak="main_dnnmenu_break" />
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div id="fourthbar">
        <table cellspacing="0" cellpadding="0" width="100%" class="mainContentContainer">
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
    </div>
    <div id="fifthbar">
        <div id="footerCentre">
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
        </div>
    </div>
















