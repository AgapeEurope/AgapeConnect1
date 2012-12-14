<%@ Control Language="VB" AutoEventWireup="false" CodeFile="EditArticle.ascx.vb" Inherits="DesktopModules_Billboard_controls_EditArticle" ClassName="DesktopModules_Billboard_controls_EditArticle" %>

<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx"%>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" TagPrefix="cc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register assembly="ImageCropper" namespace="KrispWare" tagprefix="cc2" %>
<link rel="stylesheet" type="text/css" href="/DesktopModules/Billboard/BillTheme/BillStyle.css" />

<script type="text/javascript">
    function artTextCounter(field, countfield, maxlimit) {
        if (field.value.length > maxlimit)
            field.value = field.value.substring(0, maxlimit);
        else
            countfield.value = maxlimit - field.value.length;
    }
</script>

<asp:HiddenField ID="hfUserId" runat="server" />
<asp:HiddenField ID="hfArtId" runat="server" />
<asp:HiddenField ID="hfMode" runat="server" />
<asp:Label ID="lblErrorUpload" runat="server" visible="false" ForeColor="Red"></asp:Label>

<asp:Panel ID="pnlContent" runat="server">
<img alt="Article" src="/DesktopModules/Billboard/images/BillArt.gif" /><br /><br />
<table >
    <tr>
        <td class="Bill_Text_Main" valign="top">Headline:</td>
        <td style="padding-left:23px;">
            <asp:TextBox ID="tbHeadline" runat="server" Font-Bold="True" Font-Names="Verdana" 
                    Font-Size="20pt" Width="650px" MaxLength="50" onkeyup='artTextCounter(this, this.form.remLenLink1, 50);'
                                onkeydown="artTextCounter(this, this.form.remLenLink1, 50);"></asp:TextBox><input readonly="readonly"
                                    type="text" name="remLenLink1" size="2" maxlength="2" value="50" />characters left<br /><asp:Label ID="lblErrorStarHeadline" runat="server" Text="*" ForeColor="Red" 
                    Font-Size="10pt" Visible="False"></asp:Label><br />
            <%--<asp:Label ID="lblAuthor" runat="server" visible="false"></asp:Label>--%>
        </td>
    </tr>
    <tr>
        <td class="Bill_Text_Main" valign="top">Author:</td>
        <td style="padding-left:23px;">
            <asp:TextBox ID="tbAuthor" runat="server" Font-Names="Verdana" Font-Size="10pt" Width="200px"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="Bill_Text_Main" valign="top">Photo:</td>
        <td style="padding-left:20px;">

            <table>
               <tr>
                   <td width="300px" class="Agape_Settings_Title"  
                       style="text-align: center; border-top-style: solid; border-top-width: thin; border-right-style: solid; border-right-width: thin; border-left-style: solid; border-left-width: thin; font-size: 8pt;">
                   1. Browse for the photo you want as the Story's main photo:
                   </td>
                   <td width="20px">&nbsp;</td>
                   <td width="150px" class="Agape_Settings_Title"  style="text-align: center; border-top-style: solid; border-top-width: thin; border-right-style: solid; border-right-width: thin; border-left-style: solid; border-left-width: thin; font-size: 8pt;">
                   2. Upload the photo you have chosen:
                   </td>
                   <td width="20px">&nbsp;</td>
                   <td width="300px" class="Agape_Settings_Title"  style="text-align: center; border-top-style: solid; border-top-width: thin; border-right-style: solid; border-right-width: thin; border-left-style: solid; border-left-width: thin; font-size: 8pt;">
                   3. Crop the photo to the correct size and shape:
                   </td>
               </tr>
               <tr>
               
                    <td width="300px" style="border-bottom-style: solid; border-bottom-width: thin; border-left-style: solid; border-left-width: thin; border-right-style: solid; border-right-width: thin; text-align: center;">
                    <asp:FileUpload ID="fuFileUpload2" runat="server" Width="200px" CausesValidation="false" />
                    </td>
                    <td width="20px">&nbsp;</td>
                    <td width="150px" style="border-bottom-style: solid; border-bottom-width: thin; border-left-style: solid; border-left-width: thin; border-right-style: solid; border-right-width: thin; text-align: center;">
                        <asp:Button ID="btnPhoto1Button" runat="server" Text="Upload" CausesValidation="false"/>
                    </td>
                    <td width="20px">&nbsp;</td>
                    <td width="300px" style="border-bottom-style: solid; border-bottom-width: thin; border-left-style: solid; border-left-width: thin; border-right-style: solid; border-right-width: thin">
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
        <td class="Bill_Text_Main" valign="top">Text:</td>
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
        <td class="Bill_Text_Main" valign="top">Is Visible:</td>
        <td style="padding-left:20px;"><asp:CheckBox ID="cbVisibleCheck" runat="server" Checked="True" /></td>
    </tr>
    <tr>
         <td colspan="2" align="center">
           <%-- <table width="100%" style="text-align:center">
                <tr>
                    <td>--%>
                    <%--<asp:LinkButton ID="btnSaveButton" runat="server" CausesValidation="false">Add</asp:LinkButton>--%>
                    <asp:ImageButton ID="btnSaveButton" runat="server" Height="24px" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/Post1.gif"  
                                                onmouseover="this.src=/DesktopModules/Billboard/images/BtnImg/Post2.gif';" CausesValidation="false"  
                                                onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/Post1.gif';" AlternateText="Save Article" ToolTip="Post Article"/>
                    &nbsp;
                    <%--</td>
                    <td>--%>
                    <%--<asp:LinkButton ID="btnCancelButton" runat="server" CausesValidation="false" OnClientClick="closePopup2();">Cancel</asp:LinkButton>--%>
                    <asp:ImageButton ID="btnCancelButton" runat="server" Height="24px" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/Cancel1.gif"  
                                                onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/Cancel2.gif';" CausesValidation="false" 
                                                onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/Cancel1.gif';" AlternateText="Cancel and go back" ToolTip="Cancel and go back"/>
                    &nbsp;
                    <%--</td>
                    <td>--%>
                     <%--<asp:LinkButton ID="btnDeleteButton" runat="server" CausesValidation="false" OnClientClick="return confirm('Are you sure you want to delete this story?')">Delete Story</asp:LinkButton>--%>
                     <asp:ImageButton ID="btnDeleteButton" runat="server" Height="24px" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/Delete1.gif" OnClientClick="return confirm('Are you sure you want to delete this article?')"  
                                                onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/Delete2.gif';" CausesValidation="false" 
                                                onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/Delete1.gif';" AlternateText="Delete Article" ToolTip="Delete Article"/>     
                    <%--</td>
                </tr>
                <tr>--%>
                <%--<td colspan="3">--%>
                <br />
                    <asp:Label ID="lblSaving" runat="server" forecolor="Red" Visible="false"></asp:Label>
                <%--</td>
                </tr>
            </table>--%> 
         </td>   
    </tr>
</table>
</asp:Panel>
    
    



        
    
    
    


