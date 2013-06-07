<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>
<%@ Register TagPrefix="dnn" TagName="LOGO" Src="~/Admin/Skins/Logo.ascx" %>
<%@ Register TagPrefix="dnn" TagName="USER" Src="~/Admin/Skins/User.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGIN" Src="~/Admin/Skins/Login.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SEARCH" Src="~/Admin/Skins/Search.ascx" %>
<%@ Register TagPrefix="dnn" TagName="MINICART" Src="~/DesktopModules/AgapeFR/Cart/SkinMinicart.ascx" %>
		<div id="header"><table style="width: 100%;"><tr>
		<td rowspan="2"><dnn:LOGO runat="server" ID="dnnLOGO" /></td>
		<td>
			<div id="upper">
				<span><dnn:LOGIN runat="server" ID="dnnLOGIN" CssClass="user" /></span>
				<span><dnn:USER runat="server" ID="dnnUSER" CssClass="user" /></span>
				<span><dnn:MINICART runat="server" ID="dnnMINICART" /></span>
				<dnn:SEARCH runat="server" ID="dnnSEARCH" CssClass="ServerSkinWidget" UseDropDownList="False" ShowWeb="False" ShowSite="False" Submit="<img src=&quot;images/search.gif&quot; border=&quot;0&quot; alt=&quot;Search&quot; /&gt;" />
			</div>
		</td></tr><tr><td>
			<div id="menu">
			<table><tbody><tr><td class="mm" sm="nous" >Nous connaitre</td><td class="sp"></td><td class="mm" sm="sinp" >Sinpliquer</td><td class="sp"></td><td class="mm" sm="acti" >Activites</td><td class="sp"></td><td class="mm" sm="actu" >Actualities</td><td class="sp"></td><td class="mm" sm="ress" >Ressources</td></tr></tbody></table>
			</div></td></tr></table>
		</div>
		<div id="submenu">
		<div id="acti" style="display: inherit;"><span>Actions Villes</span><span>Agape Campus</span><span>Crescendo</span><span>Agape Famille</span><span>Agape au feminin</span><span>Film Jesus</span><span>Agape Internet</span><span>Mosaique</span><span>Services internes</span><span>Sport Foi</span></div>
		</div>
		<div id="main">
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
		<div id="footertop"></div>
		<div id="footer">
			<table id="tblFoot">
				<colgroup>
					<col style="width: 15em;">
					<col style="width: 15em;">
					<col style="width: 15em;">
					<col style="width: 15em;">
					<col style="width: 15em;">
				</colgroup>
				<tbody><tr>
					<td><dnn:LOGO runat="server" ID="dnnLOGOfooter" /></td>
					<td><span class="mm">Nous connaitre</span><br><span class="sm">Notre motivation</span><br><span class="sm">Notre equipe</span><br><span class="sm">Projet associatif</span><br><span class="sm">Notre histoire</span><br><span class="sm">Nous contacter</span></td>
					<td><span class="mm">Sinpliquer</span><br><span class="sm">Partenariats</span><br><span class="sm">Devenair permanent</span><br><span class="sm">Faire un stage</span><br><span class="sm">Nous aider benevolement</span><br><span class="sm">Faire un don</span></td>
					<td><span class="mm">Activites</span><br><span class="sm">Actions Villes</span><br><span class="sm">Agape Campus</span><br><span class="sm">Crescendo</span><br><span class="sm">Agape Famille</span><br><span class="sm">Agape au feminin</span><br><span class="sm">Film Jesus</span><br><span class="sm">Agape Internet</span><br><span class="sm">Mosaique</span><br><span class="sm">Services internes</span><br><span class="sm">Sport Foi</span></td>
					<td><span class="mm">Actualities</span><br><span class="sm">Nouvelles</span><br><span class="sm">Evenement</span><br><span class="sm">Agenda</span><br><span class="sm">Recevoir nos mouvelles</span></td>
				</tr>
				<tr>
					<td></td>
					<td colspan="2"></td>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td></td>
					<td colspan="2"></td>
					<td colspan="2"></td>
				</tr>
			</tbody></table>
		</div>
		<div id="footerband">
			<table id="tblBand">
				<colgroup>
					<col style="width: 15em;"/>
					<col style="width: 30em;"/>
					<col style="width: 30em;"/>
				</colgroup>
				<tr>
					<td></td>
					<td><span style="font-size: 1.2em;">RESTER CONNECTER AVEC NOUS</span><button><img src="<%= SkinPath %>images/facebook.png" style="width: .7em;" /></button><button><img src="<%= SkinPath %>images/you_tube.png" style="width: 1.4em;" /></button></td>
					<td><input value="NEWSLETTERS"/><button style="width: 2em; height:2em;"><img src="<%= SkinPath %>images/white_right_arrow.png" style="width: .8em;" /></button>
</td>
				</tr>
			</table>
		</div>
		<div id="footerfoot">
			<table id="tblFootFoot">
				<colgroup>
					<col style="width: 15em;"/>
					<col style="width: 20em;"/>
					<col style="width: 20em;"/>
					<col style="width: 20em;"/>
				</colgroup>
				<tr>
					<td></td>
					<td>AGAPE FRANCE<br>BP 29, 77831<br>OZOIR-LA-FERRIERE CEDEX</td>
					<td><img src="<%= SkinPath %>images/phone.png"/>01 60 02 55 56<br><img src="<%= SkinPath %>images/fax.png"/>01 60 02 55 56<br><img src="<%= SkinPath %>images/email.png"/>info@agape-france.org</td>
					<td><span style="font-size: .8em;font-style:italic;">Au service de l'Evangile depuis 1967.</span></td>
				</tr>
				<tr>
					<td></td>
					<td colspan="2"><br><br><br><span style="font-size: .8em">C Agape France 2012-Mentions legales</span></td>
				</tr>
			</table>
		</div>

