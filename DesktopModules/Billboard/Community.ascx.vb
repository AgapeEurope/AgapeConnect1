Imports System.Linq
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.HtmlControls
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports DotNetNuke
Imports DotNetNuke.Security
Imports Billboard


Namespace DotNetNuke.Modules.Billboard
    Partial Class Community
        Inherits Entities.Modules.PortalModuleBase
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            billComm.Initialise(Me.UserId, 1)
        End Sub
    End Class
End Namespace
