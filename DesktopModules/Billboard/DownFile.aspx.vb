Imports System.Linq
Imports Billboard

Partial Class DesktopModules_Billboard_DownFile
    Inherits System.Web.UI.Page
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Dim AnnId As Integer = CInt(Request.QueryString("AnnId"))
            Dim d As New Billboard.BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Announcements Where c.AnnouncementId = AnnId
            If q.Count > 0 Then
                If Not (q.First.FileAttach = "" Or q.First.FileAttach Is Nothing) Then
                    Dim fullFile As String = Server.MapPath("~/AnnounceFiles/" & q.First.FileAttach)
                    If System.IO.File.Exists(fullFile) Then
                        Dim thisFile As String = Server.UrlPathEncode(q.First.FileAttach)
                        Response.Clear()
                        Response.ContentType = "application/binary"
                        Response.AddHeader("Content-Disposition", String.Format("attachment;filename={0}", thisFile))
                        Response.TransmitFile(fullFile)
                        Response.Flush()
                        Response.End()
                    Else
                        lblOutput.Text = "There was no file found matching: <i>" & fullFile & "</i>"
                        lblOutput.Visible = True
                    End If
                Else
                    lblOutput.Text = "There is no file associated with announcement ID " & AnnId
                    lblOutput.Visible = True
                End If
                lblOutput.Text = "There was no announcement found with announcement ID " & AnnId
                lblOutput.Visible = True
            End If
        Catch ex As Exception
            lblOutput.Text = ex.Message
            lblOutput.Visible = True
        End Try
    End Sub


End Class
