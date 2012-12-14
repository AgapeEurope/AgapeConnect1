<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ViewArt.ascx.vb" Inherits="DesktopModules_Billboard_controls_ViewArt_ViewArt" ClassName="DesktopModules_Billboard_controls_ViewArt_ViewArt" %>
<link rel="stylesheet" type="text/css" href="/DesktopModules/Billboard/BillTheme/BillStyle.css" />
<script type="text/javascript" >
    var useBSNns;

    if (useBSNns) {
        if (typeof (bsn) == "undefined")
            bsn = {}
        var _bsn = bsn;
    }
    else {
        var _bsn = this;
    }




    _bsn.Crossfader = function(divs, fadetime, delay) {
        this.nAct = -1;
        this.aDivs = divs;

        for (var i = 0; i < divs.length; i++) {
            document.getElementById(divs[i]).style.opacity = 0;
            document.getElementById(divs[i]).style.position = "absolute";
            document.getElementById(divs[i]).style.filter = "alpha(opacity=0)";
            document.getElementById(divs[i]).style.visibility = "hidden";
        }

        this.nDur = fadetime;
        this.nDelay = delay;
 this.IsActive = true;
        this.direction = 1;
        this._newfade();
       

    }



    _bsn.Crossfader.prototype._newfade = function() {


        if (this.IsActive == false )
            return false;
        if (this.nID1)
            clearInterval(this.nID1);

       this.nOldAct = this.nAct;
        this.nAct += this.direction;
        if (this.nAct == -1)
            this.nAct = this.aDivs.length - 1;

        
        if (!this.aDivs[this.nAct]) this.nAct = 0;

        if (this.nAct == this.nOldAct)
            return false;

        document.getElementById(this.aDivs[this.nAct]).style.visibility = "visible";
       document.getElementById("lblStatus").innerHTML = '(' + (this.nAct + 1);
       
        this.nInt = 50;
        this.nTime = 0;

        var p = this;
        this.nID2 = setInterval(function() { p._fade() }, this.nInt);

    }


    _bsn.Crossfader.prototype._fade = function() {
        this.nTime += this.nInt;

        var ieop = Math.round(this._easeInOut(this.nTime, 0, 1, this.nDur) * 100);
        var op = ieop / 100;
        document.getElementById(this.aDivs[this.nAct]).style.opacity = op;
        document.getElementById(this.aDivs[this.nAct]).style.filter = "alpha(opacity=" + ieop + ")";

        if (this.nOldAct > -1) {
            document.getElementById(this.aDivs[this.nOldAct]).style.opacity = 1 - op;
            document.getElementById(this.aDivs[this.nOldAct]).style.filter = "alpha(opacity=" + (100 - ieop) + ")";
            
        }

        if (this.nTime == this.nDur) {
            clearInterval(this.nID2);

            if (this.nOldAct > -1)
                document.getElementById(this.aDivs[this.nOldAct]).style.visibility = "hidden";

            var p = this;
            this.nID1 = setInterval(function() { p._newfade() }, this.nDelay);
        }
    }



    _bsn.Crossfader.prototype._easeInOut = function(t, b, c, d) {
        return c / 2 * (1 - Math.cos(Math.PI * t / d)) + b;
    }


    gotoNext = function() {
        if (cf.IsActive == false) {
            
            cf.IsActive = true;
            clearInterval(cf.nID1);
            cf._newfade();
            cf.IsActive = false;
        }
        else{
            if (cf.nTime < cf.nDur)
                return;
            clearInterval(cf.nID1);
            clearInterval(cf.nID2);
            cf._newfade();
        }
    }

    gotoPrev = function() {
        if (cf.IsActive == false) {

            cf.IsActive = true;
            clearInterval(cf.nID1);
            clearInterval(cf.nID2);
            cf.direction = -1;
            cf._newfade();
            cf.direction = 1; 
            cf.IsActive = false;
        }
        else {
            clearInterval(cf.nID2);
            clearInterval(cf.nID1);
            cf.direction = -1;
            cf._newfade();
            cf.direction = 1; 
              
        }
    }

    holdPause = function () {
        if (cf.IsActive == false) {

            document.getElementById("btnPause2").style.height = "";
            document.getElementById("btnPause2").style.width = "";
            document.getElementById("btnPause2").style.display = "inline";
            document.getElementById("btnPause").style.height = "0";
            document.getElementById("btnPause").style.width = "0";
            document.getElementById("btnPause").style.display = "none";

            document.getElementById("btnPlay").style.height = "";
            document.getElementById("btnPlay").style.width = "";
            document.getElementById("btnPlay").style.display = "inline";
            document.getElementById("btnPlay2").style.height = "0";
            document.getElementById("btnPlay2").style.width = "0";
            document.getElementById("btnPlay2").style.display = "none";
        }
    }
    holdPlay = function () {
        if (cf.IsActive == true) {
            document.getElementById("btnPause").style.height = "";
            document.getElementById("btnPause").style.width = "";
            document.getElementById("btnPause").style.display = "inline";
            document.getElementById("btnPause2").style.height = "0";
            document.getElementById("btnPause2").style.width = "0";
            document.getElementById("btnPause2").style.display = "none";

            document.getElementById("btnPlay2").style.height = "";
            document.getElementById("btnPlay2").style.width = "";
            document.getElementById("btnPlay2").style.display = "inline";
            document.getElementById("btnPlay").style.height = "0";
            document.getElementById("btnPlay").style.width = "0";
            document.getElementById("btnPlay").style.display = "none";
        }
    }
</script>

	<style type="text/css">

#wrapper {
		width: 100%;
		margin: 10px auto;
		text-align: center;
		 
				}

	#thiscontent {
		font-size: 1.2em;
		line-height: 1.8em;
		color:#666666;
	}


.Agape_RTitle_Green
{
	 font-weight:Bold ;
	 letter-spacing: -2 ;
	font-family: Verdana ;
	font-size: 36px;
	color: #466629;
	 text-align:left ;
}	


	/* STYLES FOR CROSSFADER */



	div.cf_wrapper
	{
		position: relative;

	}
	
	div.cf_element
	{
		
		
		height: 150px;
		cursor: pointer ;
	}
	
	div.cf_element div.content
	{
		padding: 10px;
	}

	div.cf_element div.content h3
	{
		padding-top: 0;
		margin-top: 0;
	}
    .hideMe
    {
        display:none;   
    }
</style>

	<div align="center" style="width:100%; clear:both;">
	<div align="left" style="width:100%; height: 150px; ">

	<div class="cf_wrapper">
	
	
        <asp:PlaceHolder ID="ProductsPH" runat="server"></asp:PlaceHolder>

		
	</div>	</div></div>


<div align="right">
    <asp:Panel ID="pnlButtons" runat="server" Visible="true">
    <div style="display:inline; vertical-align:middle; font-size:20px;">
    <div style="width:38px;display:inline;padding-top:inherit; vertical-align:inherit; font-size:inherit;">
    <img id="btnPrev" src="/DesktopModules/Billboard/images/BlueBack.gif"  onclick="gotoPrev();"     style="cursor: pointer;"                                          
                                                onmouseover="this.src='/DesktopModules/Billboard/images/BlueBack2.gif';"  
                                                onmouseout="this.src='/DesktopModules/Billboard/images/BlueBack.gif';" alt="Prev" title="Prev" />
    </div>
    <div style="width:38px; display:inline; vertical-align:inherit; font-size:inherit;">
     <img id="btnPause" src="/DesktopModules/Billboard/images/BluePause.gif" onclick="cf.IsActive=false; clearInterval(cf.nID1); clearInterval(cf.nID2); cf.nTime = cf.nDur; holdPause();"
 onmouseover="this.src='/DesktopModules/Billboard/images/BluePause2.gif';" style="cursor:pointer; display:inline;"
 onmouseout="this.src='/DesktopModules/Billboard/images/BluePause.gif';" alt="Pause" title="Pause" />   
 <img id="btnPause2" src="/DesktopModules/Billboard/images/BluePause3.gif" alt="Pause" title="Pause" style="cursor:pointer; height:0; width:0; display:none;" />  
    </div>
    <div style="display:inline; position: relative; font-size:12px;">
 <span id="lblStatus" style="display:inline; vertical-align:inherit;"></span>  
     <asp:Label ID="lblOf" runat="server" resourcekey="lblOf" Text="of" style="vertical-align:inherit;"></asp:Label> 
    <asp:Label ID="lblTotal" runat="server" style="vertical-align:inherit;"></asp:Label>   
    </div>
    <div style="width:38px;display:inline; vertical-align:inherit; font-size:inherit;">
   <img id="btnPlay" src="/DesktopModules/Billboard/images/BluePlay.gif" onclick="cf.IsActive=true; clearInterval(cf.nID1); clearInterval(cf.nID2); cf._newfade(); holdPlay();"
 onmouseover="this.src='/DesktopModules/Billboard/images/BluePlay2.gif';" style="cursor:pointer; height:0; width:0; display:none;"
 onmouseout="this.src='/DesktopModules/Billboard/images/BluePlay.gif';" alt="Play" title="Play" />
  <img id="btnPlay2" src="/DesktopModules/Billboard/images/BluePlay3.gif" alt="Play" title="Play" style="cursor:pointer; display:inline;" />   
    </div>
    <div style="width:38px;display:inline; vertical-align:inherit; font-size:inherit;">
     <img id="btnNext" src="/DesktopModules/Billboard/images/BlueNext.gif" onclick=" gotoNext() " onmouseover="this.src='/DesktopModules/Billboard/images/BlueNext2.gif';"  style="cursor: pointer;" 
                                                onmouseout="this.src='/DesktopModules/Billboard/images/BlueNext.gif';" alt="Next" title="Next" /> 
    </div>
    </div>
                                   
</asp:Panel>

</div>
	 
	
<asp:PlaceHolder ID="loadscriptPH" runat="server"></asp:PlaceHolder>
<asp:Label ID="lblOutput" runat="server" ></asp:Label>