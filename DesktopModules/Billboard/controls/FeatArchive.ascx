<%@ Control Language="VB" AutoEventWireup="false" CodeFile="FeatArchive.ascx.vb"
    Inherits="DesktopModules_Billboard_controls_FeatArchive" ClassName="DesktopModules_Billboard_controls_FeatArchive" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<style type="text/css">
    .BackBlue
    {
        background-color: #CCFFFF;
    }
    .BackClear
    {
        background-color: transparent;
    }
    .BackYellow
    {
        background-color: #FFFF99;
    }
    .BackGreen
    {
        background-color: #CCFFCC;
    }
    .accordionHeader
    {
        background-image: url('http://france.myagape.co.uk/DesktopModules/Billboard/Images/arrow_expand.gif');
        background-repeat: no-repeat;
        background-position-x: 2px;
        background-position-y: 50%;
        margin-right: 10px;
        cursor: pointer;
        overflow: auto;
    }
    .accordionSelected
    {
        background-image: url('http://france.myagape.co.uk/DesktopModules/Billboard/Images/arrow_collapse.gif');
        background-repeat: no-repeat;
        background-position-x: 2px;
        background-position-y: 50%;
        padding: 3px 3px 3px 3px;
        cursor: pointer;
    }
</style>
<asp:HiddenField ID="hfMode" runat="server" />
<asp:Label ID="lblControlError" runat="server" ForeColor="Red" Visible="false"></asp:Label>
<br />
<div style="text-align: center">
    <%--<asp:Label ID="lblArchTitle" runat="server" Text="Feature Archive" CssClass="Bill_H2"></asp:Label><br />--%>
    <br />
    <asp:Label ID="lblEmpty" runat="server" Text="There are no archived feature articles currently."
        CssClass="Bill_H4" Visible="false"></asp:Label>
</div>
<asp:Panel ID="pnlKey" runat="server">
    <table width="100%">
        <tr>
            <td class="Agape_Body_Text">
                <asp:Panel ID="pnlFeatType" runat="server">
                    <asp:UpdatePanel ID="upFeatType" runat="server">
                        <ContentTemplate>
                            <div class="Bill_H4">
                                Feature Types</div>
                            <br />
                            <asp:GridView ID="gvFeatType" runat="server" AutoGenerateColumns="False" DataKeyNames="FeatureTypeId"
                                DataSourceID="dsFeatType" EnableModelValidation="True">
                                <Columns>
                                    <asp:TemplateField HeaderText="Type Name" SortExpression="TypeName">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("TypeName") %>' MaxLength="50"></asp:TextBox><br />
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="You must have text in this box."
                                                ControlToValidate="TextBox1" ForeColor="Red" Font-Bold="true" Font-Size="10pt"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("TypeName") %>'></asp:Label><br />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False">
                                        <EditItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Update"
                                                Text="Update"></asp:LinkButton>
                                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                                                Text="Cancel"></asp:LinkButton>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit"
                                                Text="Edit"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:LinqDataSource ID="dsFeatType" runat="server" ContextTypeName="Billboard.BillboardDataContext"
                                EnableUpdate="True" OrderBy="TypeNumber" TableName="Agape_Billboard_Feature_Types">
                            </asp:LinqDataSource>
                            <br />
                            Add New:&nbsp;<asp:TextBox ID="tbNewType" runat="server" MaxLength="50"></asp:TextBox>&nbsp;<asp:LinkButton
                                ID="btnNewType" runat="server" CausesValidation="false">Add</asp:LinkButton><br />
                            <asp:Label ID="lblNewTypeError" runat="server" Visible="false" ForeColor="Red"></asp:Label>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnNewType" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="gvFeatType" EventName="RowEditing" />
                        </Triggers>
                    </asp:UpdatePanel>
                </asp:Panel>
            </td>
            <td>
                <table>
                    <tr>
                        <td class="Bill_H5" colspan="2">
                            Key:
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Visible/Un-sent (Queued):&nbsp;
                        </td>
                        <td class="BackClear" style="border: 1pt solid #000000">
                            &nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Invisible/Un-sent (Editing):&nbsp;
                        </td>
                        <td class="BackBlue" style="border: 1pt solid #000000">
                            &nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Visible/Sent (Archive/Current):&nbsp;
                        </td>
                        <td class="BackYellow" style="border: 1pt solid #000000">
                            &nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Invisible/Sent (Removed from Archive):&nbsp;
                        </td>
                        <td class="BackGreen" style="border: 1pt solid #000000">
                            &nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <br />
                <asp:Label ID="Label4" runat="server" Text="Feature Queue:" CssClass="Bill_H4"></asp:Label><br />
                <asp:GridView ID="gvNextFeat" runat="server" AutoGenerateColumns="False" DataSourceID="dsNextFeat"
                    EnableModelValidation="True">
                    <Columns>
                        <asp:BoundField DataField="Headline" HeaderText="Headline" ReadOnly="True" SortExpression="Headline" />
                        <asp:TemplateField HeaderText="StoryDate" SortExpression="StoryDate">
                            <EditItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("StoryDate") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# CDate(Eval("StoryDate")).toString("dd/MMM/yyyy") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CheckBoxField DataField="Current" HeaderText="Current" ReadOnly="True" SortExpression="Current" />
                        <asp:CheckBoxField DataField="Sent" HeaderText="Sent" ReadOnly="True" SortExpression="Sent" />
                        <asp:TemplateField HeaderText="FeatType" SortExpression="FeatType">
                            <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# NameCategory(Eval("FeatType")) %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# NameCategory(Eval("FeatType")) %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Next" SortExpression="Next">
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Next") %>' Enabled="false"
                                    Visible='<%# Not(Eval("Current")) %>' />
                                <asp:Label ID="lblNext" runat="server" Font-Size="7pt" Visible='<%# Eval("Current") %>'
                                    Text="This is the current feature<br/>and can't be set to the next feature."></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="false" Visible='<%# Not(Eval("Current")) %>'
                                    CommandArgument='<%# Eval("BillboardFeatureId") %>' CommandName="SetToNext">Set to Next Feature</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:LinqDataSource ID="dsNextFeat" runat="server" ContextTypeName="Billboard.BillboardDataContext"
                    OrderBy="StoryDate desc" Select="new (Headline, StoryDate, Current, Visible, Sent, FeatType, Next, BillboardFeatureId)"
                    TableName="Agape_Billboard_Features" Where="Visible == @Visible &amp;&amp; (Sent == @Sent || Current == @Current)">
                    <WhereParameters>
                        <asp:Parameter DefaultValue="True" Name="Visible" Type="Boolean" />
                        <asp:Parameter DefaultValue="False" Name="Sent" Type="Boolean" />
                        <asp:Parameter DefaultValue="True" Name="Current" Type="Boolean" />
                    </WhereParameters>
                </asp:LinqDataSource>
            </td>
        </tr>
    </table>
</asp:Panel>
<br />
<div id="FeatAccordion">
    <asp:Repeater ID="repPrayer" runat="server" DataSourceID="dsHeaders">
        <ItemTemplate>
            <h3>
                <table>
                    <tr>
                        <td width="10px">
                            &nbsp;
                        </td>
                        <td>
                            <a style="cursor: pointer; text-decoration: none;">
                                <asp:Label ID="lblHeader" runat="server" CssClass="Bill_H4" Text='<%# Eval("TypeName") %>'></asp:Label></a>
                        </td>
                    </tr>
                </table>
            </h3>
            <div>
                <asp:DataList ID="dlMain2" runat="server" DataSource='<%# GetArcData(Eval("TypeNumber")) %>'
                    OnItemCommand="dlMain2_ItemCommand">
                    <ItemTemplate>
                        <table class='<%#ColourMeGray(Eval("Visible"), Eval("Sent")) %>' width="100%">
                            <tr>
                                <td valign="middle" width="104px">
                                    <div class="Bill_Photo">
                                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# "~/DesktopModules/Billboard/GetBillboardImage.aspx?PhotoId=" & Eval("BillboardPhotoId") & "&Size=100" %>' /></div>
                                    <td valign="top" align="left" width="600px">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Headline") %>' Font-Bold="True"
                                                        Font-Names="Verdana" Font-Size="10pt" ForeColor="#666666" Font-Underline="True"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("StoryDate", "{0:dd/MM/yyyy}") %>'
                                                        Font-Names="Verdana" Font-Size="7pt" Font-Italic="true" ForeColor="Gray"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label2" runat="server" Text='<%# CleanText(Eval("StoryText")) %>'
                                                        Font-Names="Verdana" Font-Size="8pt" ForeColor="#666666"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        <asp:ImageButton ID="LinkButton2" Height="24px" runat="server" ImageUrl="~/DesktopModules/Billboard/Images/BtnImg/View1.gif"
                                            onmouseover="this.src='/DesktopModules/Billboard/Images/BtnImg/View2.gif';" onmouseout="this.src=/DesktopModules/Billboard/Images/BtnImg/View1.gif';"
                                            AlternateText="View Article" ToolTip="View Article" CommandArgument='<%#Eval("BillboardFeatureId") %>'
                                            CommandName="GoTo" CausesValidation="false" /><br />
                                        <asp:ImageButton ID="LinkButton1" Height="24px" runat="server" ImageUrl="~/DesktopModules/Billboard/Images/BtnImg/Edit1.gif"
                                            onmouseover="this.src='/DesktopModules/Billboard/Images/BtnImg/Edit2.gif';" onmouseout="this.src='/DesktopModules/Billboard/Images/BtnImg/Edit1.gif';"
                                            AlternateText="Edit Article" ToolTip="Edit Article" CommandArgument='<%#Eval("BillboardFeatureId") %>'
                                            CommandName="MyEdit" Visible='<%#IsVisible() %>' CausesValidation="false" />
                                    </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>
<%--
<asp:Accordion ID="accFeat" runat="server"
    AutoSize="None"
    FadeTransitions="true"
    TransitionDuration="250"
    FramesPerSecond="40"
    SuppressHeaderPostbacks="true"
    Width= "100%"
    RequireOpenedPane="false"
    SelectedIndex="-1"
 DataSourceID="dsHeaders"
 HeaderCssClass="accordionHeader"
 HeaderSelectedCssClass="accordionSelected">
<HeaderTemplate>
<table>
<tr>
<td width="10px">&nbsp;</td>
<td>
<a style="cursor:pointer; text-decoration:none;"><asp:Label ID="lblHeader" runat="server" CssClass="Bill_H3" Text='<%# Eval("TypeName") %>'></asp:Label></a>
</td>
</tr>
</table>
</HeaderTemplate>
<ContentTemplate>
<asp:DataList ID="dlMain2" runat="server" DataSource='<%# GetArcData(Eval("TypeNumber")) %>' OnItemCommand="dlMain2_ItemCommand">
        <Itemtemplate>
        <table class='<%#ColourMeGray(Eval("Visible"), Eval("Sent")) %>' width="100%">
            <tr>
                <td valign="middle" width="104px">
                <div class="Bill_Photo">
                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# "~/DesktopModules/Billboard/GetBillboardImage.aspx?PhotoId=" & Eval("BillboardPhotoId") & "&Size=100" %>' /></div>
                <td valign="top" align="left" width="600px">
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Headline") %>' Font-Bold="True"
                                    Font-Names="Verdana" Font-Size="10pt" ForeColor="#666666" Font-Underline="True"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("StoryDate", "{0:dd/MM/yyyy}") %>'
                                    Font-Names="Verdana" Font-Size="7pt" Font-Italic="true" ForeColor="Gray"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label2" runat="server" Text='<%# CleanText(Eval("StoryText")) %>'
                                    Font-Names="Verdana" Font-Size="8pt" ForeColor="#666666"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                        <asp:ImageButton ID="LinkButton2" Height="24px" runat="server" ImageUrl="~/images/Billboard/BtnImg/View1.gif"  
                                                onmouseover="this.src='/images/Billboard/BtnImg/View2.gif';"  
                                                onmouseout="this.src='/images/Billboard/BtnImg/View1.gif';" AlternateText="View Article" ToolTip="View Article"
                                                 CommandArgument='<%#Eval("BillboardFeatureId") %>' CommandName="GoTo" CausesValidation="false"/><br />
                        <asp:ImageButton ID="LinkButton1" Height="24px" runat="server" ImageUrl="~/images/Billboard/BtnImg/Edit1.gif"  
                                                onmouseover="this.src='/images/Billboard/BtnImg/Edit2.gif';"  
                                                onmouseout="this.src='/images/Billboard/BtnImg/Edit1.gif';" AlternateText="Edit Article" ToolTip="Edit Article"
                                                 CommandArgument='<%#Eval("BillboardFeatureId") %>' CommandName="MyEdit" Visible='<%#IsVisible() %>' CausesValidation="false"/>
                </td>
            </tr>
        </table>
                </Itemtemplate>
        </asp:DataList>
</ContentTemplate>
</asp:Accordion>
--%>
<asp:LinqDataSource ID="dsHeaders" runat="server" ContextTypeName="Billboard.BillboardDataContext"
    OrderBy="TypeNumber" TableName="Agape_Billboard_Feature_Types">
</asp:LinqDataSource>
