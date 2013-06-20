<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" %>
<%@ Register TagPrefix="dnn" TagName="LOGO" Src="~/Admin/Skins/Logo.ascx" %>
<%@ Register TagPrefix="dnn" TagName="PRIVACY" Src="~/Admin/Skins/Privacy.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TERMS" Src="~/Admin/Skins/Terms.ascx" %>
<%@ Register TagPrefix="dnn" TagName="COPYRIGHT" Src="~/Admin/Skins/Copyright.ascx" %>
<%@ Register TagPrefix="ddr" Namespace="DotNetNuke.Web.DDRMenu.TemplateEngine" Assembly="DotNetNuke.Web.DDRMenu" %>
<%@ Register TagPrefix="ddr" TagName="MENU" src="~/DesktopModules/DDRMenu/Menu.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TEXT" Src="~/Admin/Skins/Text.ascx" %>

<div class="bar">
	<div class="globalbox">
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