<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ArtArchive.ascx.vb" Inherits="DesktopModules_Billboard_controls_ArtArchive" ClassName="DesktopModules_Billboard_controls_ArtArchive" %>
<link rel="stylesheet" type="text/css" href="/DesktopModules/Billboard/BillTheme/BillStyle.css" />
<style type="text/css">
.BackBlue
{
    background-color:#CCFFFF;
}
.BackClear
{
    background-color:transparent;
}
.BackYellow
{
    background-color:#FFFF99;
}
.BackGreen
{
    background-color:#CCFFCC;
}
</style>
<asp:HiddenField ID="hfUserId" runat="server" />
<asp:HiddenField ID="hfMode" runat="server" />
<asp:HiddenField ID="hfEdit" runat="server" />
<asp:HiddenField ID="hfView" runat="server" />
<asp:Label ID="lblControlError" runat="server" Forecolor="Red" Visible="false"></asp:Label>
<div style="text-align:center">
    <asp:Label ID="lblEmpty" runat="server" Text="There are no archived articles currently." CssClass="Bill_H4" Visible="false"></asp:Label>
</div>
<asp:Panel ID="pnlKey" runat="server">
<table>
<tr>
<td class="Bill_H5" colspan="2">
Key:
</td>
</tr>
<tr>
<td>
Visible/Un-sent (Current):&nbsp;
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
</asp:Panel>
<asp:DataList ID="dlMain" runat="server" DataSource='<%#GetData() %>'>
    <ItemTemplate>
    <table class='<%#ColourMeGray(Eval("Visible"), Eval("Sent")) %>' width="100%">
        <tr>
            <td valign="top" width="100px"><div class="Bill_Photo" style="width:100px; height:100px;">
                <asp:Image ID="Image1" runat="server" ImageUrl='<%# "~/DesktopModules/Billboard/GetBillboardImage.aspx?PhotoId=" & Eval("BillboardPhotoId") & "&Size=100" %>'/></div>
            </td>
            <td valign="top" align="left" width="600px">
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("Headline") %>' Font-Bold="True" Font-Names="Verdana" Font-Size="10pt" ForeColor="#003399" Font-Underline="True"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label3" runat="server" Text='<%# UnderLabelText(Eval("BillbaordArticleId")) %>' Font-names="Verdana" Font-size="7pt" Font-Italic="true" ForeColor="Gray"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label2" runat="server" Text='<%# CleanText(Eval("StoryText")) %>' Font-Names="Verdana" Font-Size="8pt"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                <asp:ImageButton ID="LinkButton2" Height="24px" runat="server" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/View1.gif"  
                                                onmouseover="this.src=/DesktopModules/Billboard/images/BtnImg/View2.gif';"  
                                                onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/View1.gif';" AlternateText="View Article" ToolTip="View Article"
                                                 CommandArgument='<%#Eval("BillbaordArticleId") %>' CommandName="GoTo" CausesValidation="false"/><br />
                <asp:ImageButton ID="LinkButton1" Height="24px" runat="server" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/Edit1.gif"  
                                                onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/Edit2.gif';"  
                                                onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/Edit1.gif';" AlternateText="Edit Article" ToolTip="Edit Article"
                                                 CommandArgument='<%#Eval("BillbaordArticleId") %>' CommandName="MyEdit" Visible='<%#IsVisible() %>' CausesValidation="false"/>
            </td>
        </tr>
    </table>
    </ItemTemplate>
</asp:DataList>
<br />
<asp:Panel ID="pnlSmallKey" runat="server" Visible="false">
<table>
<tr>
<td style="width:10px; height:10px;" class="BackYellow">&nbsp;</td>
<td style="height:10px; font-size:10pt;" class="Bill_Text_Main"> = Article not visible</td>
</tr>
</table>
</asp:Panel>
