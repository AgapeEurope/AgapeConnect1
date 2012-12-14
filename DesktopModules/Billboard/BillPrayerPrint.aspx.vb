Imports System.Linq
Imports Billboard

Partial Class DesktopModules_Billboard_BillPrayerPrint
    Inherits System.Web.UI.Page
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
        lblDate.Text = "Printed on: " & (CDate(Now())).ToString("dd/MM/yyyy")
        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Prayers Where c.Current = True And c.Visible = True Order By c.SubmittedDate Descending, c.PrayerTitle Select c
        If q.Count > 0 Then
            For Each pItem In q
                phMain.Controls.Add(New LiteralControl("<div class=""Bill_H4"">" & pItem.PrayerTitle & "</div>"))
                Dim Submitter As String
                If pItem.SubBehalf Is Nothing Then
                    Submitter = (From c In d.Users Where c.UserID = pItem.SubmittedBy Select c.DisplayName).First
                Else
                    Submitter = pItem.SubBehalf
                End If

                phMain.Controls.Add(New LiteralControl("<div style=""text-align:right"" class=""Agape_SubTitle"">Submitted By:&nbsp;" & Submitter & ",&nbsp;on&nbsp;" & (pItem.SubmittedDate).Value.ToString("dd/MM/yyyy") & "</div><br/>"))

                phMain.Controls.Add(New LiteralControl("<div class=""Bill_Text_Main"" style=""font-size:10pt"">" & Billboard.BillboardFunctions.BillHtml(pItem.PrayerText) & "</div>"))
                phMain.Controls.Add(New LiteralControl("<div class=""Bill_dashed"">&nbsp;</div><br/>"))
            Next
        Else
            lblMainOutput.Text = "There are no Prayer Requests."
            lblMainOutput.ForeColor = Color.Red
            lblMainOutput.Visible = True
        End If
    End Sub
End Class
