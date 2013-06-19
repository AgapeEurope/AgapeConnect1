<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>
<%@ Register TagPrefix="dnn" TagName="Header" Src="~/Portals/_default/Skins/AgapeFR/controls/Header.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Footer" Src="~/Portals/_default/Skins/AgapeFR/controls/Footer.ascx" %>

<script type="text/javascript">
    (function ($, Sys) {
        function initContentTitle() {
            $('#ContentContainer #ContentTitle').text(document.title);
        }

        // Functions to fix the problem of DNN admin ActionMenu opening under the PhotoPane
        function onActionMenu() {
            $('.PhotoPane').css("z-index", "400");
        }
        function offActionMenu() {
            $('.PhotoPane').css("z-index", "0");
        }

        $(document).ready(function () {
            initContentTitle();
            $('.PhotoPane .dnnActionMenu').hover(onActionMenu, offActionMenu);
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                initContentTitle();
                $('.PhotoPane .dnnActionMenu').hover(onActionMenu, offActionMenu);
            });
        });
    }(jQuery, window.Sys));
</script>

<dnn:Header runat="server" ID="dnnHeader" />

<div id="bar3" class="bar">
	<div id="ContentContainer" class="centeredbox">
		<div id="PhotoPane" class="PhotoPane" runat="server">
		</div>
        <div id="PhotoOverlay">
		</div>
        <div id="ContentTitle">
		</div>
        <div id="ContentPane" class="ContentPane" runat="server">
		</div>
	</div>
</div>	

<dnn:Footer runat="server" ID="dnnFooter" />