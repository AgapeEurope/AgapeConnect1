<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Setting_ManagerOptions.ascx.cs" Inherits="DNNGo.Modules.DNNGallery.Setting_ManagerOptions" %>
<div class="options_views">
    <h2 class="setting_page_title">
        <%=ViewTitle("lblModuleTitle", "View Module Options")%></h2>
    <div class="choose_tags form_field handlediv">
        <h3 class="hndle">
            <%=ViewTitle("lblBaseSetting", "Basic Settings")%></h3>
        <div class="inside">
         <!--
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
            -->



            <div class="form_field">
                <h4>
                    <%=ViewTitle("lblThemeName", "Theme Name", "ddlThemeName")%>:</h4>
                    <asp:DropDownList ID="ddlThemeName" runat="server" CssClass="input_text" ></asp:DropDownList>
            </div>


            <div class="form_field">
                <asp:Image runat="server" style="max-width:350px;" ID="imgThemeThumbnails" Visible="false" />
                <asp:HiddenField runat="server" ID="hfThemeThumbnails" />
            </div>
        </div>
    </div>
    <div class="choose_tags form_field handlediv">
        <h3 class="hndle">
            <%=ViewTitle("lblEffectSetting", "Effect Settings")%></h3>
        <div class="inside">
            <table>
            <asp:Repeater ID="RepeaterTheme" runat="server" OnItemDataBound="RepeaterTheme_ItemDataBound">
                <ItemTemplate>
                            <tr>
                                <td  style="white-space: nowrap;">
                                    <asp:Literal ID="liTitle" runat="server"></asp:Literal>:
                                </td>
                                <td>
                                    <asp:PlaceHolder ID="ThemePH" runat="server"></asp:PlaceHolder>
                                    <asp:Literal ID="liHelp" runat="server"></asp:Literal>
                             
                                </td>
                            </tr>
                </ItemTemplate>
            </asp:Repeater>
            </table>
        </div>
    </div>
    <p style="text-align: center;">
        <asp:Button CssClass="input_button" lang="Submit" ID="cmdUpdate" resourcekey="cmdUpdate"
            runat="server" Text="Update" OnClick="cmdUpdate_Click"></asp:Button>&nbsp;
        <asp:Button CssClass="input_button" ID="cmdCancel" resourcekey="cmdCancel" runat="server" OnClientClick="CancelValidation();" 
            Text="Cancel" CausesValidation="False" OnClick="cmdCancel_Click"></asp:Button>&nbsp;
    </p>
</div>


<script type="text/javascript">
    jQuery().ready(function ($) {
        $("#<%=ddlThemeName.ClientID %>").change(function () {
            var selecttext = $("#<%=ddlThemeName.ClientID %> option:selected").val();
            var urltext = $("#<%=hfThemeThumbnails.ClientID %>").val();
            $("#<%=imgThemeThumbnails.ClientID %>").attr("src", selecttext);


        });



    });
</script>