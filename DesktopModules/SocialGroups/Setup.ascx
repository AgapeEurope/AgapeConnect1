<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Setup.ascx.cs" Inherits="DotNetNuke.Modules.Groups.Setup" %>
<div class="dnnForm">
<h1><%=LocalizeString("SetupHeader") %></h1>
<p><%=LocalizeString("SetupIntro") %></p>
<asp:LinkButton ID="btnGo" runat="server" resourceKey="AutoConfigure" CssClass="dnnPrimaryAction" />

</div>
