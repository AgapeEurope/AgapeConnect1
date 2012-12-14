<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ViewStaffDirectory.ascx.vb" Inherits="DotNetNuke.Modules.StaffDirectory.ViewStaffDirectory" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ccsearch" %>
<style type="text/css">
.Agape_Watermarked_TextBox
{
 color: #999;
 font-style: italic;   
}
</style>


<table width="100%">
<tr valign="top">
    <td style="padding-right:10px"> 
    <asp:Panel ID="Panel1" runat="server" DefaultButton="SearchBtn">

      <table width="100%">
    <tr valign="middle">
        <td width="100%"><asp:TextBox ID="SearchBox" runat="server" Width ="140px" Font-Size="8pt" ></asp:TextBox></td>
        <td><asp:ImageButton ID="SearchBtn" runat="server" ImageUrl="images/search.gif" ToolTip="Search"  /></td>
    </tr>
</table>
     </asp:Panel>
<ccsearch:TextBoxWatermarkExtender runat="server" ID="TBWE1" TargetControlID="SearchBox" 
    WatermarkText="Search Staff Directory" WatermarkCssClass="Agape_Watermarked_TextBox">
</ccsearch:TextBoxWatermarkExtender>
        <asp:ListBox ID="ListBox1" runat="server"  
    DataTextField="DisplayName" DataValueField="UserId" AutoPostBack="true" Width="164px" height="450px"></asp:ListBox>
       
  

    
    </td>
    <td width="100%">
        <asp:Panel ID="ContactPanel" runat="server">
      <fieldset><legend class="AgapeH3"><asp:Label ID="FirstName" runat="server"></asp:Label>  <asp:Label ID="LastName" runat="server"></asp:Label></legend>
        
           <table cellspacing="10px">
                <tr valign="top">
                    <td style="white-space: nowrap; " width="350px">
                       <span class="AgapeH5">Contact Info:</span><br />
                        <table style="font-size: 9pt; margin-left: 10px;">
                            <tr>
                                <td><b>Email:</b></td>
                                <td>
                                    <asp:HyperLink ID="Email" runat="server" style="color:#660000; text-decoration: underline;" ></asp:HyperLink>
                                </td>
                            </tr>
                             <tr>
                                <td><b>Home Phone:</b></td>
                                <td><asp:Label ID="HomePhone" runat="server"></asp:Label></td>
                            </tr>
                            <%-- <tr>
                                <td><b>Work Phone:</b></td>
                                <td><asp:Label ID="WorkPhone" runat="server"></asp:Label></td>
                            </tr>--%>
                            <tr>
                                <td><b>Mobile Phone:</b></td>
                                <td>
                                    <asp:Label ID="MobilePhone" runat="server"></asp:Label>
                                   </td>
                            </tr>
                            <%-- <tr>
                                <td><b>Skype:</b></td>
                                <td><asp:Label ID="Skype" runat="server"></asp:Label></td>
                            </tr>--%>
                             <tr valign="top">
                                <td><b>Address:</b></td>
                                <td><asp:Label ID="Address" runat="server"></asp:Label></td>
                            </tr>
                        </table>
                 <%--   </td>
                    <td width="350px">
                        --%>
                  
                        <span class="AgapeH5">Personal:</span><br />
                        <table style="font-size: 9pt; margin-left: 10px;">
                            <tr>
                                <td><b>Birthday:</b></td>
                                <td><asp:Label ID="Birthday" runat="server"></asp:Label></td>
                            </tr>
                       </table><br />
                       <asp:Panel ID="FamilyPanel" runat="server">
                      <span class="AgapeH5">Family:</span><br />
                        <table style="font-size: 9pt; margin-left: 10px;">
                            <tr>
                                <td><b>Married to:</b></td>
                                <td><asp:Label ID="Spouse" runat="server"></asp:Label></td>
                            </tr>
                            </table>
                            <asp:Panel ID="ChildrenPanel" runat="server">
                       
                      <span class="AgapeH5">Children:</span>
                                <table style="font-size: 9pt; margin-left: 14px;" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="70px"><b>Name</b></td>
                                        <td width="70px"><b>Birthday</b></td>
                                        <td width="70px"><b>Age</b></td>
                                    </tr>
                                    <asp:PlaceHolder ID="ChildrenPH" runat="server"></asp:PlaceHolder>
                                 </table>
                                
                            
                      </asp:Panel>
                        <br />
                        </asp:Panel>
                       <span class="AgapeH5">Employment:</span><br />
                       
                        <table style="font-size: 9pt; margin-left: 10px;">
                            <tr>
                                <td><b>Job Title:</b></td>
                                <td><asp:Label ID="JobTitle" runat="server"></asp:Label></td>
                            </tr>
                        </table>
                    </td>
                    
                    <td >
                        <asp:Image ID="ProfileImage" runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
                    
                    </td>
                </tr>
           </table>
           </fieldset>
          </asp:Panel>
    
    </td>
</tr>
</table>

