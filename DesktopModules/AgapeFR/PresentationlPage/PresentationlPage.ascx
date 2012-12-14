<%@ Control Language="VB" AutoEventWireup="false" CodeFile="PresentationlPage.ascx.vb"
    Inherits="DotNetNuke.Modules.AgapeFR.PresentationlPage.PresentationlPage" %>
<%@ Register Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" TagPrefix="cc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<script src="/js/jquery.numeric.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">

    (function ($, Sys) {
        function setUpMyTabs() {
            $('.aButton').button();
        }
        $(document).ready(function () {
            setUpMyTabs();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpMyTabs();
            });
        });
    } (jQuery, window.Sys));

</script>
<asp:HiddenField ID="RowId" runat="server" />
<asp:HiddenField ID="DonationType" runat="server" />
<asp:HiddenField ID="hfUserId1" runat="server" Value="-1" />
<div align="left" style="font-size: 10pt;">
    <div style="width: 700px; float: left;">
    <div id="GiveTitle" runat="server" class="AgapeH2" style="margin-bottom: 12px;">
        <asp:Label ID="Title" runat="server"></asp:Label>
    </div>
    <div>
        <asp:Label ID="GiveTextLbl" runat="server"></asp:Label>
    </div>
    </div>
    <div style="float: right; font-size: 10pt;">
        <asp:Image ID="theImage1" runat="server" Width="300px" BorderColor="Black" BorderStyle="Solid"
            BorderWidth="2px" EnableViewState="False" />
        <br />
        <asp:Button ID="btnGive" runat="server" Text="Give" CssClass="aButton" />
        <asp:Button ID="btnEditProfile" runat="server" Text="Edit Profile" CssClass="aButton" />
    </div>
</div>
