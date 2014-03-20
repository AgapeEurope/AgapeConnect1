<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View_MegaMenu.ascx.cs" Inherits="DNNGo.SkinObject.GoMenu.View_MegaMenu" %>
<div id="gomenu<%=ClientID %>" class="gomenu <%=CssClass %>">
    <asp:Literal ID="LiContent" runat="server"></asp:Literal>
</div>
 
 <script type="text/javascript">
 jQuery(function ($) {
	 
    function megaHoverOver() {
        $(this).addClass('dgn-root-hover').find("div.mega_submenu").stop().show();
    }

    function megaHoverOut() {
        $(this).removeClass('dgn-root-hover').find("div.mega_submenu").stop().fadeOut('fast', function () {
            $(this).hide();
        });
    }
     var config = {
         sensitivity: <%=MegaMenu_Sensitivity %>,
         interval: <%=MegaMenu_Interval %>,
         over: megaHoverOver,
         timeout: <%=MegaMenu_Timeout %>,
         out: megaHoverOut
     };
     $("ul.dnngo_mega li.dgn-root").hoverIntent(config); //Trigger Hover intent with custom configurations

	jQuery('.dnngo_mega .dir').mousemove(function(){
		var mega_win = parseInt($(window).width()) ,
			mega_left= parseInt($(this).offset().left), 
			mega_small=$(this).find('.mega_submenu'),
			mega_small_wid=parseInt(mega_small.css('width'))  ;
		if( mega_win - mega_left < mega_small_wid){
			var dnngo_mega_right='-'+  parseInt(  mega_small_wid + mega_left - mega_win +5) +'px';
			mega_small.css('left',dnngo_mega_right);
		}
	})


 });
jQuery(document).ready(function () {
	jQuery("#gomenu<%=ClientID %>").find("ul.dnngo_mega > li.dir > a").attr("aria-haspopup", "true");
}); 

 
 </script>