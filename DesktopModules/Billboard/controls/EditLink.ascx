<%@ Control Language="VB" AutoEventWireup="false" CodeFile="EditLink.ascx.vb" Inherits="DesktopModules_Billboard_controls_EditLink"
    ClassName="DesktopModules_Billboard_controls_EditLink" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/labelcontrol.ascx" %>
<link rel="stylesheet" type="text/css" href="/DesktopModules/Billboard/BillTheme/BillStyle.css" />
<script type="text/javascript">

    function textCounter(field, countfield, maxlimit) {
        if (field.value.length > maxlimit)
            field.value = field.value.substring(0, maxlimit);
        else
            countfield.value = maxlimit - field.value.length;
    }

</script>

<asp:HiddenField ID="hfThisUser" runat="server" />
<asp:HiddenField ID="hfCurrentPanel" runat="server" />
<asp:HiddenField ID="hfMode" runat="server" />



                <table>
                    <tr>
                        <td style="font-size: 7pt;">
                            <dnn:Label ID="lblTitle" runat="server" ControlName="tbLinkTitle" Text="Link Title:"
                                HelpText="Enter a title for your link. It can only be 100 characters long." />


                        </td>
                        <td style="font-size: 7pt;">
                            <asp:TextBox ID="tbLinkTitle" runat="server" MaxLength="100" Width="300px" onkeyup='textCounter(this, this.form.remLenLink3, 100);'
                                onkeydown="textCounter(this, this.form.remLenLink3, 100);"></asp:TextBox>

<input readonly="readonly"
                                    type="text" name="remLenLink3" size="3" maxlength="3" value="100" />
                            characters left
                        </td>
                    </tr>
                    <tr>
                        <td style="font-size: 7pt;">
                            <dnn:Label ID="lblLinkURL" runat="server" ControlName="tbLinkURL" Text="Link URL:"
                                HelpText="Enter the full URL for your link. This must be the full URL - including the 'http://' bit." />


                        </td>
                        <td>
                            <asp:TextBox ID="tbLinkURL" runat="server" Width="300px" MaxLength="500">http://</asp:TextBox>


                        </td>
                    </tr>
                    <tr>
                        <td style="font-size: 7pt;">
                            <dnn:Label ID="lblLinkDesc" runat="server" ControlName="tbLinkDesc" Text="Link Description:"
                                HelpText="Enter a description for this link. This will appear when someone hovers over your link." />


                        </td>
                        <td style="font-size: 7pt;">
                            <asp:TextBox ID="tbLinkDesc" runat="server" Width="300px" TextMode="MultiLine" MaxLength="150"
                                onkeyup='textCounter(this, this.form.remLenLink2, 150);' onkeydown="textCounter(this, this.form.remLenLink2, 150);"></asp:TextBox>


                            <input readonly="readonly" type="text" name="remLenLink2" size="3" maxlength="3"
                                value="150" />
                            characters left
                        </td>
                    </tr>
                    <tr>
                        <td style="font-size: 7pt;">
                            <dnn:Label ID="lblLinkVisible" runat="server" ControlName="cbVisible" Text="Visible:"
                                HelpText="Do you want to make this link visible to everyone (leave unchecked if you don't)." />


                        </td>
                        <td>
                            <asp:CheckBox ID="cbVisible" runat="server" />


                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <asp:ImageButton ID="btnAddLink" Height="24px" runat="server" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/Save1.gif"
                                onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/Save2.gif';" onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/Save1.gif';"
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
<%--                <asp:UpdatePanel ID="UpdatePanelLinks" runat="server">
<ContentTemplate>--%>
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
                                                    <asp:ImageButton ID="ImageButton6" runat="server" CausesValidation="false" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/Update1.gif"
                                                        onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/Update2.gif';" onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/Update1.gif';"
                                                        AlternateText="Update Link" ToolTip="Update Link" Height="20px" CommandName="MyEdit"
                                                        CommandArgument='<%# Container.DataItemIndex %>' />
                                                    <br />
                                                    <asp:ImageButton ID="ImageButton5" runat="server" CausesValidation="false" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/Delete1.gif"
                                                        onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/Delete2.gif';" onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/Delete1.gif';"
                                                        AlternateText="Delete Link" ToolTip="Delete Link" Height="20px" CommandName="MyDelete"
                                                        CommandArgument='<%# Eval("BillboardLinkId") %>' />
                                                </td>
                                                <td width="20px">
                                                    <asp:Image ID="imgTick" runat="server" ImageUrl="~/DesktopModules/Billboard/images/GreenCheck.png" Width="20px"
                                                        Visible="false" />
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    <asp:Label ID="lblGVError" runat="server" visible="false"></asp:Label>
                    <%--</ContentTemplate>--%>
<%--<Triggers>

<asp:PostBackTrigger ControlID="GridView1" />
</Triggers>
</asp:UpdatePanel>--%>

