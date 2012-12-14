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
    Partial Class ViewBillboardAnnouncements
        Inherits Entities.Modules.PortalModuleBase

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            btnEdit.Visible = IsEditable()
            Dim d As New Billboard.BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Announcements Where c.Visible = True And c.Current = True Order By c.AnnouncementDate Descending Select c
            If q.Count > 0 Then
                For Each Ann In q

                    phMain.Controls.Add(New LiteralControl("<div class=""Bill_H4"" style=""text-align:left;"">" & Ann.AnnouncementTitle & "</div><div class=""Bill_Text_Main"" style=""font-size:10pt;"">" & Billboard.BillboardFunctions.BillHtml(Ann.AnnouncementText) & "</div>"))
                    If Not (Ann.FileAttach = "" Or Ann.FileAttach Is Nothing) Then
                        Dim out As String = "<a class=""Bill_Text_Main"" style=""font-size:7pt;"" target=""_blank"" href=""http://france.myagape.co.uk/DesktopModules/Billboard/DownFile.aspx?AnnId=" & Ann.AnnouncementId & """>Download Attachment: " & Ann.FileAttach
                        If Ann.FileSize Is Nothing Then
                            out &= "</a>"
                        Else
                            out &= " (" & MakeBytes(Ann.FileSize) & ")" & "</a><br/>"
                        End If
                        phMain.Controls.Add(New LiteralControl(out))
                    End If
                    phMain.Controls.Add(New LiteralControl("<br/>"))
                Next
            Else
                phMain.Controls.Add(New LiteralControl("<div class=""Bill_Text_Main"" style=""text-align:left"">There are no announcements currently</div>"))
            End If
        End Sub

        Protected Sub btnEdit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEdit.Click
            Response.Redirect(EditUrl("Edit") & "?Mode=2")
        End Sub
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
End Namespace

