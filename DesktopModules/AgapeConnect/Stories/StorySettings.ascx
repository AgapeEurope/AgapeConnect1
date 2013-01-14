<%@ Control Language="vb" AutoEventWireup="false" CodeFile="StorySettings.ascx.vb"
    Inherits="DotNetNuke.Modules.Stories.StorySettings" %>
    
<%@ Register Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" TagPrefix="uc1" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register src="../StaffAdmin/Controls/acImage.ascx" tagname="acImage" tagprefix="uc2" %>
<script src="/js/knobKnob/transform.js" type="text/javascript"></script>
<script src="/js/knobKnob/knobKnob.jquery.js" type="text/javascript"></script>
<script src="/js/jquery.numeric.js" type="text/javascript"></script>
<script src="/js/jquery.jscrollpane.min.js" type="text/javascript"></script>
<link href="/js/jquery.jscrollpane.css" rel="stylesheet" type="text/css" />
<script src="/js/jquery.mousewheel.js" type="text/javascript"></script>
<script src="/js/mwheelIntent.js" type="text/javascript"></script>
<link href="/js/knobKnob/knobKnob.css" rel="stylesheet" type="text/css" />
<link href="/js/knobKnob/styles.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src='http://maps.google.com/maps/api/js?sensor=false'></script>
<script src="/js/jquery.locationpicker.js" type="text/javascript"></script>


<script type="text/javascript">

    function setUpMyTabs() {

        $('.numeric').numeric();
        
         
    }

    $(document).ready(function () {
        setUpMyTabs();


        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () { setUpMyTabs(); });



    });

    
</script>

Hello World