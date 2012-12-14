<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ViewBooklet.ascx.vb" Inherits="DotNetNuke.Modules.Booklet.DesktopModules_Booklet_ViewBooklet" %>
<%@ Register Assembly="DotNetNuke" Namespace="DotNetNuke.Security.Permissions.Controls"
    TagPrefix="cc2" %>


<%@ Register Assembly="System.Web.Silverlight" Namespace="System.Web.UI.SilverlightControls" TagPrefix="asp" %>
<script type="text/javascript">
     WaitForInstallCompletion = function() {
         try {
             //This forces Firefox/Safari to refresh their
             //list of known plugins.
             
             navigator.plugins.refresh();
         }
         catch (e) {
             //IE does not support the method, so an
             //exception will be thrown.
             
         }
         if (isSilverlightInstalled()) {
             //Silverlight is installed. Refresh the page.
             window.location.reload(false);
         }
         else {
             //Wait 3 seconds and try again
             setTimeout(WaitForInstallCompletion, 5000);
         }
     };

     onLoad = function() {
         //This only works if we are performing a clean install, 
         //not an upgrade.
         if (!isSilverlightInstalled()) {
             //Silverlight is not installed. Try to refresh 
             //the page when it is installed.
             WaitForInstallCompletion();
         }
     }

     function isSilverlightInstalled() {
         var isSilverlightInstalled = false;

         try {
             //check on IE
             try {
                 var slControl = new ActiveXObject('AgControl.AgControl');
                 isSilverlightInstalled = true;
             }
             catch (e) {
                 //either not installed or not IE. Check Firefox
                 if (navigator.plugins["Silverlight Plug-In"]) {
                     isSilverlightInstalled = true;
                 }
             }
         }
         catch (e) {
             //we don't want to leak exceptions. However, you may want
             //to add exception tracking code here.
         }
         return isSilverlightInstalled;
     }
    </script>


<table width="100%">
    <asp:Panel ID="ModPanel" runat="server">
<tr>
<td style="text-align: center">
<asp:Silverlight ID="Xaml1" runat="server" Source="~/ClientBin/QuadraFlipBook.xap" MinimumVersion="2.0.31005.0" Width="500px" Height="300px"  Windowless="true"  >
 <PluginNotInstalledTemplate>
<table>
<tr>
    <td><span style="font-family:Verdana; font-size:9pt; color:#8888FF">
You do not have Silverlight installed. Some of the features of this site require Silverlight. Click the link below to install (it only takes a few seconds)<br />

<br />
<a href="http://go.microsoft.com/fwlink/?LinkID=124807" style="text-decoration: none;">
     			<img src="http://go.microsoft.com/fwlink/?LinkId=108181" alt="Get Microsoft Silverlight" height="55px" style="border-style: none"/>
			</a>
</span></td>
    <td><asp:Image ID="Image2" runat="server" visible="false"/></td>
</tr>

</table>


            

        </PluginNotInstalledTemplate>
</asp:Silverlight><br />
<asp:Image ID="Image1" runat="server" visible="false"/>
</td>
</tr>
    </asp:Panel>
<tr>
<td>
<asp:LinkButton ID="LinkButton1" runat="server" Visible="false">Configure Booklet</asp:LinkButton>

</td>
</tr>
</table>  
  
     
