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
Imports System.IO
Imports UK.Booklet



Imports DotNetNuke

Namespace DotNetNuke.Modules.Booklet

    Partial Class DesktopModules_Booklet_ViewBooklet
        Inherits DotNetNuke.Entities.Modules.PortalModuleBase

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
            'Try
            If Request.Browser.Browser = "Safari" Then ' Or Request.Browser.Browser = "Chrome" Then
                Xaml1.Windowless = False

            End If
            Dim myscript As String = "onLoad() ;"
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "myscript", myscript, True)
            If Not Page.IsPostBack Then
                Dim d As New BookletDataContext
                Dim r = d.Agape_Main_Booklet_GetAdd(Me.ModuleId).Single



                Dim q = From c In d.Agape_Main_BookletImages Where c.ModuleId = Me.ModuleId Select c
                Xaml1.Width = r.Width
                Xaml1.Height = CInt(CDbl(r.Width) * r.Aspect / 1.8)
                Xaml1.Source &= "?version=1"

                Xaml1.InitParameters = ("Images=" & q.Count & ",Width=" & r.Width & ",Height=" & CInt((CDbl(r.Width) * r.Aspect / 1.8)).ToString & ", ModuleId=" & Me.ModuleId & ", rootPath=" & Request.Url.Scheme & "://" & Request.Url.Authority & Request.ApplicationPath & "DesktopModules/AgapeUK/BookletPreview/GetImage.aspx")
                'Response.Write(Xaml1.InitParameters)



            End If

            'Catch ex As Exception

            'End Try
            LinkButton1.Visible = IsEditable()
        End Sub


       
        Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click
            
            Response.Redirect(EditUrl("Edit"))

        End Sub
    End Class

End Namespace



