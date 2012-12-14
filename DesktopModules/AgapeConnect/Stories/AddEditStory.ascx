<%@ Control Language="VB" AutoEventWireup="false" CodeFile="AddEditStory.ascx.vb"
    Inherits="DotNetNuke.Modules.Stories.AddEditStory" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
     <%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
     <%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register src="../StaffAdmin/Controls/acImage.ascx" tagname="acImage" tagprefix="uc1" %>
<script src="/js/jquery.watermarkinput.js" type="text/javascript"></script>
<script type="text/javascript" src='http://maps.google.com/maps/api/js?sensor=false'></script>
<script src="/js/jquery.locationpicker.js" type="text/javascript"></script>
<script type="text/javascript">
    /*globals jQuery, window, Sys */
    (function ($, Sys) {
        function setUpMyTabs() {
            $('#<%= Headline.ClientId %>').Watermark('Headline');
            $('#<%= Author.ClientId %>').Watermark('Author');
            $('.aButton').button();
            $("#<%= tbLocation.ClientId %>").locationPicker({ map: 'before',showMap: 'always', width: '200px', padding: 0, border: 0 });
            $('.picker-search-button').button();
            $('.picker-search-button').click();
            $('.picker-search-button').css('font-size', 'x-small');
          

        }

        $(document).ready(function () {
            setUpMyTabs();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpMyTabs();
            });
        });
    } (jQuery, window.Sys));
</script>

<style type="text/css">
  
</style>

<asp:HiddenField ID="StoryIdHF" runat="server" />
<asp:HiddenField ID="ShortTextHF" runat="server" />
<asp:HiddenField ID="PhotoIdHF" runat="server" />

<asp:Label ID="NotFoundLabel" runat="server" Text="Story Not Found" Font-Bold="True"
    ForeColor="Red"></asp:Label>
<asp:Panel ID="PagePanel" runat="server" Style="margin-right: 0px; margin-left: 0px;
    padding-left 0px;">
    <div class="Agape_Story_storymain">
        <div class="AgapeH2">
            <asp:TextBox ID="Headline" class="AgapeH2" style="border-bottom-style: none; width: 100%" runat="server" ></asp:TextBox>
        </div>
        <div class="Agape_Story_subtitle">
            <table width="100%">
                <tr>
                    <td class="Agape_Story_subtitle" align="left">
                        By
                        <asp:TextBox ID="Author" runat="server"  class="Agape_Story_subtitle" style="width: 90%; display: inline;" ></asp:TextBox>
                    </td>
                    <td class="Agape_Story_subtitle" align="right" style="padding-right: 25px">
                        <asp:Label ID="StoryDate" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <div class="Agape_FullStory_bodytext" style="padding-right: 12px; margin-bottom: 10px;">
        <table>
            <tr valign="top">
                <td >
                <uc1:acImage ID="acImage1" runat="server" Aspect="1.3" /><br />
                    <table border="0" cellpadding="0" cellspacing="0">
                         <tr>
                            <td>
                              <b>Language:</b>
                            </td>
                            <td>
                             <asp:DropDownList ID="ddlLanguage" runat="server" Width="130px">

</asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                              <b>Channel:</b>
                            </td>
                            <td>
                             <asp:DropDownList ID="ddlChannels" runat="server"  Width="130px"></asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                   
                    
                <br />
                    
                      <asp:TextBox ID="tbLocation" runat="server" Width="130px" style="margin-right: 3px;"></asp:TextBox>
                         <br /><br />
                        <asp:Panel ID="pnlLanguages" runat="server" Visible="false" Width="100%"  >
                            
                <b>Translations:</b><br /><i>(Click to open in new tab)</i>

                <div style="margin: 4px 0 4px 0;">
             <asp:DataList ID="dlLanuages" runat="server" RepeatDirection="Horizontal" ItemStyle-HorizontalAlign="Center"  Width="100%" >
                    <ItemTemplate>
                       <asp:HyperLink ID="HyperLink2" runat="server" target="_blank"  ToolTip='<%# GetLanguageName(Eval("Language")) %>' ImageUrl='<%# GetFlag(Eval("Language"))  %>' NavigateUrl ='<%# NavigateURL() & "?StoryId=" & Eval("StoryId") %>'>HyperLink</asp:HyperLink>
                    </ItemTemplate>
             </asp:DataList>
                    </div>
           </asp:Panel>
                
               </td>
                <td>
                <dnn:TextEditor ID="StoryText" runat="server"  TextRenderMode="Raw"  Width="100%"  HtmlEncode="False" defaultmode="Rich" height="700" choosemode="True" chooserender="False"   />
                </td>
            </tr>
        </table>
            
           
            
          
        </div>
    </div>
   
   
    <div style="clear: both;" />

 

    <asp:Panel ID="SuperPowers" runat="server" Visible="false">
        <br />
        <table style="border-style: groove; border-width: thin">
       
            <tr>
                <td style="font-family: verdana; font-size: 14pt;">
                    Boost Story
                </td>
                <td colspan="2" valign="middle">
                    <asp:Button ID="BoostButton" runat="server" Text="Boost" />
                    &nbsp
                    <asp:Label ID="BoostLabel" runat="server" Text="BoostLabel" ForeColor="Gray" Font-Italic="True"
                        Font-Names="Verdana" Font-Size="10pt"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="font-family: verdana; font-size: 14pt;">
                    Is Editable
                </td>
                <td style="text-align: left">
                    <asp:CheckBox ID="Editable" runat="server" Checked="True" />
                </td>
                <td>
                    <asp:LinkButton ID="UpdatePowerBtn" runat="server">Update</asp:LinkButton>
                    &nbsp;
                    <asp:LinkButton ID="CancelPowerBtn" runat="server">Cancel</asp:LinkButton>
                </td>
            </tr>
        </table>
    </asp:Panel>
  
    <div style="clear: both;" />
    <div align="center">
<asp:Button ID="btnSave" runat="server" Text="Save" class="aButton" />
<asp:Button ID="btnCancel" runat="server" Text="Cancel" class="aButton" />
</div>
    </asp:Panel> 


