<%@ Control Language="VB" AutoEventWireup="false" CodeFile="EditFeature.ascx.vb" Inherits="DesktopModules_Billboard_controls_EditFeature" ClassName="DesktopModules_Billboard_controls_EditFeature" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/texteditor.ascx"%>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/labelcontrol.ascx" %>
<%@ Register Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" TagPrefix="cc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register assembly="ImageCropper" namespace="KrispWare" tagprefix="cc2" %>
<link rel="stylesheet" type="text/css" href="/DesktopModules/Billboard/BillTheme/BillStyle.css" />

<script type="text/javascript">
/*globals jQuery, window, Sys */
    (function ($, Sys) {
        function setUpMyTabs() {
            var pickerOpts = {
                dateFormat: '<%= GetDateFormat() %>'
            };
            $('.datepicker').datepicker(pickerOpts);
        }

        $(document).ready(function () {
            setUpMyTabs();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpMyTabs();
            });
        });
    } (jQuery, window.Sys));


    function featTextCounter(field, countfield, maxlimit) {
        if (field.value.length > maxlimit)
            field.value = field.value.substring(0, maxlimit);
        else
            countfield.value = maxlimit - field.value.length;
    }


</script>

<asp:HiddenField ID="hfUserId" runat="server" />
<asp:HiddenField ID="hfFeatureArtId" runat="server" />
<asp:Label ID="lblErrorUpload" runat="server" visible="false" ForeColor="Red"></asp:Label>

<asp:Panel ID="pnlContent" runat="server">
<img alt="Feature Article" src="/DesktopModules/Billboard/Images/BillFeat.gif" /><br /><br />
<table class="Agape_Settings_Title" >
    <tr>
        <td class="Agape_Settings_Title" >Headline:</td>
        <td>
            <asp:TextBox ID="tbHeadline" runat="server" Font-Bold="True" Font-Names="Verdana" 
                    MaxLength="50" Font-Size="20pt" Width="650px" onkeyup='featTextCounter(this, this.form.remLenLink1, 50);'
                                onkeydown="featTextCounter(this, this.form.remLenLink1, 50);"></asp:TextBox><input readonly="readonly"
                                    type="text" name="remLenLink1" size="2" maxlength="2" value="50" />characters left<br />
                                    <asp:Label ID="lblErrorStarHeadline" runat="server" Text="*" ForeColor="Red" 
                    Font-Size="10pt" Visible="False"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="Agape_Settings_Title">
        Date:
        </td>
        <td>
            <asp:TextBox ID="tbDate" runat="server" class="datepicker"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="Agape_Settings_Title">Photo:</td>
        <td>

            <table>
               <tr>
                   <td width="230px" class="Agape_Settings_Title"  
                       style="text-align: center; border-top-style: solid; border-top-width: thin; border-right-style: solid; border-right-width: thin; border-left-style: solid; border-left-width: thin; font-size: 8pt;">
                   1. Browse for the photo you want as the Story's main photo:
                   </td>
                   <td width="75px" class="Agape_Settings_Title"  style="text-align: center; border-top-style: solid; border-top-width: thin; border-right-style: solid; border-right-width: thin; border-left-style: solid; border-left-width: thin; font-size: 8pt;">
                   2. Upload the photo you have chosen:
                   </td>
                   <td width="220px" class="Agape_Settings_Title"  style="text-align: center; border-top-style: solid; border-top-width: thin; border-right-style: solid; border-right-width: thin; border-left-style: solid; border-left-width: thin; font-size: 8pt;">
                   3. Crop the photo to the correct size and shape:
                   </td>
               </tr>
               <tr>
               
                    <td width="230px" style="border-bottom-style: solid; border-bottom-width: thin; border-left-style: solid; border-left-width: thin; border-right-style: solid; border-right-width: thin; text-align: center;">
                    <asp:FileUpload ID="fuFileUpload2" runat="server" Width="200px" CausesValidation="false" />
                    </td>
                    <td width="75px" style="border-bottom-style: solid; border-bottom-width: thin; border-left-style: solid; border-left-width: thin; border-right-style: solid; border-right-width: thin; text-align: center;">
                        <asp:Button ID="btnPhoto1Button" runat="server" Text="Upload" CausesValidation="false"/>
                    </td>
                    <td width="220px" style="border-bottom-style: solid; border-bottom-width: thin; border-left-style: solid; border-left-width: thin; border-right-style: solid; border-right-width: thin">
                    <div align="center" style="height:auto">
                    <cc2:ImageCropper ID="icImageCropper1" runat="server" AspectRatio="1" Width = "200px"/>
                    </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblErrorPhoto" runat="server" style="color: #FF0000" 
                            Font-Names="Verdana" Font-Size="9pt"></asp:Label>
                    </td>
                </tr>
            </table>

                    </td>
    </tr>
    <tr>
        <td class="Agape_Settings_Title">Text</td>
        <td>
            <dnn:TextEditor ID="tbStoryText" runat="server" Height="647" Width="100%" /> <asp:Label ID="lblErrorStarStoryText" runat="server" Text="*" ForeColor="Red" 
                    Font-Size="10pt" Visible="False"></asp:Label>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <asp:Label ID="lblErrorLabelHeadline" runat="server" Text="*Please enter a Headline" 
                    ForeColor="Red" Font-Names="verdana" Visible="False"></asp:Label> <br />
            <asp:Label ID="lblErrorLabelStoryText" runat="server" Text="*Please enter a Story" 
                    ForeColor="Red" Font-Names="verdana" Visible="False"></asp:Label><br />
            
            
        </td>
    </tr>
    <tr> 
        <td class="Agape_Settings_Title">Is Visible:</td>
        <td><asp:CheckBox ID="cbVisibleCheck" runat="server" Checked="True" /></td>
    </tr>
    <tr>
    <td class="Agape_Settings_Title">Feature Type:</td>
    <td>
        <asp:RadioButtonList ID="rblFeatType" runat="server" DataSourceID="dsFeatType" 
            DataTextField="TypeName" DataValueField="TypeNumber">
        </asp:RadioButtonList>
        <asp:LinqDataSource ID="dsFeatType" runat="server" 
            ContextTypeName="Billboard.BillboardDataContext" OrderBy="TypeNumber" 
            TableName="Agape_Billboard_Feature_Types">
        </asp:LinqDataSource>
    </td>
    </tr>
    <tr>
         <td colspan="2">
            <table  class="Agape_Settings_Title">
                <tr>
                    <td align="left">
                    <%--<asp:LinkButton ID="btnSaveButton" runat="server" CausesValidation="false">Add</asp:LinkButton>--%>
                    <asp:ImageButton ID="btnSaveButton" runat="server" Height="24px" ImageUrl="~/DesktopModules/Billboard/Images/BtnImg/Save1.gif"  
                                                onmouseover="this.src='/DesktopModules/Billboard/Images/BtnImg/Save2.gif';" CausesValidation="false"  
                                                onmouseout="this.src='/DesktopModules/Billboard/Images/BtnImg/Save1.gif';" AlternateText="Save Article" ToolTip="Save Article"/>
                    </td>
                    <td align="left">
                    <%--<asp:LinkButton ID="btnCancelButton" runat="server" CausesValidation="false" OnClientClick="closePopup2();">Cancel</asp:LinkButton>--%>
                     <asp:ImageButton ID="btnCancelButton" runat="server" Height="24px" ImageUrl="~/DesktopModules/Billboard/Images/BtnImg/Cancel1.gif" OnClientClick="closePopup2();" 
                                                onmouseover="this.src='/DesktopModules/Billboard/Images/BtnImg/Cancel2.gif';" CausesValidation="false" 
                                                onmouseout="this.src='/DesktopModules/Billboard/Images/BtnImg/Cancel1.gif';" AlternateText="Cancel and go back" ToolTip="Cancel and go back"/>
                    </td>
                    <td align="left">
                     <%--<asp:LinkButton ID="btnDeleteButton" runat="server" CausesValidation="false" OnClientClick="return confirm('Are you sure you want to delete this story?')">Delete Story</asp:LinkButton>--%>
                     <asp:ImageButton ID="btnDeleteButton" runat="server" Height="24px" ImageUrl="~/DesktopModules/Billboard/Images/BtnImg/Delete1.gif" OnClientClick="return confirm('Are you sure you want to delete this article?')"  
                                                onmouseover="this.src=/DesktopModules/Billboard/Images/BtnImg/Delete2.gif';" CausesValidation="false" 
                                                onmouseout="this.src='/DesktopModules/Billboard/Images/BtnImg/Delete1.gif';" AlternateText="Delete Article" ToolTip="Delete Article"/>
                       
                    </td>
                </tr>
                <tr>
                <td colspan="3">
                    <asp:Label ID="lblSaving" runat="server" forecolor="Red" Visible="false"></asp:Label>
                </td>
                </tr>
            </table> 
         </td>   
    </tr>
</table>
</asp:Panel>
    
    



        
    
    
    


