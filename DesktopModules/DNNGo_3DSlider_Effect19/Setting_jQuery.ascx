<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Setting_jQuery.ascx.cs" Inherits="DNNGo.Modules.DNNGallery.Setting_jQuery" %>

<div class="options_views">
    <h2 class="setting_page_title">
        <%=ViewTitle("lblModuleTitle", "Module Settings")%></h2>
  


    <div class="choose_tags form_field handlediv">
        <h3 class="hndle">
            <%=ViewTitle("lbljQuerySettings", "jQuery Settings")%></h3>
        <div class="inside">


        <div class="form_field">
            <h4><%=ViewTitle("lbljQueryEnable", "jQuery Enable", "cbjQueryEnable")%>:</h4>
                    <asp:CheckBox ID="cbjQueryEnable" runat="server" />
            </div>
        <div class="form_field">
            <h4><%=ViewTitle("lbljQueryVersion", "Installed jQuery Version")%>:</h4>
                 <%=ViewTitle("lbljQueryVersionText", "1.7.2")%>
        </div>
         <div class="form_field">
            <h4><%=ViewTitle("lbljQueryVersion", "Installed jQuery UI Version")%>:</h4>
                 <%=ViewTitle("lbljQueryUIVersionText", "1.8.2")%>
        </div>
        <div class="form_field">
            <h4><%=ViewTitle("lblUseHostedjQuery", "Use Hosted jQuery Version", "cbUseHostedjQuery")%>?</h4>
                <asp:CheckBox ID="cbUseHostedjQuery" runat="server" />
            </div>

            <div class="form_field">
                <h4><%=ViewTitle("lblHostedjQuery", "Hosted jQuery URL", "txtHostedjQuery")%>:</h4>
                 <asp:TextBox runat="server" ID="txtHostedjQuery" Width="80%" CssClass="input_text validate[required]"></asp:TextBox>
            </div>
             <div class="form_field">
                <h4><%=ViewTitle("lblHostedjQueryUI", "Hosted jQuery UI Url", "txtHostedjQueryUI")%>:</h4>
                 <asp:TextBox runat="server" ID="txtHostedjQueryUI" Width="80%" CssClass="input_text validate[required]"></asp:TextBox>
            </div>
          

 
        


        </div>
    </div>

    
 
  
    <p style="text-align: center;">
        <asp:Button CssClass="input_button" lang="Submit" ID="cmdUpdate" resourcekey="cmdUpdate"
            runat="server" Text="Update" OnClick="cmdUpdate_Click"></asp:Button>&nbsp;
        <asp:Button CssClass="input_button" ID="cmdCancel" resourcekey="cmdCancel" runat="server"
            Text="Cancel" CausesValidation="False" OnClick="cmdCancel_Click"  OnClientClick="CancelValidation();"></asp:Button>&nbsp;
    </p>
</div>

