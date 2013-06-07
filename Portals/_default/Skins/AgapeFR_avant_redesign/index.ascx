<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>
<%@ Register TagPrefix="dnn" TagName="LOGO" Src="~/Admin/Skins/Logo.ascx" %>
<%@ Register TagPrefix="dnn" TagName="MINICART" Src="~/DesktopModules/AgapeFR/Cart/SkinMinicart.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LANGUAGE" Src="~/Admin/Skins/Language.ascx" %>
<%@ Register TagPrefix="dnn" TagName="USER" Src="~/Admin/Skins/User.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGIN" Src="~/Admin/Skins/Login.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SEARCH" Src="~/Admin/Skins/Search.ascx" %>
<%@ Register TagPrefix="dnn" TagName="NAV" Src="~/Admin/Skins/Nav.ascx" %>
<%@ Register TagPrefix="dnn" TagName="PRIVACY" Src="~/Admin/Skins/Privacy.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TERMS" Src="~/Admin/Skins/Terms.ascx" %>
<%@ Register TagPrefix="dnn" TagName="COPYRIGHT" Src="~/Admin/Skins/Copyright.ascx" %>
<%@ Register TagPrefix="ddr" Namespace="DotNetNuke.Web.DDRMenu.TemplateEngine" Assembly="DotNetNuke.Web.DDRMenu" %>
<%@ Register TagPrefix="ddr" TagName="MENU" src="~/DesktopModules/DDRMenu/Menu.ascx" %>

<div id="wrap">
    <!-- The Control Panel -->
    <div id="controlPanelContainer">
        <div id="ControlPanel" runat="server" />
    </div>
    <div id="firstbar">
        <div id="header">
            <div id="logo">
                <dnn:LOGO runat="server" ID="dnnLOGO" />
            </div>
            <div id="minicartContainer">
                <dnn:MINICART runat="server" ID="dnnMINICART" />
            </div>
            <div id="langcont" style="float: right;">
                <dnn:LANGUAGE runat="server" ID="dnnLANGUAGE" ShowMenu="False" ShowLinks="True" />
            </div>
            <div id="reglogsearch">
                <dnn:USER runat="server" ID="dnnUSER" CssClass="user" />
                &nbsp;&nbsp;|&nbsp;&nbsp;<dnn:LOGIN runat="server" ID="dnnLOGIN" CssClass="user" />
                &nbsp;&nbsp;|&nbsp;&nbsp;Search:&nbsp;<dnn:SEARCH runat="server" ID="dnnSEARCH" CssClass="ServerSkinWidget" UseDropDownList="False" ShowWeb="False" ShowSite="False" Submit="<img src=&quot;images/search.gif&quot; border=&quot;0&quot; alt=&quot;Search&quot; /&gt;" />
            </div>
        </div>
    </div>
    <div id="secondbar">
        <div class="topMenu">
            <ddr:MENU ID="MENU1" MenuStyle="/templates/AgapeFRMenu/" NodeSelector="RootOnly" runat="server" />
            <%--<dnn:NAV runat="server" ID="dnnNAV" ProviderName="DNNMenuNavigationProvider" IndicateChildren="True" IndicateChildImageRoot="/images/1x1.GIF" IndicateChildImageSub="/images/action_right.gif" ControlOrientation="Horizontal" CSSNodeRoot="main_dnnmenu_rootitem" CSSNodeHoverRoot="main_dnnmenu_rootitem_hover" CSSNodeSelectedRoot="main_dnnmenu_rootitem_selected" CSSBreadCrumbRoot="main_dnnmenu_rootitem_selected" CSSContainerSub="main_dnnmenu_submenu" CSSNodeHoverSub="main_dnnmenu_itemhover" CSSNodeSelectedSub="main_dnnmenu_itemselected" CSSContainerRoot="main_dnnmenu_container" CSSControl="main_dnnmenu_bar" CSSBreak="main_dnnmenu_break" />--%>
        </div>
    </div>
    <div id="thirdbar">
        <div id="botMenu">
            <ddr:MENU ID="MENU2" MenuStyle="/templates/AgapeFRMenu/" NodeSelector="RootChildren" runat="server" />
            <%--<dnn:NAV runat="server" ID="dnnNAV2" Level="child" ProviderName="DNNMenuNavigationProvider" PopulateNodesFromClient="false" ExpandDepth="1" IndicateChildren="False" ControlOrientation="Horizontal" CSSNodeRoot="main_dnnmenu_rootitem" CSSNodeHoverRoot="main_dnnmenu_rootitem_hover" CSSNodeSelectedRoot="main_dnnmenu_rootitem_selected" CSSBreadCrumbRoot="main_dnnmenu_rootitem_selected" CSSContainerRoot="main_dnnmenu_container" CSSControl="main_dnnmenu_bar" CSSBreak="main_dnnmenu_break" />--%>
        </div>
    </div>
    <div id="fourthbar">
        <div id="ContentContainer">
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
        </div>
    </div>
</div>
<div id="fifthbar">
    <div id="footerCentre">
        <div style="text-align: Left; color: #FFF; margin-left: 15px;" class="footer">
            <dnn:PRIVACY runat="server" ID="dnnPRIVACY" CssClass="footer" />
            &nbsp;&nbsp;|&nbsp;&nbsp;<dnn:TERMS runat="server" ID="dnnTERMS" CssClass="footer" />
            &nbsp;&nbsp;|&nbsp;&nbsp;<dnn:COPYRIGHT runat="server" ID="dnnCOPYRIGHT" CssClass="footer" />
        </div>
    </div>
</div>

