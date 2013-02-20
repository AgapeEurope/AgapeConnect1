<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View_DropDownList.ascx.cs" Inherits="DNNGo.SkinObject.GoMenu.View_DropDownList" %>
<div id="gomenu<%=ClientID %>" class="gomenu <%=CssClass %>">
   <asp:DropDownList ID="ddlSelectMenu" CssClass="select_menu" runat="server"></asp:DropDownList>
</div>
<script type="text/javascript">
    jQuery().ready(function ($) {
        $("#<%=ddlSelectMenu.ClientID %>").change(function () {
            window.location.href = $(this).val();
        });
    });
</script>