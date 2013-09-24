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
    Partial Class staffDashboard
        Inherits Entities.Modules.PortalModuleBase

        Public jsonPI = ""
        Public jsonLi = ""

        Dim d As New MPDDataContext
        Dim Pid As Integer = -1
        Dim ds As New StaffBroker.StaffBrokerDataContext
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load

            Dim theStaff = From c In ds.AP_StaffBroker_Staffs Where c.StaffId = CInt(Request.QueryString("staffId"))

            If theStaff.Count > 0 Then
                lblStaffName.Text = theStaff.First.DisplayName
                Dim incomeData = (From c In d.AP_mpd_UserAccountInfos Where c.staffId = CInt(Request.QueryString("staffId")) And c.period >= Today.AddMonths(-13).ToString("yyyyMM") And c.income > 0).ToList

                Dim BudgetData = (From c In d.AP_mpdCalc_StaffBudgets Where c.StaffId = CInt(Request.QueryString("staffId")) And Not c.TotalBudget Is Nothing).ToList


                jsonLi = ""
                For Each row In incomeData
                    Dim start = New Date(CInt(Left(row.period, 4)), CInt(Right(row.period, 2)), 1)
                    Dim bud As Double = 0.0
                    If BudgetData.Count > 0 Then
                        If Not BudgetData.First.TotalBudget Is Nothing Then
                            bud = BudgetData.First.TotalBudget
                        End If

                    End If
                    jsonLi &= "['" & start.ToString("MMM yy") & "', " & row.balance.ToString("0.00") & ", " & row.income.ToString("0.00") & ", " & bud.ToString("0.00") & ", " & (-row.expense).ToString("0.00") & "],"
                Next

                Dim fi As Double = incomeData.Average(Function(c) c.foreignIncome)
                Dim comp As Double = incomeData.Average(Function(c) c.compensation)
                Dim li As Double = incomeData.Average(Function(c) c.income - (c.foreignIncome + c.compensation))

                jsonPI = "['Local Income', " & li.ToString("0.00") & "],['Foreign Income', " & fi.ToString("0.00") & "], ['Compensation', " & comp.ToString("0.00") & "]"


                Dim yearI = incomeData.Average(Function(c) c.income)
                Dim quarterI = (From c In incomeData Order By c.period Descending Select c.income).Take(3).Average
                Dim monthI = (From c In incomeData Order By c.period Select c.income).Last

                Dim BudgetAvg = 0
                If BudgetData.Count > 0 Then
                    If Not BudgetData.First.TotalBudget Is Nothing Then
                        BudgetAvg = BudgetData.First.TotalBudget
                    End If

                End If

                lblYear.Text = (100 * yearI / BudgetAvg).ToString("0.0") & "%"
                lblQuarter.Text = (100 * quarterI / BudgetAvg).ToString("0.0") & "%"
                lblMonth.Text = (100 * monthI / BudgetAvg).ToString("0.0") & "%"
            End If





        End Sub
        

    End Class
End Namespace
