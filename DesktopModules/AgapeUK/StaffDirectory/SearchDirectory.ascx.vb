Imports System
Imports System.Collections
Imports System.Configuration
Imports System.Data
Imports System.Linq
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.HtmlControls
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports DotNetNuke
Imports DotNetNuke.Security




Namespace DotNetNuke.Modules.SearchDirectory
    Partial Class SearchDirectory
        Inherits Entities.Modules.PortalModuleBase

       
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            


        End Sub


       
        Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles Button1.Click
            'Need to redirect to StaffDirectory page.
            Dim mc As New DotNetNuke.Entities.Modules.ModuleController
            Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
            Dim x = mc.GetModuleByDefinition(PS.PortalId, "ukStaffDirectory")

            Response.Redirect(NavigateURL(x.TabID) & "?search=" & SearchBox.Text)



        End Sub
    End Class
End Namespace
