<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Setting_ManagerInfo.ascx.cs" Inherits="DNNGo.Modules.DNNGallery.Setting_ManagerInfo" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.UI.WebControls" Assembly="DotNetNuke" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<%@ Register TagPrefix="dnn" TagName="URL" Src="~/controls/URLControl.ascx" %>
<div class="options_views">
    <h2 class="setting_page_title"><%=ViewTitle("lblModuleTitle", "Compose a new Content")%></h2>
   <!-- <div class="choose_tags form_field handlediv">
        <h3 class="hndle">
            <%=ViewTitle("lblBaseSetting", "Base Views")%></h3>
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
        </div>
    </div>
    -->

   <div class="choose_tags form_field handlediv">
        <h3 class="hndle"><%=ViewTitle("lblEditContentTitle", "Edit Content")%></h3>
        <div class="inside">
             <div class="form_field">
                <h4>
                    <%=ViewTitle("lblTitle", "Title", "txtTitle")%>:</h4>
                    <asp:TextBox ID="txtTitle" runat="server" Width="90%"  CssClass="input_text validate[required,maxSize[100]]"></asp:TextBox>
            </div>
               <div class="form_field">
                <h4>
                    <%=ViewTitle("lblStatus", "Activation", "cbStatus")%>:</h4>
                   <asp:CheckBox ID="cbStatus" runat="server" />
            </div>
             <div class="form_field" runat="server" id="divViewType" visible="false">
                <h4>
                    <%=ViewTitle("lblViewType", "View Type", "rblViewType")%>:</h4>
                    <asp:RadioButtonList ID="rblViewType" runat="server" RepeatDirection="Horizontal" 
                     onselectedindexchanged="rblViewType_SelectedIndexChanged" AutoPostBack="true"></asp:RadioButtonList>
            </div>
               <div class="form_field" runat="server" id="divSubtitle" visible="false">
                <h4>
                    <%=ViewTitle("lblSubTitle", "Subtitle", "txtSubTitle")%>:</h4>
                    <asp:TextBox ID="txtSubTitle" runat="server" Width="90%"  CssClass="input_text validate[maxSize[100]]"></asp:TextBox>
            </div>
             <div class="form_field" runat="server" id="divDescription" visible="false">
                <h4>
                    <%=ViewTitle("lblDescription", "Description", "txtDescription")%>:</h4>
                    <asp:TextBox ID="txtDescription" CssClass="input_text" runat="server" Width="90%" Rows="5" TextMode="MultiLine" ></asp:TextBox>
            </div>
             <div class="form_field" runat="server" id="divContentText" visible="false">
                <h4>
                    <%=ViewTitle("lblContentText", "Content Text", "txtContentText")%>:</h4>
                    <div id="wp-content-editor-container" class="wp-editor-container">  
                        <dnn:TextEditor id="txtContentText" runat="server" height="450" width="100%"></dnn:TextEditor>
                    </div>
            </div>
        </div>
    </div>

    <div class="insert_picture form_field handlediv" runat="server" id="divPicture" visible="false">
        <h3 class="hndle"><%=ViewTitle("lblPicture", "Picture", "ucPicture")%></h3>
        <div class="inside">
           <dnn:URL ID="ucPicture" runat="server" ShowTabs="false" UrlType="U" ShowNewWindow="false"
                    ShowNone="false" Visible="true" ShowSecure="false" ShowDatabase="false" ShowLog="false"
                    ShowTrack="false" ShowFiles="true" ShowUrls="true" />
        </div>
    </div>
   <div class="insert_picture form_field handlediv" runat="server" id="divThumbnails" visible="false">
        <h3 class="hndle"><%=ViewTitle("lblThumbnails", "Thumbnails", "ucThumbnails")%></h3>
        <div class="inside">
           <dnn:URL ID="ucThumbnails" runat="server" ShowTabs="false" UrlType="U" ShowNewWindow="false"
                    ShowNone="false" Visible="true" ShowSecure="false" ShowDatabase="false" ShowLog="false"
                    ShowTrack="false" ShowFiles="true" ShowUrls="true" />
        </div>
    </div>
    <div class="insert_picture form_field handlediv" runat="server" id="divUrlLink" visible="false">
        <h3 class="hndle"><%=ViewTitle("lblUrlLinkTitle", "Link Setting")%></h3>
        <div class="inside">
             <div class="form_field">
                <h4>
                    <%=ViewTitle("lblUrlLink", "Url Link", "ucUrlLink")%>:</h4>
                <dnn:URL ID="ucUrlLink" runat="server" ShowTabs="true" UrlType="U" ShowNewWindow="false"
                    ShowNone="false" Visible="true" ShowSecure="true" ShowDatabase="false" ShowLog="false"
                    ShowTrack="false" ShowFiles="true" ShowUrls="true" />
             </div>
             <div class="form_field">
                <h4>  <%=ViewTitle("lblLinkTarget", "New Window", "rblLinkTarget")%>:</h4>
                <asp:CheckBox ID="cbLinkTarget" runat="server" />
                
            </div>
              <div class="form_field" id="divLinkType" runat="server" visible="false">
                <h4>
                    <%=ViewTitle("lblLinkMeta", "Link Meta", "rblLinkMeta")%>:</h4>
                    <asp:RadioButtonList ID="rblLinkType" runat="server"></asp:RadioButtonList>
            </div>
           
        </div> 
    </div>
      <div class="insert_picture form_field handlediv" runat="server" id="divIncludeModule" visible="false">
        <h3 class="hndle"><%=ViewTitle("lblIncludeModule", "Include Module")%></h3>
        <div class="inside">
             <div class="form_field">
                <h4>
                    <%=ViewTitle("lblViewTab", "Select Tab", "ddlViewTab")%>:</h4>
                    <asp:DropDownList ID="ddlViewTab" runat="server" 
                     DataTextField="IndentedTabName" DataValueField="TabId" 
                     CssClass="NormalTextBox input_text :required" Width="300" 
                     onselectedindexchanged="ddlViewTab_SelectedIndexChanged" AutoPostBack="true" />
            </div>
            <div class="form_field">
                <h4>
                    <%=ViewTitle("lblViewModule", "Select Module", "ddlViewModule")%>:</h4>
                    <asp:DropDownList ID="ddlViewModule" runat="server" CssClass="NormalTextBox input_text :required"></asp:DropDownList>
            </div>
        </div>
    </div>


    <p style="text-align: center;">
    <asp:Button CssClass="input_button" lang="Submit" ID="cmdUpdate" resourcekey="cmdUpdate" runat="server"
         Text="Update" OnClick="cmdUpdate_Click"></asp:Button>&nbsp;
    <asp:Button CssClass="input_button" ID="cmdCancel" resourcekey="cmdCancel" runat="server"  OnClientClick="CancelValidation();"
         Text="Cancel" CausesValidation="False" OnClick="cmdCancel_Click"></asp:Button>&nbsp;
    <asp:Button CssClass="input_button" ID="cmdDelete" resourcekey="cmdDelete" runat="server"  OnClientClick="CancelValidation();"
         Text="Delete" Enabled="false" CausesValidation="False" OnClick="cmdDelete_Click"></asp:Button>&nbsp;
    </p>

</div>












 