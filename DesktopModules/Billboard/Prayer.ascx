<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Prayer.ascx.vb" Inherits="DotNetNuke.Modules.Billboard.Prayer" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<link rel="stylesheet" type="text/css" href="/DesktopModules/Billboard/BillTheme/BillStyle.css" />

<script type="text/javascript">
    $(document).ready(function () {
    });

    function showPopMesg() {
        var popID = 'popMesg';
        var popWidth = 300;
        fadePopMesg(popID, popWidth);
        return false;
    }

    function fadePopMesg(oElementID, oWidth) {
        $('#' + oElementID).hide();
        $('#' + oElementID).fadeIn('slow').css({ 'width': Number(oWidth), 'height': '100' }).delay(3000).fadeOut('slow');
        var thisScrollTop = $(window).scrollTop();
        if (!thisScrollTop) { thisScrollTop = 0; }
        var popMargTop = ($(window).scrollTop() + $(window).height()) - $('#mainBox').offset().top;
        var popMargLeft = $('#mainBox').offset().left;
        $('#' + oElementID).css({
            'position': 'fixed !important',
            'position': 'absolute',
            'top': (popMargTop - 150) + 'px',
            'left': (0 - popMargLeft + 25) + 'px'
        });
        return false;
    }


    function textCounter(field, countfield, maxlimit) {
        if (field.value.length > maxlimit)
            field.value = field.value.substring(0, maxlimit);
        else
            countfield.value = maxlimit - field.value.length;
    }
    function doSomething(e) {
        if (!e) var e = window.event;
        e.cancelBubble = true;
        if (e.stopPropagation) e.stopPropagation();
        return false;
    }
</script>
<style type="text/css">
    .popup_block2
    {
        display: none; /*--hidden by default--*/
        background: #fff;
        padding: 10px;
        float: left;
        position: absolute;
        z-index: 99999; /*--CSS3 Box Shadows--*/
        -webkit-box-shadow: 0px 0px 20px #000;
        -moz-box-shadow: 0px 0px 20px #000;
        box-shadow: 0px 0px 20px #000;
        border-color: #0670A2;
        border-style: solid;
        border-width: 2px;
        -moz-border-radius-topleft: 10px; -webkit-border-top-left-radius: 10px; -khtml-border-top-left-radius: 10px; border-top-left-radius: 10px;
        -moz-border-radius-topright: 10px; -webkit-border-top-right-radius: 10px; -khtml-border-top-right-radius: 10px; border-top-right-radius: 10px;
        -moz-border-radius-bottomleft: 10px; -webkit-border-bottom-left-radius: 10px; -khtml-border-bottom-left-radius: 10px; border-bottom-left-radius: 10px;
        -moz-border-radius-bottomright: 10px; -webkit-border-bottom-right-radius: 10px; -khtml-border-bottom-right-radius: 10px; border-bottom-right-radius: 10px;
    }
    img.btn_close2
    {
        float: right;
        margin: -5px -5px 0 0;
    }
    /*--Making IE6 Understand Fixed Positioning--*/
    *html .popup_block2
    {
        position: absolute;
    }
</style>
<asp:HiddenField ID="hfOneWeek" runat="server" />
<asp:HiddenField ID="hfShowRequest" runat="server" />
<div id="mainBox" style="text-align: left;">
    <asp:Image ID="imgHead" runat="server" ImageUrl="~/DesktopModules/Billboard/Images/BillPrayer.gif" />
    <div style="width: 550px">
        <div class="Bill_dashed">
            &nbsp;</div>
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <asp:Panel ID="pnlMain" runat="server" Width="100%">
                    <div id="AccordionBREAK">
                        <asp:Repeater ID="repPrayer" runat="server" DataSourceID="dsPrayer">
                            <ItemTemplate>
                                
                                    
                                        <div style="background-color: White; color: White;">
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("PrayerTitle") %>' CssClass="Bill_H4"></asp:Label>
                                        </div>
                                    
                                
                                    <div style="text-align: right; font-style: italic; font-family: Verdana; font-size: 8pt;
                                        color: #666666; font-weight: bold;">
                                        <asp:Label ID="Label2" runat="server" Text='<%# "Submitted by " & ConName(Eval("BillboardPrayerId")) & " on " & CDate(Eval("SubmittedDate")).ToString("dd/MM/yyyy")  %>'></asp:Label>
                                    </div>
                                    <br />
                                    <div class="Bill_Text_Main" style="font-size: 10pt;">
                                        <asp:Label ID="Label3" runat="server" Text='<%# Billboard.BillboardFunctions.BillHtml(Eval("PrayerText")) %>'></asp:Label>
                                    </div>
                                    <br />
                                    <div style="text-align: right; padding-top: 5px;">
                                        <asp:ImageButton ID="ImageButton1" runat="server" Height="20px" ImageUrl="~/DesktopModules/Billboard/Images/BtnImg/MessageAuthor1.gif"
                                            onmouseover="this.src='/DesktopModules/Billboard/Images/BtnImg/MessageAuthor2.gif';" onmouseout="this.src='/DesktopModules/Billboard/Images/BtnImg/MessageAuthor1.gif';"
                                            AlternateText="Message Author" ToolTip="Message Author" CommandName="ReplyPrayer"
                                            CommandArgument='<%# Eval("BillboardPrayerId") %>' />
                                        &nbsp;
                                        <asp:ImageButton ID="ImageButton2" runat="server" Height="20px" ImageUrl="~/DesktopModules/Billboard/Images/BtnImg/EditRequest1.gif"
                                            onmouseover="this.src='/DesktopModules/Billboard/Images/BtnImg/EditRequest2.gif';" onmouseout="this.src='/DesktopModules/Billboard/Images/BtnImg/EditRequest1.gif';"
                                            AlternateText="Edit Request" ToolTip="Edit Request" CommandName="EditPrayer"
                                            CommandArgument='<%# Eval("BillboardPrayerId") %>' Visible='<%#ThisIsEditable(Eval("BillboardPrayerId"))%>' />
                                        &nbsp;
                                        <asp:ImageButton ID="ImageButton3" runat="server" CommandArgument='<%# Eval("BillboardPrayerId")%>'
                                            CommandName="DeletePrayer" Visible='<%#ThisIsEditable(Eval("BillboardPrayerId")) %>'
                                            ImageUrl="~/DesktopModules/Billboard/Images/BtnImg/Delete1.gif" Height="20px" onmouseover="this.src='/DesktopModules/Billboard/Images/BtnImg/Delete2.gif';"
                                            onmouseout="this.src=/DesktopModules/Billboard/Images/BtnImg/Delete1.gif';" ToolTip="Delete Prayer"
                                            AlternateText="Delete Prayer" />
                                    </div><br /><br />
                                    <%--<div class="Bill_dashed">
                                        &nbsp;</div>--%>
                                
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </asp:Panel>
                <asp:LinqDataSource ID="dsPrayer" runat="server" ContextTypeName="Billboard.BillboardDataContext"
                    TableName="Agape_Billboard_Prayers" Where="Current == @Current" OrderBy="SubmittedDate desc, PrayerTitle">
                    <WhereParameters>
                        <asp:Parameter DefaultValue="true" Name="Current" Type="Boolean" />
                    </WhereParameters>
                </asp:LinqDataSource>
                <div style="text-align: center;">
                    <asp:Label ID="lblNoPrayer" runat="server" Text="No one has posted any prayer requests in the last week."
                        Visible="false" class="Bill_Text_Main"></asp:Label></div>
                <div class="Bill_dashed">
                    &nbsp;</div>
                <br />
                <br />
                <asp:ImageButton ID="btnAddPrayer" runat="server" Height="24px" ImageUrl="~/DesktopModules/Billboard/Images/BtnImg/NewPrayer1.gif"
                    onmouseover="this.src='/DesktopModules/Billboard/Images/BtnImg/NewPrayer2.gif';" onmouseout="this.src='/DesktopModules/Billboard/Images/BtnImg/NewPrayer1.gif';"
                    AlternateText="New Prayer Request" ToolTip="New Prayer Request" />
                &nbsp; <a href="http://france.myagape.co.uk/DesktopModules/Billboard/BillPrayerPrint.aspx"
                    target="_blank" runat="server" title="Print Requests">
                    <asp:Image ID="Image1" runat="server" Height="24px" ImageUrl="~/DesktopModules/Billboard/Images/BtnImg/PrintRequests1.gif"
                        onmouseover="this.src='/DesktopModules/Billboard/Images/BtnImg/PrintRequests2.gif';" onmouseout="this.src='/DesktopModules/Billboard/Images/BtnImg/PrintRequests1.gif';"
                        AlternateText="Print Requests" />
                </a>
                <asp:Image ID="Image2" runat="server" Height="24px" ImageUrl="~/DesktopModules/Billboard/Images/BtnImg/ViewArchive1.gif"
                    onmouseover="this.src='/DesktopModules/Billboard/Images/BtnImg/ViewArchive2.gif';" onmouseout="this.src='/DesktopModules/Billboard/Images/BtnImg/ViewArchive1.gif';"
                    AlternateText="View Archive" onclick="showArcPrayer();" Style="cursor: pointer;" />
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnUpdate" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnDeletePrayer" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="repPrayer" EventName="ItemCommand" />
                <asp:AsyncPostBackTrigger ControlID="btnAddPrayer" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
        <br />
        <br />
        <br />
        <div id="divEditPrayer">
            <div id="EditPrayerInner" style="overflow: hidden">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div style="text-align: center;">
                            <asp:Label ID="lblEditError" runat="server" Visible="false" ForeColor="Red"></asp:Label>
                            <table style="font-size: 10pt;">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblTellTitle" runat="server" Text="Edit Request Title:"></asp:Label>
                                    </td>
                                    <td style="font-size: 7pt;">
                                        <asp:TextBox ID="tbEditTitle" runat="server" Width="300px" MaxLength="150" onkeyup='textCounter(this, this.form.remLen3, 150);'
                                            onkeydown="textCounter(this, this.form.remLen3, 150);" onselect="textCounter(this, this.form.remLen4, 500);"></asp:TextBox>
                                        <input readonly="readonly" type="text" name="remLen3" size="3" maxlength="3" value="150" />
                                        characters left
                                    </td>
                                </tr>
                                <tr>
                                <td colspan="2">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblTellText" runat="server" Text="Edit Request Text:"></asp:Label>
                                    </td>
                                    <td style="font-size: 7pt;">
                                        <asp:TextBox ID="tbEditText" runat="server" Width="300px" TextMode="MultiLine" Rows="5"
                                            MaxLength="500" onkeyup='textCounter(this, this.form.remLen4, 500);' onkeydown="textCounter(this, this.form.remLen4, 500);"
                                            onselect="textCounter(this, this.form.remLen4, 500);"></asp:TextBox>
                                        <input readonly="readonly" type="text" name="remLen4" size="3" maxlength="3" value="500" />
                                        characters left
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                        <div style="font-size: 7pt; text-align:left;">
                                            To make text bold place <b>[b]</b> before it and <b>[/b]</b> after it.<br />
                                            To make text italic place <b>[i]</b> before it and <b>[/i]</b> after it.<br />
                                            To make text underlined place <b>[ul]</b> before it and <b>[/ul]</b> after it.<br />
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                <td colspan="2">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                                        <asp:ImageButton ID="btnSave" runat="server" Height="24px" ImageUrl="~/DesktopModules/Billboard/Images/BtnImg/Post1.gif"
                                            onmouseover="this.src='/DesktopModules/Billboard/Images/BtnImg/Post2.gif';" onmouseout="this.src='/DesktopModules/Billboard/Images/BtnImg/Post1.gif';"
                                            AlternateText="Save Prayer Request" ToolTip="Save Prayer Request" />
                                        <asp:ImageButton ID="btnUpdate" runat="server" Height="24px" ImageUrl="~/DesktopModules/Billboard/Images/BtnImg/Update1.gif"
                                            onmouseover="this.src='/DesktopModules/Billboard/Images/BtnImg/Update2.gif';" onmouseout="this.src='/DesktopModules/Billboard/Images/BtnImg/Update1.gif';"
                                            AlternateText="Update Prayer Request" ToolTip="Update Prayer Request" />&nbsp;
                                        <asp:ImageButton ID="btnDeletePrayer" runat="server" ImageUrl="~/DesktopModules/Billboard/Images/BlueCross.gif"
                                            Height="24px" Width="24px" ToolTip="Delete Prayer" AlternateText="Delete Prayer" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <asp:HiddenField ID="hfEditPrayerId" runat="server" />
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnUpdate" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnDeletePrayer" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
</div>
<div id="divMessage">
    <div id="MessageInner" style="overflow: hidden">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <div style="text-align: left; font-family: Verdana; font-size: 10pt; color:#0670A2;">
                    <asp:Label ID="lblMessageTitle" runat="server"></asp:Label>
                </div>
                <br />
                <br />
                <table width="100%">
                    <tr>
                        <td valign="top">
                            Message:
                        </td>
                        <td>
                            <asp:TextBox ID="tbMessageTo" runat="server" MaxLength="400" TextMode="MultiLine"
                                Rows="5" Width="300px" onkeyup='textCounter(this, this.form.remLen5, 400);' onkeydown="textCounter(this, this.form.remLen5, 400);"
                                onselect="textCounter(this, this.form.remLen5, 400);"></asp:TextBox>
                            <input readonly="readonly" type="text" name="remLen5" size="3" maxlength="3" value="400" />
                            characters left
                        </td>
                    </tr>
                    <tr>
                    <td colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            Make anonymous?
                        </td>
                        <td align="left">
                            <asp:CheckBox ID="cbAnonymous" runat="server" />
                        </td>
                    </tr>
                    <tr>
                    <td colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center">
                            <asp:ImageButton ID="btnSendMessage" runat="server" Height="24px" ImageUrl="~/DesktopModules/Billboard/Images/BtnImg/Send1.gif"
                                onmouseover="this.src='/DesktopModules/Billboard/Images/BtnImg/Send2.gif';" onmouseout="this.src='/DesktopModules/Billboard/Images/BtnImg/Send1.gif';"
                                AlternateText="Send Message" ToolTip="Send Message" />
                        </td>
                    </tr>
                </table>
                <br />
                <div class="Bill_SubTitle" style="font-size:10pt; text-align:justify;">This will send a message to&nbsp;<asp:Label ID="lblNameTo" runat="server"></asp:Label>. Please
                put a tick in<br />the 'Make anonymous?' box if you don't want them to know who sent it.</div>
                <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" Visible="false"></asp:Label>
                <asp:HiddenField ID="hfRequestId" runat="server" />
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSendMessage" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</div>
<div id="popMesg" title="Message Sent" class="popup_block2">
    <table width="100%">
        <tr>
            <td height="90px" width="300px" class="Bill_H4" valign="middle" style="text-align: center;">
                Your message was sent successfully
            </td>
        </tr>
    </table>
</div>
<div id="divPrayerArc" class="padInner">
    <%--<img alt="" src="/images/Billboard/BillPrayer.gif" /><br /><br />--%>
    <div id="prayerArcInner" style="overflow: hidden; padding-right: 10px;">
        <div style="text-align:center;" class="Bill_H5"><asp:Label ID="lblNoPrayerArc" runat="server" Visible="false"></asp:Label></div>
        <asp:DataList ID="dlPrayerArc" runat="server" DataSourceID="dsArcPrayer">
            <ItemTemplate>
                <div class="Bill_H4" style="text-align:left;">
                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("PrayerTitle") %>'></asp:Label></div>
                <div style="text-align: right; font-style: italic; font-family: Verdana; font-size: 8pt;
                    color: #666666; font-weight: bold;">
                    <asp:Label ID="Label5" runat="server" Text='<%# "Submitted by " & ConName(Eval("BillboardPrayerId")) & " on " & CDate(Eval("SubmittedDate")).ToString("dd/MM/yyyy")  %>'></asp:Label>
                </div>
                <br />
                <div class="Bill_Text_Main" style="text-align: justify;">
                    <asp:Label ID="Label6" runat="server" Text='<%# Billboard.BillboardFunctions.BillHtml(Eval("PrayerText")) %>'></asp:Label>
                </div>
                <br />
                <div class="Bill_dashed">
                    &nbsp;</div>
            </ItemTemplate>
        </asp:DataList>
        <asp:LinqDataSource ID="dsArcPrayer" runat="server" ContextTypeName="Billboard.BillboardDataContext"
            TableName="Agape_Billboard_Prayers" Where="Visible == @Visible &amp;&amp; Current == @Current &amp;&amp; Sent == @Sent"
            OrderBy="SubmittedDate desc">
            <WhereParameters>
                <asp:Parameter DefaultValue="false" Name="Current" Type="Boolean" />
                <asp:Parameter DefaultValue="true" Name="Visible" Type="Boolean" />
                <asp:Parameter DefaultValue="true" Name="Sent" Type="Boolean" />
            </WhereParameters>
        </asp:LinqDataSource>
    </div>
</div>
