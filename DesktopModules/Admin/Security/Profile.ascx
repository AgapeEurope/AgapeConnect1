<%@ Control Language="C#" AutoEventWireup="false" Inherits="DesktopModules.Admin.Security.DNNProfile" CodeFile="Profile.ascx.cs" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls"%>
<script language="javascript" type="text/javascript">
/*globals jQuery, window, Sys */
(function ($, Sys) {
    function setUpProfile() {

        $('div[name$="_visibility"] > a').click(function () {
            var visibilityMenu = $(this).parent().children("ul");
            if ($(this).hasClass('dnnFormActive')) {
                //show this menu
                visibilityMenu.slideUp('slow'); ;

                $(this).removeClass('dnnFormActive');
            }
            else {
                //hide any menu that is currently open
                $('div[name$="_visibility"] > ul').hide();
                $('div[name$="_visibility"] > a').removeClass('dnnFormActive');

                //show this menu
                visibilityMenu.slideDown('slow', function () {
                    showHideOptions(visibilityMenu.find('li > input[name$="_visibility"]:checked'));
                }); ;

                $(this).addClass('dnnFormActive');
            }
        });

        $('div[name$="_visibility"] > ul').mouseleave(function () {
            $(this).slideUp('slow');
            $(this).parent().children("a").removeClass('dnnFormActive');
        });

        $('input[name$="_visibility"]').click(function () {
            showHideOptions($(this));
        });

        function showHideOptions(visibility) {
            var options = visibility.parent().parent().children("ul");
            if (visibility.val() == "3") {
                options.slideDown('slow');
            } else {
                options.slideUp('slow');
            }
        }
    }

    $(document).ready(function () {
        setUpProfile();
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            setUpProfile();
        });
    });
} (jQuery, window.Sys));
</script>
<div class="dnnForm dnnProfile dnnClear">
	<h2 id="divTitle" runat="server" class="dnnFormSectionHead"><asp:label id="lblTitle" runat="server" /></h2>
	<fieldset>
		<div class="propertyList">
			<dnn:ProfileEditorControl id="ProfileProperties" runat="Server" enableClientValidation="true" />
		</div>
		<ul id="actionsRow" runat="server" class="dnnActions dnnClear">
			<li><asp:LinkButton class="dnnPrimaryAction" id="cmdUpdate" runat="server" resourcekey="cmdUpdate" /></li>
		</ul>
	</fieldset>
</div>