<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View_Index.ascx.cs" Inherits="DNNGo.Modules.DNNGallery.View_Index" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<asp:Panel ID="plLicense" runat="server">
<asp:PlaceHolder ID="phScript" runat="server"></asp:PlaceHolder>
 <asp:PlaceHolder  ID="phContainer" runat="server"></asp:PlaceHolder>
 
</asp:Panel>
<asp:Panel ID="pnlTrial" runat="server">
    <center>
        <asp:Literal ID="litTrial" runat="server"></asp:Literal>
        <br />
        <asp:Label ID="lblMessages" runat="server" CssClass="SubHead" resourcekey="lblMessages"
            Visible="false" ForeColor="Red"></asp:Label>
    </center>
</asp:Panel>