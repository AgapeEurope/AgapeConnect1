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


'Imports AgapeStaff
Imports StaffBrokerFunctions



Namespace DotNetNuke.Modules.Billboard
    Public Class MyHyperStruct

        Private MyHyperlinkValue As HyperLink
        Public Property MyHyperlink() As HyperLink
            Get
                Return MyHyperlinkValue
            End Get
            Set(ByVal value As HyperLink)
                MyHyperlinkValue = value
            End Set
        End Property

        Private ThisDateValue As Date
        Public Property ThisDate() As Date
            Get
                Return ThisDateValue
            End Get
            Set(ByVal value As Date)
                ThisDateValue = value
            End Set
        End Property




        Public Sub New()

        End Sub
    End Class
    Partial Class BillBirthdays
        Inherits Entities.Modules.PortalModuleBase



        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            'If Not Page.IsPostBack Then
            'Dim d As New DNNProfile.DNNProfileDataContextDataContext
            'Dim da As New AgapeStaffDataContext
            'Dim dF As New FullStory.FullStoryDataContext

            Dim outList As New Generic.List(Of MyHyperStruct)


            Dim objUserInfo As UserInfo

            Dim stff As New StaffBroker.StaffBrokerDataContext
            Dim excludelist As String() = {"Ex-Staff", "Council", "Foreign Staff", "Office", "Other", "Associate Staff"}
            Dim staff = From c In stff.AP_StaffBroker_Staffs Where Not excludelist.Contains(c.AP_StaffBroker_StaffType.Name)
            ' Dim onlyStaff = AgapeStaffFunctions.GetStaff("Associate Staff", "Foreign Staff", "Council", "Other", "Office", "Ex-Staff")

            Dim rc As New DotNetNuke.Security.Roles.RoleController
            'Dim staff = rc.GetUsersByRoleName(PortalId, "Staff")
            ' Dim staff = onlyStaff
            'For Each row As UserInfo In staff
            For Each row In staff
                Try
                    objUserInfo = UserController.GetUserById(0, row.UserId1)
                    If objUserInfo.Profile.GetPropertyValue("Birthday") <> "" Then
                        Dim bday As Date = Date.Parse(objUserInfo.Profile.GetPropertyValue("Birthday"), New CultureInfo("en-GB"))
                        Dim Age As Double = DateDiff(DateInterval.Year, bday, Now())
                        bday = DateAdd(DateInterval.Year, Age, bday)
                        If (bday >= CDate(Today())) And (bday <= DateAdd(DateInterval.Day, 7.0, CDate(Today()))) Then
                            'If bday.Day = Now.Day And bday.Month = Now.Month Then

                            Dim HL As New HyperLink()
                            HL.Font.Size = 7
                            HL.CssClass = "Bill_Text_Side"
                            If row.UserId1 = Me.UserId Then
                                HL.Text = "Happy Birthday " & row.User.FirstName & "!"
                            Else
                                HL.Text = objUserInfo.DisplayName & " - " & bday.ToString("dd MMM")
                            End If

                            'HYPERLINK TO STAFF PAGE
                            'If dF.Agape_Main_GlobalDatas.Count > 0 Then
                            '    HL.NavigateUrl = NavigateURL(CInt(dF.Agape_Main_GlobalDatas.First.StaffDirectoryTabId)) & "?uid=" & row.UserId1

                            'End If

                            Dim ThisOutput As New MyHyperStruct()
                            ThisOutput.MyHyperlink = HL
                            ThisOutput.ThisDate = bday
                            outList.Add(ThisOutput)
                            'PlaceHolder1.Controls.Add(HL)
                            'PlaceHolder1.Controls.Add(New LiteralControl("<br />"))

                        End If

                    End If

                    If row.UserId2 > 0 Then

                        objUserInfo = UserController.GetUserById(0, row.UserId2)
                        If objUserInfo.Profile.GetPropertyValue("Birthday") <> "" Then
                            Dim bday As Date = Date.Parse(objUserInfo.Profile.GetPropertyValue("Birthday"), New CultureInfo("en-GB"))
                            Dim Age As Double = DateDiff(DateInterval.Year, bday, Now())
                            bday = DateAdd(DateInterval.Year, Age, bday)
                            If (bday >= CDate(Today())) And (bday <= DateAdd(DateInterval.Day, 7.0, CDate(Today()))) Then
                                'If bday.Day = Now.Day And bday.Month = Now.Month Then

                                Dim HL As New HyperLink()
                                HL.Font.Size = 7
                                HL.CssClass = "Bill_Text_Side"
                                If row.UserId2 = Me.UserId Then
                                    HL.Text = "Happy Birthday " & row.User2.FirstName & "!"
                                Else
                                    HL.Text = objUserInfo.DisplayName & " - " & bday.ToString("dd MMM")
                                End If

                                'HYPERLINK TO STAFF PAGE
                                'If dF.Agape_Main_GlobalDatas.Count > 0 Then
                                '    HL.NavigateUrl = NavigateURL(CInt(dF.Agape_Main_GlobalDatas.First.StaffDirectoryTabId)) & "?uid=" & row.UserId2

                                'End If

                                Dim ThisOutput As New MyHyperStruct()
                                ThisOutput.MyHyperlink = HL
                                ThisOutput.ThisDate = bday
                                outList.Add(ThisOutput)

                            End If

                        End If

                    ElseIf row.UserId2 = -1 Then
                        If GetStaffProfileProperty(row.StaffId, "SpouseDOB") <> "" Then
                            'If objUserInfo.Profile.GetPropertyValue("DOB") <> "" Then
                            Dim bday As Date = Date.Parse(GetStaffProfileProperty(row.StaffId, "SpouseDOB"), New CultureInfo("en-GB"))
                            Dim Age As Double = DateDiff(DateInterval.Year, bday, Now())
                            bday = DateAdd(DateInterval.Year, Age, bday)
                            If (bday >= CDate(Now())) And (bday <= DateAdd(DateInterval.Day, 7.0, CDate(Now()))) Then
                                'If bday.Day = Now.Day And bday.Month = Now.Month Then
                                Dim HL As New HyperLink()
                                HL.Font.Size = 7
                                HL.CssClass = "Bill_Text_Side"
                                objUserInfo = UserController.GetUserById(0, row.UserId1)
                                HL.Text = GetStaffProfileProperty(row.StaffId, "SpouseName") & " " & objUserInfo.LastName & " - " & bday.ToString("dd MMM")

                                'HYPERLINK TO STAFF PAGE
                                'If dF.Agape_Main_GlobalDatas.Count > 0 Then
                                '    HL.NavigateUrl = NavigateURL(CInt(dF.Agape_Main_GlobalDatas.First.StaffDirectoryTabId)) & "?uid=" & row.UserId1
                                'End If

                                Dim ThisOutput As New MyHyperStruct()
                                ThisOutput.MyHyperlink = HL
                                ThisOutput.ThisDate = bday
                                outList.Add(ThisOutput)

                            End If
                        End If
                    End If
                    Dim children = From c In stff.AP_StaffBroker_Childrens Where c.StaffId = row.StaffId
                    For Each child In children
                        Dim bday As Date = child.Birthday
                        Dim Age2 As Double = DateDiff(DateInterval.Year, bday, Now())
                        bday = DateAdd(DateInterval.Year, Age2, bday)
                        If (bday >= CDate(Now())) And (bday <= DateAdd(DateInterval.Day, 7.0, CDate(Now()))) Then
                            Dim Age As Integer
                            Age = DateTime.Today.Year - child.Birthday.Year
                            If Age < 22 Then
                                Dim HL As New HyperLink()
                                HL.Font.Size = 7
                                HL.CssClass = "Bill_Text_Side"
                                HL.Text = child.FirstName & " " & UserController.GetUserById(PortalId, row.UserId1).LastName
                                If Age < 17 Then
                                    HL.Text = HL.Text & " (" & Age & ")" & " - " & bday.ToString("dd MMM")
                                Else
                                    HL.Text = HL.Text & " - " & bday.ToString("dd MMM")
                                End If

                                'HYPERLINK TO STAFF PAGE
                                'If dF.Agape_Main_GlobalDatas.Count > 0 Then
                                '    HL.NavigateUrl = NavigateURL(CInt(dF.Agape_Main_GlobalDatas.First.StaffDirectoryTabId)) & "?uid=" & row.UserId1
                                'End If

                                Dim ThisOutput As New MyHyperStruct()
                                ThisOutput.MyHyperlink = HL
                                ThisOutput.ThisDate = bday
                                outList.Add(ThisOutput)
                            End If
                        End If
                    Next

                Catch ex As Exception
                    PlaceHolder1.Controls.Add(New LiteralControl("<div class=""Bill_Text_Side"" style=""font-size:7pt; width=160px; font-style:italic;"">" & ex.Message & "</div>"))
                End Try
            Next


            If outList.Count = 0 Then
                PlaceHolder1.Controls.Add(New LiteralControl("<div class=""Bill_Text_Side"" style=""font-size:7pt; width=160px; font-style:italic;"">There are no Birthdays this week</div>"))
            Else
                outList.Sort(AddressOf sortDates)
                For Each birth As MyHyperStruct In outList
                    PlaceHolder1.Controls.Add(birth.MyHyperlink)
                    PlaceHolder1.Controls.Add(New LiteralControl("<br />"))
                Next
            End If


        End Sub
        Private Shared Function sortDates( _
    ByVal x As MyHyperStruct, ByVal y As MyHyperStruct) As Integer
            Return x.ThisDate.CompareTo(y.ThisDate)
        End Function


    End Class

End Namespace
