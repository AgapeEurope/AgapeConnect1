<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ViewBillbaordArt.ascx.vb"
    Inherits="DotNetNuke.Modules.BillboardArt.ViewBillboardArt" %>
<%@ Register Src="~/DesktopModules/Billboard/controls/ViewArt/ViewArt.ascx" TagName="viewArt" TagPrefix="uc1" %>
<%@ Register Src="~/DesktopModules/Billboard/controls/ArtArchive.ascx" TagName="artArch" TagPrefix="uc4" %>
<link rel="stylesheet" type="text/css" href="/DesktopModules/Billboard/BillTheme/BillStyle.css" />
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
</style>
<br />
<div style="width: 550px; text-align: left;">
    <asp:Image ID="imgHead" runat="server" ImageUrl="~/DesktopModules/Billboard/images/BillArt.gif" />
    <div class="Bill_dashed">
        &nbsp;</div>
    <uc1:viewArt ID="viewArt" runat="server" />
    
    <div class="Bill_dashed">
        &nbsp;</div>
    <div style="text-align: left">
        <asp:ImageButton ID="btnNewArt" runat="server" Height="24px" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/NewArticle1.gif"
            onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/NewArticle2.gif';" onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/NewArticle1.gif';"
            AlternateText="New Article" ToolTip="New Article" />&nbsp;
        <asp:ImageButton ID="btnArtArch" runat="server" Height="24px" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/ViewArchive1.gif"
            onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/ViewArchive2.gif';" onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/ViewArchive1.gif';"
            AlternateText="View Archive" ToolTip="View Archive" OnClientClick="showViewArt(); return false;" />
    </div>
</div>
<br />
<div id="divViewArt" class="padInner">
    <div id="ViewArtInner" style="overflow: hidden">
        <div style="text-align: center">
            <asp:Label ID="lblEmpty" runat="server" Text="There are no archived articles currently."
                CssClass="Bill_H4" Visible="false"></asp:Label>
        </div>
        <asp:DataList ID="dlMain" runat="server" DataSource='<%#GetData() %>'>
            <ItemTemplate>
                <table class='<%#ColourMeGray(Eval("Visible"), Eval("Sent")) %>' width="100%">
                    <tr>
                        <td valign="top" width="100px" style="padding-top:7px;">
                            <div class="Bill_Photo" style="width:100px; height:100px;">
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# "~/DesktopModules/Billboard/GetBillboardImage.aspx?PhotoId=" & Eval("BillboardPhotoId") & "&Size=100" %>' /></div>
                        </td>
                        <td valign="top" align="left" width="600px">
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Headline") %>' class="Bill_H4"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label3" runat="server" Text='<%# UnderLabelText(Eval("BillbaordArticleId")) %>'
                                            Font-Names="Verdana" Font-Size="7pt" Font-Italic="true" ForeColor="Gray"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="justify" class="Bill_Text_Main">
                                        <asp:Label ID="Label2" runat="server" Text='<%# CleanText(Eval("StoryText")) %>'
                                            Font-Names="Verdana" Font-Size="8pt"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td valign="top" style="padding-top:7px">
                            <asp:ImageButton ID="btnGoTo" Height="24px" runat="server" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/View1.gif"
                                onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/View2.gif';" onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/View1.gif';"
                                AlternateText="View Article" ToolTip="View Article" CommandArgument='<%#Eval("BillbaordArticleId") %>'
                                CommandName="GoTo" CausesValidation="false" /><br />
                            <asp:ImageButton ID="btnEdit" Height="24px" runat="server" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/Edit1.gif"
                                onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/Edit2.gif';" onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/Edit1.gif';"
                                AlternateText="Edit Article" ToolTip="Edit Article" CommandArgument='<%#Eval("BillbaordArticleId") %>'
                                CommandName="MyEdit" Visible='<%#IsVisible(Eval("BillbaordArticleId")) %>' CausesValidation="false" />
                            <br />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>
        <asp:Panel ID="pnlSmallKey" runat="server" Visible="false">
            <table>
                <tr>
                    <td style="width: 10px; height: 10px;" class="BackYellow">
                        &nbsp;
                    </td>
                    <td style="height: 10px; font-size: 10pt;" class="Bill_Text_Main">
                        = Article not visible
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <%--<uc4:artArch ID="artArch1" runat="server" />--%>
    </div>
</div>
<br />
<asp:Label ID="lblTest" runat="server"></asp:Label>