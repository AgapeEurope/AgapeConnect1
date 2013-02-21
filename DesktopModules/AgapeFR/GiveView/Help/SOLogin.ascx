<%@ Control Language="VB" AutoEventWireup="false" CodeFile="SOLogin.ascx.vb" Inherits="DotNetNuke.Modules.AgapeFR.GiveView.SOLogin" %>
<%--<%@ Register src="../../admin/Users/manageusers.ascx" tagname="manageusers" tagprefix="uc2" %>--%>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<script type="text/javascript" language="javascript">

    (function ($, Sys) {
        function setUpMyTabs() {
            $('.aButton').button();
            $('.numeric').numeric();
        }
        $(document).ready(function () {
            setUpMyTabs();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpMyTabs();
            });
        });
    } (jQuery, window.Sys));

</script>

<h3>Give Regularly by Standing Order</h3>
Thank you for agreeing to set up a standing order. Please either log in or enter
your personal details to continue.
<br />
<br />
<asp:Button ID="btnSOContinue" runat="server" Text="Continue" CssClass="aButton" />