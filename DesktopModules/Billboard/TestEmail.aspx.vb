Imports System
Imports System.Collections
Imports System.Configuration
Imports System.Data
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.HtmlControls
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports DotNetNuke
Imports DotNetNuke.Security
Imports Billboard
Imports System.Linq
Partial Class DesktopModules_Billboard_TestEmail
    Inherits System.Web.UI.Page
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
        'UpdateSend()
        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Tests Where 1 = 1
        If q.Count > 0 Then
            phMain.Controls.Add(New LiteralControl(q.First.BillboardTest))
            tbOutHtml.Text = q.First.BillboardTest
        Else
            phMain.Controls.Add(New LiteralControl("<div style=""color:#666666; font-size:12pt; font-family:Verdana, Geneva, sans-serif; font-weight:bold;>There was a problem loading the test page.</div>"))
        End If

    End Sub
    Private Sub UpdateSend()

        Dim FinalOutput As String = System.IO.File.ReadAllText(Server.MapPath("BillOut.htm"))
        Dim message As String = ""
        Dim d As New BillboardDataContext
        'Announcements
        Dim q = From c In d.Agape_Billboard_Announcements Where c.Sent = False And c.Visible = True And c.Current = True
        If q.Count = 0 Then
            message = "<div style=""color: #666666;font-size: 10pt; font-family:  Verdana, Geneva, sans-serif; font-weight: bold ;"">"
            message = message & "There are currently no announcements.</div>"
        End If
        For Each anno In q
            message = message & "<div style=""color: #666666;font-size: 12pt; font-family:  Verdana, Geneva, sans-serif; font-weight: bold ;"">"
            message = message & anno.AnnouncementTitle & "</div><div style=""color: #808080;font-size: 7pt; font-family:  Verdana, Geneva, sans-serif; font-style: italic; text-align:right;"">"
            message = message & CDate(anno.AnnouncementDate).ToString("dd MMM yyyy") & "</div>"
            message = message & "<div style=""color: #666666;font-size: 8pt; font-family:  Verdana, Geneva, sans-serif;"">"
            message = message & anno.AnnouncementText & "</div><br/>"
            'anno.Sent = True
            'anno.Current = False
            'anno.ViewOrder = -1
        Next
        FinalOutput = FinalOutput.Replace("[ANNOUNCEMENTS]", message)
        d.SubmitChanges()
        Dim t = From c In d.Agape_Billboard_Announcements Where c.Sent = False Order By c.AnnouncementDate Ascending
        Dim thisOrder As Integer = 1
        For Each annouce In t
            annouce.ViewOrder = thisOrder
            thisOrder = thisOrder + 1
        Next

        message = ""
        'Feature Articles
        Dim r = From c In d.Agape_Billboard_Features Where c.Current = True And c.Sent = False
        If r.Count > 0 Then
            message = "<table><tr><td><img height=""150px"" width=""150px"" src=""http://france.myagape.co.uk/DesktopModules/Billboard/GetBillboardImage.aspx?PhotoId=" & r.First.BillboardPhotoId & "&Size=150""></td>"
            message = message & "<td valign=""top""><table><tr><td style=""color: #666666;font-size: 24pt; font-family:  Verdana, Geneva, sans-serif; font-weight: bold ;"">" & r.First.Headline & "</td></tr>"
            message = message & "<tr><td style=""font-family: verdana; font-size: 8pt; font-style: italic; color: #808080; text-align: right"">" & CDate(r.First.StoryDate).ToString("dd MMM yyyy") & "</td></tr>"
            message = message & "<tr><td style=""font-size:10pt; font-family:Verdana; color:#666666;"">" & (BillboardFunctions.StripBillTags(r.First.StoryText)).Substring(0, Math.Min(CStr(r.First.StoryText).Length, 300)) & "...</td></tr></table></td></tr></table>"
        End If
        For Each featart In r
            'featart.Current = False
            'featart.Sent = True
        Next
        FinalOutput = FinalOutput.Replace("[FEATURE]", message)
        d.SubmitChanges()
        Dim s = From c In d.Agape_Billboard_Features Where c.Sent = True And c.Visible = True Order By c.StoryDate
        If s.Count > 0 Then
            s.First.Current = True
        End If

        message = ""
        'Articles
        Dim u = From c In d.Agape_Billboard_Articles Where c.Sent = False And c.Visible = True
        If u.Count = 0 Then
            message = "<div style=""color: #666666;font-size: 12pt; font-family:  Verdana, Geneva, sans-serif; font-weight: bold ;"">There are no new articles this week.</div>"
        End If
        For Each arti In u
            message = message & "<div style=""color: #666666;font-size: 12pt; font-family:  Verdana, Geneva, sans-serif; font-weight: bold ;"">" & arti.Headline & "</div>"
            message = message & "<div style=""font-family: verdana; font-size: 8pt; font-style: italic; color: #808080; text-align: right"">"
            message = message & "By:&nbsp;" & (From c In d.Users Where c.UserID = arti.Author Select c.DisplayName).First & ",&nbsp;" & CDate(arti.StoryDate).ToString("dd MMM yyyy") & "</div>"
            message = message & "<div style=""font-size:10pt; font-family:Verdana; color:#666666;"">" & (BillboardFunctions.StripBillTags(arti.StoryText)).Substring(0, Math.Min(CStr(arti.StoryText).Length, 150)) & "..."
            message = message & "</div><br/>"
            'arti.Current = False
            'arti.Sent = True
        Next
        FinalOutput = FinalOutput.Replace("[ARTICLES]", message)

        'Links
        message = ""
        Dim v = From c In d.Agape_Billboard_Links Where c.Sent = False And c.Visible = True
        If v.Count = 0 Then
            message = "There are currently no links this week."
        End If
        For Each Linker In v
            message = message & Linker.LinkTitle & "<br/>(" & Linker.LinkURL & ")<br/>"
            'Linker.Sent = True
        Next
        FinalOutput = FinalOutput.Replace("[LINKS]", "<div style=""font-size:7pt;"">" & message & "</div>")

        'Community
        message = ""
        Dim w = From c In d.Agape_Billboard_Communities Where c.Sent = False And c.ReplyId = -3 Order By c.DateSub Descending
        If w.Count = 0 Then
            message = "There are no community items this week."
        End If
        For Each Commune In w
            message = message & "<table><tr><td>" & Commune.Text & "</td></tr><tr><td align=""right"" valign=""middle"">"
            message = message & "-" & (From c In d.Users Where c.UserID = Commune.AuthorId Select c.DisplayName).First & ",&nbsp;" & CDate(Commune.DateSub).ToString("dd MMM yyyy")
            message = message & "</td></tr></table><br/>"
            'Commune.Sent = True
        Next
        FinalOutput = FinalOutput.Replace("[COMMUNITY]", "<div style=""font-size:7pt;"">" & message & "</div>")

        'Prayer
        message = ""
        Dim x = From c In d.Agape_Billboard_Prayers Where c.Sent = False And c.Visible = True
        If x.Count = 0 Then
            message = "<div style=""color: #666666;font-size: 12pt; font-family:  Verdana, Geneva, sans-serif; font-weight: bold ;"">There are no new prayer requests this week.</div>"
        End If
        For Each PrayerItem In x
            message = message & "<div style=""color: #666666;font-size: 12pt; font-family:  Verdana, Geneva, sans-serif; font-weight: bold;"">"
            message = message & PrayerItem.PrayerTitle & "</div>"
            message = message & "<div style=""font-family: verdana; font-size: 8pt; font-style: italic; color: #808080; text-align: right"">"
            message = message & "Submitted By:&nbsp;" & (From c In d.Users Where c.UserID = PrayerItem.SubmittedBy Select c.DisplayName).First & ", on&nbsp;"
            message = message & CDate(PrayerItem.SubmittedDate).ToString("dd MMM yyyy") & "</div>"
            message = message & "<div style=""font-size:10pt; font-family:Verdana; color:#666666;"">" & BillboardFunctions.StripBillTags(PrayerItem.PrayerText) & "</div><br/>"
            'PrayerItem.Sent = True
            'PrayerItem.Current = False
        Next
        FinalOutput = FinalOutput.Replace("[PRAYERS]", message)
        SendEmail(FinalOutput)
        d.SubmitChanges()

    End Sub
    Private Sub SendEmail(ByVal FinalOutput As String)


        'Prepare birthdays and reminders and send
        Dim d As New BillboardDataContext
        Dim message As String

        'Birthdays
        'Dim dn As New DNNProfile.DNNProfileDataContextDataContext
        'Dim da As New AgapeStaff.AgapeStaffDataContext
        Dim objUserInfo As UserInfo

        Dim onlyStaff = AgapeStaffFunctions.GetStaff("Associate Staff", "Foreign Staff", "Council", "Other", "Office", "Ex-Staff")
        Dim rc As New DotNetNuke.Security.Roles.RoleController
        Dim staff = onlyStaff
        For Each row In staff
            objUserInfo = UserController.GetUserById(0, row.UserID)
            If objUserInfo.Profile.GetPropertyValue("DOB") <> "" Then
                Dim bday As Date = CDate(Rearrange(objUserInfo.Profile.GetPropertyValue("DOB")))
                Dim Age As Double = DateDiff(DateInterval.Year, bday, Now())
                bday = DateAdd(DateInterval.Year, Age, bday)
                If (bday >= DateAdd(DateInterval.Day, -3.0, CDate(Now()))) And (bday <= DateAdd(DateInterval.Day, 7.0, CDate(Now()))) Then
                    message = message & row.DisplayName & " - " & bday.ToString("dd MMM") & "<br/>"
                End If
            End If
        Next
        Dim dBroke As New StaffBroker.StaffBrokerDataContext
        For Each row In (From c In dBroke.AP_StaffBroker_Staffs Where c.UserId2 = -1)
            Dim ThisContinue As Boolean = False
            For Each member In onlyStaff
                If row.UserId1 = member.UserID Then
                    ThisContinue = True
                End If
            Next
            If ThisContinue Then
                Dim bday As Date = StaffBrokerFunctions.GetStaffProfileProperty(row.StaffId, "SpouseDOB")
                Dim Age As Double = DateDiff(DateInterval.Year, bday, Now())
                bday = DateAdd(DateInterval.Year, Age, bday)
                If (bday >= DateAdd(DateInterval.Day, -3.0, CDate(Now()))) And (bday <= DateAdd(DateInterval.Day, 7.0, CDate(Now()))) Then
                    Dim sName As String = StaffBrokerFunctions.GetStaffProfileProperty(row.StaffId, "SpouseName")
                    message = message & sName & " " & UserController.GetUserById(0, row.UserId1).LastName & " - " & bday.ToString("dd MMM") & "<br/>"
                End If
            End If
        Next
        For Each row In dBroke.AP_StaffBroker_Childrens
            Dim bday As Date = row.Birthday
            Dim Age2 As Double = DateDiff(DateInterval.Year, bday, Now())
            bday = DateAdd(DateInterval.Year, Age2, bday)
            If (bday >= DateAdd(DateInterval.Day, -3.0, CDate(Now()))) And (bday <= DateAdd(DateInterval.Day, 7.0, CDate(Now()))) Then
                Dim q = From c In dBroke.AP_StaffBroker_Staffs Where c.StaffId = row.StaffId
                If q.Count > 0 Then
                    Dim ThisContinue2 As Boolean = False
                    For Each member In onlyStaff
                        If q.First.UserId1 Or q.First.USerId2 = member.UserID Then
                            ThisContinue2 = True
                        End If
                    Next
                    If ThisContinue2 Then
                        message = message & row.FirstName & " " & UserController.GetUserById(0, q.First.UserId1).LastName
                        Dim Age As Integer
                        If DateTime.Today.Month < row.Birthday.Month Or DateTime.Today.Month = row.Birthday.Month And DateTime.Today.Day < row.Birthday.Day Then
                            Age = DateTime.Today.Year - row.Birthday.Year - 1
                        Else
                            Age = DateTime.Today.Year - row.Birthday.Year
                        End If
                        If Age < 17 Then
                            message = message & " (" & Age & ")" & " - " & bday.ToString("dd MMM")
                        Else
                            message = message & " - " & bday.ToString("dd MMM")
                        End If
                        message = message & "<br/>"
                    End If
                End If

            End If
        Next
        If message = "" Or message Is Nothing Then
            message = "There are no birthdays this week."
        End If

        FinalOutput = FinalOutput.Replace("[BIRTHDAYS]", "<div style=""font-size:7pt; padding-left:10px;"">" & message & "</div>")

        'Loop around people to send to and add reminders before sending

        Dim SendTo = From c In d.Users Where c.UserID = 13


        'DotNetNuke.Services.Mail.Mail.SendMail("chriscarter@agape.org.uk", SendTo.First.Email, "", "Billboard: " & Now().ToString("dd/MM/yyyy"), FinalOutput, "", "HTML", "", "", "", "")
        For Each staffer In SendTo
            'Reminders
            message = BillboardFunctions.CreateReminders(staffer.UserID)
            FinalOutput = FinalOutput.Replace("[REMINDERS]", "<div style=""font-size:7pt; padding-left:10px;"">" & Regex.Replace(message, "<a(.|\n)*?>", "") & "</div>")

            'Send Email
            'DotNetNuke.Services.Mail.Mail.SendMail("donotreply@agape.org.uk", staffer.Email, "", "Billboard: " & Now().ToString("dd/MM/yyyy"), FinalOutput, "", "HTML", "", "", "", "")
        Next
        phMain.Controls.Add(New LiteralControl(FinalOutput))
        tbOutHtml.Text = FinalOutput

    End Sub
    Public Function Rearrange(ByVal InDate As String) As String
        Dim Out As String = ""
        Try
            Dim Day As Integer = CInt(InDate.Substring(0, 2))
            Dim Month As Integer = CInt(InDate.Substring(InDate.IndexOf("/") + 1, 2))
            Dim Year As Integer = CInt(InDate.Substring(InDate.LastIndexOf("/") + 1, 4))
            Out = Month & "/" & Day & "/" & Year
        Catch ex As Exception
            Out = InDate
        End Try

        Return Out
    End Function

End Class
