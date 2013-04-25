<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>
<%@ Register TagPrefix="dnn" TagName="LOGO" Src="~/Admin/Skins/Logo.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGIN" Src="~/Admin/Skins/Login.ascx" %>
<%@ Register TagPrefix="dnn" TagName="USER" Src="~/Admin/Skins/User.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SEARCH" Src="~/Admin/Skins/Search.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SEARCH1" Src="~/Admin/Skins/Search.ascx" %>
<%@ Register TagPrefix="dnn" TagName="BREADCRUMB" Src="~/Admin/Skins/BreadCrumb.ascx" %>
<%@ Register TagPrefix="dnn" TagName="COPYRIGHT" Src="~/Admin/Skins/Copyright.ascx" %>
<%@ Register TagPrefix="dnn" TagName="PRIVACY" Src="~/Admin/Skins/Privacy.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TERMS" Src="~/Admin/Skins/Terms.ascx" %>
<%@ Register TagPrefix="dnn" TagName="STYLES" Src="~/Admin/Skins/Styles.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Meta" Src="~/Admin/Skins/Meta.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LANGUAGE" Src="~/Admin/Skins/Language.ascx" %>
<%@ Register TagPrefix="dnn" TagName="GOMENU" Src="~/DesktopModules/dnngo_gomenu/ViewMenu.ascx" %>
<%@ Register TagPrefix="dnn" TagName="GOMENU2" Src="~/DesktopModules/dnngo_gomenu/ViewMenu.ascx" %>
<%--<dnn:Meta runat="server" Name="viewport" Content="width=device-width, minimum-scale=1.0, maximum-scale=2.0" />--%>
<dnn:Meta runat="server" Name="robots" Content="noindex" />
<dnn:Meta runat="server" Name="dnncrawler" Content="doindex" />
<!--[if lt IE 9]>

<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>

<![endif]-->
<script type="text/javascript" src="<%= SkinPath %>scripts/bootstrap.js"></script>
<script type="text/javascript" src="<%= SkinPath %>scripts/animatedcollapse.js"></script>
<script type="text/javascript" src="<%= SkinPath %>scripts/scrolltop.js"></script>
<div id="dnn_wrapper">
    
    <section id="dnn_content">
        <div class="content_mid_rightmenu dnn_layout">
      <%--      <header>
        <div class="head_mid dnn_layout clearfix " >
            <div class="mobile_icon clearfix visible-phone">
                <div class="home_icon"><a href="<%=DotNetNuke.Common.Globals.NavigateURL(PortalSettings.HomeTabId).ToString()%>">
                    <img src="<%= SkinPath %>images/home_icon.png" alt="" title="Home" /><br />
                    Home</a></div>
                <div class="user_icon"><a href="javascript:animatedcollapse.toggle('login_style')">
                    <img src="<%= SkinPath %>images/user_icon.png" alt="" title="Account" /><br />
                    Account</a></div>
                <div class="search_icon"><a href="javascript:animatedcollapse.toggle('search')">
                    <img src="<%= SkinPath %>images/search_icon.png" alt="" title="Search" /><br />
                    Search</a></div>
                <div class="menu_icon"><a href="javascript:animatedcollapse.toggle('mobile_menu')">
                    <img src="<%= SkinPath %>images/menu_icon.png" alt="" title="Menu" /><br />
                    Menu</a></div>
            </div>
           

            <div id="search" class="search_bg">
                <dnn:SEARCH runat="server" ID="dnnSEARCH" CssClass="search" UseDropDownList="true" ShowSite="False" ShowWeb="False" Submit="GO" />
            </div>
            <div id="mobile_menu">
                <dnn:GOMENU runat="server" ID="dnnGOMENU1" ViewLevel="0" Effect="AccordionPro" AccordionPro_Sensitivit="1" AccordionPro_Interval="100" AccordionPro_Timeout="1000" AccordionPro_AnimateSpeed="450" />
            </div>
        </div>
    </header>--%>
    <div class="nav_light">
        <nav>
            <div class="menu_mid dnn_layout clearfix">
                <div class="clearfix"  style="padding: 0 10px 0 10px">
                     
                    
                    
                    <div id="login_style" class="clearfix">
                <div class="language_style">
                    <dnn:LANGUAGE runat="server" ID="dnnLANGUAGE" ShowMenu="False" ShowLinks="True" />
                </div>
                <dnn:LOGIN runat="server" ID="dnnLOGIN" CssClass="login" />
                &nbsp;&nbsp;|&nbsp;&nbsp;<dnn:USER runat="server" ID="dnnUSER" CssClass="user" />
            </div>



                    <div class="dnn_logo">
                        <dnn:LOGO runat="server" ID="dnnLOGO" BorderWidth="0" />
                    </div>


                    <div class="searchp clearfix">
                        <div id="search1" class="search_bg">
                            <dnn:SEARCH runat="server" ID="dnnSEARCH1" CssClass="search" UseDropDownList="true" ShowSite="False" ShowWeb="False" Submit="GO" />
                        </div>
                        <div class="toplinkp">
                            <div class="TopLinkPane" id="TopLinkPane" runat="server"></div>
                        </div>
                    </div>
                </div>
                <div id="top_menu" class="hidden-phone">
                    <%--<dnn:GOMENU runat="server" ID="dnnGOMENU" Effect="Hslide" ViewLevel="0" />--%>
                </div>
            </div>
        </nav>
    </div>
            <section  class="row-fluid">
                <div class="span9">
                    <div class="bannerp">
                        <div class="BannerPane" id="BannerPane" runat="server" style="background-size: 700px;"></div>
                    </div>
            
                    <div class="pane_layout_rightmenu">
                        <section class="row-fluid">
                            <div class="span12">
                                <div class="TopPane" id="TopPane" runat="server"></div>
                            </div>
                        </section>
                        <section class="row-fluid">
                            <div class="span3">
                                <div class="RowOne_Grid3_Pane" id="RowOne_Grid3_Pane" runat="server"></div>
                            </div>
                            <div class="span9">
                                <div class="RowOne_Grid9_Pane" id="RowOne_Grid9_Pane" runat="server"></div>
                            </div>
                        </section>
                        <section class="row-fluid">
                            <div class="span4">
                                <div class="RowTwo_Grid4_Pane" id="RowTwo_Grid4_Pane" runat="server"></div>
                            </div>
                            <div class="span8">
                                <div class="RowTwo_Grid8_Pane" id="RowTwo_Grid8_Pane" runat="server"></div>
                            </div>
                        </section>
                        <section class="row-fluid">
                            <div class="span5">
                                <div class="RowThree_Grid5_Pane" id="RowThree_Grid5_Pane" runat="server"></div>
                            </div>
                            <div class="span7">
                                <div class="RowThree_Grid7_Pane" id="RowThree_Grid7_Pane" runat="server"></div>
                            </div>
                        </section>
                        <section class="row-fluid">
                            <div class="span6">
                                <div class="RowFour_Grid6_Pane1" id="RowFour_Grid6_Pane1" runat="server"></div>
                            </div>
                            <div class="span6">
                                <div class="RowFour_Grid6_Pane2" id="RowFour_Grid6_Pane2" runat="server"></div>
                            </div>
                        </section>
                        <section class="row-fluid">
                            <div class="span7">
                                <div class="RowFive_Grid7_Pane" id="RowFive_Grid7_Pane" runat="server"></div>
                            </div>
                            <div class="span5">
                                <div class="RowFive_Grid5_Pane" id="RowFive_Grid5_Pane" runat="server"></div>
                            </div>
                        </section>
                        <section class="row-fluid">
                            <div class="span8">
                                <div class="RowSix_Grid8_Pane" id="RowSix_Grid8_Pane" runat="server"></div>
                            </div>
                            <div class="span4">
                                <div class="RowSix_Grid4_Pane" id="RowSix_Grid4_Pane" runat="server"></div>
                            </div>
                        </section>
                        <section class="row-fluid">
                            <div class="span9">
                                <div class="RowSeven_Grid9_Pane" id="RowSeven_Grid9_Pane" runat="server"></div>
                            </div>
                            <div class="span3">
                                <div class="RowSeven_Grid3_Pane" id="RowSeven_Grid3_Pane" runat="server"></div>
                            </div>
                        </section>
                        <section class="row-fluid">
                            <div class="span4">
                                <div class="RowEight_Grid4_Pane1" id="RowEight_Grid4_Pane1" runat="server"></div>
                            </div>
                            <div class="span4">
                                <div class="RowEight_Grid4_Pane2" id="RowEight_Grid4_Pane2" runat="server"></div>
                            </div>
                            <div class="span4">
                                <div class="RowEight_Grid4_Pane3" id="RowEight_Grid4_Pane3" runat="server"></div>
                            </div>
                        </section>
                        <section class="row-fluid">
                            <div class="span3">
                                <div class="RownNine_Grid3_Pane1" id="RowNine_Grid3_Pane1" runat="server"></div>
                            </div>
                            <div class="span3">
                                <div class="RowNine_Grid3_Pane2" id="RowNine_Grid3_Pane2" runat="server"></div>
                            </div>
                            <div class="span3">
                                <div class="RowNine_Grid3_Pane3" id="RowNine_Grid3_Pane3" runat="server"></div>
                            </div>
                            <div class="span3">
                                <div class="RowNine_Grid3_Pane4" id="RowNine_Grid3_Pane4" runat="server"></div>
                            </div>
                        </section>
                        <section class="row-fluid">
                            <div class="span4">
                                <div class="RowTen_Grid4_Pane1" id="RowTen_Grid4_Pane1" runat="server"></div>
                            </div>
                            <div class="span4">
                                <div class="RowTen_Grid4_Pane2" id="RowTen_Grid4_Pane2" runat="server"></div>
                            </div>
                            <div class="span4">
                                <div class="RowTen_Grid4_Pane3" id="RowTen_Grid4_Pane3" runat="server"></div>
                            </div>
                        </section>
                        <section class="row-fluid">
                            <div class="span9">
                                <div class="RowEleven_Grid9_Pane" id="RowEleven_Grid9_Pane" runat="server"></div>
                            </div>
                            <div class="span3">
                                <div class="RowEleven_Grid3_Pane" id="RowEleven_Grid3_Pane" runat="server"></div>
                            </div>
                        </section>
                        <section class="row-fluid">
                            <div class="span8">
                                <div class="RowTwelve_Grid8_Pane" id="RowTwelve_Grid8_Pane" runat="server"></div>
                            </div>
                            <div class="span4">
                                <div class="RowTwelve_Grid4_Pane" id="RowTwelve_Grid4_Pane" runat="server"></div>
                            </div>
                        </section>
                        <section class="row-fluid">
                            <div class="span7">
                                <div class="RowThirteen_Grid7_Pane" id="RowThirteen_Grid7_Pane" runat="server"></div>
                            </div>
                            <div class="span5">
                                <div class="RowThirteen_Grid5_Pane" id="RowThirteen_Grid5_Pane" runat="server"></div>
                            </div>
                        </section>
                        <section class="row-fluid">
                            <div class="span6">
                                <div class="RowFourteen_Grid6_Pane1" id="RowFourteen_Grid6_Pane1" runat="server"></div>
                            </div>
                            <div class="span6">
                                <div class="RowFourteen_Grid6_Pane2" id="RowFourteen_Grid6_Pane2" runat="server"></div>
                            </div>
                        </section>
                        <section class="row-fluid">
                            <div class="span5">
                                <div class="RowFifteen_Grid5_Pane" id="RowFifteen_Grid5_Pane" runat="server"></div>
                            </div>
                            <div class="span7">
                                <div class="RowFifteen_Grid7_Pane" id="RowFifteen_Grid7_Pane" runat="server"></div>
                            </div>
                        </section>
                        <section class="row-fluid">
                            <div class="span4">
                                <div class="RowSixteen_Grid4_Pane" id="RowSixteen_Grid4_Pane" runat="server"></div>
                            </div>
                            <div class="span8">
                                <div class="RowSixteen_Grid8_Pane" id="RowSixteen_Grid8_Pane" runat="server"></div>
                            </div>
                        </section>
                        <section class="row-fluid">
                            <div class="span3">
                                <div class="RowSeventeen_Grid3_Pane" id="RowSeventeen_Grid3_Pane" runat="server"></div>
                            </div>
                            <div class="span9">
                                <div class="RowSeventeen_Grid9_Pane" id="RowSeventeen_Grid9_Pane" runat="server"></div>
                            </div>
                        </section>
                        <section class="row-fluid">
                            <div class="span12">
                                <div class="ContentPane" id="ContentPane" runat="server"></div>
                            </div>
                        </section>
                    </div>
              
        </div>
        <div class="span3">
            <div  id="right_menu" />
            <div class="RightOutPane" id="RightOutPane" runat="server" ></div>
        </div>
                </section>
        <div id="dnn_footer" class="clearfix">
            <div class="footerpa">
                <div class="FooterPane_A" id="FooterPane_A" runat="server"></div>
            </div>
            <div class="footerpb">
                <div class="FooterPane_B" id="FooterPane_B" runat="server"></div>
            </div>
            <div class="footerpc">
                <div class="FooterPane_C" id="FooterPane_C" runat="server"></div>
            </div>
        </div>
        <div id="dnn_bottom" class="clearfix">
            <div class="copyright_style">
                <dnn:COPYRIGHT runat="server" ID="dnnCOPYRIGHT" CssClass="footer" />
                <span class="sep">|</span><dnn:PRIVACY runat="server" ID="dnnPRIVACY" CssClass="terms" />
                <span class="sep">|</span><dnn:TERMS runat="server" ID="dnnTERMS" CssClass="terms" />
                <dnn:STYLES runat="server" ID="dnnSTYLES" Name="IE6Minus" StyleSheet="ie.css" Condition="LT IE 9" UseSkinPath="True" />
            </div>
            <div id="to_top">
                <img src="<%= SkinPath %>images/backtotop.png" alt="" title="Back To Top" /></div>
            <div class="footerp">
                <div class="FooterLinkPane" id="FooterLinkPane" runat="server"></div>
            </div>
        </div>

        </div>
                    
                    
			
    </section>
</div>
<script type="text/javascript" language="javascript">
  <!--
    //Search:
    jQuery(document).ready(function(){
        var s="Search...";
        jQuery("#dnn_dnnSEARCH_txtSearchNew").val(s).click(function(){
            var ss=$(this).val();if(ss==s)$(this).val("") }
         )
        .blur(function(){
            var ss=$(this).val();if(ss=="")$(this).val(s) }
         );
    });
    //Search1:
    jQuery(document).ready(function(){
        var s="Search...";
        jQuery("#dnn_dnnSEARCH1_txtSearchNew").val(s).click(function(){
            var ss=$(this).val();if(ss==s)$(this).val("") }
         )
        .blur(function(){
            var ss=$(this).val();if(ss=="")$(this).val(s) }
         );
    });
    //Top:
    jQuery(document).ready(function($) {
        $(window).scroll(function() {
        });	 
        jQuery('#to_top').click(function() {
            jQuery('body,html').animate({scrollTop:0},800);
        });	
    });
    jQuery(document).ready(function($) {		
	
        animatedcollapse.addDiv('language_style', 'fade=1,speed=200,group=mobile')
        animatedcollapse.addDiv('login_style', 'fade=1,speed=200,group=mobile')
        animatedcollapse.addDiv('search', 'fade=1,speed=200,group=mobile,persist=1,hide=1')
        animatedcollapse.addDiv('mobile_menu', 'fade=1,speed=200,group=mobile,hide=1')
		
        animatedcollapse.ontoggle=function($, divobj, state){ //fires each time a DIV is expanded/contracted
            //$: Access to jQuery
            //divobj: DOM reference to DIV being expanded/ collapsed. Use "divobj.id" to get its ID
            //state: "block" or "none", depending on state
        }		
        animatedcollapse.init()
    });

    -->
</script>







