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
Imports DotNetNuke.Modules.BillboardFeatureArt.TheseEditArtEventArgs
Imports Billboard

Namespace DotNetNuke.Modules.Billboard
    Partial Class EditArticle
        Inherits Entities.Modules.PortalModuleBase

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not Page.IsPostBack Then
                editArt.Initialise(Me.UserId, Request.QueryString("Mode"), Request.QueryString("ArtId"))
            End If
        End Sub
        Private Sub editArt_MyEvent(ByVal sender As Object, ByVal e As TheseEditArtEventArgs) Handles editArt.MyEvent
            If e.Switch < 0 Then
                Response.Redirect(NavigateURL())
            Else
                Dim mode As Integer = 1
                If Request.QueryString("Mode") = 1 Then
                    mode = 2
                End If
                Dim d As New BillboardDataContext
                Dim q = From c In d.Agape_Billboard_Globals Where 1 = 1 Select c.BillArtTabId

                If q.Count > 0 Then
                    If Not (q.First Is Nothing) Then
                        Response.Redirect(NavigateURL(CInt(q.First)) & "?ArtId=" & e.Switch & "&Mode=" & mode)
                    End If
                End If
                'Response.Redirect(EditUrl("ViewArt") & "?ArtId=" & e.Switch & "&Mode=" & mode)
            End If
        End Sub

    End Class
End Namespace

