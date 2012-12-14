<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ViewBillboardLink.ascx.vb"
    Inherits="DotNetNuke.Modules.BillboardLink.ViewBillboardLink" %>
<%@ Register Src="~/DesktopModules/Billboard/controls/EditLink.ascx" TagName="editLink" TagPrefix="uc1" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<link rel="stylesheet" type="text/css" href="/DesktopModules/Billboard/BillTheme/BillStyle.css" />
<script type="text/javascript">

 (function ($, Sys) {
     function setUpMyLinksTabs() {
         var selectedTabIndex = $('#<%= hfCurrentLinkPanel.ClientID  %>').attr('value');
         $('#Linktabs').tabs({

             show: function () {
                 var newIdx = $('#Linktabs').tabs('option', 'selected');
                 $('#<%= hfCurrentLinkPanel.ClientID  %>').val(newIdx);
             },
             selected: selectedTabIndex
         });
     }
     $(document).ready(function () {
         setUpMyLinksTabs();
         hideTick();
         Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
             setUpMyLinksTabs();
         });
     });
 } (jQuery, window.Sys));

    function textCounter(field, countfield, maxlimit) {
        if (field.value.length > maxlimit)
            field.value = field.value.substring(0, maxlimit);
        else
            countfield.value = maxlimit - field.value.length;
    }
    function hideTick() {
        $('.theTicks').hide();
    }

</script>
<style type="text/css">
.tableSpace
{
    padding-bottom:10px;
}
.theTicks
{}
</style>
<asp:HiddenField ID="hfCurrentLinkPanel" runat="server" />
<div style="text-align: left;">
    <div class="Bill_Links_Top">
        &nbsp;</div>
    
    <div class="Bill_Side_Middle">
        <div style="width: 160px; padding: 0 0 0 20px; margin: 0; line-height: 1.25em;">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <asp:PlaceHolder ID="phMainContent" runat="server"></asp:PlaceHolder>
                    <br />
                    <asp:Label ID="lblOutput" runat="server" Visible="false" CssClass="Bill_Text_Side"></asp:Label>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" />
                    <asp:AsyncPostBackTrigger ControlID="btnAddLink" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
            <div style="text-align: center;">
                <asp:ImageButton ID="btnEdit" runat="server" Height="20px" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/AddEdit1.gif"
                    onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/AddEdit2.gif';" onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/AddEdit1.gif';"
                    AlternateText="Add/Edit a Link" ToolTip="Add/Edit a Link" OnClientClick="showEditLink(); return false;" />
                <asp:ImageButton ID="btnArc" runat="server" Height="20px" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/Archive1.gif"
                    onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/Archive2.gif';" OnClientClick="showLinkArc(); return false;"
                    onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/Archive1.gif';" AlternateText="The Links Archive"
                    ToolTip="The Links Archive" />
            </div>
        </div>
    </div>
    <div class="Bill_Side_Bottom">
        &nbsp;</div>
</div>
<br />
<div id="divLinkArc">
    <div id="LinkArcInner" style="overflow: hidden; padding-right: 5px; padding-left:3px; text-align: left;">
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <asp:PlaceHolder ID="phAllLinks" runat="server"></asp:PlaceHolder>
                <asp:Label ID="lblAllLinksOut" runat="server" Visible="false"></asp:Label>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" />
                <asp:AsyncPostBackTrigger ControlID="btnAddLink" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</div>
<div id="divEditLink">
    <div id="EditLinkInner" style="overflow: hidden; padding-right: 5px; text-align: left;">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
            <div id="Linktabs" style="width: 550px;">
            <ul>
        <li><a href='#Tab1-tab'>Add a New Link</a></li>
        <li><a href='#Tab2-tab'>Edit Your Old Links</a></li>
        </ul>
         <div style="width: 550px; min-height: 350px; background-color: #FFFFFF;">
        <div id='Tab1-tab'>
        <br />
        <br />
                <table>
                    <tr>
                        <td style="font-size: 7pt; padding-bottom:10px;">
                            <dnn:Label ID="lblTitle" runat="server" ControlName="tbLinkTitle" Text="Link Title:"
                                HelpText="Enter a title for your link. It can only be 100 characters long." />
                        </td>
                        <td style="font-size: 7pt; padding-bottom:10px;">
                            <asp:TextBox ID="tbLinkTitle" runat="server" MaxLength="100" Width="200px" onkeyup='textCounter(this, this.form.remLenLink3, 100);'
                                onkeydown="textCounter(this, this.form.remLenLink3, 100);"></asp:TextBox>
                            <input readonly="readonly" type="text" name="remLenLink3" size="3" maxlength="3"
                                value="100" />
                            characters left
                        </td>
                    </tr>
                    <tr>
                        <td style="font-size: 7pt; padding-bottom:10px;">
                            <dnn:Label ID="lblLinkURL" runat="server" ControlName="tbLinkURL" Text="Link URL:"
                                HelpText="Enter the full URL for your link. This must be the full URL - including the 'http://' bit." />
                        </td>
                        <td style="padding-bottom:10px;">
                            <asp:TextBox ID="tbLinkURL" runat="server" Width="300px" MaxLength="500">http://</asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-size: 7pt; padding-bottom:10px;">
                            <dnn:Label ID="lblLinkDesc" runat="server" ControlName="tbLinkDesc" Text="Link Description:"
                                HelpText="Enter a description for this link. This will appear when someone hovers over your link." />
                        </td>
                        <td style="font-size: 7pt; padding-bottom:10px;">
                            <asp:TextBox ID="tbLinkDesc" runat="server" Width="200px" TextMode="MultiLine" MaxLength="150"
                                onkeyup='textCounter(this, this.form.remLenLink2, 150);' onkeydown="textCounter(this, this.form.remLenLink2, 150);"></asp:TextBox>
                            <input readonly="readonly" type="text" name="remLenLink2" size="3" maxlength="3"
                                value="150" />
                            characters left
                        </td>
                    </tr>
                    <tr>
                        <td style="font-size: 7pt; padding-bottom:20px;">
                            <dnn:Label ID="lblLinkVisible" runat="server" ControlName="cbVisible" Text="Visible:"
                                HelpText="Do you want to make this link visible to everyone (leave unchecked if you don't)." />
                        </td>
                        <td style="padding-bottom:20px;">
                            <asp:CheckBox ID="cbVisible" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center" style="padding-bottom:10px;">
                            <asp:ImageButton ID="btnAddLink" Height="24px" runat="server" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/Add1.gif"
                                onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/Add2.gif';" onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/Add1.gif';"
                                AlternateText="Save Link" ToolTip="Save Link" CausesValidation="False" />
                            <asp:ImageButton ID="btnCancel" Height="24px" runat="server" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/Cancel1.gif"
                                onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/Cancel2.gif';" onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/Cancel1.gif';"
                                AlternateText="Cancel" ToolTip="Cancel" CausesValidation="False" />
                        </td>
                    </tr>
                </table>
                <br />
                <div style="text-align: center; font-size: 12pt; font-weight: bold; font-family: Verdana;">
                    <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red" Visible="False"></asp:Label>
                </div>
                </div>
                <div id='Tab2-tab'>
                <br />
                <br />
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False">
                    <Columns>
                        <asp:TemplateField HeaderText="Link" ItemStyle-CssClass="tableSpace">
                            <ItemTemplate>
                                <asp:HiddenField ID="hfLinkId" runat="server" Value='<%# Eval("BillboardLinkId") %>' />
                                <asp:TextBox ID="tbTitle1" runat="server" Text='<%#Eval("LinkTitle")%>' Width="150px"
                                    Font-Size="7pt" Font-Bold="true" MaxLength="100"></asp:TextBox><br /><br />
                                <asp:TextBox ID="tbURL1" runat="server" Text='<%#Eval("LinkURL")%>' Width="150px"
                                    Font-Size="7pt" Font-Italic="true" TextMode="MultiLine" Rows="2" MaxLength="500"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" ItemStyle-CssClass="tableSpace" ItemStyle-VerticalAlign="top">
                            <ItemTemplate>
                                <asp:TextBox ID="tbDesc1" runat="server" Text='<%# Eval("LinkDesc") %>' Width="150px"
                                    Font-Size="7pt" TextMode="MultiLine" Rows="3" MaxLength="150"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Visible" ItemStyle-CssClass="tableSpace">
                            <ItemTemplate>
                                <asp:CheckBox ID="cbVis1" runat="server" Checked='<%# Eval("Visible") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False" ItemStyle-CssClass="tableSpace">
                            <ItemTemplate>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:ImageButton ID="ImageButton6" runat="server" CausesValidation="false" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/Update1.gif"
                                                onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/Update2.gif';" onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/Update1.gif';"
                                                AlternateText="Update Link" ToolTip="Update Link" Height="20px" CommandName="MyEdit"
                                                CommandArgument='<%# Container.DataItemIndex %>'/>
                                            <br />
                                            <asp:ImageButton ID="ImageButton5" runat="server" CausesValidation="false" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/Delete1.gif"
                                                onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/Delete2.gif';" onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/Delete1.gif';"
                                                AlternateText="Delete Link" ToolTip="Delete Link" Height="20px" CommandName="MyDelete"
                                                CommandArgument='<%# Eval("BillboardLinkId") %>' />
                                        </td>
                                        <td width="60px">
                                            <asp:Image ID="imgTick" runat="server" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/Updated.gif" Width="60px" CssClass="theTicks" />
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:Label ID="lblGVError" runat="server" Visible="false"></asp:Label>
                </div>
                </div>
                </div>
                <%--<uc1:editLink ID="editLink" runat="server" />--%>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" />
                <asp:AsyncPostBackTrigger ControlID="btnAddLink" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</div>
