<%@ Control language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>
<%@ Register TagPrefix="dnn" TagName="LOGO" Src="~/Admin/Skins/Logo.ascx" %>
<%@ Register TagPrefix="dnn" TagName="NAV" Src="~/Admin/Skins/Nav.ascx" %>
<%@ Register TagPrefix="dnn" TagName="USER" Src="~/Admin/Skins/User.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGIN" Src="~/Admin/Skins/Login.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SEARCH" Src="~/Admin/Skins/Search.ascx" %>
<%@ Register TagPrefix="dnn" TagName="COPYRIGHT" Src="~/Admin/Skins/Copyright.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TERMS" Src="~/Admin/Skins/Terms.ascx" %>
<%@ Register TagPrefix="dnn" TagName="PRIVACY" Src="~/Admin/Skins/Privacy.ascx" %>

    <div id="outerContainer" class="outerContainer" align="center">
        <div id="innerContainer" class="innerContainer">
            <!-- The Control Panel -->
            <div id="controlPanelContainer">
                <div id="ControlPanel" runat="server" />
            </div>
            
            <div id="Header">
                <table width="100%">
                    <tr>
                        <td align="left">
                            <dnn:LOGO runat="server" id="dnnLOGO" />
                        </td>
                        <td width="100%">
                            <div align="right">
                                <dnn:NAV runat="server" id="dnnNAV" ProviderName="DNNMenuNavigationProvider" IndicateChildren="True" IndicateChildImageRoot="/images/1x1.GIF" IndicateChildImageSub="/images/action_right.gif" ControlOrientation="Horizontal" CSSNodeRoot="main_dnnmenu_rootitem" CSSNodeHoverRoot="main_dnnmenu_rootitem_hover" CSSNodeSelectedRoot="main_dnnmenu_rootitem_selected" CSSBreadCrumbRoot="main_dnnmenu_rootitem_selected" CSSContainerSub="main_dnnmenu_submenu" CSSNodeHoverSub="main_dnnmenu_itemhover" CSSNodeSelectedSub="main_dnnmenu_itemselected" CSSContainerRoot="main_dnnmenu_container" CSSControl="main_dnnmenu_bar" CSSBreak="main_dnnmenu_break" /></div>
                            <div align="right">
                                <div style="float: right;">
                                    <dnn:SEARCH runat="server" id="dnnSEARCH" CssClass="ServerSkinWidget" UseDropDownList="True" ShowWeb="False" ShowSite="False" submit="<img src=&quot;images/SearchIcon.gif&quot; border=&quot;0&quot; alt=&quot;Search&quot; /&gt;" />
                                </div>
                                <div style="clear: both; " />
                                <dnn:USER runat="server" id="dnnUSER" CssClass="user" />&nbsp; &nbsp;<dnn:LOGIN runat="server" id="dnnLOGIN" CssClass="user" />
                            
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="mainContainer" >
                <table cellspacing="0" cellpadding="0" border="0" width="100%"  id="mainContentContainer">
                    <tr>
                        <td id="TopLeft" class="TopLeft" runat="server" height="320px" valign="top"></td>
                        <td  id="ContentPane" class="contentPane" runat="server" height="320px"  valign="top"></td>
                    </tr>
                    <tr>
                        <td  id="BottomLeft" class="BottomLeft" runat="server"  height="320px" valign="top"></td>
                        <td id="BottomRight" class="BottomRight" runat="server"  height="300px"  valign="top"></td>
                        
                    </tr>

                </table>
                
            </div>
            <div style="width: 100%; direction:rtl ;   ">
                <div class="SocialNetworking">
                <!-- AddThis Button BEGIN -->
<%--<div class="addthis_toolbox addthis_default_style "  style="margin-left: 80px; margin-top:5px; width:100%;">
<a class="addthis_button_preferred_1"></a>
<a class="addthis_button_preferred_2"></a>
<a class="addthis_button_preferred_3"></a>
<a class="addthis_button_preferred_4"></a>
<a class="addthis_button_compact"></a>
<a class="addthis_counter addthis_bubble_style"></a>
</div>
<script type="text/javascript" src="https://s7.addthis.com/js/250/addthis_widget.js#pubid=xa-4eb26d947401cfe7"></script>
--%><!-- AddThis Button END -->

                    
                </div>
            </div>
            <div id="footer">
                <table width="100%">
                    <tr>
                        <td><dnn:COPYRIGHT runat="server" id="dnnCOPYRIGHT" CssClass="footer" /> &nbsp; &nbsp; <dnn:TERMS runat="server" id="dnnTERMS" CssClass="footer" /> &nbsp; &nbsp; <dnn:PRIVACY runat="server" id="dnnPRIVACY" CssClass="footer" /></td>
                    </tr>
                </table>
                
            </div>

        </div>
    </div>


