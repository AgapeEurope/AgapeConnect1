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


Namespace DotNetNuke.Modules.BillboardAnnouncements
    Partial Class EditBillboardAnnouncements
        Inherits Entities.Modules.PortalModuleBase
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            If Request.QueryString("Mode") = 2 Then
                Try
                    editAnn.Initialise(Me.UserId)
                    pnlEdit.Visible = True
                Catch ex As Exception
                    lblLoadError.Text = ex.Message
                    lblLoadError.Visible = True
                End Try
            End If


        End Sub
        Protected Sub btnBack_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBack.Click
            Response.Redirect(NavigateURL)
        End Sub
    End Class
End Namespace
