<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View_MultiMenu.ascx.cs" Inherits="DNNGo.SkinObject.GoMenu.View_MultiMenu" %>
<div class="menu_main">
  <div id="multi_menu<%=ClientID %>" class="multi_menu">
<asp:Literal ID="LiContent" runat="server"></asp:Literal>
   </div>
</div>



<script type="text/javascript">
    jQuery(function ($) {
        $("#multi_menu<%=ClientID %>").accordion({
            accordion: true,
            speed: 300,
            closedSign: '+',
            openedSign: '-'
        });
    }); 
</script>
