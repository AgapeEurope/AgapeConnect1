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




Namespace DotNetNuke.Modules.ProfilePicture
    Partial Class ProfilePicture
        Inherits Entities.Modules.PortalModuleBase


        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load


            ProfilePic.ImageUrl = "~/DesktopModules/AgapeUK/StaffDirectory/GetImage.aspx?size=150&UserId=" & UserId


        End Sub




    End Class
End Namespace
