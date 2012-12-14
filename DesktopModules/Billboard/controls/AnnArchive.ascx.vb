Imports System.Linq
Imports Billboard

Partial Class DesktopModules_Billboard_controls_AnnArchive
    Inherits System.Web.UI.UserControl
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
        If dlAnn.Items.Count = 0 Then
            lblEmpty.Visible = True
        End If
    End Sub
    Public Function AttachThis(ByVal ThisAnnId As Integer) As String
        Dim out = ""

        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Announcements Where c.AnnouncementId = ThisAnnId

        If q.Count > 0 Then
            If Not (q.First.FileAttach = "" Or q.First.FileAttach Is Nothing) Then
                out = "<a target=""_blank"" href=""http://france.myagape.co.uk/DesktopModules/Billboard/DownFile.aspx?AnnId=" & q.First.AnnouncementId & """>Download Attachment: " & q.First.FileAttach
                If q.First.FileSize Is Nothing Then
                    out &= "</a>"
                Else
                    out &= " (" & MakeBytes(q.First.FileSize) & ")" & "</a>"
                End If
            End If
        End If

        Return out
    End Function
    Public Function MakeBytes(ByVal InBytes As Integer) As String
        Dim outPut As String = ""
        If InBytes < 1024 Then
            outPut = InBytes & " bytes"
        ElseIf InBytes < 1048576 And InBytes > 1023 Then
            outPut = CInt(InBytes / 1024) & " kB"
        Else
            outPut = CDbl(InBytes / 1048576).ToString("0.00") & " MB"
        End If
        Return outPut
    End Function
End Class
