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
<%@ Register TagPrefix="dnn" TagName="TEXT" Src="~/Admin/Skins/Text.ascx" %>


<script runat="server">
    Protected Function Translate(ResourceKey As String) As String   
        Dim strFile As String = System.IO.Path.GetFileName(Server.MapPath(PortalSettings.ActiveTab.SkinSrc))
                strFile = PortalSettings.ActiveTab.SkinPath + Localization.LocalResourceDirectory + "/" + strFile
        Return Localization.GetString(ResourceKey, strFile)
    End Function
    
</script>
<script src="/js/jquery.watermarkinput.js" type="text/javascript"></script>
<script type="text/javascript">
    (function ($, Sys) {
        function initSearchText() {
            $('#SearchContainer span input[type=text]').Watermark('<%=Translate("SearchWatermark.Text")%>');
        }

        $(document).ready(function () {
            initSearchText();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                initSearchText();
            });
        });
    }(jQuery, window.Sys));
    </script>

<div id="controlPanelContainer">
	<div id="ControlPanel" runat="server" />
</div>
<div id="globalbar" class="bar">
	<div id="globalbox" class="">
		<div id="bar1" class="bar bar1">
			<div id="header" class="centeredbox bar1">
				<div id="headerContent" class="bar1">
					<div id="logoHeader">
						<dnn:LOGO runat="server" ID="dnnLOGOHEADER" />
					</div>	
					<div id="toplinks">
						<div id="RegisterContainer" class="needMargin"><dnn:USER runat="server" ID="dnnUSER" CssClass="user" /></div>
						<div id="LoginContainer" class="needMargin"><dnn:LOGIN runat="server" ID="dnnLOGIN" CssClass="user" /></div>
						<div id="MinicartContainer" class="needMargin"><dnn:MINICART runat="server" ID="dnnMINICART" /></div>
						<div id="SearchContainer" class="needMargin"><dnn:SEARCH runat="server" ID="dnnSEARCH" UseDropDownList="False" ShowWeb="False" ShowSite="False" Submit="<div id=&quot;SearchSubmit&quot;></div>" /></div>
					</div>
					<div id="menu1">
						<ddr:MENU ID="MENU1" MenuStyle="/templates/AgapeFRMenu/" NodeSelector="*" runat="server" ExcludeNodes="" />
					</div>
				</div>
			</div>
		</div>
		<div class="clear_float"></div>
		<div id="bar2" class="bar">
			<div id="menu2" class="centeredbox">
				<ddr:MENU ID="MENU2" MenuStyle="/templates/AgapeFRMenu/" NodeSelector="RootChildren" runat="server" />            
			</div>
		</div>
		<div id="bar3" class="bar">
			<div id="ContentContainer1" class="centeredbox">
				<div id="TopPane" class="TopPane" runat="server">
				</div>
			</div>
		</div>			
		<div id="bar4" class="bar">
			<div id="ContentContainer2" class="centeredbox">
				<table cellspacing="0" cellpadding="0" border="0" width="100%" class="mainContentContainer">
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
		<div id="bar5" class="bar">
		</div>		
		<div id="bar6" class="bar">
			<div id="footer1" class="centeredbox">
                <div id="logoFooter">
					<dnn:LOGO runat="server" ID="dnnLOGOFOOTER" />
				</div>
                <ddr:MENU ID="SITEMAP" MenuStyle="/templates/AgapeFRSitemap/" NodeSelector="*" runat="server" />	
			</div>
		</div>
		<div id="bar7" class="bar">
			<div id="footer2" class="centeredbox">
                <div id="socialmedia"><dnn:TEXT runat="server" ID="txtSocialMedia" ResourceKey="SocialMedia" CssClass=""/></div>
                <a href="http://www.facebook.com/agapefrance" target="_blank" id="facebook"></a>
                <a href="http://www.youtube.com/user/VideosAgapeFrance" target="_blank" id="youtube"></a>
			</div>		
		</div>
		<div id="bar8" class="bar">
			<div id="footer3" class="centeredbox">
				<div id="contactAndSlogan">
				    <div id="postalAddress">
                        <dnn:TEXT runat="server" ID="txtPostalAddress" ResourceKey="OzoirAddress" />
				    </div>
                    <div id="telFaxEmail">
                        <div id="tel">
                            <div id="telIcon"></div>
                            <div id="telText"><dnn:TEXT runat="server" ID="txtTel" ResourceKey="OzoirPhone" CssClass="" /></div>
                        </div>
                        <div id="fax">
                            <div id="faxIcon"></div>
                            <div id="faxText"><dnn:TEXT runat="server" ID="txtFax" ResourceKey="OzoirFax" CssClass="" /></div>
                        </div>
                        <div id="email">
                            <div id="emailIcon"></div>
                            <div id="emailText"><dnn:TEXT runat="server" ID="txtEmail" ResourceKey="OzoirEmail" CssClass="" /></div>
                        </div>
				    </div>
                    <div id="slogan">
                        <dnn:TEXT runat="server" ID="txtSlogan" ResourceKey="Slogan" CssClass="" />
                    </div>
                </div>
                <div id="infosLegales">
					<div id="copyright"><dnn:COPYRIGHT runat="server" ID="dnnCOPYRIGHT" CssClass="" /></div>
                    <div id="privacy"><dnn:PRIVACY runat="server" ID="dnnPRIVACY" CssClass="" /></div>
					<div id="terms"><dnn:TERMS runat="server" ID="dnnTERMS" CssClass="" /></div>
				</div>
			</div>
		</div>
	</div>
</div>