<%@ Control Language="VB" AutoEventWireup="false" CodeFile="GiveInfo.ascx.vb" Inherits="DotNetNuke.Modules.AgapeFR.GiveInfo.GiveInfo" %>
<%@ Register Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" TagPrefix="cc2" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<script src="/js/jquery.numeric.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">

    (function ($, Sys) {
        function setUpMyTabs() {
            $('.aButton').button();
            $('.numeric').numeric();
            $("#accordionInfo").accordion({
                autoHeight: false,
                navigation: true,
            });
        }

        $(document).ready(function () {
            setUpMyTabs();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpMyTabs();
            });
        });
    } (jQuery, window.Sys));

</script>
<div id="accordionInfo" style="width: 300px;">
    <h3>
        <a href="#Section0">Déduction fiscale</a></h3>
    <div>
        <p>
            The text goes here.</p>
    </div>
    <h3>
        <a href="#Section1">Pourquoi donner ?</a></h3>
    <div>
        <p>
            The text goes here.</p>
    </div>
    <h3>
        <a href="#Section2">Transparence</a></h3>
    <div>
        <p>
            The text goes here.</p>
    </div>
    <h3>
        <a href="#Section3">Sécurité</a></h3>
    <div>
        <p>
            The text goes here.</p>
    </div>
    <h3>
        <a href="#Section4">Relation Donateurs</a></h3>
    <div>
        <p>
            The text goes here.</p>
    </div>
</div>
