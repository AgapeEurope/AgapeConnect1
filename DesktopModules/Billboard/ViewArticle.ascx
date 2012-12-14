<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ViewArticle.ascx.vb" Inherits="DotNetNuke.Modules.Billboard.ViewArticle" %>
<%@ Register src="~/DesktopModules/Billboard/controls/ViewArticle.ascx" tagname="viewArt" tagprefix="uc1" %>

<uc1:viewArt ID="viewArt" runat="server" />
<br />
<div style="text-align:left;">
<%--<asp:LinkButton ID="btnBack" runat="server">Back</asp:LinkButton>--%>
<asp:ImageButton ID="btnBack" runat="server" Height="24px" ImageUrl="~/DesktopModules/Billboard/Images/BtnImg/Back1.gif"  
                                                onmouseover="this.src='/DesktopModules/Billboard/Images/BtnImg/Back2.gif';"  
                                                onmouseout="this.src='/DesktopModules/Billboard/Images/BtnImg/Back1.gif';" AlternateText="Go Back" ToolTip="Go Back"/>
                                                </div>
