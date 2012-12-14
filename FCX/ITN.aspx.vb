Imports System.Net
Imports System.IO
Partial Class FCX_ITN
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load

        Dim sr As New StreamReader(Request.InputStream)

        Dim data = sr.ReadToEnd()


    End Sub
End Class
