<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Community.ascx.vb" Inherits="DesktopModules_Billboard_controls_Community"
    ClassName="DesktopModules_Billboard_controls_Community" %>
<link rel="stylesheet" type="text/css" href="/DesktopModules/Billboard/BillTheme/BillStyle.css" />
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<script type="text/javascript">
    //var $j = jQuery.noConflict();
    (function ($, Sys) {

        function setUpMyTabs() {

            var stop = false;

            $("#popRep").dialog({
                autoOpen: false,
                width: 250,
                modal: false,
                show: 'fade',
                hide: 'fade',
                dialogClass: 'dialogWithDropShadow',
                resizable: false,
                title: '<div class="Bill_H5" style="text-align:left">Add New:</div>',
                open: function (event, ui) { $('.ui-dialog-titlebar-close').show(); },
                close: function () { afterRepClose(); }
            });
            $("#popRep").parent().appendTo($("form:first"));

            $("#popRep2").dialog({
                autoOpen: false,
                width: 250,
                modal: false,
                show: 'fade',
                hide: 'fade',
                dialogClass: 'dialogWithDropShadow',
                resizable: false,
                title: '<div class="Bill_H5" style="text-align:left">Reply:</div>',
                open: function (event, ui) {
                    $('.ui-dialog-titlebar-close').show();
                },
                close: function () { afterRepClose(); }
            });
            $("#popRep2").parent().appendTo($("form:first"));
            $("#RepError").hide();
            $("#RepError2").hide();
        }
        $(document).ready(function () {
            setUpMyTabs();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpMyTabs();
            });
        });
    } (jQuery, window.Sys));
    function doSomething(e) {
        if (!e) var e = window.event;
        e.cancelBubble = true;
        if (e.stopPropagation) e.stopPropagation();
        showRep2(e);
    }
    function placeValue(oInd, oChoice) {
        var thisHF = '<%= hfChosenComm.ClientID %>';
        var thisSelHF = '<%= hfSelInd.ClientID %>';
        document.getElementById(thisHF).value = oChoice;
        document.getElementById(thisSelHF).value = oInd;
    }
    function placeValue2(oChoice) {
        var thisHF = '<%= hfDeleteThis.ClientID %>';
        document.getElementById(thisHF).value = oChoice;
        raiseAsyncPostback();
        return false;
    }
    function raiseAsyncPostback() {
        __doPostBack("<%= lbFalse.UniqueID %>", "");
    }
    function doSomething2(e) {
        //var e = window.event;
        if (!e) var e = window.event;
        e.cancelBubble = true;
        if (e.stopPropagation) e.stopPropagation();
    }
    function textCounter(field, countfield, maxlimit) {
        if (field.value.length > maxlimit)
            field.value = field.value.substring(0, maxlimit);
        else
            countfield.value = maxlimit - field.value.length;
    }
    function showRep(e) {
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
        $('#popRep').dialog('option', 'position', [posx, (posy - $(window).scrollTop())]);
        $("#popRep").dialog('option', 'draggable', false);
        $("#popRep").dialog("open");
        return false;
    }
    function afterRepClose() {
        var tb1Client = '<%= tbRepComm.ClientId %>';
        var tb2Client = '<%= tbNewComm2.ClientId %>';
        document.getElementById(tb1Client).value = '';
        document.getElementById(tb2Client).value = '';
        var thisHF = '<%= hfChosenComm.ClientID %>';
        document.getElementById(thisHF).value = -1;
        thisHF = '<%= hfDeleteThis.ClientID %>';
        document.getElementById(thisHF).value = -1;
    }
    function showRep2(e) {
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
        $('#popRep2').dialog('option', 'position', [posx, (posy - $(window).scrollTop())]);
        $("#popRep2").dialog('option', 'draggable', false);
        $("#popRep2").dialog("open");
        return false;
    }
    function closeAddComm() {
        var tb2Client = '<%= tbNewComm2.ClientId %>';
        if (document.getElementById(tb2Client).value == '') {
            $('#RepError').show();
            setTimeout(function () { $('#RepError').fadeOut(); }, 1000);
            return false;
        }
        else {
            setTimeout(function () { $('#popRep').dialog('close'); }, 1000);
            return false;
        }
    }
    function closeAddComm2() {
        var tb2Client = '<%= tbRepComm.ClientId %>';
        if (document.getElementById(tb2Client).value == '') {
            $('#RepError2').show();
            setTimeout(function () { $('#RepError2').fadeOut(); }, 1000);
            return false;
        }
        else {
            setTimeout(function () { $('#popRep2').dialog('close'); }, 1000);
            return false;
        }
    }
</script>
<style type="text/css">
    .blankBground
    {
        background-color: transparent;
    }
    .dialogWithDropShadow
    {
        -webkit-box-shadow: 0px 0px 20px #000;
        -moz-box-shadow: 0px 0px 20px #000;
        box-shadow: 0px 0px 20px #000;
    }
    .hideThis
    {
        display: none;
    }
</style>
<asp:HiddenField ID="hfThisUser" runat="server" />
<asp:HiddenField ID="hfChosenComm" runat="server" />
<asp:HiddenField ID="hfSelInd" runat="server" Value = -1 />
<asp:HiddenField ID="hfMode" runat="server" />
<asp:HiddenField ID="hfDeleteThis" runat="server" />

<div style="background-color: #0670A2;">
      <asp:LinkButton ID="lbFalse" runat="server" style="display:none;"> 
    LinkButton 
</asp:LinkButton>

    
    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
        <div style="text-align:center">
<asp:Label ID="lblNoComm" runat="server" Visible="false" class="Bill_Text_Side" Font-Size="7pt"></asp:Label>
</div>
            <asp:Accordion ID="accMain" runat="server" AutoSize="None" FadeTransitions="true"
                TransitionDuration="250" FramesPerSecond="40" SuppressHeaderPostbacks="true"
                Width="100%" RequireOpenedPane="false" SelectedIndex="-1" ContentCssClass="Bill_dashed_white"
                HeaderCssClass="Bill_dashed_white" HeaderSelectedCssClass="blankBground">
                <HeaderTemplate>
                    <table style="cursor: pointer;" width="100%">
                        <tr>
                            <td valign="top">
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# GetCommImage(Eval("BillboardCommId")) %>'
                                    Width="30px" />
                            </td>
                            <td valign="top" style="line-height: 1em; text-align:justify !important;" class="Bill_Text_Side">
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Text") %>' Font-Size="7pt"></asp:Label>
                            </td>
                            <td valign="top" align="right">
                                <a onclick="doSomething2(); placeValue2(<%#Eval("BillboardCommId") %>);">
                                    <asp:Image ID="Image3" runat="server" AlternateText="Delete Thread" ToolTip="Delete Thread"
                                        ImageUrl="~/DesktopModules/Billboard/images/BlueCross2.png" Width="10px" Visible='<%# AllowDelete(Eval("BillboardCommId")) %>'
                                        Enabled='<%# AllowDelete(Eval("BillboardCommId")) %>' /></a>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <table width="100%">
                                    <tr>
                                        <td align="left">
                                            <asp:Label ID="Label5" runat="server" Text='<%# Eval("DisplayName") %>' Font-Size="7pt"
                                                    CssClass="Bill_Text_Side"></asp:Label>
                                        </td>
                                        <td align="right">
                                            <asp:Label ID="Label6" runat="server" Text='<%# CDate(Eval("DateSub")).ToString("dd/MM/yyyy") %>'
                                                    Font-Size="7pt" CssClass="Bill_Text_Side"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                            
                                        
                                            
     
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="font-style: italic; padding-right:7px;" width="100%">
                            <table width="100%">
                            <tr>
                            <td align="left" style="padding-top:7px">
                            <a onclick="doSomething(); placeValue(<%# Container.DataItemIndex %>, <%# Eval("BillboardCommId") %>);" style="cursor: pointer;">
                                        <asp:Image ID="Image4" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/Reply1.gif" onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/Reply2.gif';"
                                            onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/Reply1.gif';" runat="server" /></a>
                            </td>
                            <td align="right">
                            <asp:Label ID="Label2" style="clear:right;" runat="server" Text='<%# GetReplies(Eval("BillboardCommId")) %>'
                                    Font-Size="6pt" CssClass="Bill_Text_Side"></asp:Label>
                            </td>
                            </tr>
                            </table>
                            </td>
                        </tr>
                    </table>
                </HeaderTemplate>
                <ContentTemplate>
                    <asp:HiddenField ID="hfThisId" runat="server" Value='<%# Eval("BillboardCommId") %>' />
                    <asp:DataList ID="dlChoice" runat="server" OnItemCommand="dlChoice_ItemCommand">
                        <ItemTemplate>
                            <table width="100%">
                                <tr>
                                    <td>
                                        <table>
                                            <tr>
                                                <td valign="top">
                                                    <asp:Image ID="Image2" runat="server" Height="20px" ImageUrl="~/DesktopModules/Billboard/images/Arrow2.png" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="top">
                                                    <a onclick="doSomething2(); placeValue2(<%#Eval("BillboardCommId") %>);" style="cursor: pointer;">
                                                        <asp:Image ID="Image3" runat="server" AlternateText="Delete Thread" ToolTip="Delete Reply"
                                                            ImageUrl="~/DesktopModules/Billboard/images/BlueCross2.png" Width="10px" Visible='<%# AllowDelete(Eval("BillboardCommId")) %>'
                                                            Enabled='<%# AllowDelete(Eval("BillboardCommId")) %>' /></a>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="padding-top:25px;">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblRepText" runat="server" Text='<%# Eval("Text") %>' Font-Size="7pt"
                                                        CssClass="Bill_Text_Side"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="right" class="Bill_Text_Side" style="font-size: 7pt; font-style: italic">
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("DisplayName") %>'></asp:Label>,&nbsp;
                                                    <asp:Label ID="Label4" runat="server" Text='<%# CDate(Eval("DateSub")).ToString("dd/MM/yyyy") %>'></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:DataList>
                    <br />
                </ContentTemplate>
            </asp:Accordion>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="lbFalse" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
</div>
<br />
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <a style="cursor: pointer;" onclick="showRep();">
            <asp:Image ID="Image4" Height="20px" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/AddNew1.gif"
                onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/AddNew2.gif';" onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/AddNew1.gif';"
                runat="server" />
        </a>
        <asp:Label ID="lblTest" runat="server"></asp:Label><br />

        <div id="popRep" style="text-align:left;">
            <div style="font-size: 7pt; display: inline; text-align:left;">
                <asp:TextBox ID="tbNewComm2" runat="server" Width="200px" Rows="3" TextMode="MultiLine"
                    MaxLength="300" onkeyup='textCounter(this, this.form.remLenComm2, 300);' onkeydown="textCounter(this, this.form.remLenComm2, 300);"></asp:TextBox><br />
                <input readonly="readonly" type="text" name="remLenComm2" size="3" maxlength="3"
                    value="300" /><asp:Label ID="Label7" runat="server" Text=" characters left" Font-Size="7pt"
                        Font-Names="verdana"></asp:Label><br />
                <asp:Label ID="Label8" runat="server" ForeColor="Red" Visible="false"></asp:Label>
            </div>
            <div style="text-align:right;">
            <asp:ImageButton ID="btnNewComm2" Height="24px" runat="server" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/Post1.gif"
                onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/Post2.gif';" onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/Post1.gif';"
                AlternateText="Post" ToolTip="Post" OnClientClick="closeAddComm();" />
                </div>
                <div id="RepError" style="font-family:Verdana; font-size:8pt; color:red; text-align:left;">You must type something in the box.</div>
            <asp:Label ID="lblNewError" runat="server" ForeColor="Red" Visible="false"></asp:Label>
        </div>

        <div id="popRep2" style="text-align:left;">
            <div style="font-size: 7pt; display: inline; text-align:left;">
                <asp:TextBox ID="tbRepComm" runat="server" Width="200px" Rows="3" TextMode="MultiLine"
                    MaxLength="300" onkeyup='textCounter(this, this.form.remLenComm3, 300);' onkeydown="textCounter(this, this.form.remLenComm3, 300);"></asp:TextBox><br />
                <input readonly="readonly" type="text" name="remLenComm3" size="3" maxlength="3"
                    value="300" /><asp:Label ID="Label9" runat="server" Text=" characters left" Font-Size="7pt"
                        Font-Names="verdana"></asp:Label><br />
                <asp:Label ID="Label10" runat="server" ForeColor="Red" Visible="false"></asp:Label>
            </div>
            <div style="text-align:right;">
            <asp:ImageButton ID="btnRepComm2" Height="24px" runat="server" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/Post1.gif"
                onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/Post2.gif';" onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/Post1.gif';"
                AlternateText="Post" ToolTip="Post" OnClientClick="closeAddComm2();" />
            </div>
            <div id="RepError2" style="font-family:Verdana; font-size:8pt; color:red; text-align:left;">You must type something in the box.</div>
        </div>

    </ContentTemplate>
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="btnNewComm2" EventName="Click" />
        <asp:AsyncPostBackTrigger ControlID="btnRepComm2" EventName="Click" />
    </Triggers>
</asp:UpdatePanel>
