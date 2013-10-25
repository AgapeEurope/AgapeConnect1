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
Imports MPD
Imports StaffBrokerFunctions

Namespace DotNetNuke.Modules.AgapeConnect
    Partial Class countryDashboard
        Inherits Entities.Modules.PortalModuleBase

        Public jsonPI = ""
        Public jsonLi = ""

        Dim d As New MPDDataContext
        Dim Pid As Integer = -1
        Dim ds As New StaffBroker.StaffBrokerDataContext
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load


            Dim thisCountry = From c In d.AP_mpd_Countries Where c.isoCode = Request.QueryString("country")

            If thisCountry.Count > 0 Then

                Pid = thisCountry.First.portalId
                lblCountryTitle.Text = thisCountry.First.name
                Dim localStaffTypes = {"National Staff", "National Staff, Overseas"}
                Dim allLocalStaff = (From c In ds.AP_StaffBroker_Staffs Where c.PortalId = thisCountry.First.portalId And localStaffTypes.Contains(c.AP_StaffBroker_StaffType.Name) Select c.StaffId).ToList

                Dim lastPeriod As String = d.AP_mpd_UserAccountInfos.Where(Function(c) c.mpdCountryId = thisCountry.First.mpdCountryId And c.income > 0).Max(Function(c) c.period)
                If String.IsNullOrEmpty(lastPeriod) Then
                    lastPeriod = Today.ToString("yyyyMM")
                End If
                Dim LastPeriodDate = New Date(CInt(Left(lastPeriod, 4)), CInt(Right(lastPeriod, 2)), 1)

                Dim firstPeriod As String = LastPeriodDate.AddMonths(-12).ToString("yyyyMM")
                Dim quateerPeriod As String = LastPeriodDate.AddMonths(-3).ToString("yyyyMM")
                Dim monthPeriod As String = LastPeriodDate.AddMonths(-1).ToString("yyyyMM")

                ' Label3.Text = lastPeriod



                Dim incomeData = (From c In d.AP_mpd_UserAccountInfos Where c.mpdCountryId = thisCountry.First.mpdCountryId And c.period >= firstPeriod And c.period <= lastPeriod And allLocalStaff.Contains(c.staffId) And c.Ap_mpd_User.AP_mpd_Country.AP_mpdCalc_Definitions.AP_mpdCalc_StaffBudgets.Where(Function(x) x.StaffId = c.staffId).Count > 0 _
                    Select Period = c.period, staffId = c.staffId, income = c.income, expense = c.expense, Budget = mpdFunctions.getBudgetForStaffPeriod(c.staffId, c.period)).ToList ' c.AP_mpd_Country.AP_mpdCalc_Definitions.AP_mpdCalc_StaffBudgets.Where(Function(x) x.StaffId = c.staffId).First.TotalBudget)).ToList


                Dim groupedData = From c In incomeData Where c.Budget > 0 Group By c.staffId Into Group Select SupLev = Group.Average(Function(x) x.income / x.Budget), staffId


                Dim g1 = groupedData.Where(Function(c) c.SupLev < 0.5)
                Dim g2 = groupedData.Where(Function(c) c.SupLev >= 0.5 And c.SupLev < 0.75)
                Dim g3 = groupedData.Where(Function(c) c.SupLev >= 0.75 And c.SupLev < 0.9)
                Dim g4 = groupedData.Where(Function(c) c.SupLev >= 0.9 And c.SupLev < 1.0)
                Dim g5 = groupedData.Where(Function(c) c.SupLev >= 1.0)
                Dim g0 = allLocalStaff.Count - (g1.Count + g2.Count + g3.Count + g4.Count + g5.Count)








                jsonPI = "['No Budget', " & g0 & "],"
                jsonPI &= "['<50% Raised', " & g1.Count & "],"
                jsonPI &= "['50-75% Raised', " & g2.Count & "],"
                jsonPI &= "['75-90% Raised', " & g3.Count & "],"
                jsonPI &= "['90-100% Raised', " & g4.Count & "],"
                jsonPI &= "['>100% Raised', " & g5.Count & "]"

                jsonLi = ""

                For i As Integer = -12 To 0

                    Dim count As Integer = i
                    Dim AvgSupport = (From c In incomeData Where c.Period = LastPeriodDate.AddMonths(count).ToString("yyyyMM") And c.Budget > 0 Select c.income / c.Budget)
                    Dim ag = 0.0
                    Dim full = 0.0
                    If AvgSupport.Count > 0 Then
                        ag = AvgSupport.Average()
                        full = AvgSupport.Where(Function(c) c > 0.9).Count / allLocalStaff.Count
                    End If




                    jsonLi &= "['" & LastPeriodDate.AddMonths(count).ToString("MMM yy") & "', " & ag.ToString("0.00") & ", " & full.ToString("0.00") & " ], "



                Next

                lblAvgSupport.Text = (groupedData.Average(Function(c) c.SupLev) * 100.0).ToString("0.0") & "%"

                'lblAvgSupport.Text = mpdFunctions.getBudgetForStaffPeriod(20, "201301")

                Dim bva = ((From c In incomeData Where c.expense < 0 And c.Budget > 0 Select -c.expense / c.Budget).Average())
                lblBdgVsAct.Text = bva.ToString("0.0%")
                lblBdgVsActLabel.Text = IIf(bva > 1, "(budgets under-estimated expenses)", "(budgets over-estimated expenses)")



               
                rpLessThan50.DataSource = g1
                rpLessThan50.DataBind()

                rpLow.DataSource = g2
                rpLow.DataBind()

                rpMedium.DataSource = g3
                rpMedium.DataBind()

                rpHigh.DataSource = g4
                rpHigh.DataBind()

                rpFull.DataSource = g5
                rpFull.DataBind()

                ' Dim noBudget = From c In allLocalStaff Where thisCountry.First.AP_mpdCalc_Definitions.AP_mpdCalc_StaffBudgets.Where(Function(x) x.StaffId = c).Count = 0 Select staffId = c, Status = "No Budget"
                Dim noBudget As New Dictionary(Of Integer, String)
                For Each row In allLocalStaff
                    Dim thisId = row
                    If (From c In groupedData Where c.staffId = thisId).Count = 0 Then
                        noBudget.Add(thisId, GetStaffName(thisId))
                    End If
                Next


                rpNone.DataSource = noBudget
                rpNone.DataBind()


            End If

        End Sub
        Public Function GetStaffName(ByVal StaffId As Integer) As String
            Dim thisStaff = From c In ds.AP_StaffBroker_Staffs Where c.PortalId = Pid And c.StaffId = StaffId

            If thisStaff.Count > 0 Then
                Return thisStaff.First.DisplayName
            Else
                Return ""
            End If

        End Function

    End Class
End Namespace
