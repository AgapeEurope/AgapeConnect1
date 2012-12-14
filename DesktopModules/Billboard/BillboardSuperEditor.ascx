<%@ Control Language="VB" AutoEventWireup="false" CodeFile="BillboardSuperEditor.ascx.vb"
    Inherits="DotNetNuke.Modules.Billboard.BillboardSuperEditor" %>
<%@ Register Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" TagPrefix="cc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/labelcontrol.ascx" %>
<%@ Register Src="~/DesktopModules/Billboard/controls/FeatArchive.ascx" TagName="billArch" TagPrefix="uc2" %>
<%@ Register Src="~/DesktopModules/Billboard/controls/EditAnnouncement.ascx" TagName="editAnn" TagPrefix="uc4" %>
<%@ Register Src="~/DesktopModules/Billboard/controls/ViewArticle.ascx" TagName="viewArt" TagPrefix="uc5" %>
<%@ Register Src="~/DesktopModules/Billboard/controls/EditArticle.ascx" TagName="editArt" TagPrefix="uc6" %>
<%@ Register Src="~/DesktopModules/Billboard/controls/ArtArchive.ascx" TagName="artArch" TagPrefix="uc7" %>
<%@ Register Src="~/DesktopModules/Billboard/controls/EditLink.ascx" TagName="editLink" TagPrefix="uc8" %>
<%@ Register Src="~/DesktopModules/Billboard/controls/EditPrayer.ascx" TagName="editPrayer" TagPrefix="uc10" %>
<link rel="stylesheet" type="text/css" href="/DesktopModules/Billboard/BillTheme/BillStyle.css" />
<link rel="stylesheet" type="text/css" href="/DesktopModules/Billboard/BillTheme/BillCSS/jquery-ui-1.8.18.custom.css" />
<script type="text/javascript">
    (function ($, Sys) {
        function setUpMyTabs() {
            var selectedTabIndex = $('#<%= hfCurrentPanel.ClientID  %>').attr('value');
            $('#tabs').tabs({

                show: function () {
                    var newIdx = $('#tabs').tabs('option', 'selected');
                    $('#<%= hfCurrentPanel.ClientID  %>').val(newIdx);
                },
                selected: selectedTabIndex
            });

            var thisIsGo = '<%= hfGoAhead.ClientID %>'
            if (document.getElementById(thisIsGo).value == 27) {
                window.open('http://france.myagape.co.uk/DesktopModules/Billboard/TestEmail.aspx');
                document.getElementById(thisIsGo).value = -1;
            }

            $('#FeatAccordion').accordion({ autoHeight: true, clearStyle: true });
            $("#popOutEdit").dialog({
                autoOpen: false,
                height: 600,
                width: 600,
                modal: true,
                show: 'fade',
                hide: 'fade',
                dialogClass: 'dialogWithDropShadow',
                title: '<div class="closeEl"><a style="cursor:pointer;" onclick="return false;"><img onclick="closepopOutEdit()" src="/DesktopModules/Billboard/Images/BlueCross.gif" title="Close Window" alt="Close" /></a></div><br/><div class="Bill_H3">Edit Announcement</div>',
                open: function (event, ui) {
                    $('.ui-dialog-titlebar-close').hide();

                    $('body').css({ 'overflow': 'hidden' });
                }
            });
            $("#popOutEdit").parent().appendTo($("form:first"));
            var selectedTabIndex = $('#<%= hfCurrentPanel.ClientID  %>').attr('value');
            $('#tabs').tabs({

                show: function () {
                    var newIdx = $('#tabs').tabs('option', 'selected');
                    $('#<%= hfCurrentPanel.ClientID  %>').val(newIdx);
                },
                selected: selectedTabIndex
            });
        }
        $(document).ready(function () {
            setUpMyTabs();
            hideTick();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpMyTabs();
            });
        });
    } (jQuery, window.Sys));
    function delThis2(oChoice) {
        var thisHF = '<%= hfDeleteComm.ClientID %>';
        document.getElementById(thisHF).value = oChoice;
        updatePanel();
        return false;
    }
    function updatePanel() {
        __doPostBack("<%= lbInvis.UniqueID %>", "");
    }
    function hideTick() {
        $('.theTicks').hide();
    }
</script>
<style type="text/css">
    img.btn_close
    {
        float: right;
        margin: 0 0 0 0;
    }
    .theTicks
{}
</style>
<asp:HiddenField ID="hfCurrentPopup" runat="server" />
<asp:HiddenField ID="hfCurrentPanel" runat="server" />
<asp:Label ID="lblTestWork" runat="server"></asp:Label>
<div id="tabs" style="width: 100%;">
    <ul>
        <li><a href='#Tab1-tab'>Feature Article</a></li>
        <li><a href='#Tab2-tab'>Articles</a></li>
        <li><a href='#Tab3-tab'>Announcements</a></li>
        <li><a href='#Tab4-tab'>Community</a></li>
        <li><a href='#Tab5-tab'>Links</a></li>
        <li><a href='#Tab6-tab'>Prayer</a></li>
    </ul>
    <div style="width: 800px; min-height: 350px; background-color: #FFFFFF;">
        <%--Feature Articles--%>
        <div id='Tab1-tab'>
            <asp:Label ID="lblErrorFeat" runat="server" ForeColor="Red" Visible="False"></asp:Label>
            <uc2:billArch ID="billArch" runat="server" />
            <div style="text-align: center">
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False">New Feature</asp:LinkButton>
            </div>
        </div>
        <%--Articles--%>
        <div id='Tab2-tab'>
            <uc7:artArch ID="artArch" runat="server" />
            <div style="text-align: center">
                <asp:LinkButton ID="btnNewArt" runat="server" Text="New Article" CausesValidation="false" />
            </div>
        </div>
        <%--Announcements--%>
        <div id='Tab3-tab'>
            <div class="Bill_H4">
                Currently Visible Announcements:</div>
            <br />
            <asp:GridView ID="gvAnn" runat="server" AutoGenerateColumns="False">
                <Columns>
                    <asp:TemplateField HeaderText="Announcement">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%#Eval("AnnText") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Attachment">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%#Eval("AttText") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Sent">
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" Enabled="false" Checked='<%#Eval("ThisCurrent") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
            <asp:ImageButton ID="btnEditAnn" runat="server" Height="24px" ImageUrl="~/DesktopModules/Billboard/Images/BtnImg/EditAnnouncements1.gif"
                onmouseover="this.src='/DesktopModules/Billboard/Images/BtnImg/EditAnnouncements2.gif';" onmouseout="this.src='/DesktopModules/Billboard/Images/BtnImg/EditAnnouncements1.gif';"
                AlternateText="Edit Announcements" ToolTip="Edit Announcements" CausesValidation="false" />
            <%--<asp:LinkButton ID="btnEditAnn" runat="server" CausesValidation="false">Edit Ann</asp:LinkButton>--%>
            <asp:Label ID="lblErrorAnn" runat="server" ForeColor="Red" Visible="false"></asp:Label>
        </div>
        <%--Community--%>
        <div id='Tab4-tab'>
        <div class="Bill_H4">Community Items:</div><br />
            <asp:HiddenField ID="hfDeleteComm" runat="server" />
            <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:DataList ID="dlComm" runat="server">
                        <ItemTemplate>
                            <asp:HiddenField ID="hfCommId" runat="server" Value='<%# Eval("BillboardCommId") %>' />
                            <table>
                                <tr>
                                    <td>
                                        <table>
                                            <tr>
                                                <td style="border: 1px solid black; height: 20px; font-size: 7pt;" width="200px">
                                                    <asp:Label ID="lblCommOut" runat="server" Text='<%# Eval("CommOut") %>'></asp:Label>
                                                </td>
                                                <td valign="top">
                                                    <a style="cursor: pointer;" onclick="delThis2(<%#Eval("BillboardCommId") %>);">
                                                        <asp:Image ID="Image3" runat="server" AlternateText="Delete Thread" ToolTip="Delete Thread"
                                                            ImageUrl="~/DesktopModules/Billboard/Images/BlueCross2.png" Height="20px" />
                                                    </a>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;" valign="top">
                                        <asp:Image ID="Image1" runat="server" Height="20px" ImageUrl="~/DesktopModules/Billboard/Images/Arrow.png"
                                            Visible='<%# IsReplies(Eval("BillboardCommId")) %>' />
                                    </td>
                                    <td>
                                        <asp:DataList ID="dlCommReply" runat="server">
                                            <ItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td style="border: 1px solid black; height: 20px; font-size: 7pt;" width="200px">
                                                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("BillRepText") %>'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <a onclick="delThis2(<%#Eval("BillboardCommId") %>);" style="cursor: pointer;">
                                                                <asp:Image ID="Image3" runat="server" AlternateText="Delete Reply" ToolTip="Delete Reply"
                                                                    ImageUrl="~/DesktopModules/Billboard/Images/BlueCross2.png" Height="20px" />
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:DataList>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:DataList>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="lbInvis" />
                </Triggers>
            </asp:UpdatePanel>
            <%--<uc9:billComm ID="billComm" runat="server" />--%>
            <asp:LinkButton ID="lbInvis" runat="server" style="display:none;">LinkButton</asp:LinkButton>
            <asp:Label ID="lblErrorComm" runat="server" ForeColor="Red" Visible="false"></asp:Label>
        </div>
        <%--Links--%>
        <div id='Tab5-tab'>
            <div class="Bill_H4">
                Current Links:</div>
            <br />
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False">
                        <Columns>
                            <asp:TemplateField HeaderText="Link">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hfLinkId" runat="server" Value='<%# Eval("BillboardLinkId") %>' />
                                    <asp:TextBox ID="tbTitle1" runat="server" Text='<%#Eval("LinkTitle")%>' Width="150px"
                                        Font-Size="7pt" Font-Bold="true" MaxLength="100"></asp:TextBox><br />
                                    <asp:TextBox ID="tbURL1" runat="server" Text='<%#Eval("LinkURL")%>' Width="150px"
                                        Font-Size="7pt" Font-Italic="true" TextMode="MultiLine" Rows="2" MaxLength="500"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description">
                                <ItemTemplate>
                                    <asp:TextBox ID="tbDesc1" runat="server" Text='<%# Eval("LinkDesc") %>' Width="150px"
                                        Font-Size="7pt" TextMode="MultiLine" Rows="3" MaxLength="150"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Visible">
                                <ItemTemplate>
                                    <asp:CheckBox ID="cbVis1" runat="server" Checked='<%# Eval("Visible") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:ImageButton ID="ImageButton6" runat="server" CausesValidation="false" ImageUrl="~/DesktopModules/Billboard/Images/BtnImg/Update1.gif"
                                                    onmouseover="this.src='/DesktopModules/Billboard/Images/BtnImg/Update2.gif';" onmouseout="this.src='/DesktopModules/Billboard/Images/BtnImg/Update1.gif';"
                                                    AlternateText="Update Link" ToolTip="Update Link" Height="20px" CommandName="MyEdit"
                                                    CommandArgument='<%# Container.DataItemIndex %>' />
                                                <br />
                                                <asp:ImageButton ID="ImageButton5" runat="server" CausesValidation="false" ImageUrl="~/DesktopModules/Billboard/Images/BtnImg/Delete1.gif"
                                                    onmouseover="this.src='/DesktopModules/Billboard/Images/BtnImg/Delete2.gif';" onmouseout="this.src='/DesktopModules/Billboard/Images/BtnImg/Delete1.gif';"
                                                    AlternateText="Delete Link" ToolTip="Delete Link" Height="20px" CommandName="MyDelete"
                                                    CommandArgument='<%# Eval("BillboardLinkId") %>' />
                                            </td>
                                            <td width="60px">
                                                <asp:Image ID="imgTick" runat="server" ImageUrl="~/DesktopModules/Billboard/Images/BtnImg/Updated.gif" Width="60px" CssClass="theTicks" />
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:Label ID="lblGVError" runat="server" Visible="false"></asp:Label>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" />
                </Triggers>
            </asp:UpdatePanel>
            
        </div>
        <%--Prayer--%>
        <div id='Tab6-tab'>
            <uc10:editPrayer ID="editPrayer" runat="server" />
        </div>
    </div>
</div>
<br />
<br />
<fieldset>
    <legend class="Bill_H4">Send Latest</legend>When you have checked all of the features
    in Billboard click this button to create the email version and send it to all staff:
    <br />
    <div style="text-align: center">
        <%--<asp:LinkButton ID="btnTest" runat="server" Text="Test" CausesValidation="false" OnClientClick="aspnetForm.target ='_blank';" ></asp:LinkButton>--%>
        <asp:HiddenField ID="hfGoAhead" runat="server" Value="-1" />
        <asp:Button ID="btnTest" runat="server" Text="Test" CausesValidation="false" /><br />
        <asp:TextBox ID="tbTestSend" runat="server"></asp:TextBox>&nbsp;<asp:Button ID="btnTestSend"
            runat="server" Text="Test Send" CausesValidation="false" /><br />
        <asp:Button ID="btnFake" runat="server" Text="Fake Send" CausesValidation="false" /><br />
        <asp:Button ID="btnSend" runat="server" Text="Send Billboard" CausesValidation="false" /><br />
        <cc1:ConfirmButtonExtender ID="cbe" runat="server" TargetControlID="btnSend" ConfirmText="Are you sure you want to send this out?" />
        <br />
        Date of last mailing:&nbsp;<asp:Label ID="lblLastBillboard" runat="server"></asp:Label><br />
        <asp:Label ID="lblBillSendOut" runat="server" Visible="false"></asp:Label>
    </div>
</fieldset>
<asp:Button ID="btnTestThis" runat="server" Text="Test This" CausesValidation="false" Visible="false"/>