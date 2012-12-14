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
Imports DotNetNuke.Modules.BillboardFeatureArt.TheseEditEventArgs
Imports Billboard

Namespace DotNetNuke.Modules.Billboard
    Partial Class EditFeature
        Inherits Entities.Modules.PortalModuleBase

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not Page.IsPostBack Then
                If Request.QueryString("FeatId") = -1 Then
                    editFeat.Initialise(Me.UserId)
                Else
                    editFeat.Initialise(Me.UserId, CInt(Request.QueryString("FeatId")))
                End If
            End If
        End Sub
        Private Sub editFeat_MyEvent(ByVal sender As Object, ByVal e As TheseEditEventArgs) Handles editFeat.MyEvent
            If e.Switch < 0 Then
                Response.Redirect(NavigateURL())
            Else
                Response.Redirect(EditUrl("ViewFeat") & "?FeatId=" & e.Switch & "&Mode=2")
            End If
        End Sub

    End Class
End Namespace

