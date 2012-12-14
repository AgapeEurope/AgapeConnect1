<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ViewBoxMenu.ascx.vb"
    Inherits="DotNetNuke.Modules.BoxMenu.ViewBoxMenu" %>
<script src="/js/jquery.jscrollpane.min.js" type="text/javascript"></script>
<link href="/js/jquery.jscrollpane.css" rel="stylesheet" type="text/css" />
<script src="../../../js/jquery.mousewheel.js" type="text/javascript"></script>
<script src="../../../js/mwheelIntent.js" type="text/javascript"></script>
<script type="text/javascript">


    $(function () {
        $('.scroll-pane').jScrollPane();
        var stop = false;
        $("#accordion h3").click(function (event) {
            if (stop) {
                event.stopImmediatePropagation();
                event.preventDefault();
                stop = false;
            }
        });
        $("#accordion")
			    .accordion({
			        header: "> div > h3"
			    })
			    .sortable({
			        axis: "y",
			        handle: "h3",
			        stop: function () {
			            stop = true;
			        }
			    });



    });



</script>
<style type="text/css">
    #demo
    {
        height:420px;
    }
    .scroll-pane
{

	height: 187px;
	width: 100%;
	overflow: auto;
	
}
.WhiteText, .WhiteText p
{
     color: White; 
     font-size: 8pt
}

    .ac_Header
    {
        color: White;
        font-size: 10pt;
        font-weight: bold ;
        width: 105px ;
        height: 24px;
        float: left;
        vertical-align: middle;
        padding-top: 9px;
        text-align:center ;
        
    }
    .ac_SubHeader
    {
        background-color=#F7F7F7;
        color: #CBCBCB ;
        font-size: 9pt;
        font-weight: bold ;
        float: left;
        padding-top: 9px;
        padding-left: 7px;
        height: 24px;
        width: 300px;  /*315*/
    }
    .aLink, .aLink:link, .aLink:visited, .aLink:active 
{
	color: #3E81B5 ;
	 text-decoration: none;
	 
}
    
    aLink:hover 
    {
        text-decoration: none ;
        
        
        border:0;
        border-color: transparent;
        
    }
    
    #aGreenBox
    {
        background: #04B304; /* for non-css3 browsers */
        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#1DBB1D', endColorstr='#04A204'); /* for IE */
        background: -webkit-gradient(linear, left top, left bottom, from(#1DBB1D), to(#04A204)); /* for webkit browsers */
        background: -moz-linear-gradient(top,  #1DBB1D,  #04A204); /* for firefox 3.6+ */    
    }
    #aPurpleBox
    {
        background: #9E1BC9; /* for non-css3 browsers */
        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#9E1BC9', endColorstr='#8402B0'); /* for IE */
        background: -webkit-gradient(linear, left top, left bottom, from(#9E1BC9), to(#8402B0)); /* for webkit browsers */
        background: -moz-linear-gradient(top,  #9E1BC9,  #8402B0); /* for firefox 3.6+ */    
    }
    #aBlueBox
    {
        background: #1B89C9; /* for non-css3 browsers */
        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#1B89C9', endColorstr='#0270B0'); /* for IE */
        background: -webkit-gradient(linear, left top, left bottom, from(#1B89C9), to(#0270B0)); /* for webkit browsers */
        background: -moz-linear-gradient(top,  #1B89C9,  #0270B0); /* for firefox 3.6+ */    
    }
    #aOrangeBox
    {
        background: #FE961A; /* for non-css3 browsers */
        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#FE961A', endColorstr='#E57C01'); /* for IE */
        background: -webkit-gradient(linear, left top, left bottom, from(#FE961A), to(#E57C01)); /* for webkit browsers */
        background: -moz-linear-gradient(top,  #FE961A,  #E57C01); /* for firefox 3.6+ */    
    }
    #aGrayBox
    {
        background: #A3A3A3; /* for non-css3 browsers */
        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#A3A3A3', endColorstr='#8A8A8A'); /* for IE */
        background: -webkit-gradient(linear, left top, left bottom, from(#A3A3A3), to(#8A8A8A)); /* for webkit browsers */
        background: -moz-linear-gradient(top,  #A3A3A3,  #8A8A8A); /* for firefox 3.6+ */    
       
    }
    
    .ac_BlueShelf
    {
       background-image: url(/Portals/0/BlueShelf.gif);   
       background-repeat:no-repeat ;
       background-position: left top ;
       
       margin: 0;
       padding: 0 ;
    }
    .ac_Shelf1
    {
       background-image: url(/Portals/0/Shelf1.gif);   
       background-repeat:no-repeat ;
       background-position: left top ;
       
       margin: 0;
       padding: 0 ;
    }
    
    .ac_ShelfText
    {
        padding: 26px 13px 26px 190px;
        
         height: 205px ;
         
    }
</style>
<div class="demo">
    <div id="accordion">
        <div>
            <h3 style="margin: 0;">
                <a href="#" class="aLink">
                    <div class="ac_Header" id="aGreenBox">
                        <asp:Label ID="lblTitle1" runat="server" resourcekey="Title1"></asp:Label>
                    </div>
                    <div class="ac_SubHeader">
                        <asp:Label ID="lblSubTitle1" runat="server" resourcekey="SubTitle1"></asp:Label>
                    </div>
                    <div style="clear: both;" />
                </a>
            </h3>
            <div class="ac_Shelf1   ">
                <div class="ac_ShelfText">
                    <div style="font-size: 11pt; color: #037c03;">
                        <asp:Label ID="lblShelfTitle1" runat="server" Font-Bold="True" resourcekey="ShelfTitle1"></asp:Label>
                    </div>
                    <div class="scroll-pane" >
                        <asp:Label ID="lblShelf1" runat="server"  CssClass="WhiteText" resourcekey="Shelf1"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <h3 style="margin: 0;">
                <a href="#" class="aLink">
                    <div class="ac_Header" id="aPurpleBox">
                        <asp:Label ID="lblTitle2" runat="server" resourcekey="Title2"></asp:Label>
                    </div>
                    <div class="ac_SubHeader">
                        <asp:Label ID="lblSubTitle2" runat="server" resourcekey="SubTitle2"></asp:Label>
                    </div>
                    <div style="clear: both;" />
                </a>
            </h3>
            <div class="ac_BlueShelf">
                <div class="ac_ShelfText">
                    <div style="font-size: 11pt; color: #50B9E9;">
                        <asp:Label ID="lblShelfTitle2" runat="server" Font-Bold="True" resourcekey="ShelfTitle2"></asp:Label>
                    </div>
                    <div class="scroll-pane">
                        <asp:Label ID="lblShelf2" runat="server"   CssClass="WhiteText"  resourcekey="Shelf2"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <h3 style="margin: 0;">
                <a href="#" class="aLink">
                    <div class="ac_Header" id="aBlueBox">
                        <asp:Label ID="lblTitle3" runat="server" resourcekey="Title3"></asp:Label>
                    </div>
                    <div class="ac_SubHeader">
                        <asp:Label ID="lblSubTitle3" runat="server" resourcekey="SubTitle3"></asp:Label>
                    </div>
                    <div style="clear: both;" />
                </a>
            </h3>
            <div class="ac_BlueShelf">
                <div class="ac_ShelfText">
                    <div style="font-size: 11pt; color: #50B9E9;">
                        <asp:Label ID="lblShelfTitle3" runat="server" Font-Bold="True" resourcekey="ShelfTitle3"></asp:Label>
                    </div>
                    <div class="scroll-pane" >
                        <asp:Label ID="lblShelf3" runat="server"  CssClass="WhiteText"  resourcekey="Shelf3"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <h3 style="margin: 0;">
                <a href="#" class="aLink">
                    <div class="ac_Header" id="aOrangeBox">
                        <asp:Label ID="lblTitle4" runat="server" resourcekey="Title4"></asp:Label>
                    </div>
                    <div class="ac_SubHeader">
                        <asp:Label ID="lblSubTitle4" runat="server" resourcekey="SubTitle4"></asp:Label>
                    </div>
                    <div style="clear: both;" />
                </a>
            </h3>
            <div class="ac_BlueShelf">
                <div class="ac_ShelfText">
                    <div style="font-size: 11pt; color: #50B9E9;">
                        <asp:Label ID="lblShelfTitle4" runat="server" Font-Bold="True" resourcekey="ShelfTitle4"></asp:Label>
                    </div>
                    <div class="scroll-pane" >
                        <asp:Label ID="lblShelf4" runat="server"  CssClass="WhiteText"  resourcekey="Shelf4"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <h3 style="margin: 0;">
                <a href="#" class="aLink">
                    <div class="ac_Header" id="aGrayBox">
                        <asp:Label ID="lblTitle5" runat="server" resourcekey="Title5"></asp:Label>
                    </div>
                    <div class="ac_SubHeader">
                        <asp:Label ID="lblSubTitle5" runat="server" resourcekey="SubTitle5"></asp:Label>
                    </div>
                    <div style="clear: both;" />
                </a>
            </h3>
            <div class="ac_BlueShelf">
                <div class="ac_ShelfText">
                    <div style="font-size: 11pt; color: #50B9E9;">
                        <asp:Label ID="lblShelfTitle5" runat="server" Font-Bold="True" resourcekey="ShelfTitle5"></asp:Label>
                    </div>
                    <div class="scroll-pane" >
                        <asp:Label ID="lblShelf5" runat="server"  CssClass="WhiteText" resourcekey="Shelf5"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End demo -->
