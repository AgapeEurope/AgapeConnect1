<%@ Control Language="C#" AutoEventWireup="true" CodeFile="QuickRender.ascx.cs" Inherits="DesktopModules_AgapeUK_QuickRender_QuickRender" %>
<script type="text/javascript" src="../../js/cSlider/c_slider.js"></script>
<link rel="stylesheet" type="text/css" href="../../js/cSlider/chris_slider.css" />
<script type="text/javascript">
    (function ($, Sys) {
        function setUpMyjQuery() {
            $('#slider').cSlider({ animSpeed: '1000', pauseTime: '10000' });
        }
        $(document).ready(function () {
            setUpMyjQuery();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpMyjQuery();
            });
        });
    }(jQuery, window.Sys));
</script>


<div id="slider">
<a href="#">
    <img src="../../../js/cSlider/images/slider1.jpg" width="625px" data-thumb="../../../js/cSlider/images/slider1.jpg" title='<div class="c_big">This should too</div><div class="c_small">It really, really should</div>' alt="http://www.agape.org.uk"/>
</a>
<a href="#">
    <img src="../../../js/cSlider/images/slider2.jpg" width="625px" data-thumb="../../../js/cSlider/images/slider2.jpg" title='<div class="c_big">This should work!</div><div class="c_small">It really, really should</div>' alt="http://give.agape.org.uk/carter"/>
</a>
<a href="#">
    <img src="../../../js/cSlider/images/slider3.jpg" width="625px" data-thumb="../../../js/cSlider/images/slider3.jpg" title='<div class="c_big">This should as well!</div><div class="c_small">It really, really should</div>' alt="http://www.google.co.uk"/>
</a>
</div>
