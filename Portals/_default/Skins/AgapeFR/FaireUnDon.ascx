<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>
<%@ Register TagPrefix="dnn" TagName="Header" Src="~/Portals/_default/Skins/AgapeFR/controls/Header.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Footer" Src="~/Portals/_default/Skins/AgapeFR/controls/Footer.ascx" %>

<dnn:Header runat="server" ID="dnnHeader" />

<div id="bar3" class="bar">
	<div id="ContentContainer" class="centeredbox">
        <div id="BannerPane" class="BannerPane" runat="server">
		</div>
        <div id="TopPane" class="TopPane" runat="server">
		</div>
        <div class="LeftMenu">
            <div id="TopImg">
		    </div>
            <div id="LeftMenuPane" class="LeftMenuPane" runat="server">
		    </div>
            <div id="BottomImg">
		    </div>
		</div>
        <div id="ContentPane" class="CenterPane" runat="server">
		</div>
        <div id="BottomPane" class="BottomPane" runat="server">
		</div>
	</div>
</div>	

<dnn:Footer runat="server" ID="dnnFooter" />