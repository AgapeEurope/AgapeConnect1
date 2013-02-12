<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Setting_Effect_Theme.ascx.cs" Inherits="DNNGo.Modules.DNNGallery.Setting_Effect_Theme" %>
<div class="theme_import_setting">
	<h2 class="setting_page_title"><%=ViewTitle("lblModuleTitle", "Install Theme")%></h2>
	<div class="form_field">
		<h4><%=ViewTitle("lblThemeFile", "Theme File", "fuThemeFile")%>:</h4>
		<asp:FileUpload runat="server" CssClass=" :required :file;.zip," Width="300" ID="fuThemeFile" />
         <p><%=ViewHelp("lblThemeFile", "If there's duplication when you import themes, system will replace them with original themes by default.")%></p>
	</div>
	<p>
        <asp:Button cssclass="input_button" lang="Submit" id="cmdUpdate" resourcekey="cmdUpdate" runat="server" text="Update" OnClick="cmdUpdate_Click"></asp:Button>&nbsp;
        <asp:Button cssclass="input_button" id="cmdCancel" resourcekey="cmdCancel" runat="server" text="Cancel" causesvalidation="False" OnClick="cmdCancel_Click"></asp:Button>
    </p>
</div>