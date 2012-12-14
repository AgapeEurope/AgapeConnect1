<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ViewBillboardFeatArt.ascx.vb" Inherits="DotNetNuke.Modules.BillboardFeatureArt.ViewBillboardFeatArt" %>
<%@ Register Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" TagPrefix="cc2" %>
<%@ Register src="~/DesktopModules/Billboard/controls/FeatArchive.ascx" tagname="billArch" tagprefix="uc2" %>
<%@ Register src="~/DesktopModules/Billboard/controls/ViewFeature.ascx" tagname="viewFeat" tagprefix="uc3" %>
<link rel="stylesheet" type="text/css" href="/DesktopModules/Billboard/BillTheme/BillStyle.css" />

<script type="text/javascript">
    function setUpMyFeat() {
        $('.openFirst').hide();
        $('#pane1').show();
        $('.rightArrow').hide();
        var ieLeft = 0;
        if (/MSIE (\d+\.\d+);/.test(navigator.userAgent)) {
            ieLeft = 5;
        }
        if ($('.openFirst').length > 0) {
            $('#rightArrow').css('left', 120 + ieLeft).show();
        }
        $('#fullTable').click(function (e) {
            var posx = 0;
            var posy = 0;
            if (!e) var e = window.event;
            if (e.pageX || e.pageY) {
                posx = e.pageX;
                posy = e.pageY;
            }
            else if (e.clientX || e.clientY) {
                posx = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
                posy = e.clientY + document.body.scrollTop + document.documentElement.scrollTop;
            }
            if (document.getElementById('hfGoAhead').value == 1)
            {
            $('#rightArrow').css('top', (posy - findPos(this)));
            document.getElementById('hfGoAhead').value = 0;
            }
        return false;
    });
    }
    function findPos(obj) {
        var curtop = 0;
        if (obj.offsetParent) {
            do {
                curtop += obj.offsetTop;
            } while (obj = obj.offsetParent);
        }
        return [curtop];
    }
    function showThis(oChoice) {
        document.getElementById('hfGoAhead').value = 1;
        var thisChoice = oChoice;
        $('.openFirst').hide();
        $('.rightArrow').hide();
        $('#rightArrow').animate({ width: 'toggle' }, 350)
        setTimeout(function () { $('#pane' + thisChoice).fadeIn(350); }, 350);
        return false;
    }
    function goThereFeat(oChoice) {
        var thisHF = '<%= hfGoThere.ClientID %>';
        document.getElementById(thisHF).value = oChoice;
        raisePostbackFeat();
        return false;
    }
    function raisePostbackFeat() {
        __doPostBack("<%= lbFalseFeat.UniqueID %>", "");
    }
</script>
<style type="text/css">
.openFirst
    {
        position:absolute;
        vertical-align:top;
        -moz-border-radius-topleft: 10px; -webkit-border-top-left-radius: 10px; -khtml-border-top-left-radius: 10px; border-top-left-radius: 10px;
        -moz-border-radius-topright: 10px; -webkit-border-top-right-radius: 10px; -khtml-border-top-right-radius: 10px; border-top-right-radius: 10px;
        -moz-border-radius-bottomleft: 10px; -webkit-border-bottom-left-radius: 10px; -khtml-border-bottom-left-radius: 10px; border-bottom-left-radius: 10px;
        -moz-border-radius-bottomright: 10px; -webkit-border-bottom-right-radius: 10px; -khtml-border-bottom-right-radius: 10px; border-bottom-right-radius: 10px;
        border:2px solid #0670A3;
        height:390px;
        padding:5px; 
    }
    .rightArrow
    {
        position:absolute;
        }
    .typeChoice
    {
        font-size:10pt;
        font-weight:bold;
    }
    .dotBottom
    {
        background-position:bottom;
        background-repeat:repeat-x;
        background-image:url('http://www.agape.org.uk/images/dashed2.png');
    }
</style>

<input id="hfGoAhead" type="hidden" />
<asp:HiddenField ID="hfFeatureId" runat="server" />

<div style="text-align:left; width:550px;">
<asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false"></asp:Label><br />
<asp:Image ID="imgHeader" runat="server" 
    ImageUrl="~/DesktopModules/Billboard/images/BillFeat.gif" />
<asp:Panel ID="pnlMainContent" runat="server" style="width:550px">
<div class="Bill_dashed">&nbsp;</div>


<asp:LinkButton ID="btnMain" runat="server" style="cursor:pointer; text-decoration:none;">

<div style="display: block; clear: both; width:550px; height:150px;">

<div style="width:125px; height:125px; float:left;" class="Bill_Photo"><asp:Image ID="imgMain" runat="server" Width="125px" Height="125px" /></div>

<div style="width:405px; vertical-align:top; float:right;">

<div style="width:405px; margin-bottom:5px;" class="Bill_H3"><asp:Label ID="lblTitle" runat="server"></asp:Label></div>

<div style="width:405px; color:#0670A2; font-family:Verdana; font-size:10pt; font-style:italic; text-align:right;"><asp:Label ID="lblType" runat="server"></asp:Label></div>

<div style="width:405px; font-size:10pt;" class="Bill_Text_Front"><asp:Label ID="lblMainText" runat="server"></asp:Label></div>

</div>

</div>

</asp:LinkButton>

<div style="clear: both;" />
<div class="Bill_dashed">&nbsp;</div>
<asp:ImageButton ID="btnArchive" runat="server" Height="24px" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/ViewArchive1.gif"  
                                                onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/ViewArchive2.gif';"  
                                                onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/ViewArchive1.gif';" AlternateText="View Archive" ToolTip="View Archive" OnClientClick="showViewFeat(); return false;"/>
</asp:Panel>
</div>


<div id="divViewFeat" class="padInner">
<div id="ViewFeatInner" style="overflow:hidden; padding-right:10px; height:400px;">

<asp:HiddenField ID="hfGoThere" runat="server" />
<asp:LinkButton ID="lbFalseFeat" runat="server" style="display:none;">LinkButton</asp:LinkButton>
<div id="fullTable" style="width:550px; height:390px;">
<table>
<tr>
<td valign="top" width="100px" height="390px" align="right">

<asp:PlaceHolder runat="server" ID="phChoices"></asp:PlaceHolder>

</td>
<td valign="top" width="20px" height="390px"><img alt="" id="rightArrow" src="../../../DesktopModules/Billboard/images/rightArrow.gif" width="20px" class="rightArrow" /><br />
<asp:PlaceHolder runat="server" ID="phArrows"></asp:PlaceHolder></td>    
<td valign="top" width="400px" height="390px">
<asp:PlaceHolder runat="server" ID="phPanes"></asp:PlaceHolder>
</td>
</tr>
</table>
</div>
<%--<uc2:billArch ID="billArch1" runat="server" />--%>

</div>
</div>