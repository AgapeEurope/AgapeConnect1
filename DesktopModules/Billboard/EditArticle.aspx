<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EditArticle.aspx.vb" Inherits="DesktopModules_Billboard_EditArticle" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/texteditor.ascx"%>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/labelcontrol.ascx" %>
<%@ Register Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" TagPrefix="cc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register assembly="ImageCropper" namespace="KrispWare" tagprefix="cc2" %>
<link rel="stylesheet" type="text/css" href="/DesktopModules/Billboard/BillTheme/BillStyle.css" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">



<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:HiddenField ID="hfUserId" runat="server" />
<asp:HiddenField ID="hfArtId" runat="server" />
<asp:HiddenField ID="hfMode" runat="server" />
<asp:Label ID="lblErrorUpload" runat="server" visible="false" ForeColor="Red"></asp:Label>

<asp:Panel ID="pnlContent" runat="server">
<table class="Agape_Settings_Title" >
    <tr>
        <td class="Agape_Settings_Title" >Headline</td>
        <td>
            <asp:TextBox ID="tbHeadline" runat="server" Font-Bold="True" Font-Names="Verdana" 
                    Font-Size="20pt" Width="700px"></asp:TextBox><asp:Label ID="lblErrorStarHeadline" runat="server" Text="*" ForeColor="Red" 
                    Font-Size="10pt" Visible="False"></asp:Label><br />
            <div style="font-style:italic">Written by:&nbsp;<asp:Label ID="lblAuthor" runat="server" visible="false"></asp:Label></div>
        </td>
    </tr>
    <tr>
        <td class="Agape_Settings_Title"  >Photo</td>
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
                   <td width="400px" class="Agape_Settings_Title"  style="text-align: center; border-top-style: solid; border-top-width: thin; border-right-style: solid; border-right-width: thin; border-left-style: solid; border-left-width: thin; font-size: 8pt;">
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
                    <td width="420px" style="border-bottom-style: solid; border-bottom-width: thin; border-left-style: solid; border-left-width: thin; border-right-style: solid; border-right-width: thin">
                    <div align="center" style="height:auto">
                    <cc2:ImageCropper ID="icImageCropper1" runat="server" AspectRatio="1" Width = "400px"/>
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
            <dnn:TextEditor ID="tbStoryText" runat="server" Height="650" Width="100%" /> <asp:Label ID="lblErrorStarStoryText" runat="server" Text="*" ForeColor="Red" 
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
         <td colspan="2">
            <table  class="Agape_Settings_Title" cellpadding="5">
                <tr>
                    <td align="center">
                    <asp:LinkButton ID="btnSaveButton" runat="server" CausesValidation="false">Update</asp:LinkButton>
                    </td>
                    <td align="center">
                     <asp:LinkButton ID="btnDeleteButton" runat="server" CausesValidation="false" OnClientClick="return confirm('Are you sure you want to delete this story?')">Delete Story</asp:LinkButton>
                       
                    </td>
                </tr>
                <tr>
                <td colspan="2">
                    <asp:Label ID="lblSaving" runat="server" forecolor="Red" Visible="false"></asp:Label>
                </td>
                </tr>
            </table> 
         </td>   
    </tr>
</table>
</asp:Panel>
    </div>
    </form>
</body>
</html>




