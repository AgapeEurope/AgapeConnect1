<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Setting_Effect_Style.ascx.cs" Inherits="DNNGo.Modules.DNNGallery.Setting_Effect_Style" %>
<div class="options_views">
    <h2 class="setting_page_title">
        <%=ViewTitle("lblModuleTitle", "Edit Theme Settings")%></h2>

        <!--
    <div class="choose_tags form_field handlediv">
        <h3 class="hndle">
            <%=ViewTitle("lblBaseSetting", "Base Settings")%></h3>
        <div class="inside">
            
            <div class="form_field">
                <h4>
                    <%=ViewTitle("lblEffectName", "Effect Name", "lblEffectName")%>:</h4>
                <asp:Label ID="lblEffectName" runat="server"></asp:Label>
            </div>
            <div class="form_field">
                <h4>
                    <%=ViewTitle("lblEffectDescription", "Effect Description", "lblEffectDescription")%>:</h4>
                <asp:Label ID="lblEffectDescription" runat="server"></asp:Label>
            </div>
           
            <div class="form_field">
                <h4>
                    <%=ViewTitle("lblThemeName", "Theme Name", "ddlThemeName")%>:</h4>
                    <asp:Label ID="lblThemeName" runat="server"></asp:Label>
            </div>
           
            <div class="form_field">
                <asp:Image runat="server" style=" max-height:100px;" ID="imgThemeThumbnails" Visible="false" />
                <asp:HiddenField runat="server" ID="hfThemeThumbnails" />
            </div> 
        </div>
    </div>
    -->
    <div class="choose_tags form_field handlediv">
        <h3 class="hndle">
            <%=ViewTitle("lblThemeSetting", "Theme Settings")%></h3>
        <div class="inside">
           <%-- <asp:TextBox runat="server" ID="txtContent" Rows="20" TextMode="MultiLine" Style="width:98%;"></asp:TextBox>--%>
            <textarea runat="server" ID="txtContent" Rows="20"  style="width:98%; overflow-x:auto;"></textarea>
        </div>
    </div>
    <p style="text-align: center;">
        <asp:Button CssClass="input_button" lang="Submit" ID="cmdUpdate" resourcekey="cmdUpdate"
            runat="server" Text="Update" OnClick="cmdUpdate_Click"></asp:Button>&nbsp;
        <asp:Button CssClass="input_button" ID="cmdCancel" resourcekey="cmdCancel" runat="server"
            Text="Cancel" CausesValidation="False" OnClick="cmdCancel_Click"></asp:Button>&nbsp;
    </p>
</div>
