<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Setting_TonkenCenter.ascx.cs" Inherits="DNNGo.Modules.DNNGallery.Setting_TonkenCenter" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

 <script type="text/javascript">
     var tb_pathToImage = "<%=ModulePath %>Resource/images/loadingAnimation.gif";
 </script>
<asp:Panel ID="plLicense" runat="server">

<asp:PlaceHolder ID="phScript" runat="server"></asp:PlaceHolder>
<div id="mo_wrapper">
    <div id="mo_head" class="clearfix">
        <div class="mo_title">
            <asp:Literal ID="litModuleTitle" runat="server"></asp:Literal>
            <asp:Literal ID="litModuleVersion" runat="server"></asp:Literal>
            <asp:Literal ID="litUpdateVersion" runat="server"></asp:Literal>
            </div>
        <div class="mo_author">
            <asp:Literal ID="litLicense" runat="server"></asp:Literal>
            version by <a href="http://www.DNNGo.net" target="_blank">DNNGo.net</a></div>
    </div>
    <div id="mo_info">
        <span class="back">
            <asp:LinkButton ID="lbBack" runat="server" OnClick="lbBack_Click" CausesValidation="false">
                <asp:Label ID="lblBack" runat="server" Text="Back"></asp:Label></asp:LinkButton>
                </span>
        <ul class="help_link">
            <li class="buyit"><a target="_blank" href="http://www.dnngo.net/DNNStore/tabid/58/CategoryID/105/List/0/Level/a/ProductID/468/Default.aspx">
                <asp:Label ID="lblBuyIt" runat="server">Buy It</asp:Label></a></li>
            <li class="document"><a target="_blank" href="http://www.dnngo.net/FreeDownloads/tabid/184/token/ViewInfo/ItemId/181/Default.aspx">
                <asp:Label ID="Label2" runat="server">Document</asp:Label></a> </li>
            <li class="contactus"><a target="_blank" href="http://www.DNNGo.net/Contactus.aspx">
                <asp:Label ID="Label4" runat="server">Contact Us</asp:Label></a> </li>
            <li class="help"><a target="_blank" href="http://www.DNNGo.net/Contactus/OnlineSupportTicket.aspx">
                <asp:Label ID="Label5" runat="server">Help</asp:Label></a> </li>
        </ul>
    </div>
    <div class="mo_breadcrumb clearfix">
      <asp:Label ID="lblEffectName"  runat="server" CssClass="EffectName"></asp:Label>  <asp:Label ID="lblMessage"  runat="server" CssClass="LI_Message"></asp:Label>
    </div>
    <div id="mo_content">
        <div id="contact_tabs">
            <ul class="tabs_nav clearfix">
                <asp:Literal ID="LiJqueryTabs"   runat="server"></asp:Literal>
            </ul>
             <asp:Repeater ID="rpJqueryPanels" runat="server" OnItemDataBound="rpJqueryPanels_OnItemDataBound">
                <ItemTemplate>
                    <asp:Literal ID="LiContainer" runat="server"></asp:Literal>
                   <%-- <div id="tabs-<%#(Container.ItemIndex +1) %>" class="ui-tabs-panel ui-widget-content ui-corner-bottom">--%>
                        <div class="mod_container">
                            <asp:PlaceHolder  ID="phContainer" runat="server"></asp:PlaceHolder>
                        </div>
                     <asp:Literal ID="LiContainerEnd" runat="server" Text="</div>"></asp:Literal>
                </ItemTemplate>
             
             </asp:Repeater>
  
        </div>
    </div>
</div>
<script type="text/javascript">
    jQuery(function (q) {
        jQuery("input:submit, a, button", ".demo").button();
        jQuery("a", ".demo").click(function () { return false; });

        /*展示框的属性*/
        q("h3[class='hndle']").each(function (i, n) {
            q(this).click(function () { q(this).parent().find("div[class='inside']").toggle(50); });
        });

        q("#Form").validationEngine({
            promptPosition: "centerRight"
        });

    });

    function CancelValidation() {
        jQuery('#Form').validationEngine('detach');
    }
</script>



</asp:Panel>
<asp:Panel ID="pnlTrial" runat="server">
    <center>
        <asp:Literal ID="litTrial" runat="server"></asp:Literal>
        <br />
        <asp:Label ID="lblMessages" runat="server" CssClass="SubHead" resourcekey="lblMessages"
            Visible="false" ForeColor="Red"></asp:Label>
    </center>
</asp:Panel>


 