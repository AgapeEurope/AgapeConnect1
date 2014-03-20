<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View_Preview.ascx.cs"
    Inherits="DNNGo.SkinObject.StyleSwicth.View_Preview" %>
<asp:Literal ID="LiStyle" runat="server"></asp:Literal>

<script type="text/javascript">
   jQuery(document).ready(function ($) {
        <asp:Literal ID="LiScript" runat="server"></asp:Literal>
   });
</script>

<asp:PlaceHolder ID="phContainer" runat="server"></asp:PlaceHolder>


<asp:HiddenField ID="hfGlobalProject" runat="server" />
<asp:Button ID="cmdGlobalProject" runat="server" OnClick="cmdGlobalProject_Click" style=" display:none;"></asp:Button>
 

<asp:Panel runat="server" ID="panGlobal">
<div id="styler_slider">
    <div class="styler_inner">
        <div class="styler_content">
        	<table width="100%" cellpadding="3">
            <asp:Repeater ID="RepeaterXmlStyleList" runat="server"
                onitemdatabound="RepeaterXmlStyleList_ItemDataBound">
                <HeaderTemplate>
                    <tr id="trGlobalProject1" runat="server">
                        <td colspan="2" class="styler_title"><%=ViewTitle("lblGlobalProject", "Color Scheme", "cbGlobal")%>:</td>
                    </tr>
                    <tr id="trGlobalProject2" runat="server">
                        <td class="styler_control" width="166"><asp:Literal ID="LiControl" runat="server"></asp:Literal></td>
                        <td><asp:CheckBox ID="cbItem" runat="server" /><asp:HiddenField ID="hfName" runat="server" /></td>
                    </tr>
                </HeaderTemplate>
                <ItemTemplate>
                	<tr>
                    	<td colspan="2" class="styler_title"><%#Eval("Alias")%>:</td>
                    </tr>
                    <tr>
                    	<td class="styler_control" width="166"><asp:Literal ID="LiControl" runat="server"></asp:Literal></td>
                        <td><asp:CheckBox ID="cbItem" runat="server" /><asp:HiddenField ID="hfName" runat="server" /></td>
                    </tr>
                    
                </ItemTemplate>
            </asp:Repeater>
           
                    <tr id="trGlobal" runat="server">
                    	<td class="styler_title"> <%=ViewTitle("lblGlobal", "Allow all users to view", "cbGlobal")%>:</td>
                        <td><asp:CheckBox ID="cbGlobal" runat="server" /></td>
                    </tr>
					<tr>
                    	<td colspan="2" align="center">
                            <asp:LinkButton runat="server" ID="cmdUpdate" Text="Update" resourcekey="cmdUpdate" CssClass="update_click" onclick="cmdUpdate_Click"></asp:LinkButton> 
                            <asp:LinkButton runat="server" ID="cmdReset" Text="Reset" resourcekey="cmdReset" CssClass="update_click" onclick="cmdReset_Click"></asp:LinkButton> 
                            <asp:LinkButton runat="server" ID="cmdEdit" Text="Preview" CssClass="update_click" onclick="cmdEdit_Click"></asp:LinkButton> 
                            
                            </td>
                    </tr>

            </table> 
        </div>
    </div>
    <div class="styler_toggler_holder">
        <div id="styler_toggler" class="styler_toggler_off">
        </div>
    </div>
</div>
<script type="text/javascript">
    var Resource_Ajax = "<%=ModulePath %>/Resource_Ajax.aspx";
    var PortalId = <%=PortalId %>;
    //For Color Picker:
    jQuery(document).ready(function ($) {

     <% if(GlobalCheck || IsAdmin)
     { %>
        $('#styler_toggler').bind('click', function () {
            if ($('#styler_slider').css('left') == '0px') {
                DNNGo.hideMenu($);
                DNNGo.setCookie("MenuStatus", false,PortalId);
            } else {
                DNNGo.showMenu($);
                DNNGo.setCookie("MenuStatus", true,PortalId);
            }
        });

        DNNGo.ExpansionMenuStatus($);

        DNNGo.eachColorPicker($('.ColorPicker'));
        DNNGo.eachStyleList($('.ul_StyleList'));
        DNNGo.eachCssList($('.ul_CssList'));
        DNNGo.eachSliderBox($('.sliderbox'));
        <%} %>


        $(".ul_ProjectList li a").click( function () { 
            $("#<%=hfGlobalProject.ClientID %>").val($(this).attr("data-value"));
            $("#<%=cmdGlobalProject.ClientID %>").click();
         });

    });
</script>
</asp:Panel>

