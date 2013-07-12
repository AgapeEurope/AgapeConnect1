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


Namespace DotNetNuke.Modules.AgapeConnect
    Partial Class mpdCalc
        Inherits Entities.Modules.PortalModuleBase

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            hfAssessment.Value = 12.0
            itemCurrent.Monthly = 3000

        End Sub




    End Class
End Namespace
