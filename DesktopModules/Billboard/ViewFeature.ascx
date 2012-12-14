<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ViewFeature.ascx.vb" Inherits="DotNetNuke.Modules.Billboard.ViewFeature" %>
<%@ Register src="~/DesktopModules/Billboard/controls/ViewFeature.ascx" tagname="viewFeat" tagprefix="uc1" %>

<uc1:viewFeat ID="viewFeat" runat="server" />

<br />
<%--<asp:LinkButton ID="btnBack" runat="server">Back</asp:LinkButton>--%>
<asp:ImageButton ID="btnBack" runat="server" Height="24px" ImageUrl="~/DesktopModules/Billboard/Images/BtnImg/Back1.gif"  
                                                onmouseover="this.src='/DesktopModules/Billboard/Images/BtnImg/Back2.gif';"  
                                                onmouseout="this.src='/DesktopModules/Billboard/Images/BtnImg/Back1.gif';" AlternateText="Go Back" ToolTip="Go Back"/>