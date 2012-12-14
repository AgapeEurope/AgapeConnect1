<%@ Control Language="VB" AutoEventWireup="false" CodeFile="EditBillboardAnnouncements.ascx.vb" Inherits="DotNetNuke.Modules.BillboardAnnouncements.EditBillboardAnnouncements" %>
<%@ Register src="~/DesktopModules/Billboard/controls/EditAnnouncement.ascx" tagname="editAnn" tagprefix="uc1" %>

<asp:Panel ID="pnlEdit" runat="server">

<uc1:editAnn ID="editAnn" runat="server" />

</asp:Panel>

<asp:Label ID="lblLoadError" runat="server" ForeColor="Red" Visible="false"></asp:Label>
<br />
<asp:ImageButton ID="btnBack" runat="server" Height="24px" ImageUrl="~/DesktopModules/Billboard/Images/BtnImg/Back1.gif"  
                                                onmouseover="this.src='/DesktopModules/Billboard/Images/BtnImg/Back2.gif';" CausesValidation="false"  
                                                onmouseout="this.src='/DesktopModules/Billboard/Images/BtnImg/Back1.gif';" AlternateText="Back" ToolTip="Back"/>
<%--<asp:LinkButton ID="btnBack" runat="server" CausesValidation="false">Back</asp:LinkButton>--%>
