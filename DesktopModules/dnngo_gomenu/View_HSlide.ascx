<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View_HSlide.ascx.cs" Inherits="DNNGo.SkinObject.GoMenu.View_HSlide" %>
<div id="gomenu<%=ClientID %>" class="gomenu <%=CssClass %>">
    <asp:Literal ID="LiContent" runat="server"></asp:Literal>
</div>
<script type="text/javascript">
    window["gomenu<%=ClientID %>"] = DnnDev.Create("gomenu<%=ClientID %>"); window["gomenu<%=ClientID %>"].Initialize({ "Enabled": true }, {});
</script>
