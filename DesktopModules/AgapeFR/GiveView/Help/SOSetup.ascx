<%@ Control Language="VB" AutoEventWireup="false" CodeFile="SOSetup.ascx.vb" Inherits="DotNetNuke.Modules.AgapeFR.GiveView.SOSetup" %>
<style type="text/css">
    li { margin-bottom:10px; vertical-align: middle;"}
</style>

<script language="javascript" type="text/javascript">
<!--
function popitup(url) {
window.open(url,'_blank','height=300,width=400');
window.focus();
}

// -->
</script>
<asp:HiddenField ID="hfSOID" runat="server" />
<span class="Agape_Red_H3">Give Regularly by Standing Order</span>
<br /><br />
You have indicated that you intend to set up a Standing Order to support the ministry of <asp:Label ID="lblDonateTo" runat="server" CssClass="Agape_Red_H5" ></asp:Label>.
You can set up your standing order in one of two ways - using your online banking or by post. Details on both can be found below:

<br /><br />

<table width="100%" class="Agape_Body_Text">
<tr>
    <td width="49%">
    <fieldset  style="height: 320px;">
    <legend class="Agape_Red_H3"><asp:Label ID="lblOnlineBankingTitle" runat="server" resourcekey="lblOnlineBankingTitle"></asp:Label>
</legend>
<asp:Label ID="lblOnlineBankingText" runat="server" resourcekey="lblOnlineBankingText"></asp:Label>
    <ol>
        <li>Login to your online banking.  
            <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank">Click here</asp:HyperLink>
            to open these instructions in a new window.
          </li>
        <li>Go to the page to set up a new standing order.</li>
        <li>Input our bank details and the payment details as follows:
            <div align="center">
                <table class="Agape_Body_Text">
                 <tr><td>Pay to:</td><td><b>Agape Ministries Ltd</b></td></tr>
                    <tr><td>Start Date:</td><td><b><asp:Label ID="lblStart" runat="server" /></b></td></tr>
                    <tr><td>A/C Number:</td><td><b>80240354</b></td></tr>
                    <tr><td>Sort Code:</td><td><b>20-07-71</b></td></tr>
                    <tr><td>Amount:</td><td><b><asp:Label ID="lblAmount" runat="server" /> <asp:Label ID="lblFreq" runat="server" /></b></td></tr>
                    <tr><td>Reference*:</td><td>
                        <b><asp:Label ID="lblReference" runat="server" ></asp:Label></b></td></tr>
                </table>
            </div>
        </li>
    </ol>
    <div class="Agape_SubTitle">* <u>The payee reference is essential</u> as it allows us to recognise your donation when it reaches our bank account, and allocate it to the correct person/ministry.
    </div>
    </fieldset>
    </td>
    <td valign="middle" class="Agape_Red_H3">
        <b><i>&nbsp;or&nbsp;<br /><br /><br /><br /><br /></i></b>
    </td>
    <td width="49%">
    <fieldset style="height: 320px;">
    <legend class="Agape_Red_H3"><asp:Label ID="lblPostTitle" runat="server" resourcekey="lblPostTitle"></asp:Label>
</legend>

    <ol style="vertical-align: middle;" >
        <li>
            <table class="Agape_Body_Text">
                <tr>
                    <td>
                    <asp:HyperLink ID="HyperLink2" runat="server" Target="_blank" >
                   <img ID="btnOpenForm" runat="server" src="~/images/ButtonImages/OpenForm.gif"   
                            onmouseover = "this.src='/images/ButtonImages/OpenForm_f2.gif';"
                                                 onmouseout="this.src='/images/ButtonImages/OpenForm.gif';" alt="Open Form" /></asp:HyperLink></td>
                    <td style="padding-bottom: 9px;"> Click this button to open your unique standing order form in a new window.</td>
                </tr>
            </table>
           
        </li>
        <li>
           Print, <b>sign and date</b> the form.
        </li>
        <li>
            Send this form directly to your bank (or take it to your local branch).
        </li>
    </ol>
    

    </fieldset>
    </td>
</tr>

</table>
<br />

<div class="Agape_SubTitle">
If you give to multiple Agap&eacute; staff, please set up a separate standing order for each staff member. You can increase/decrease or cancel your standing
order at anytime via online banking or by contacting your bank. If you do make any changes, we would appreciate it if you could <a href="MAILTO:info@agape.org.uk">let us know</a>, 
so that we can adjust our records accordingly. A copy of these instructions have been emailed to you.
<br /><br />
Thank you for your generosity.</div>


<p>
    &nbsp;</p>
<p>
   
</p>
<asp:Label ID="Label1" runat="server" ></asp:Label>