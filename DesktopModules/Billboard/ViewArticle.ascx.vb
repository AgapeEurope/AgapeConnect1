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
Imports DotNetNuke.Modules.BillboardFeatureArt.ViewArtEventArgs
Imports Billboard

Namespace DotNetNuke.Modules.Billboard
    Partial Class ViewArticle
        Inherits Entities.Modules.PortalModuleBase

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not Page.IsPostBack Then
                viewArt.Initialise(Request.QueryString("ArtId"), Request.QueryString("Mode"), Me.UserId)
            End If
        End Sub
        Private Sub viewArt_MyEvent(ByVal sender As Object, ByVal e As ViewArtEventArgs) Handles viewArt.MyEvent
            If e.Switch > 0 Then
                Dim mode As Integer = 2
                If Request.QueryString("Mode") = 2 Then
                    mode = 1
                End If
                Dim d As New BillboardDataContext
                Dim q = From c In d.Agape_Billboard_Globals Where 1 = 1 Select c.BillMainTabId

                If q.Count > 0 Then
                    If Not (q.First Is Nothing) Then
                        Response.Redirect(NavigateURL(CInt(q.First)) & "?ArtId=" & e.Switch & "&Mode=" & mode)
                    End If
                End If
                'Response.Redirect(EditUrl("EditArt") & "?ArtId=" & e.Switch & "&Mode=" & mode)
            End If
        End Sub

        Protected Sub btnBack_Click(sender As Object, e As System.EventArgs) Handles btnBack.Click
            Dim d As New BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Globals Where 1 = 1 Select c.BillMainTabId

            If q.Count > 0 Then
                If Not (q.First Is Nothing) Then
                    Response.Redirect(NavigateURL(CInt(q.First)))
                End If
            End If
            'Response.Redirect(NavigateURL())
        End Sub
    End Class
End Namespace