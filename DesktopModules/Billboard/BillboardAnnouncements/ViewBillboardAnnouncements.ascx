<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ViewBillboardAnnouncements.ascx.vb"
    Inherits="DotNetNuke.Modules.BillboardAnnouncements.ViewBillboardAnnouncements" %>
<%@ Register Src="~/DesktopModules/Billboard/controls/AnnArchive.ascx" TagName="annArc" TagPrefix="uc1" %>
<link rel="stylesheet" type="text/css" href="/DesktopModules/Billboard/BillTheme/BillCSS/jquery-ui-1.8.18.custom.css" />
<link rel="stylesheet" type="text/css" href="/DesktopModules/Billboard/BillTheme/BillStyle.css" />
<script type="text/javascript">
    (function ($, Sys) {
        function setUpMyTabs() {
            var stop = false;
            $("#divAnnArc").dialog({
                autoOpen: false,
                height: 500,
                width: 600,
                modal: true,
                show: 'fade',
                hide: 'fade',
                dialogClass: 'dialogWithDropShadow',
                title: '<div class="closeEl"><a style="cursor:pointer;" onclick="return false;"><img onclick="closeAnnArc()" src="/DesktopModules/Billboard/Images/BlueCross.gif" title="Close Window" alt="Close" /></a></div><br/><img src="/DesktopModules/Billboard/Images/BillboardAnn.gif" height="40px" />',
                open: function (event, ui) {
                    $('.ui-dialog-titlebar-close').hide();
                    $('body').css({ 'overflow': 'hidden' });
                }
            });
            $("#divAnnArc").parent().appendTo($("form:first"));

            $("#divViewArt").dialog({
                autoOpen: false,
                height: 500,
                width: 600,
                modal: true,
                show: 'fade',
                hide: 'fade',
                dialogClass: 'dialogWithDropShadow',
                title: '<div class="closeEl"><a style="cursor:pointer;" onclick="return false;"><img onclick="closeViewArt()" src="/DesktopModules/Billboard/Images/BlueCross.gif" title="Close Window" alt="Close" /></a></div><br/><img src="/DesktopModules/Billboard/Images/BillArt.gif" height="40px" />',
                open: function (event, ui) {
                    $('.ui-dialog-titlebar-close').hide();
                    $('body').css({ 'overflow': 'hidden' });
                }
            });
            $("#divViewArt").parent().appendTo($("form:first"));

            $("#divViewFeat").dialog({
                autoOpen: false,
                height: 500,
                width: 600,
                modal: true,
                show: 'fade',
                hide: 'fade',
                dialogClass: 'dialogWithDropShadow',
                title: '<div class="closeEl"><a style="cursor:pointer;" onclick="return false;"><img onclick="closeViewFeat()" src="/DesktopModules/Billboard/Images/BlueCross.gif" title="Close Window" alt="Close" /></a></div><br/><img src="/DesktopModules/Billboard/Images/BillFeat.gif" height="40px" />',
                open: function (event, ui) {
                    $('.ui-dialog-titlebar-close').hide();
                    $('body').css({ 'overflow': 'hidden' });
                }
            });
            $("#divViewFeat").parent().appendTo($("form:first"));

            $("#divEditPrayer").dialog({
                autoOpen: false,
                height: 500,
                width: 600,
                modal: true,
                show: 'fade',
                hide: 'fade',
                dialogClass: 'dialogWithDropShadow',
                title: '<div class="closeEl"><a style="cursor:pointer;" onclick="return false;"><img onclick="closeEditPrayer()" src="/DesktopModules/Billboard/Images/BlueCross.gif" title="Close Window" alt="Close" /></a></div><br/><img src="/DesktopModules/Billboard/Images/BillPrayer.gif" height="40px" />',
                open: function (event, ui) {
                    $('.ui-dialog-titlebar-close').hide();
                    $('body').css({ 'overflow': 'hidden' });
                }
            });
            $("#divEditPrayer").parent().appendTo($("form:first"));

            $("#divMessage").dialog({
                autoOpen: false,
                height: 500,
                width: 600,
                modal: true,
                show: 'fade',
                hide: 'fade',
                dialogClass: 'dialogWithDropShadow',
                title: '<div class="closeEl"><a style="cursor:pointer;" onclick="return false;"><img onclick="closeMessage()" src="/DesktopModules/Billboard/Images/BlueCross.gif" title="Close Window" alt="Close" /></a></div><br/><img src="/DesktopModules/Billboard/Images/BillPrayer.gif" height="40px" />',
                open: function (event, ui) {
                    $('.ui-dialog-titlebar-close').hide();
                    $('body').css({ 'overflow': 'hidden' });
                }
            });
            $("#divMessage").parent().appendTo($("form:first"));


            //$('#Accordion').accordion({ clearStyle: true });
            $("#divPrayerArc").dialog({
                autoOpen: false,
                height: 500,
                width: 600,
                modal: true,
                show: 'fade',
                hide: 'fade',
                dialogClass: 'dialogWithDropShadow',
                title: '<div class="closeEl"><a style="cursor:pointer;" onclick="return false;"><img onclick="closePrayerArc()" src="/DesktopModules/Billboard/Images/BlueCross.gif" title="Close Window" alt="Close" /></a></div><br/><img src="/DesktopModules/Billboard/Images/BillPrayer.gif" height="40px" />',
                open: function (event, ui) {
                    $('.ui-dialog-titlebar-close').hide();
                    $('body').css({ 'overflow': 'hidden' });
                }
            });
            $("#divPrayerArc").parent().appendTo($("form:first"));

            $("#divEditLink").dialog({
                autoOpen: false,
                height: 500,
                width: 600,
                modal: true,
                show: 'fade',
                hide: 'fade',
                dialogClass: 'dialogWithDropShadow',
                title: '<div class="closeEl"><a style="cursor:pointer;" onclick="return false;"><img onclick="closeEditLink()" src="/DesktopModules/Billboard/Images/BlueCross.gif" title="Close Window" alt="Close" /></a></div><br/><img src="/DesktopModules/Billboard/Images/Links2.gif" height="40px" />',
                open: function (event, ui) {
                    $('.ui-dialog-titlebar-close').hide();
                    $('body').css({ 'overflow': 'hidden' });
                }
            });
            $("#divEditLink").parent().appendTo($("form:first"));

            $("#divLinkArc").dialog({
                autoOpen: false,
                height: 500,
                width: 600,
                modal: true,
                show: 'fade',
                hide: 'fade',
                dialogClass: 'dialogWithDropShadow',
                title: '<div class="closeEl"><a style="cursor:pointer;" onclick="return false;"><img onclick="closeLinkArc()" src="/DesktopModules/Billboard/Images/BlueCross.gif" title="Close Window" alt="Close" /></a></div><br/><img src="/DesktopModules/Billboard/Images/Links2.gif" height="40px" />',
                open: function (event, ui) {
                    $('.ui-dialog-titlebar-close').hide();
                    $('body').css({ 'overflow': 'hidden' });
                }
            });
            $("#divLinkArc").parent().appendTo($("form:first"));
        }
        $(document).ready(function () {
            setUpMyTabs();
            //ieTest();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpMyTabs();
            });
        });
    } (jQuery, window.Sys));

    function ieTest() {
        if (/MSIE (\d+\.\d+);/.test(navigator.userAgent)) { //test for MSIE x.x
            var ieversion = new Number(RegExp.$1); // capture x.x portion and store as a number
            if (ieversion >= 5 && ieversion < 8) {
                alert("You are using an obsolete version of Internet Explorer.\nThis section of the website may not work well with this.\n\nPlease consider upgrading your version of internet explorer or using a different browser.");
            }
        }

    }
    function closeAnnArc() {
        $("#divAnnArc").dialog("close");
        $('body').css({ 'overflow': 'auto' });
        return false;
     }
    function showAnnArc() { $("#divAnnArc").dialog("open"); return false; }

    function showViewArt() {$("#divViewArt").dialog("open"); return false; }
    function closeViewArt() {
        $("#divViewArt").dialog("close");
        $('body').css({ 'overflow': 'auto' });
        return false;
    }

    function showViewFeat() { $("#divViewFeat").dialog("open"); return false; }
    function closeViewFeat() {
        $("#divViewFeat").dialog("close");
        setUpMyFeat();
        $('body').css({ 'overflow': 'auto' });
        return false;
    }

    function showEditPrayer() { $("#divEditPrayer").dialog("open"); return false; }
    function closeEditPrayer() {
        $("#divEditPrayer").dialog("close");
        $('body').css({ 'overflow': 'auto' });
        return false;
    }

    function showMessage() { $("#divMessage").dialog("open"); return false; }
    function closeMessage() {
        $("#divMessage").dialog("close");
        $('body').css({ 'overflow': 'auto' });
        return false;
    }

    function showArcPrayer() { $("#divPrayerArc").dialog("open"); return false; }
    function closePrayerArc() {
        $("#divPrayerArc").dialog("close");
        $('body').css({ 'overflow': 'auto' });
        return false;
    }

    function showEditLink() { $("#divEditLink").dialog("open"); return false; }
    function closeEditLink() {
        $("#divEditLink").dialog("close");
        $('body').css({ 'overflow': 'auto' });
        return false;
    }

    function showLinkArc() { $("#divLinkArc").dialog("open"); return false; }
    function closeLinkArc() {
        $("#divLinkArc").dialog("close");
        $('body').css({ 'overflow': 'auto' });
        return false;
    }
</script>
<style type="text/css">
    .dialogWithDropShadow
    {
        -webkit-box-shadow: 0px 0px 20px #000;
        -moz-box-shadow: 0px 0px 20px #000;
        box-shadow: 0px 0px 20px #000;
    }
    .closeEl
    {
        position: absolute;
        right: .3em;
        top: 50%;
        width: 19px;
        margin: -25px 0 0 0;
        padding: 1px;
        height: 18px;
    }
    .padInner
    {
        margin: 5px 10px 10px 5px;
    }
</style>
<br />
<br />
<div style="width: 550px; text-align: left;">
    <asp:Image ID="imgHead" runat="server" ImageUrl="~/DesktopModules/Billboard/images/BillboardAnn.gif" />
    <div class="Bill_dashed">
        &nbsp;</div>
    <asp:PlaceHolder ID="phMain" runat="server"></asp:PlaceHolder>
    <div class="Bill_dashed">
        &nbsp;</div>
    <asp:ImageButton ID="btnArch" runat="server" Height="24px" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/ViewArchive1.gif"
        onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/ViewArchive2.gif';" onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/ViewArchive1.gif';"
        AlternateText="View Archive" ToolTip="View Archive" OnClientClick="showAnnArc(); return false;" />
    &nbsp;
    <asp:ImageButton ID="btnEdit" runat="server" Height="24px" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/EditAnnouncements1.gif"
        onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/EditAnnouncements2.gif';" onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/EditAnnouncements1.gif';"
        AlternateText="Edit Announcements" ToolTip="Edit Announcements" />
</div>
<br />
<br />
<div id="divAnnArc" class="padInner">
    <div id="AnnArcInner" style="overflow: hidden; padding-right: 5px;">
        <uc1:annArc ID="annArc" runat="server"></uc1:annArc>
    </div>
</div>
