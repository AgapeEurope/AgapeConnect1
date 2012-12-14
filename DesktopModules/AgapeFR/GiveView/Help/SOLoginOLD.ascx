<%@ Control Language="VB" AutoEventWireup="false" CodeFile="SOLoginOLD.ascx.vb" Inherits="DotNetNuke.Modules.AgapeFR.GiveView.SOLogin" %>
<%--<%@ Register src="../../admin/Users/manageusers.ascx" tagname="manageusers" tagprefix="uc2" %>--%>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<span class="Agape_Red_H3">Give Regularly by Standing Order</span>
<br />
<br />
Thank you for agreeing to set up a standing order. Please either log in or enter your personal details to continue.
<br />
<br />
<fieldset>
<legend><span class="Agape_Red_H4"> Your Details</span></legend>
<table width="100%" >
    <tr>
      <td style="font-size: 9pt;" align="center" valign="top">
      <asp:Panel ID="Panel1" runat="server"  defaultbutton="btnSOContinue">
   <br />
        If you already have an account log in here:<br /><br />
        <table style="font-size: 9pt;" >
            <tr>
                <td><b>Username:</b></td>
                <td><asp:TextBox ID="tbUsernameLgn" runat="server"></asp:TextBox></td>
                
            </tr>
            <tr>
                <td><b>Password:</b></td>
                <td><asp:TextBox ID="tbPasswordLgn" runat="server" TextMode="Password"></asp:TextBox></td>
                
            </tr>
        </table>
      <asp:Label ID="lblLoginError" runat="server" ForeColor="Red" Visible="false">* Incorrect Username/Password</asp:Label><br />
       <asp:Button ID="btnSOContinue" runat="server" Text="Continue" CssClass="aButton" />
  
         </asp:Panel>
  </td>
  <td class="Agape_Red_H3" align="center" valign="top"><br /><i>or</i></td>
        <td align="center">
        
      <asp:Panel ID="Panel2" runat="server"  defaultbutton="btnRegister">

<table style="font-size: 9pt;">
        <tr>
            <td>
                <b>Title:</b>
            </td>
            <td>
                <asp:TextBox ID="tbTitle" runat="server" Font-Size="9pt"></asp:TextBox>
                
            </td>
        </tr>
        <tr>
            <td>
                <b>First Name:</b>
            </td>
            <td>
                <asp:TextBox ID="tbFirstName" runat="server" Font-Size="9pt"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbFirstName" ErrorMessage="Please enter your first name" ValidationGroup="Register"  Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <b>Last Name:</b>
            </td>
            <td>
                <asp:TextBox ID="tbLastName" runat="server"  Font-Size="9pt"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbLastName" ErrorMessage="Please enter your last name" ValidationGroup="Register"  Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <b>Username:</b>
               
            </td>
            <td>
                <asp:TextBox ID="tbUserName" runat="server"  Font-Size="9pt"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tbFirstName" ErrorMessage="Please enter a Username" ValidationGroup="Register"  Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <b>Password:</b><br /><span style="font-size: .73em;">Must be at least 7 characters</span>
               
            </td>
            <td>
                <asp:TextBox ID="tbPassword1" runat="server" TextMode="Password"  Font-Size="9pt" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="tbPassword1" ErrorMessage="Please enter a password" ValidationGroup="Register"  Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <b>Repeat Password:</b>
               
            </td>
            <td>
                <asp:TextBox ID="tbPassword2" runat="server"  TextMode="Password"  Font-Size="9pt"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="tbPassword2" ErrorMessage="Please re-enter your password" ValidationGroup="Register"  Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <b>E-mail:</b>
            </td>
            <td>
                <asp:TextBox ID="tbEmail" runat="server"  Font-Size="9pt"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="tbEmail" ErrorMessage="Please enter your e-mail" ValidationGroup="Register"  Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <b>Address 1:</b>
            </td>
            <td>
                <asp:TextBox ID="tbAddress1" runat="server"  Font-Size="9pt" Width="200px"></asp:TextBox> 
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="tbAddress1" ErrorMessage="Please enter your address" ValidationGroup="Register"  Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <b>Address 2:</b>
            </td>
            <td>
                <asp:TextBox ID="tbAddress2" runat="server" Font-Size="9pt"  Width="200px"></asp:TextBox> 
               
            </td>
        </tr>
        <tr>
            <td>
                <b>City:</b>
            </td>
            <td>
                <asp:TextBox ID="tbCity" runat="server" Font-Size="9pt" ></asp:TextBox>
               
            </td>
        </tr>
        <tr>
            <td>
                <b>Region:</b>
               
            </td>
            <td>
                <asp:TextBox ID="tbCounty" runat="server" Font-Size="9pt" ></asp:TextBox>
            </td>
        </tr>
         <tr>
            <td>
                <b>Postcode:</b>
            </td>
            <td>
                <asp:TextBox ID="tbPostCode" runat="server" Font-Size="9pt" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="tbPostCode" ErrorMessage="Please enter your postcode" ValidationGroup="Register"  Text="*" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
        
</table>

<table width="350px" border="0" >
                                        <tr>
                                            <td  width="100%"><b>
                                                <dnn:sectionhead id="dshPreferences" runat="server"  Text="Contact Preferences" section="tblPreferences"
                                                    includerule="False" Visible="true">
                                                </dnn:sectionhead></b></td>
                                        </tr>
                                    </table>
                                    <table id="tblPreferences" cellspacing="1" cellpadding="0" summary="Preferences"
                                        runat="server" style="font-size: 7pt;">
                                        <tr>
                                            <td width="175">
                                                <b>I would like to receive news and prayer updates by email once a fortnight.</b>
                                            </td>
                                            <td nowrap>
                                            
                                                <asp:CheckBox ID="cbENews" runat="server" Checked="true"/>
                                               </td>
                                        </tr>
                                       <tr>
                                            <td width="175">
                                                <b>Preferred Team</b>
                                            </td>
                                            <td nowrap>
                                                <asp:DropDownList ID="ddlPrefTeam" runat="server" Font-Size="7pt">
                                                </asp:DropDownList>
                                               
                                               </td>
                                        </tr>
                                       <tr>
                                            <td width="175">
                                                <b> I would like to receive <a href="http://www.agape.org.uk/move" target="_blank"><strong><span style="color: #660000">MOVE magazine</span></strong></a> by post twice a year (free).</b>
                                            </td>
                                            <td nowrap>
                                            
                                                <asp:CheckBox ID="cbMove" runat="server" />
                                               </td>
                                        </tr>
                                       
                                    </table>

          <asp:ValidationSummary ID="ValidationSummary1" runat="server"  ValidationGroup="Register"/>
 <asp:Label ID="lblRegisterError" runat="server" ForeColor="Red" Visible="false"></asp:Label><br />
  <asp:ImageButton ID="btnRegister" runat="server" ImageUrl="~/images/ButtonImages/ContinueS.gif"   
                            onmouseover = "this.src='/images/ButtonImages/ContinueS_f2.gif';"
                            onmouseout="this.src='/images/ButtonImages/ContinueS.gif';" AlternateText="Continue" ToolTip="Continue"    ValidationGroup="Register" />
           </asp:Panel>

  </td>

  
    </tr>

</table>



</fieldset>




